Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2424120851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2424120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTq1Y-0006Se-9W
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:52:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hTpwT-00039P-J8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hTpwR-0007uO-EM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:47:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hTpwR-0007tO-2I; Thu, 23 May 2019 11:47:39 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hTpwL-0002xl-W7; Thu, 23 May 2019 18:47:34 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:47:33 +0300
Message-Id: <20190523154733.54944-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190523154733.54944-1-vsementsov@virtuozzo.com>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
 reopening logic
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current logic
=============

Reopen rw -> ro:

Store bitmaps and release BdrvDirtyBitmap's.

Reopen ro -> rw:

Load bitmap list
Skip bitmaps which for which we don't have BdrvDirtyBitmap [this is
   the worst thing]
A kind of fail with error message if we see not readonly bitmap

This leads to at least the following bug:

Assume we have bitmap0.
Create external snapshot
  bitmap0 is stored and therefore removed
Commit snapshot
  now we have no bitmaps
Do some writes from guest (*)
  they are not marked in bitmap
Shutdown
Start
  bitmap0 is loaded as valid, but it is actually broken! It misses
  writes (*)
Incremental backup
  it will be inconsistent

New logic
=========

Reopen rw -> ro:

Store bitmaps and don't remove them from RAM, only mark them readonly
(the latter is already done, but didn't work properly because of
removing in storing function)

Reopen to rw (don't filter case with reopen rw -> rw, it is supported
now in qcow2_reopen_bitmaps_rw)

Load bitmap list

Carefully consider all possible combinations of bitmaps in RAM and in
the image, try to fix corruptions, print corresponding error messages.

Also, call qcow2_reopen_bitmaps_rw after the whole reopen queue
commited, as otherwise we can't write to the qcow2 file child on reopen
ro -> rw.

Also, add corresponding test-cases to 255.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h              |   5 +-
 include/block/block_int.h  |   2 +-
 block.c                    |  29 ++----
 block/qcow2-bitmap.c       | 197 ++++++++++++++++++++++++++-----------
 block/qcow2.c              |   2 +-
 tests/qemu-iotests/255     |   2 +
 tests/qemu-iotests/255.out |  35 +++++++
 7 files changed, 193 insertions(+), 79 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8d92ef1fee..5928306e62 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -725,9 +725,10 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                                 Error **errp);
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
-int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+void qcow2_reopen_bitmaps_rw(BlockDriverState *bs);
 int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                          bool release_stored, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1eebc7c8f3..9a694f3da0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -536,7 +536,7 @@ struct BlockDriver {
      * as rw. This handler should realize it. It also should unset readonly
      * field of BlockDirtyBitmap's in case of success.
      */
-    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
+    void (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs);
     bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
                                             const char *name,
                                             uint32_t granularity,
diff --git a/block.c b/block.c
index cb11537029..db1ec0c673 100644
--- a/block.c
+++ b/block.c
@@ -3334,6 +3334,16 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         bdrv_reopen_commit(&bs_entry->state);
     }
 
+    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+        BlockDriverState *bs = bs_entry->state.bs;
+
+        if (!bdrv_is_writable(bs) || !bs->drv->bdrv_reopen_bitmaps_rw) {
+            continue;
+        }
+
+        bs->drv->bdrv_reopen_bitmaps_rw(bs);
+    }
+
     ret = 0;
 cleanup_perm:
     QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
@@ -3770,16 +3780,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     BlockDriver *drv;
     BlockDriverState *bs;
     BdrvChild *child;
-    bool old_can_write, new_can_write;
 
     assert(reopen_state != NULL);
     bs = reopen_state->bs;
     drv = bs->drv;
     assert(drv != NULL);
 
-    old_can_write =
-        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
-
     /* If there are any driver level actions to take */
     if (drv->bdrv_reopen_commit) {
         drv->bdrv_reopen_commit(reopen_state);
@@ -3823,21 +3829,6 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     }
 
     bdrv_refresh_limits(bs, NULL);
