Received: from eggs.gnu.org ([209.51.188.92]:57508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gpCg9-0004ux-Eg
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gpCg7-0003YI-0l
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:46:53 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 31 Jan 2019 16:46:44 +0300
Message-Id: <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
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
Cc: eblake@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

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

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/qcow2-bitmap.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        | 11 +++++++-
 block/qcow2.h        |  2 ++
 qapi/block-core.json | 40 ++++++++++++++++++++++++++-
 4 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b946301..516994e 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1006,6 +1006,84 @@ fail:
     return false;
 }
 
+
+static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
+{
+    Qcow2BitmapInfoFlagsList *list = NULL;
+    Qcow2BitmapInfoFlagsList **plist = &list;
+    int i;
+
+    static const struct {
+        int bme;  /* Bitmap directory entry flags */
+        int info; /* The flags to report to the user */
+    } map[] = {
+        { BME_FLAG_IN_USE, QCOW2_BITMAP_INFO_FLAGS_IN_USE },
+        { BME_FLAG_AUTO,   QCOW2_BITMAP_INFO_FLAGS_AUTO },
+    };
+
+    int map_size = sizeof(map) / sizeof(map[0]);
+
+    for (i = 0; i < map_size; ++i) {
+        if (flags & map[i].bme) {
+            Qcow2BitmapInfoFlagsList *entry =
+                g_new0(Qcow2BitmapInfoFlagsList, 1);
+            entry->value = map[i].info;
+            *plist = entry;
+            plist = &entry->next;
+            flags &= ~map[i].bme;
+        }
+    }
+    /* Check if the BME_* mapping above is complete */
+    assert(!flags);
+
+    return list;
+}
+
+/*
+ * qcow2_get_bitmap_info_list()
+ * Returns a list of QCOW2 bitmap details.
+ * In case of no bitmaps, the function returns NULL and
+ * the @errp parameter is not set.
+ * When bitmap information can not be obtained, the function returns
+ * NULL and the @errp parameter is set.
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
+        info->flags = get_bitmap_info_flags(bm->flags & ~BME_RESERVED_FLAGS);
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
index 27e5a2c..a5607f1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4386,7 +4386,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
     spec_info = g_new(ImageInfoSpecific, 1);
     *spec_info = (ImageInfoSpecific){
         .type  = IMAGE_INFO_SPECIFIC_KIND_QCOW2,
-        .u.qcow2.data = g_new(ImageInfoSpecificQCow2, 1),
+        .u.qcow2.data = g_new0(ImageInfoSpecificQCow2, 1),
     };
     if (s->qcow_version == 2) {
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
@@ -4394,6 +4394,13 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
             .refcount_bits      = s->refcount_bits,
         };
     } else if (s->qcow_version == 3) {
+        Qcow2BitmapInfoList *bitmaps;
+        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qapi_free_ImageInfoSpecific(spec_info);
+            return NULL;
+        }
         *spec_info->u.qcow2.data = (ImageInfoSpecificQCow2){
             .compat             = g_strdup("1.1"),
             .lazy_refcounts     = s->compatible_features &
@@ -4403,6 +4410,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        = true,
             .refcount_bits      = s->refcount_bits,
+            .has_bitmaps        = !!bitmaps,
+            .bitmaps            = bitmaps,
         };
     } else {
         /* if this assertion fails, this probably means a new version was
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
index 91685be..271e0df 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -69,6 +69,8 @@
 # @encrypt: details about encryption parameters; only set if image
 #           is encrypted (since 2.10)
 #
+# @bitmaps: A list of qcow2 bitmap details (since 4.0)
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
+# @flags: recognized flags of the bitmap
+#
+# @unknown-flags: any remaining flags not recognized by the current qemu version
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
