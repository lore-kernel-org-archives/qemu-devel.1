Received: from eggs.gnu.org ([2001:4830:134:3::10]:58383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc1C-000476-0b
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUc1A-000328-6y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUc19-00031c-Tz
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:58:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D03E585541
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 16:58:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jul 2017 18:58:27 +0200
Message-Id: <20170710165827.4250-6-pbonzini@redhat.com>
In-Reply-To: <20170710165827.4250-1-pbonzini@redhat.com>
References: <20170710165827.4250-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] block: convert bdrv_check callback to
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kwolf@redhat.com

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   | 43 ++++++++++++++++++++++++++++++++++++++++---
 block/parallels.c         | 17 +++++++++++------
 block/qcow2.c             | 23 +++++++++++++++++++----
 block/qed-check.c         |  1 +
 block/qed-table.c         | 26 +++++++++-----------------
 block/qed.c               | 13 +++++++++----
 block/vdi.c               |  6 +++---
 block/vhdx.c              |  7 ++++---
 block/vmdk.c              |  7 ++++---
 include/block/block_int.h |  5 +++--
 10 files changed, 103 insertions(+), 45 deletions(-)

diff --git a/block.c b/block.c
index c8856cc594..21742842ec 100644
--- a/block.c
+++ b/block.c
@@ -3245,17 +3245,54 @@ static void bdrv_delete(BlockDriverState *bs)
  * free of errors) or -errno when an internal error occurred. The results of the
  * check are stored in res.
  */
