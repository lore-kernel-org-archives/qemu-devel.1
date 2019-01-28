Received: from eggs.gnu.org ([209.51.188.92]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1goBpW-0001eY-0A
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:40:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1goBpR-0005av-S2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:40:21 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 28 Jan 2019 21:40:04 +0300
Message-Id: <1548700805-1016533-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 1/2] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

In the 'Format specific information' section of the 'qemu-img info'
command output, the supplemental information about existing QCOW2
bitmaps will be shown, such as a bitmap name, flags and granularity:

image: /vz/vmprivate/VM1/harddisk.hdd
file format: qcow2
virtual size: 64G (68719476736 bytes)
disk size: 3.0M
cluster_size: 1048576
Format specific information:
    compat: 1.1
    lazy refcounts: true
    bitmaps:
        [0]:
            flags:
                [0]: in-use
                [1]: auto
            name: back-up1
            unknown flags: 4
            granularity: 65536
        [1]:
            flags:
                [0]: in-use
                [1]: auto
            name: back-up2
            unknown flags: 8
            granularity: 65536
    refcount bits: 16
    corrupt: false

As the print of the qcow2 specific information expanded by adding
the bitmap parameters to the 'qemu-img info' command output,
it requires amendment of the output benchmark in the following
tests: 060, 065, 082, 198, and 206.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/qapi.c               |  6 +++++
 block/qcow2-bitmap.c       | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c              | 13 ++++++++++
 block/qcow2.h              |  2 ++
 qapi/block-core.json       | 42 +++++++++++++++++++++++++++++-
 tests/qemu-iotests/060.out |  1 +
 tests/qemu-iotests/065     | 16 ++++++------
 tests/qemu-iotests/082.out |  7 +++++
 tests/qemu-iotests/198.out |  2 ++
 tests/qemu-iotests/206.out |  5 ++++
 10 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index c66f949..0fde98c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -38,6 +38,7 @@
 #include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 
 BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
                                         BlockDriverState *bs, Error **errp)
@@ -868,6 +869,11 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
 
     if (info->has_format_specific) {
         func_fprintf(f, "Format specific information:\n");
+        if (info->format_specific &&
+            info->format_specific->type == IMAGE_INFO_SPECIFIC_KIND_QCOW2 &&
+            info->format_specific->u.qcow2.data->has_bitmaps == false) {
+            warn_report("Failed to load bitmap list");
+        }
         bdrv_image_info_specific_dump(func_fprintf, f, info->format_specific);
     }
 }
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b946301..ae842eb 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1006,6 +1006,70 @@ fail:
     return false;
 }
 
+static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
+{
+    Qcow2BitmapInfoFlagsList *list = NULL;
+    Qcow2BitmapInfoFlagsList **plist = &list;
+
+    if (flags & BME_FLAG_IN_USE) {
+        Qcow2BitmapInfoFlagsList *entry = g_new0(Qcow2BitmapInfoFlagsList, 1);
+        entry->value = QCOW2_BITMAP_INFO_FLAGS_IN_USE;
+        *plist = entry;
+        plist = &entry->next;
+    }
+    if (flags & BME_FLAG_AUTO) {
+        Qcow2BitmapInfoFlagsList *entry = g_new0(Qcow2BitmapInfoFlagsList, 1);
+        entry->value = QCOW2_BITMAP_INFO_FLAGS_AUTO;
+        *plist = entry;
+    }
+    return list;
+}
+
+/*
+ * qcow2_get_bitmap_info_list()
+ * Returns a list of QCOW2 bitmap details.
+ * In case of no bitmaps, the function returns NULL and
+ * the @errp parameter is not set (for a 0-length list in the QMP).
+ * When bitmap information can not be obtained, the function returns
+ * NULL and the @errp parameter is set (for omitting the list in QMP).
+ */
+Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                                Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    Qcow2BitmapInfoList *list = NULL;
+    Qcow2BitmapInfoList **plist = &list;
+
+    if (s->nb_bitmaps == 0) {
+        return NULL;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        return NULL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        Qcow2BitmapInfo *info = g_new0(Qcow2BitmapInfo, 1);
+        Qcow2BitmapInfoList *obj = g_new0(Qcow2BitmapInfoList, 1);
+        info->granularity = 1U << bm->granularity_bits;
+        info->name = g_strdup(bm->name);
+        info->flags = get_bitmap_info_flags(bm->flags);
+        info->unknown_flags = bm->flags & BME_RESERVED_FLAGS;
+        info->has_unknown_flags = !!info->unknown_flags;
+        obj->value = info;
+        *plist = obj;
+        plist = &obj->next;
+    }
+
+    bitmap_list_free(bm_list);
+
+    return list;
+}
+
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897aba..07b99ee 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4386,8 +4386,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("0.10"),
             .refcount_bits      = s->refcount_bits,
