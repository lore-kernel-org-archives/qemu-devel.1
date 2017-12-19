Received: from eggs.gnu.org ([2001:4830:134:3::10]:57603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZe-0004mO-VO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJZd-0006xv-LQ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJZd-0006xN-Cz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:12:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:32 +0000
Message-Id: <20171219151144.11120-12-stefanha@redhat.com>
In-Reply-To: <20171219151144.11120-1-stefanha@redhat.com>
References: <20171219151144.11120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/23] block: don't keep AioContext acquired
 after internal_snapshot_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171206144550.22295-6-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index d7ad76416e..6332a249ea 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1454,7 +1454,6 @@ struct BlkActionState {
 typedef struct InternalSnapshotState {
     BlkActionState common;
     BlockDriverState *bs;
-    AioContext *aio_context;
     QEMUSnapshotInfo sn;
     bool created;
 } InternalSnapshotState;
@@ -1485,6 +1484,7 @@ static void internal_snapshot_prepare(BlkActionState *common,
     qemu_timeval tv;
     BlockdevSnapshotInternal *internal;
     InternalSnapshotState *state;
+    AioContext *aio_context;
     int ret1;
 
     g_assert(common->action->type ==
@@ -1506,32 +1506,33 @@ static void internal_snapshot_prepare(BlkActionState *common,
         return;
     }
 
-    /* AioContext is released in .clean() */
-    state->aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(state->aio_context);
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
 
     state->bs = bs;
+
+    /* Paired with .clean() */
     bdrv_drained_begin(bs);
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INTERNAL_SNAPSHOT, errp)) {
-        return;
+        goto out;
     }
 
     if (bdrv_is_read_only(bs)) {
         error_setg(errp, "Device '%s' is read only", device);
-        return;
+        goto out;
     }
 
     if (!bdrv_can_snapshot(bs)) {
         error_setg(errp, "Block format '%s' used by device '%s' "
                    "does not support internal snapshots",
                    bs->drv->format_name, device);
-        return;
+        goto out;
     }
 
     if (!strlen(name)) {
         error_setg(errp, "Name is empty");
-        return;
+        goto out;
     }
 
     /* check whether a snapshot with name exist */
@@ -1539,12 +1540,12 @@ static void internal_snapshot_prepare(BlkActionState *common,
                                             &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        goto out;
     } else if (ret) {
         error_setg(errp,
                    "Snapshot with name '%s' already exists on device '%s'",
                    name, device);
-        return;
+        goto out;
     }
 
     /* 3. take the snapshot */
@@ -1560,11 +1561,14 @@ static void internal_snapshot_prepare(BlkActionState *common,
         error_setg_errno(errp, -ret1,
                          "Failed to create snapshot '%s' on device '%s'",
                          name, device);
-        return;
+        goto out;
     }
 
     /* 4. succeed, mark a snapshot is created */
     state->created = true;
+
+out:
+    aio_context_release(aio_context);
 }
 
 static void internal_snapshot_abort(BlkActionState *common)
@@ -1573,12 +1577,16 @@ static void internal_snapshot_abort(BlkActionState *common)
                              DO_UPCAST(InternalSnapshotState, common, common);
     BlockDriverState *bs = state->bs;
     QEMUSnapshotInfo *sn = &state->sn;
+    AioContext *aio_context;
     Error *local_error = NULL;
 
     if (!state->created) {
         return;
     }
 
+    aio_context = bdrv_get_aio_context(state->bs);
+    aio_context_acquire(aio_context);
+
     if (bdrv_snapshot_delete(bs, sn->id_str, sn->name, &local_error) < 0) {
         error_reportf_err(local_error,
                           "Failed to delete snapshot with id '%s' and "
@@ -1586,19 +1594,26 @@ static void internal_snapshot_abort(BlkActionState *common)
                           sn->id_str, sn->name,
                           bdrv_get_device_name(bs));
     }
+
+    aio_context_release(aio_context);
 }
 
 static void internal_snapshot_clean(BlkActionState *common)
 {
     InternalSnapshotState *state = DO_UPCAST(InternalSnapshotState,
                                              common, common);
+    AioContext *aio_context;
 
-    if (state->aio_context) {
-        if (state->bs) {
-            bdrv_drained_end(state->bs);
-        }
-        aio_context_release(state->aio_context);
+    if (!state->bs) {
+        return;
     }
+
+    aio_context = bdrv_get_aio_context(state->bs);
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_end(state->bs);
+
+    aio_context_release(aio_context);
 }
 
 /* external snapshot private data */
-- 
2.14.3
