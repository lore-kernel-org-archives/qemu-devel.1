Received: from eggs.gnu.org ([2001:4830:134:3::10]:52902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmF-0004OM-JY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmC-0001eI-Cw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:47 +0200
Message-Id: <20180611142611.6609-6-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 05/29] block: Add Error parameter to
 bdrv_amend_options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Looking at the qcow2 code that is riddled with error_report() calls,
this is really how it should have been from the start.

Along the way, turn the target_version/current_version comparisons at
the beginning of qcow2_downgrade() into assertions (the caller has to
make sure these conditions are met), and rephrase the error message on
using compat=1.1 to get refcount widths other than 16 bits.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180509210023.20283-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h      |  3 +-
 include/block/block_int.h  |  3 +-
 block.c                    |  8 +++--
 block/qcow2.c              | 72 ++++++++++++++++++++++----------------
 qemu-img.c                 |  4 +--
 tests/qemu-iotests/060.out |  4 +--
 tests/qemu-iotests/061.out |  7 ----
 tests/qemu-iotests/080.out |  4 +--
 tests/qemu-iotests/112.out |  5 +--
 9 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6cc6c7e699..4dd4f1eab2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -343,7 +343,8 @@ int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
 typedef void BlockDriverAmendStatusCB(BlockDriverState *bs, int64_t offset,
                                       int64_t total_work_size, void *opaque);
 int bdrv_amend_options(BlockDriverState *bs_new, QemuOpts *opts,
-                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque);
+                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+                       Error **errp);
 
 /* external snapshots */
 bool bdrv_recurse_is_first_non_filter(BlockDriverState *bs,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 888b7f7bff..327e478a73 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -353,7 +353,8 @@ struct BlockDriver {
 
     int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
                               BlockDriverAmendStatusCB *status_cb,
-                              void *cb_opaque);
+                              void *cb_opaque,
+                              Error **errp);
 
     void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
 
diff --git a/block.c b/block.c
index 501b64c819..9d577f65bb 100644
--- a/block.c
+++ b/block.c
@@ -4996,15 +4996,19 @@ void bdrv_remove_aio_context_notifier(BlockDriverState *bs,
 }
 
 int bdrv_amend_options(BlockDriverState *bs, QemuOpts *opts,
-                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque)
+                       BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+                       Error **errp)
 {
     if (!bs->drv) {
+        error_setg(errp, "Node is ejected");
         return -ENOMEDIUM;
     }
     if (!bs->drv->bdrv_amend_options) {
+        error_setg(errp, "Block driver '%s' does not support option amendment",
+                   bs->drv->format_name);
         return -ENOTSUP;
     }
-    return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque);
+    return bs->drv->bdrv_amend_options(bs, opts, status_cb, cb_opaque, errp);
 }
 
 /* This function will be called by the bdrv_recurse_is_first_non_filter method
diff --git a/block/qcow2.c b/block/qcow2.c
index 549fee9b69..6b2d88759d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4215,22 +4215,21 @@ static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
  * have to be removed.
  */
 static int qcow2_downgrade(BlockDriverState *bs, int target_version,
-                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque)
+                           BlockDriverAmendStatusCB *status_cb, void *cb_opaque,
+                           Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int current_version = s->qcow_version;
     int ret;
 
-    if (target_version == current_version) {
-        return 0;
-    } else if (target_version > current_version) {
-        return -EINVAL;
-    } else if (target_version != 2) {
-        return -EINVAL;
-    }
+    /* This is qcow2_downgrade(), not qcow2_upgrade() */
+    assert(target_version < current_version);
+
+    /* There are no other versions (now) that you can downgrade to */
+    assert(target_version == 2);
 
     if (s->refcount_order != 4) {
-        error_report("compat=0.10 requires refcount_bits=16");
+        error_setg(errp, "compat=0.10 requires refcount_bits=16");
         return -ENOTSUP;
     }
 
@@ -4238,6 +4237,7 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
     if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
         ret = qcow2_mark_clean(bs);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to make the image clean");
             return ret;
         }
     }
@@ -4247,6 +4247,8 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
      * best thing to do anyway */
 
     if (s->incompatible_features) {
+        error_setg(errp, "Cannot downgrade an image with incompatible features "
+                   "%#" PRIx64 " set", s->incompatible_features);
         return -ENOTSUP;
     }
 
@@ -4260,6 +4262,7 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
 
     ret = qcow2_expand_zero_clusters(bs, status_cb, cb_opaque);
     if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to turn zero into data clusters");
         return ret;
     }
 
