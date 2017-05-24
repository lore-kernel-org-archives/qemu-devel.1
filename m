Received: from eggs.gnu.org ([2001:4830:134:3::10]:39813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDPn9-0003y5-5E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDPn4-00040o-Ic
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:29:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495601614-18586-2-git-send-email-bharata@linux.vnet.ibm.com>
	(Bharata B. Rao's message of "Wed, 24 May 2017 10:23:32 +0530")
References: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495601614-18586-2-git-send-email-bharata@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 24 May 2017 08:28:59 +0200
Message-ID: <87a8627opg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> Introduce a new function unregister_savevm_live() to unregister the vmstate
> handlers registered via register_savevm_live().
>
> register_savevm() allocates SaveVMHandlers while register_savevm_live()
> gets passed with SaveVMHandlers. During unregistration, we  want to
> free SaveVMHandlers in the former case but not free in the latter case.
> Hence this new API is needed to differentiate this.
>
> This new API will be needed by PowerPC to unregister the HTAB savevm
> handlers.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>

Hi

How about this one?
I just test compiled it.

Advantage from my point of view is that we always do the right thing.
And as migration code already knows if it has to be freed or not, I
think it is a better API.

What do you think?

Later, Juan.

commit 6e71fac7a9c29cef9625135c58ce59ccfbb3b86f
Author: Juan Quintela <quintela@redhat.com>
Date:   Wed May 24 08:25:06 2017 +0200

    migration: Allow to free save_live handlers
    
    Migration save_live handlers have an ops member that is not dynamic.
    Add a new member is_allocated that remembers if ops has to be freed.
    
    Signed-off-by: Juan Quintela <quintela@redhat.com>

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f97411d..1d20e30 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -57,6 +57,8 @@ typedef struct SaveVMHandlers {
                               uint64_t *non_postcopiable_pending,
                               uint64_t *postcopiable_pending);
     LoadStateHandler *load_state;
+    /* Has been allocated by migratation code */
+    bool is_allocated;
 } SaveVMHandlers;
 
 int register_savevm(DeviceState *dev,
diff --git a/migration/savevm.c b/migration/savevm.c
index d971e5e..187f386 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -628,6 +628,7 @@ int register_savevm(DeviceState *dev,
     SaveVMHandlers *ops = g_new0(SaveVMHandlers, 1);
     ops->save_state = save_state;
     ops->load_state = load_state;
+    ops->is_allocated = true;
     return register_savevm_live(dev, idstr, instance_id, version_id,
                                 ops, opaque);
 }
@@ -651,7 +652,9 @@ void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque)
         if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
             QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
             g_free(se->compat);
-            g_free(se->ops);
+            if (se->ops->is_allocated) {
+                g_free(se->ops);
+            }
             g_free(se);
         }
     }