-
-    new_can_write =
-        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
-    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) {
-        Error *local_err = NULL;
-        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
-            /* This is not fatal, bitmaps just left read-only, so all following
-             * writes will fail. User can remove read-only bitmaps to unblock
-             * writes.
-             */
-            error_reportf_err(local_err,
-                              "%s: Failed to make dirty bitmaps writable: ",
-                              bdrv_get_node_name(bs));
-        }
-    }
 }
 
 /*
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 2b84bfa007..4e565db11f 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 
 #include "block/block_int.h"
 #include "qcow2.h"
@@ -951,6 +952,12 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
 }
 
+/* for g_slist_foreach for GSList of const char* elements */
+static void error_report_helper(gpointer message, gpointer _unused)
+{
+    error_report("%s", (const char *)message);
+}
+
 /* qcow2_load_dirty_bitmaps()
  * Return value is a hint for caller: true means that the Qcow2 header was
  * updated. (false doesn't mean that the header should be updated by the
@@ -1103,76 +1110,150 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
     return list;
 }
 
-int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
-                                 Error **errp)
+/*
+ * qcow2_reopen_bitmaps_rw
+ *
+ * The function is called in bdrv_reopen_multiple after all calls to
+ * bdrv_reopen_commit, when final bs is writable. It is done so, as we need
+ * write access to child bs, and with current reopening architecture, when
+ * reopen ro -> rw it is possible only after all reopen commits.
+ *
+ * So, we can't fail here. On the other hand, we may face different kinds of
+ * corruptions and/or just can't write IN_USE flags to the image due to EIO.
+ *
+ * Try to handle as many cases as we can.
+ */
+void qcow2_reopen_bitmaps_rw(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
-    GSList *ro_dirty_bitmaps = NULL;
+    GSList *ro_dirty_bitmaps = NULL, *corrupted_bitmaps = NULL;
+    Error *local_err = NULL;
     int ret = 0;
-
-    if (header_updated != NULL) {
-        *header_updated = false;
-    }
+    bool need_update = false, updated_ok = false;
 
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
-        return 0;
-    }
-
-    if (!can_write(bs)) {
-        error_setg(errp, "Can't write to the image on reopening bitmaps rw");
-        return -EINVAL;
+        return;
     }
 
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+                               s->bitmap_directory_size, &local_err);
     if (bm_list == NULL) {
-        return -EINVAL;
+        error_reportf_err(local_err, "Failed to reopen bitmaps rw: "
+                          "cannot load bitmap list: ");
+        return;
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
         BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
-        if (bitmap == NULL) {
-            continue;
-        }
+        const char *corruption = NULL;
 
-        if (!bdrv_dirty_bitmap_readonly(bitmap)) {
-            error_setg(errp, "Bitmap %s was loaded prior to rw-reopen, but was "
-                       "not marked as readonly. This is a bug, something went "
-                       "wrong. All of the bitmaps may be corrupted", bm->name);
-            ret = -EINVAL;
-            goto out;
-        }
+        if (bm->flags & BME_FLAG_IN_USE) {
+            if (bitmap == NULL) {
+                /*
+                 * It's an unexpected inconsistent bitmap,
+                 * it is safe to ignore it.
+                 */
+                continue;
+            }
 
-        bm->flags |= BME_FLAG_IN_USE;
-        ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+            /*
+             * It's either an inconsistent bitmap, or we are reopening rw -> rw,
+             * or we just didn't save bitmap for some buggy reason. Still, no
+             * reason to consider in-RAM bitmap inconsistent, than, mark it rw.
+             */
+            bdrv_dirty_bitmap_set_readonly(bitmap, false);
+        } else {
+            /*
+             * In-image bitmap not marked IN_USE
+             *
+             * The only valid case is
+             *     bitmap && bdrv_dirty_bitmap_readonly(bitmap) &&
+             *        !bdrv_dirty_bitmap_inconsistent(bitmap))
+             *
+             * which means reopen ro -> rw of consistent bitmap.
+             *
+             * Other cases a different kinds of corruptions:
+             */
+            if (!bitmap) {
+                corruption =
+                    "Corruption: unexpected valid bitmap '%s' is found in the "
+                    "image '%s' on reopen rw. Will try to set IN_USE flag.";
+
+                bitmap = load_bitmap(bs, bm, NULL);
+                if (!bitmap) {
+                    bitmap = bdrv_create_dirty_bitmap(
+                            bs, bdrv_get_default_bitmap_granularity(bs),
+                            bm->name, NULL);
+                }
+
+                if (bitmap) {
+                    bdrv_dirty_bitmap_set_persistence(bitmap, true);
+                    bdrv_dirty_bitmap_set_readonly(bitmap, true);
+                    bdrv_dirty_bitmap_set_inconsistent(bitmap);
+                }
+            } else if (!bdrv_dirty_bitmap_readonly(bitmap)) {
+                corruption =
+                    "Corruption: bitmap '%s' is not marked IN_USE in the "
+                    "image '%s' and not marked readonly in RAM. Will try to "
+                    "set IN_USE flag.";
+
+                bdrv_dirty_bitmap_set_readonly(bitmap, true);
+                bdrv_dirty_bitmap_set_inconsistent(bitmap);
+            } else if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+                corruption =
+                    "Corruption: bitmap '%s' is inconsistent but is not marked "
+                    "IN_USE in the image. Will try to set IN_USE flag.";
+
+                bdrv_dirty_bitmap_set_readonly(bitmap, true);
+            }
+
+            if (bitmap) {
+                ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+            }
+            bm->flags |= BME_FLAG_IN_USE;
+            need_update = true;
+            if (corruption) {
+                error_report(corruption, bm->name, bs->filename);
+                corrupted_bitmaps = g_slist_append(corrupted_bitmaps, bm->name);
+            }
+        }
     }
 
