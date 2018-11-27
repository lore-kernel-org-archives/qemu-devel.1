Received: from eggs.gnu.org ([2001:4830:134:3::10]:52349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gRcg5-0001c4-OD
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gRcg0-0001hK-TO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:41:21 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 27 Nov 2018 15:41:06 +0300
Message-Id: <1543322466-525229-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qemu-img info lists bitmap directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The 'Format specific information' of qemu-img info command will show
the name, flags and granularity for every QCOW2 bitmap.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
Dear colleagues,

With this patch, qemu-img info will display a name, flags and granularity
information for every bitmap in the directory section of a QCOW2 image.
That information appears in the 'Format specific information' section as
it's shown in the following example:

image: /vz/vmprivate/VM1/harddisk.hdd
file format: qcow2
virtual size: 64G (68719476736 bytes)
disk size: 3.0M
cluster_size: 1048576
Format specific information:
    compat: 1.1
    lazy refcounts: true
    refcount bits: 16
    dirty bitmaps:
        [0]:
            flags:
                [0]: in-use
                [1]: auto
            name: {257b5ea5-38c5-410e-a457-71c76f763c60}
            granularity: 65536
        [1]:
            flags:
                [0]: in-use
                [1]: auto
            name: back-up
            granularity: 65536
    corrupt: false

 block/qcow2-bitmap.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        | 10 ++++++++++
 block/qcow2.h        |  2 ++
 qapi/block-core.json | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index accebef..dcc53db 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1008,6 +1008,56 @@ fail:
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
+Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                                Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    Qcow2BitmapInfoList *list = NULL;
+    Qcow2BitmapInfoList **plist = &list;
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
index 991d6ac..6485f79 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4254,6 +4254,13 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
     BDRVQcow2State *s = bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *encrypt_info = NULL;
+    Error *local_err = NULL;
+    Qcow2BitmapInfoList *bitmaps;
+
+    bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
+    if (local_err != NULL) {
+        error_report_err(local_err);
+    }
 
     if (s->crypto != NULL) {
         encrypt_info = qcrypto_block_get_info(s->crypto, &error_abort);
@@ -4268,6 +4275,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("0.10"),
             .refcount_bits      = s->refcount_bits,
+            .bitmaps            = bitmaps,
         };
     } else if (s->qcow_version == 3) {
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
@@ -4279,6 +4287,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
             .refcount_bits      = s->refcount_bits,
+            .has_bitmaps        = bitmaps ? true : false,
+            .bitmaps            = bitmaps,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
diff --git a/block/qcow2.h b/block/qcow2.h
index 8662b68..0ec2b3d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -685,6 +685,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                                Error **errp);
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f4538fa..e021ead 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -77,7 +77,8 @@
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
-      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
+      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
+      '*bitmaps': ['Qcow2BitmapInfo']
   } }
 
 ##
@@ -454,6 +455,38 @@
            'status': 'DirtyBitmapStatus'} }
 
 ##
+# @Qcow2BitmapInfoFlags:
+#
+# An enumeration of states that a bitmap can report to the user.
+#
+# @in-use: The bitmap was not saved correctly and may be inconsistent.
+#
+# @auto: The bitmap must reflect all changes of the virtual disk by any
+#        application that would write to this qcow2 file.
+#
+# Since: 3.2
+##
+{ 'enum': 'Qcow2BitmapInfoFlags',
+  'data': ['in-use', 'auto'] }
+
+##
+# @Qcow2BitmapInfo:
+#
+# Image bitmap information.
+#
+# @name: the name of the dirty bitmap
+#
+# @granularity: granularity of the dirty bitmap in bytes
+#
+# @flags: flags of the dirty bitmap
+#
+# Since: 3.2
+##
+{ 'struct': 'Qcow2BitmapInfo',
+  'data': {'name': 'str', 'granularity': 'uint32',
+           'flags': ['Qcow2BitmapInfoFlags']} }
+
+##
 # @BlockLatencyHistogramInfo:
 #
 # Block latency histogram.
-- 
1.8.3.1