@@ -4267,6 +4270,7 @@ static int qcow2_downgrade(BlockDriverState *bs, int target_version,
     ret = qcow2_update_header(bs);
     if (ret < 0) {
         s->qcow_version = current_version;
+        error_setg_errno(errp, -ret, "Failed to update the image header");
         return ret;
     }
     return 0;
@@ -4344,7 +4348,8 @@ static void qcow2_amend_helper_cb(BlockDriverState *bs,
 
 static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                BlockDriverAmendStatusCB *status_cb,
-                               void *cb_opaque)
+                               void *cb_opaque,
+                               Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int old_version = s->qcow_version, new_version = old_version;
@@ -4356,7 +4361,6 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     bool encrypt;
     int encformat;
     int refcount_bits = s->refcount_bits;
-    Error *local_err = NULL;
     int ret;
     QemuOptDesc *desc = opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
@@ -4377,11 +4381,11 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             } else if (!strcmp(compat, "1.1")) {
                 new_version = 3;
             } else {
-                error_report("Unknown compatibility level %s", compat);
+                error_setg(errp, "Unknown compatibility level %s", compat);
                 return -EINVAL;
             }
         } else if (!strcmp(desc->name, BLOCK_OPT_PREALLOC)) {
-            error_report("Cannot change preallocation mode");
+            error_setg(errp, "Cannot change preallocation mode");
             return -ENOTSUP;
         } else if (!strcmp(desc->name, BLOCK_OPT_SIZE)) {
             new_size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
@@ -4394,7 +4398,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                                         !!s->crypto);
 
             if (encrypt != !!s->crypto) {
-                error_report("Changing the encryption flag is not supported");
+                error_setg(errp,
+                           "Changing the encryption flag is not supported");
                 return -ENOTSUP;
             }
         } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT_FORMAT)) {
@@ -4402,17 +4407,19 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                 qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT));
 
             if (encformat != s->crypt_method_header) {
-                error_report("Changing the encryption format is not supported");
+                error_setg(errp,
+                           "Changing the encryption format is not supported");
                 return -ENOTSUP;
             }
         } else if (g_str_has_prefix(desc->name, "encrypt.")) {
-            error_report("Changing the encryption parameters is not supported");
+            error_setg(errp,
+                       "Changing the encryption parameters is not supported");
             return -ENOTSUP;
         } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
             cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
                                              cluster_size);
             if (cluster_size != s->cluster_size) {
-                error_report("Changing the cluster size is not supported");
+                error_setg(errp, "Changing the cluster size is not supported");
                 return -ENOTSUP;
             }
         } else if (!strcmp(desc->name, BLOCK_OPT_LAZY_REFCOUNTS)) {
@@ -4425,8 +4432,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             if (refcount_bits <= 0 || refcount_bits > 64 ||
                 !is_power_of_2(refcount_bits))
             {
-                error_report("Refcount width must be a power of two and may "
-                             "not exceed 64 bits");
+                error_setg(errp, "Refcount width must be a power of two and "
+                           "may not exceed 64 bits");
                 return -EINVAL;
             }
         } else {
@@ -4451,6 +4458,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         ret = qcow2_update_header(bs);
         if (ret < 0) {
             s->qcow_version = old_version;
+            error_setg_errno(errp, -ret, "Failed to update the image header");
             return ret;
         }
     }
@@ -4459,18 +4467,17 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         int refcount_order = ctz32(refcount_bits);
 
         if (new_version < 3 && refcount_bits != 16) {
-            error_report("Different refcount widths than 16 bits require "
-                         "compatibility level 1.1 or above (use compat=1.1 or "
-                         "greater)");
+            error_setg(errp, "Refcount widths other than 16 bits require "
+                       "compatibility level 1.1 or above (use compat=1.1 or "
+                       "greater)");
             return -EINVAL;
         }
 
         helper_cb_info.current_operation = QCOW2_CHANGING_REFCOUNT_ORDER;
         ret = qcow2_change_refcount_order(bs, refcount_order,
                                           &qcow2_amend_helper_cb,
-                                          &helper_cb_info, &local_err);
+                                          &helper_cb_info, errp);
         if (ret < 0) {
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -4480,6 +4487,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                     backing_file ?: s->image_backing_file,
                     backing_format ?: s->image_backing_format);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to change the backing file");
             return ret;
         }
     }
@@ -4487,14 +4495,16 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     if (s->use_lazy_refcounts != lazy_refcounts) {
         if (lazy_refcounts) {
             if (new_version < 3) {
-                error_report("Lazy refcounts only supported with compatibility "
-                             "level 1.1 and above (use compat=1.1 or greater)");
+                error_setg(errp, "Lazy refcounts only supported with "
+                           "compatibility level 1.1 and above (use compat=1.1 "
+                           "or greater)");
                 return -EINVAL;
             }
             s->compatible_features |= QCOW2_COMPAT_LAZY_REFCOUNTS;
             ret = qcow2_update_header(bs);
             if (ret < 0) {
                 s->compatible_features &= ~QCOW2_COMPAT_LAZY_REFCOUNTS;
+                error_setg_errno(errp, -ret, "Failed to update the image header");
                 return ret;
             }
             s->use_lazy_refcounts = true;
@@ -4502,6 +4512,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             /* make image clean first */
             ret = qcow2_mark_clean(bs);
             if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to make the image clean");
                 return ret;
             }
             /* now disallow lazy refcounts */
@@ -4509,6 +4520,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             ret = qcow2_update_header(bs);
             if (ret < 0) {
                 s->compatible_features |= QCOW2_COMPAT_LAZY_REFCOUNTS;
+                error_setg_errno(errp, -ret, "Failed to update the image header");
                 return ret;
             }
             s->use_lazy_refcounts = false;
@@ -4517,17 +4529,15 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
 
     if (new_size) {
         BlockBackend *blk = blk_new(BLK_PERM_RESIZE, BLK_PERM_ALL);
-        ret = blk_insert_bs(blk, bs, &local_err);
+        ret = blk_insert_bs(blk, bs, errp);
         if (ret < 0) {
-            error_report_err(local_err);
             blk_unref(blk);
             return ret;
         }
 
-        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, &local_err);
+        ret = blk_truncate(blk, new_size, PREALLOC_MODE_OFF, errp);
         blk_unref(blk);
         if (ret < 0) {
-            error_report_err(local_err);
             return ret;
         }
     }