-    if (ro_dirty_bitmaps != NULL) {
+    if (need_update) {
+        if (!can_write(bs->file->bs)) {
+            error_report("Failed to reopen bitmaps rw: cannot write to "
+                         "the protocol file");
+            goto handle_corrupted;
+        }
+
         /* in_use flags must be updated */
         ret = update_ext_header_and_dir_in_place(bs, bm_list);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Can't update bitmap directory");
-            goto out;
-        }
-        if (header_updated != NULL) {
-            *header_updated = true;
+            error_report("Cannot update bitmap directory: %s", strerror(-ret));
+            goto handle_corrupted;
         }
+        updated_ok = true;
         g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
     }
 
-out:
+handle_corrupted:
+    if (corrupted_bitmaps) {
+        if (updated_ok) {
+            error_report("Corrupted bitmaps in '%s' successfully marked "
+                         "IN_USE", bs->filename);
+        } else {
+            error_report("Failed to mark IN_USE the following corrupted "
+                         "bitmaps in '%s', DO NOT USE THEM:", bs->filename);
+            g_slist_foreach(corrupted_bitmaps, error_report_helper, NULL);
+        }
+    }
+
     g_slist_free(ro_dirty_bitmaps);
+    g_slist_free(corrupted_bitmaps);
     bitmap_list_free(bm_list);
-
-    return ret;
-}
-
-int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
-{
-    return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
 }
 
 /* Checks to see if it's safe to resize bitmaps */
@@ -1446,7 +1527,8 @@ fail:
     bitmap_list_free(bm_list);
 }
 
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                          bool release_stored, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s = bs->opaque;
@@ -1559,20 +1641,23 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         g_free(tb);
     }
 
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        /* For safety, we remove bitmap after storing.
-         * We may be here in two cases:
-         * 1. bdrv_close. It's ok to drop bitmap.
-         * 2. inactivation. It means migration without 'dirty-bitmaps'
-         *    capability, so bitmaps are not marked with
-         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
-         *    and reload on invalidation.
-         */
-        if (bm->dirty_bitmap == NULL) {
-            continue;
-        }
+    if (release_stored) {
+        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+            /*
+             * For safety, we remove bitmap after storing.
+             * We may be here in two cases:
+             * 1. bdrv_close. It's ok to drop bitmap.
+             * 2. inactivation. It means migration without 'dirty-bitmaps'
+             *    capability, so bitmaps are not marked with
+             *    BdrvDirtyBitmap.migration flags. It's not bad to drop them
+             *    too, and reload on invalidation.
+             */
+            if (bm->dirty_bitmap == NULL) {
+                continue;
+            }
 
-        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+            bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+        }
     }
 
 success:
@@ -1600,7 +1685,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
     BdrvDirtyBitmap *bitmap;
     Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return -EINVAL;
diff --git a/block/qcow2.c b/block/qcow2.c
index d39882785d..f0a8479874 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2273,7 +2273,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
     int ret, result = 0;
     Error *local_err = NULL;
 
-    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    qcow2_store_persistent_dirty_bitmaps(bs, true, &local_err);
     if (local_err != NULL) {
         result = -EINVAL;
         error_reportf_err(local_err, "Lost persistent bitmaps during "
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 36712689d3..e8b0c9d4bb 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -79,3 +79,5 @@ def test(persistent, restart):
 
 
 test(persistent=False, restart=False)
+test(persistent=True, restart=False)
+test(persistent=True, restart=True)
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index 2bffb486d2..46e2e3ad4e 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -15,3 +15,38 @@ check, that no bitmaps in snapshot: not found
 {"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 check merged bitmap: name=bitmap0 dirty-clusters=2
 check updated bitmap: name=bitmap0 dirty-clusters=3
+
+Testcase persistent without restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check, that no bitmaps in snapshot: not found
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check merged bitmap: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
+
+Testcase persistent with restart
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0", "persistent": true}}
+{"return": {}}
+initial bitmap: name=bitmap0 dirty-clusters=1
+{"execute": "blockdev-snapshot-sync", "arguments": {"device": "drive0", "format": "qcow2", "snapshot-file": "TEST_DIR/PID-top"}}
+{"return": {}}
+check, that no bitmaps in snapshot: not found
+... Restart ...
+{"execute": "block-commit", "arguments": {"device": "drive0", "top": "TEST_DIR/PID-top"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "block-job-complete", "arguments": {"device": "drive0"}}
+{"return": {}}
+{"data": {"device": "drive0", "len": 65536, "offset": 65536, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+check merged bitmap: name=bitmap0 dirty-clusters=2
+check updated bitmap: name=bitmap0 dirty-clusters=3
-- 
2.18.0