-int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix)
+static int coroutine_fn bdrv_co_check(BlockDriverState *bs,
+                                      BdrvCheckResult *res, BdrvCheckMode fix)
 {
     if (bs->drv == NULL) {
         return -ENOMEDIUM;
     }
-    if (bs->drv->bdrv_check == NULL) {
+    if (bs->drv->bdrv_co_check == NULL) {
         return -ENOTSUP;
     }
 
     memset(res, 0, sizeof(*res));
-    return bs->drv->bdrv_check(bs, res, fix);
+    return bs->drv->bdrv_co_check(bs, res, fix);
+}
+
+typedef struct CheckCo {
+    BlockDriverState *bs;
+    BdrvCheckResult *res;
+    BdrvCheckMode fix;
+    int ret;
+} CheckCo;
+
+static void bdrv_check_co_entry(void *opaque)
+{
+    CheckCo *cco = opaque;
+    cco->ret = bdrv_co_check(cco->bs, cco->res, cco->fix);
+}
+
+int bdrv_check(BlockDriverState *bs,
+               BdrvCheckResult *res, BdrvCheckMode fix)
+{
+    Coroutine *co;
+    CheckCo cco = {
+        .bs = bs,
+        .res = res,
+        .ret = -EINPROGRESS,
+        .fix = fix,
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_check_co_entry(&cco);
+    } else {
+        co = qemu_coroutine_create(bdrv_check_co_entry, &cco);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(bs, cco.ret == -EINPROGRESS);
+    }
+
+    return cco.ret;
 }
 
 /*
diff --git a/block/parallels.c b/block/parallels.c
index 82c6dd9aed..a198354f4e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -376,8 +376,9 @@ static coroutine_fn int parallels_co_readv(BlockDriverState *bs,
 }
 
 
-static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
-                           BdrvCheckMode fix)
+static int coroutine_fn parallels_co_check(BlockDriverState *bs,
+                                           BdrvCheckResult *res,
+                                           BdrvCheckMode fix)
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t size, prev_off, high_off;
@@ -392,6 +393,7 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
         return size;
     }
 
+    qemu_co_mutex_lock(&s->lock);
     if (s->header_unclean) {
         fprintf(stderr, "%s image was not closed correctly\n",
                 fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
@@ -440,11 +442,12 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
         prev_off = off;
     }
 
+    ret = 0;
     if (flush_bat) {
         ret = bdrv_pwrite_sync(bs->file, 0, s->header, s->header_size);
         if (ret < 0) {
             res->check_errors++;
-            return ret;
+            goto out;
         }
     }
 
@@ -462,13 +465,15 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
             if (ret < 0) {
                 error_report_err(local_err);
                 res->check_errors++;
-                return ret;
+                goto out;
             }
             res->leaks_fixed += count;
         }
     }
 
-    return 0;
+out:
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
 }
 
 
@@ -784,7 +789,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_writev = parallels_co_writev,
 
     .bdrv_co_create = parallels_co_create,
-    .bdrv_check     = parallels_check,
+    .bdrv_co_check  = parallels_co_check,
     .create_opts    = &parallels_create_opts,
 };
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 9bab0d3012..22a8650c5f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -319,8 +319,9 @@ int qcow2_mark_consistent(BlockDriverState *bs)
     return 0;
 }
 
-static int qcow2_check(BlockDriverState *bs, BdrvCheckResult *result,
-                       BdrvCheckMode fix)
+static int coroutine_fn qcow2_co_check_locked(BlockDriverState *bs,
+                                              BdrvCheckResult *result,
+                                              BdrvCheckMode fix)
 {
     int ret = qcow2_check_refcounts(bs, result, fix);
     if (ret < 0) {
@@ -337,6 +338,19 @@ static int qcow2_check(BlockDriverState *bs, BdrvCheckResult *result,
     return ret;
 }
 
+static int coroutine_fn qcow2_co_check(BlockDriverState *bs,
+                                       BdrvCheckResult *result,
+                                       BdrvCheckMode fix)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = qcow2_co_check_locked(bs, result, fix);
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
+}
+
 static int validate_table_offset(BlockDriverState *bs, uint64_t offset,
                                  uint64_t entries, size_t entry_len)
 {
@@ -1168,7 +1182,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
         BdrvCheckResult result = {0};
 
-        ret = qcow2_check(bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
+        ret = qcow2_co_check_locked(bs, &result,
+                                    BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not repair dirty image");
             goto fail;
@@ -3535,7 +3550,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_inactivate            = qcow2_inactivate,
 
     .create_opts         = &qcow2_create_opts,
-    .bdrv_check          = qcow2_check,
+    .bdrv_co_check       = qcow2_co_check,
     .bdrv_amend_options  = qcow2_amend_options,
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
diff --git a/block/qed-check.c b/block/qed-check.c
index dcd4f036b8..0edac03159 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -217,6 +217,7 @@ static void qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
     qed_write_header_sync(s);
 }
 
+/* Called with table_lock held.  */
 int qed_check(BDRVQEDState *s, BdrvCheckResult *result, bool fix)
 {
     QEDCheck check = {
diff --git a/block/qed-table.c b/block/qed-table.c
index eead8b0fc7..7df5680adb 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -18,7 +18,7 @@
 #include "qed.h"
 #include "qemu/bswap.h"
 
-/* Called either from qed_check or with table_lock held.  */
+/* Called with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 {
     QEMUIOVector qiov;
@@ -33,13 +33,9 @@ static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *table)
 
     trace_qed_read_table(s, offset, table);
 
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_unlock(&s->table_lock);
-    }
+    qemu_co_mutex_unlock(&s->table_lock);
     ret = bdrv_preadv(s->bs->file, offset, &qiov);
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_lock(&s->table_lock);
-    }
+    qemu_co_mutex_lock(&s->table_lock);
     if (ret < 0) {
         goto out;
     }
@@ -67,7 +63,7 @@ out:
  * @n:          Number of elements
  * @flush:      Whether or not to sync to disk
  *
- * Called either from qed_check or with table_lock held.
+ * Called with table_lock held.
  */
 static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
                            unsigned int index, unsigned int n, bool flush)
@@ -104,13 +100,9 @@ static int qed_write_table(BDRVQEDState *s, uint64_t offset, QEDTable *table,
     /* Adjust for offset into table */
     offset += start * sizeof(uint64_t);
 
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_unlock(&s->table_lock);
-    }
+    qemu_co_mutex_unlock(&s->table_lock);
     ret = bdrv_pwritev(s->bs->file, offset, &qiov);
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_lock(&s->table_lock);
-    }
+    qemu_co_mutex_lock(&s->table_lock);
     trace_qed_write_table_cb(s, table, flush, ret);
     if (ret < 0) {
         goto out;
@@ -134,7 +126,7 @@ int qed_read_l1_table_sync(BDRVQEDState *s)
     return qed_read_table(s, s->header.l1_table_offset, s->l1_table);
 }
 
-/* Called either from qed_check or with table_lock held.  */
+/* Called with table_lock held.  */
 int qed_write_l1_table(BDRVQEDState *s, unsigned int index, unsigned int n)
 {
     BLKDBG_EVENT(s->bs->file, BLKDBG_L1_UPDATE);
@@ -148,7 +140,7 @@ int qed_write_l1_table_sync(BDRVQEDState *s, unsigned int index,
     return qed_write_l1_table(s, index, n);
 }
 
-/* Called either from qed_check or with table_lock held.  */
+/* Called with table_lock held.  */
 int qed_read_l2_table(BDRVQEDState *s, QEDRequest *request, uint64_t offset)
 {
     int ret;
@@ -191,7 +183,7 @@ int qed_read_l2_table_sync(BDRVQEDState *s, QEDRequest *request, uint64_t offset
     return qed_read_l2_table(s, request, offset);
 }
 
-/* Called either from qed_check or with table_lock held.  */
+/* Called with table_lock held.  */
 int qed_write_l2_table(BDRVQEDState *s, QEDRequest *request,
                        unsigned int index, unsigned int n, bool flush)
 {
diff --git a/block/qed.c b/block/qed.c
index 56254faee8..576692bcf5 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1566,12 +1566,17 @@ static void coroutine_fn bdrv_qed_co_invalidate_cache(BlockDriverState *bs,
     }
 }
 
-static int bdrv_qed_check(BlockDriverState *bs, BdrvCheckResult *result,
-                          BdrvCheckMode fix)
+static int bdrv_qed_co_check(BlockDriverState *bs, BdrvCheckResult *result,
+                             BdrvCheckMode fix)
 {
     BDRVQEDState *s = bs->opaque;
+    int ret;
 
-    return qed_check(s, result, !!fix);
+    qemu_co_mutex_lock(&s->table_lock);
+    ret = qed_check(s, result, !!fix);
+    qemu_co_mutex_unlock(&s->table_lock);
+
+    return ret;
 }
 
 static QemuOptsList qed_create_opts = {
@@ -1631,7 +1636,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_refresh_limits      = bdrv_qed_refresh_limits,
     .bdrv_change_backing_file = bdrv_qed_change_backing_file,
     .bdrv_co_invalidate_cache = bdrv_qed_co_invalidate_cache,
-    .bdrv_check               = bdrv_qed_check,
+    .bdrv_co_check            = bdrv_qed_co_check,
     .bdrv_detach_aio_context  = bdrv_qed_detach_aio_context,
     .bdrv_attach_aio_context  = bdrv_qed_attach_aio_context,
     .bdrv_co_drain            = bdrv_qed_co_drain,
diff --git a/block/vdi.c b/block/vdi.c
index 1d6e779551..aa3e58dd73 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -258,8 +258,8 @@ static void vdi_header_print(VdiHeader *header)
 }
 #endif
 
-static int vdi_check(BlockDriverState *bs, BdrvCheckResult *res,
-                     BdrvCheckMode fix)
+static int coroutine_fn vdi_co_check(BlockDriverState *bs, BdrvCheckResult *res,
+                                     BdrvCheckMode fix)
 {
     /* TODO: additional checks possible. */
     BDRVVdiState *s = (BDRVVdiState *)bs->opaque;
@@ -907,7 +907,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_get_info = vdi_get_info,
 
     .create_opts = &vdi_create_opts,
-    .bdrv_check = vdi_check,
+    .bdrv_co_check = vdi_co_check,
 };
 
 static void bdrv_vdi_init(void)
diff --git a/block/vhdx.c b/block/vhdx.c
index e42a417ffd..d0f7db9bd7 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1939,8 +1939,9 @@ exit:
  * r/w and any log has already been replayed, so there is nothing (currently)
  * for us to do here
  */
-static int vhdx_check(BlockDriverState *bs, BdrvCheckResult *result,
-                       BdrvCheckMode fix)
+static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
+                                      BdrvCheckResult *result,
+                                      BdrvCheckMode fix)
 {
     BDRVVHDXState *s = bs->opaque;
 
@@ -2001,7 +2002,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_co_writev         = vhdx_co_writev,
     .bdrv_co_create         = vhdx_co_create,
     .bdrv_get_info          = vhdx_get_info,
-    .bdrv_check             = vhdx_check,
+    .bdrv_co_check          = vhdx_co_check,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
 
     .create_opts            = &vhdx_create_opts,
diff --git a/block/vmdk.c b/block/vmdk.c
index 2579cfbec5..4d8f94f27c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2193,8 +2193,9 @@ static ImageInfo *vmdk_get_extent_info(VmdkExtent *extent)
     return info;
 }
 
-static int vmdk_check(BlockDriverState *bs, BdrvCheckResult *result,
-                      BdrvCheckMode fix)
+static int coroutine_fn vmdk_co_check(BlockDriverState *bs,
+                                      BdrvCheckResult *result,
+                                      BdrvCheckMode fix)
 {
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *extent = NULL;
@@ -2353,7 +2354,7 @@ static BlockDriver bdrv_vmdk = {
     .instance_size                = sizeof(BDRVVmdkState),
     .bdrv_probe                   = vmdk_probe,
     .bdrv_open                    = vmdk_open,
-    .bdrv_check                   = vmdk_check,
+    .bdrv_co_check                = vmdk_co_check,
     .bdrv_reopen_prepare          = vmdk_reopen_prepare,
     .bdrv_child_perm              = bdrv_format_default_perms,
     .bdrv_co_preadv               = vmdk_co_preadv,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8558d7b78d..746025763b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -262,8 +262,9 @@ struct BlockDriver {
      * Returns 0 for completed check, -errno for internal errors.
      * The check results are stored in result.
      */
-    int (*bdrv_check)(BlockDriverState *bs, BdrvCheckResult *result,
-        BdrvCheckMode fix);
+    int coroutine_fn (*bdrv_co_check)(BlockDriverState *bs,
+                                      BdrvCheckResult *result,
+                                      BdrvCheckMode fix);
 
     int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
                               BlockDriverAmendStatusCB *status_cb,
-- 
2.13.0