+            .has_bitmaps        = true, /* To handle error check properly */
+            .bitmaps            = NULL, /* Unsupported for version 2 */
         };
     } else if (s->qcow_version == 3) {
+        Qcow2BitmapInfoList *bitmaps;
+        Error *local_err = NULL;
+
+        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("1.1"),
             .lazy_refcounts     = s->compatible_features &
@@ -4397,7 +4403,14 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
             .refcount_bits      = s->refcount_bits,
+            .has_bitmaps        = !local_err,
+            .bitmaps            = bitmaps,
         };
+        /*
+         * If an error occurs in obtaining bitmaps, ignore
+         * it to show other QCOW2 specific information.
+         */
+        error_free(local_err);
     } else {
         /* if this assertion fails, this probably means a new version was
          * added without having it covered here */
diff --git a/block/qcow2.h b/block/qcow2.h
index 438a1de..13e8964 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -684,6 +684,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                                Error **errp);
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91685be..3352562 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -69,6 +69,10 @@
 # @encrypt: details about encryption parameters; only set if image
 #           is encrypted (since 2.10)
 #
+# @bitmaps: A list of qcow2 bitmap details (possibly empty, such as for
+#           v2 images which do not support bitmaps); absent if bitmap
+#           information could not be obtained (since 4.0)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -77,7 +81,8 @@
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
-      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
+      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
+      '*bitmaps': ['Qcow2BitmapInfo']
   } }
 
 ##
@@ -454,6 +459,41 @@
            'status': 'DirtyBitmapStatus'} }
 
 ##
+# @Qcow2BitmapInfoFlags:
+#
+# An enumeration of flags that a bitmap can report to the user.
+#
+# @in-use: The bitmap was not saved correctly and may be inconsistent.
+#
+# @auto: The bitmap must reflect all changes of the virtual disk by any
+#        application that would write to this qcow2 file.
+#
+# Since: 4.0
+##
+{ 'enum': 'Qcow2BitmapInfoFlags',
+  'data': ['in-use', 'auto'] }
+
+##
+# @Qcow2BitmapInfo:
+#
+# Qcow2 bitmap information.
+#
+# @name: the name of the bitmap
+#
+# @granularity: granularity of the bitmap in bytes
+#
+# @flags: flags of the bitmap
+#
+# @unknown-flags: unspecified flags if detected
+#
+# Since: 4.0
+##
+{ 'struct': 'Qcow2BitmapInfo',
+  'data': {'name': 'str', 'granularity': 'uint32',
+           'flags': ['Qcow2BitmapInfoFlags'],
+           '*unknown-flags': 'uint32' } }
+
+##
 # @BlockLatencyHistogramInfo:
 #
 # Block latency histogram.
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index af623cf..d0438b2 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -18,6 +18,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
+    bitmaps:
     refcount bits: 16
     corrupt: true
 can't open device TEST_DIR/t.IMGFMT: IMGFMT: Image is corrupt; cannot be opened read/write
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 8bac383..86406cb 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -88,23 +88,23 @@ class TestQMP(TestImageInfoSpecific):
 class TestQCow2(TestQemuImgInfo):
     '''Testing a qcow2 version 2 image'''
     img_options = 'compat=0.10'
