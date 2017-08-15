Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbat-0000Mf-Cc
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbas-000808-G5
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:09:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 21:07:39 +0800
Message-Id: <20170815130740.31229-4-famz@redhat.com>
In-Reply-To: <20170815130740.31229-1-famz@redhat.com>
References: <20170815130740.31229-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v2 3/4] block-backend: Defer
 shared_perm tightening migration completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, stefanha@redhat.com

As in the case of nbd_export_new(), bdrv_invalidate_cache() can be
called when migration is still in progress. In this case we are not
ready to tighten the shared permissions fenced by blk->disable_perm.

Defer to a VM state change handler.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 968438c149..e9798e897d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -20,6 +20,7 @@
 #include "qapi-event.h"
 #include "qemu/id.h"
 #include "trace.h"
+#include "migration/misc.h"
 
 /* Number of coroutines to reserve per attached device model */
 #define COROUTINE_POOL_RESERVATION 64
@@ -68,6 +69,7 @@ struct BlockBackend {
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
 
     int quiesce_counter;
+    VMChangeStateEntry *vmsh;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -129,6 +131,23 @@ static const char *blk_root_get_name(BdrvChild *child)
     return blk_name(child->opaque);
 }
 
+static void blk_vm_state_changed(void *opaque, int running, RunState state)
+{
+    Error *local_err = NULL;
+    BlockBackend *blk = opaque;
+
+    if (state == RUN_STATE_INMIGRATE) {
+        return;
+    }
+
+    qemu_del_vm_change_state_handler(blk->vmsh);
+    blk->vmsh = NULL;
+    blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    }
+}
+
 /*
  * Notifies the user of the BlockBackend that migration has completed. qdev
  * devices can tighten their permissions in response (specifically revoke
@@ -147,6 +166,24 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
 
     blk->disable_perm = false;
 
+    blk_set_perm(blk, blk->perm, BLK_PERM_ALL, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        blk->disable_perm = true;
+        return;
+    }
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /* Activation can happen when migration process is still active, for
+         * example when nbd_server_add is called during non-shared storage
+         * migration. Defer the shared_perm update to migration completion. */
+        if (!blk->vmsh) {
+            blk->vmsh = qemu_add_vm_change_state_handler(blk_vm_state_changed,
+                                                         blk);
+        }
+        return;
+    }
+
     blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -291,6 +328,10 @@ static void blk_delete(BlockBackend *blk)
     if (blk->root) {
         blk_remove_bs(blk);
     }
+    if (blk->vmsh) {
+        qemu_del_vm_change_state_handler(blk->vmsh);
+        blk->vmsh = NULL;
+    }
     assert(QLIST_EMPTY(&blk->remove_bs_notifiers.notifiers));
     assert(QLIST_EMPTY(&blk->insert_bs_notifiers.notifiers));
     QTAILQ_REMOVE(&block_backends, blk, link);
-- 
2.13.4
