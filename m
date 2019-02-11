Received: from eggs.gnu.org ([209.51.188.92]:53642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYX-0007C4-5D
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYK-0006eP-F9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Feb 2019 14:51:27 -0600
Message-Id: <20190211205128.27146-4-eblake@redhat.com>
In-Reply-To: <20190211205128.27146-1-eblake@redhat.com>
References: <20190211205128.27146-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

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
            granularity: 65536
        [1]:
            flags:
                [0]: in-use
                [1]: auto
            name: back-up2
            granularity: 65536
    refcount bits: 16
    corrupt: false

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1549638368-530182-3-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 41 +++++++++++++++++++++++-
 block/qcow2.h        |  2 ++
 block/qcow2-bitmap.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        | 11 ++++++-
 4 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5f17d67d714..0f349d46033 100644
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
@@ -453,6 +456,42 @@
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
            'status': 'DirtyBitmapStatus'} }

+##
+# @Qcow2BitmapInfoFlags:
+#
+# An enumeration of flags that a bitmap can report to the user.
+#
+# @in-use: This flag is set by any process actively modifying the qcow2 =
file,
+#          and cleared when the updated bitmap is flushed to the qcow2 i=
mage.
+#          The presence of this flag in an offline image means that the =
bitmap
+#          was not saved correctly after its last usage, and may contain
+#          inconsistent data.
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
+# Since: 4.0
+##
+{ 'struct': 'Qcow2BitmapInfo',
+  'data': {'name': 'str', 'granularity': 'uint32',
+           'flags': ['Qcow2BitmapInfoFlags'] } }
+
 ##
 # @BlockLatencyHistogramInfo:
 #
diff --git a/block/qcow2.h b/block/qcow2.h
index 32cce9eee22..9dd02df831c 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -684,6 +684,8 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *b=
s, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
+                                                Error **errp);
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_upda=
ted,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b9463014292..3ee524da4b5 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1006,6 +1006,82 @@ fail:
     return false;
 }

+
+static Qcow2BitmapInfoFlagsList *get_bitmap_info_flags(uint32_t flags)
+{
+    Qcow2BitmapInfoFlagsList *list =3D NULL;
+    Qcow2BitmapInfoFlagsList **plist =3D &list;
+    int i;
+
+    static const struct {
+        int bme;  /* Bitmap directory entry flags */
+        int info; /* The flags to report to the user */
+    } map[] =3D {
+        { BME_FLAG_IN_USE, QCOW2_BITMAP_INFO_FLAGS_IN_USE },
+        { BME_FLAG_AUTO,   QCOW2_BITMAP_INFO_FLAGS_AUTO },
+    };
+
+    int map_size =3D ARRAY_SIZE(map);
+
+    for (i =3D 0; i < map_size; ++i) {
+        if (flags & map[i].bme) {
+            Qcow2BitmapInfoFlagsList *entry =3D
+                g_new0(Qcow2BitmapInfoFlagsList, 1);
+            entry->value =3D map[i].info;
+            *plist =3D entry;
+            plist =3D &entry->next;
+            flags &=3D ~map[i].bme;
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
+    BDRVQcow2State *s =3D bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    Qcow2BitmapInfoList *list =3D NULL;
+    Qcow2BitmapInfoList **plist =3D &list;
+
+    if (s->nb_bitmaps =3D=3D 0) {
+        return NULL;
+    }
+
+    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list =3D=3D NULL) {
+        return NULL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        Qcow2BitmapInfo *info =3D g_new0(Qcow2BitmapInfo, 1);
+        Qcow2BitmapInfoList *obj =3D g_new0(Qcow2BitmapInfoList, 1);
+        info->granularity =3D 1U << bm->granularity_bits;
+        info->name =3D g_strdup(bm->name);
+        info->flags =3D get_bitmap_info_flags(bm->flags & ~BME_RESERVED_=
FLAGS);
+        obj->value =3D info;
+        *plist =3D obj;
+        plist =3D &obj->next;
+    }
+
+    bitmap_list_free(bm_list);
+
+    return list;
+}
+
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_upda=
ted,
                                  Error **errp)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index bcb80d0270c..65a54c9ac65 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4387,7 +4387,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(B=
lockDriverState *bs,
     spec_info =3D g_new(ImageInfoSpecific, 1);
     *spec_info =3D (ImageInfoSpecific){
         .type  =3D IMAGE_INFO_SPECIFIC_KIND_QCOW2,
-        .u.qcow2.data =3D g_new(ImageInfoSpecificQCow2, 1),
+        .u.qcow2.data =3D g_new0(ImageInfoSpecificQCow2, 1),
     };
     if (s->qcow_version =3D=3D 2) {
         *spec_info->u.qcow2.data =3D (ImageInfoSpecificQCow2){
@@ -4395,6 +4395,13 @@ static ImageInfoSpecific *qcow2_get_specific_info(=
BlockDriverState *bs,
             .refcount_bits      =3D s->refcount_bits,
         };
     } else if (s->qcow_version =3D=3D 3) {
+        Qcow2BitmapInfoList *bitmaps;
+        bitmaps =3D qcow2_get_bitmap_info_list(bs, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            qapi_free_ImageInfoSpecific(spec_info);
+            return NULL;
+        }
         *spec_info->u.qcow2.data =3D (ImageInfoSpecificQCow2){
             .compat             =3D g_strdup("1.1"),
             .lazy_refcounts     =3D s->compatible_features &
@@ -4404,6 +4411,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(B=
lockDriverState *bs,
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        =3D true,
             .refcount_bits      =3D s->refcount_bits,
+            .has_bitmaps        =3D !!bitmaps,
+            .bitmaps            =3D bitmaps,
         };
     } else {
         /* if this assertion fails, this probably means a new version wa=
s
--=20
2.20.1