-    json_compare = { 'compat': '0.10', 'refcount-bits': 16 }
-    human_compare = [ 'compat: 0.10', 'refcount bits: 16' ]
+    json_compare = { 'compat': '0.10', 'bitmaps': [], 'refcount-bits': 16 }
+    human_compare = [ 'compat: 0.10', 'bitmaps:', 'refcount bits: 16' ]
 
 class TestQCow3NotLazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
     img_options = 'compat=1.1,lazy_refcounts=off'
-    json_compare = { 'compat': '1.1', 'lazy-refcounts': False,
+    json_compare = { 'compat': '1.1', 'lazy-refcounts': False, 'bitmaps': [],
                      'refcount-bits': 16, 'corrupt': False }
-    human_compare = [ 'compat: 1.1', 'lazy refcounts: false',
+    human_compare = [ 'compat: 1.1', 'lazy refcounts: false', 'bitmaps:',
                       'refcount bits: 16', 'corrupt: false' ]
 
 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
     img_options = 'compat=1.1,lazy_refcounts=on'
-    json_compare = { 'compat': '1.1', 'lazy-refcounts': True,
+    json_compare = { 'compat': '1.1', 'lazy-refcounts': True, 'bitmaps': [],
                      'refcount-bits': 16, 'corrupt': False }
-    human_compare = [ 'compat: 1.1', 'lazy refcounts: true',
+    human_compare = [ 'compat: 1.1', 'lazy refcounts: true', 'bitmaps:',
                       'refcount bits: 16', 'corrupt: false' ]
 
 class TestQCow3NotLazyQMP(TestQMP):
@@ -112,7 +112,7 @@ class TestQCow3NotLazyQMP(TestQMP):
        with lazy refcounts enabled'''
     img_options = 'compat=1.1,lazy_refcounts=off'
     qemu_options = 'lazy-refcounts=on'
-    compare = { 'compat': '1.1', 'lazy-refcounts': False,
+    compare = { 'compat': '1.1', 'lazy-refcounts': False, 'bitmaps': [],
                 'refcount-bits': 16, 'corrupt': False }
 
 
@@ -121,7 +121,7 @@ class TestQCow3LazyQMP(TestQMP):
        with lazy refcounts disabled'''
     img_options = 'compat=1.1,lazy_refcounts=on'
     qemu_options = 'lazy-refcounts=off'
-    compare = { 'compat': '1.1', 'lazy-refcounts': True,
+    compare = { 'compat': '1.1', 'lazy-refcounts': True, 'bitmaps': [],
                 'refcount-bits': 16, 'corrupt': False }
 
 TestImageInfoSpecific = None
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 0ce18c0..cfae9c4 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -18,6 +18,7 @@ cluster_size: 4096
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -30,6 +31,7 @@ cluster_size: 8192
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -276,6 +278,7 @@ cluster_size: 4096
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -287,6 +290,7 @@ cluster_size: 8192
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -529,6 +533,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -540,6 +545,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -551,6 +557,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index adb805c..aeee3c6 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -36,6 +36,7 @@ image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"driver"
 file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 Format specific information:
+    bitmaps:
     encrypt:
         ivgen alg: plain64
         hash alg: sha256
@@ -79,6 +80,7 @@ file format: IMGFMT
 virtual size: 16M (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
 Format specific information:
+    bitmaps:
     encrypt:
         ivgen alg: plain64
         hash alg: sha256
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 91f4db5..9758569 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -19,6 +19,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -41,6 +42,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
+    bitmaps:
     refcount bits: 16
     corrupt: false
 
@@ -63,6 +65,7 @@ cluster_size: 2097152
 Format specific information:
     compat: 1.1
     lazy refcounts: true
+    bitmaps:
     refcount bits: 1
     corrupt: false
 
@@ -86,6 +89,7 @@ backing file: TEST_IMG.base
 backing file format: IMGFMT
 Format specific information:
     compat: 0.10
+    bitmaps:
     refcount bits: 16
 
 === Successful image creation (encrypted) ===
@@ -103,6 +107,7 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
+    bitmaps:
     refcount bits: 16
     encrypt:
         ivgen alg: plain64
-- 
1.8.3.1
