Received: from eggs.gnu.org ([209.51.188.92]:38772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9fu-00017j-Ff
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk9ft-0005Un-Az
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:33:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 09:33:20 -0600
Message-Id: <20190117153321.29749-3-eblake@redhat.com>
In-Reply-To: <20190117153321.29749-1-eblake@redhat.com>
References: <20190117153321.29749-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] file: Expose some protocol-specific
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:raw" <qemu-block@nongnu.org>

When analyzing performance, it might be nice to let 'qemu-img info'
expose details that it learned from the underlying file or block
device.  Start the process by picking a few useful items determined
during raw_open_common().

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 24 +++++++++++++++++++++++-
 block/file-posix.c   | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f28d5f5fc76..296c22a1003 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -101,6 +101,25 @@
       'extents': ['ImageInfo']
   } }

+##
+# @ImageInfoSpecificFile:
+#
+# Details about a file protocol BDS.
+#
+# @align: Alignment in use
+#
+# @discard: True if discard operations can be attempted
+#
+# @write-zero: True if efficient write zero operations can be attempted
+#
+# @discard-zero: True if discarding is known to read back as zero
+#
+# Since: 4.0
+##
+{ 'struct': 'ImageInfoSpecificFile',
+  'data': { 'align': 'int', 'discard': 'bool', 'write-zero': 'bool',
+            '*discard-zero': 'bool' } }
+
 ##
 # @ImageInfoSpecific:
 #
@@ -110,12 +129,15 @@
 ##
 { 'union': 'ImageInfoSpecific',
   'data': {
+      # Format drivers:
       'qcow2': 'ImageInfoSpecificQCow2',
       'vmdk': 'ImageInfoSpecificVmdk',
       # If we need to add block driver specific parameters for
       # LUKS in future, then we'll subclass QCryptoBlockInfoLUKS
       # to define a ImageInfoSpecificLUKS
-      'luks': 'QCryptoBlockInfoLUKS'
+      'luks': 'QCryptoBlockInfoLUKS',
+      # Protocol drivers:
+      'file': 'ImageInfoSpecificFile'
   } }

 ##
diff --git a/block/file-posix.c b/block/file-posix.c
index 8aee7a3fb8b..d4ce0e9116c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1079,6 +1079,23 @@ static void raw_refresh_limits(BlockDriverState *b=
s, Error **errp)
     bs->bl.opt_mem_alignment =3D MAX(s->buf_align, getpagesize());
 }

+static ImageInfoSpecific *raw_get_specific_info(BlockDriverState *bs)
+{
+    BDRVRawState *s =3D bs->opaque;
+    ImageInfoSpecific *info =3D g_new0(ImageInfoSpecific, 1);
+    ImageInfoSpecificFile *infofile =3D g_new0(ImageInfoSpecificFile, 1)=
;
+
+    info->type =3D IMAGE_INFO_SPECIFIC_KIND_FILE;
+    info->u.file.data =3D infofile;
+    infofile->align =3D s->buf_align;
+    infofile->discard =3D s->has_discard;
+    infofile->write_zero =3D s->has_write_zeroes;
+    infofile->has_discard_zero =3D s->has_discard;
+    infofile->discard_zero =3D s->discard_zeroes;
+
+    return info;
+}
+
 static int check_for_dasd(int fd)
 {
 #ifdef BIODASDINFO2
@@ -2765,6 +2782,7 @@ BlockDriver bdrv_file =3D {
     .bdrv_co_copy_range_from =3D raw_co_copy_range_from,
     .bdrv_co_copy_range_to  =3D raw_co_copy_range_to,
     .bdrv_refresh_limits =3D raw_refresh_limits,
+    .bdrv_get_specific_info =3D raw_get_specific_info,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
@@ -3240,6 +3258,7 @@ static BlockDriver bdrv_host_device =3D {
     .bdrv_co_copy_range_from =3D raw_co_copy_range_from,
     .bdrv_co_copy_range_to  =3D raw_co_copy_range_to,
     .bdrv_refresh_limits =3D raw_refresh_limits,
+    .bdrv_get_specific_info =3D raw_get_specific_info,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
@@ -3363,6 +3382,7 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_co_pwritev        =3D raw_co_pwritev,
     .bdrv_co_flush_to_disk  =3D raw_co_flush_to_disk,
     .bdrv_refresh_limits =3D raw_refresh_limits,
+    .bdrv_get_specific_info =3D raw_get_specific_info,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
@@ -3494,6 +3514,7 @@ static BlockDriver bdrv_host_cdrom =3D {
     .bdrv_co_pwritev        =3D raw_co_pwritev,
     .bdrv_co_flush_to_disk  =3D raw_co_flush_to_disk,
     .bdrv_refresh_limits =3D raw_refresh_limits,
+    .bdrv_get_specific_info =3D raw_get_specific_info,
     .bdrv_io_plug =3D raw_aio_plug,
     .bdrv_io_unplug =3D raw_aio_unplug,
     .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
--=20
2.20.1
