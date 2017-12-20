Received: from eggs.gnu.org ([208.118.235.92]:35040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd5-0003ul-P7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd1-0005dR-9I
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:49:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Dec 2017 18:49:41 +0300
Message-Id: <20171220154945.88410-10-vsementsov@virtuozzo.com>
In-Reply-To: <20171220154945.88410-1-vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 09/13] migration: add is_active_iterate
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
to disable them and stop transporting empty sections there is a new
savevm handler.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/migration/register.h | 9 +++++++++
 migration/savevm.c           | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9436a87678..f6f12f9b1a 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -26,6 +26,15 @@ typedef struct SaveVMHandlers {
     bool (*is_active)(void *opaque);
     bool (*has_postcopy)(void *opaque);
 
+    /* is_active_iterate
+     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
+     * it returns false. For example, it is needed for only-postcopy-states,
+     * which needs to be handled by qemu_savevm_state_setup and
+     * qemu_savevm_state_pending, but do not need iterations until not in
+     * postcopy stage.
+     */
+    bool (*is_active_iterate)(void *opaque);
+
     /* This runs outside the iothread lock in the migration case, and
      * within the lock in the savevm case.  The callback had better only
      * use data that is local to the migration thread or protected
diff --git a/migration/savevm.c b/migration/savevm.c
index c3c60a15e3..e5d557458e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1026,6 +1026,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
                 continue;
             }
         }
+        if (se->ops && se->ops->is_active_iterate) {
+            if (!se->ops->is_active_iterate(se->opaque)) {
+                continue;
+            }
+        }
         /*
          * In the postcopy phase, any device that doesn't know how to
          * do postcopy should have saved it's state in the _complete
-- 
2.11.1
