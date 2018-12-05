Received: from eggs.gnu.org ([2001:4830:134:3::10]:58904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gUaMH-0005C3-Em
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gUaMD-0001gx-D6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:49:09 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed,  5 Dec 2018 19:48:59 +0300
Message-Id: <1544028539-1010808-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2] qemu-img info lists bitmap directory entries
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
    bitmaps:
        [0]:
            flags:
                [0]: in-use
                [1]: auto
            name: {257b5ea5-38c5-410e-a457-71c76f763c60}
            unknown flags: 4
            granularity: 65536
        [1]:
            flags:
                [0]: in-use
                [1]: auto
            name: back-up
            unknown flags: 8
            granularity: 65536
    refcount bits: 16
    corrupt: false

v2:
The targeted version of the release at 'Since' word of the comments to the new
structures changed to 4.0 in the file qapi/block-core.json.
A comment to the 'bitmaps' new member was supplied.
The 'unknown flags' parameter was introduced to indicate presence of QCOW2
bitmap unknown flags, if any.
The word 'dirty' was removed from the code and from the comments as we list all
the bitmaps.
The 'bitmaps' printed parameter was removed for the release versions earlier
than 3.x.
The example of the output was moved above the 'Signed-off-by' line.

The first version was '[PATCH] qemu-img info lists bitmap directory entries'

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/qcow2-bitmap.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  9 +++++++++
 block/qcow2.h        |  2 ++
 qapi/block-core.json | 40 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index accebef..0c292e5 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1008,6 +1008,58 @@ fail:
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
+        info->unknown_flags = bm->flags & ~(BME_FLAG_IN_USE | BME_FLAG_AUTO);
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
index 991d6ac..5e43b70 100644
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
@@ -4279,6 +4286,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
             .refcount_bits      = s->refcount_bits,
+            .has_bitmaps        = !!bitmaps,
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
index d4fe710..d6d9bd7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -69,6 +69,8 @@
 # @encrypt: details about encryption parameters; only set if image
 #           is encrypted (since 2.10)
 #
+# @bitmaps: list of qcow2 bitmaps details (since 4.0)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -77,7 +79,8 @@
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
-      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
+      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
+      '*bitmaps': ['Qcow2BitmapInfo']
   } }
 
 ##
@@ -454,6 +457,41 @@
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
+# Since: 4.0
+##
+{ 'enum': 'Qcow2BitmapInfoFlags',
+  'data': ['in-use', 'auto'] }
+
+##
+# @Qcow2BitmapInfo:
+#
+# Image bitmap information.
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
-- 
1.8.3.1