@@ -4536,7 +4546,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     if (new_version < old_version) {
         helper_cb_info.current_operation = QCOW2_DOWNGRADING;
         ret = qcow2_downgrade(bs, new_version, &qcow2_amend_helper_cb,
-                              &helper_cb_info);
+                              &helper_cb_info, errp);
         if (ret < 0) {
             return ret;
         }
diff --git a/qemu-img.c b/qemu-img.c
index 0be11b3852..df3ec5b7fe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3810,10 +3810,10 @@ static int img_amend(int argc, char **argv)
 
     /* In case the driver does not call amend_status_cb() */
     qemu_progress_print(0.f, 0);
-    ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL);
+    ret = bdrv_amend_options(bs, opts, &amend_status_cb, NULL, &err);
     qemu_progress_print(100.f, 0);
     if (ret < 0) {
-        error_report("Error while amending options: %s", strerror(-ret));
+        error_report_err(err);
         goto out;
     }
 
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 25d5c3938b..5f4264cff6 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -129,7 +129,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: L2 table offset 0x42a00 unaligned (L1 index: 0); further corruption events will be suppressed
-qemu-img: Error while amending options: Input/output error
+qemu-img: Failed to turn zero into data clusters: Input/output error
 
 === Testing unaligned L2 entry ===
 
@@ -145,7 +145,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Cluster allocation offset 0x52a00 unaligned (L2 offset: 0x40000, L2 index: 0); further corruption events will be suppressed
-qemu-img: Error while amending options: Input/output error
+qemu-img: Failed to turn zero into data clusters: Input/output error
 
 === Testing unaligned reftable entry ===
 
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index e857ef9a7d..183f7dd690 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -358,18 +358,12 @@ No errors were found on the image.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
-qemu-img: Error while amending options: Invalid argument
 qemu-img: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
-qemu-img: Error while amending options: Invalid argument
 qemu-img: Unknown compatibility level 0.42
-qemu-img: Error while amending options: Invalid argument
 qemu-img: Invalid parameter 'foo'
 qemu-img: Changing the cluster size is not supported
-qemu-img: Error while amending options: Operation not supported
 qemu-img: Changing the encryption flag is not supported
-qemu-img: Error while amending options: Operation not supported
 qemu-img: Cannot change preallocation mode
-qemu-img: Error while amending options: Operation not supported
 
 === Testing correct handling of unset value ===
 
@@ -377,7 +371,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Should work:
 Should not work:
 qemu-img: Changing the cluster size is not supported
-qemu-img: Error while amending options: Operation not supported
 
 === Testing zero expansion on inactive clusters ===
 
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 4e0f7f7b92..281c7e0d1d 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -65,7 +65,7 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Snapshot L1 table offset invalid
-qemu-img: Error while amending options: Invalid argument
+qemu-img: Failed to turn zero into data clusters: Invalid argument
 Failed to flush the refcount block cache: Invalid argument
 write failed: Invalid argument
 qemu-img: Snapshot L1 table offset invalid
@@ -88,7 +88,7 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Snapshot L1 table too large
-qemu-img: Error while amending options: File too large
+qemu-img: Failed to turn zero into data clusters: File too large
 Failed to flush the refcount block cache: File too large
 write failed: File too large
 qemu-img: Snapshot L1 table too large
diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index 86f041075d..ae0318cabe 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -99,13 +99,11 @@ refcount bits: 64
 === Amend to compat=0.10 ===
 
 qemu-img: compat=0.10 requires refcount_bits=16
-qemu-img: Error while amending options: Operation not supported
 refcount bits: 64
 No errors were found on the image.
 refcount bits: 16
 refcount bits: 16
-qemu-img: Different refcount widths than 16 bits require compatibility level 1.1 or above (use compat=1.1 or greater)
-qemu-img: Error while amending options: Invalid argument
+qemu-img: Refcount widths other than 16 bits require compatibility level 1.1 or above (use compat=1.1 or greater)
 refcount bits: 16
 
 === Amend with snapshot ===
@@ -113,7 +111,6 @@ refcount bits: 16
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Cannot decrease refcount entry width to 1 bits: Cluster at offset 0x50000 has a refcount of 2
-qemu-img: Error while amending options: Invalid argument
 No errors were found on the image.
 refcount bits: 16
 No errors were found on the image.
-- 
2.17.1
