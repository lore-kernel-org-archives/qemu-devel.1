Received: from eggs.gnu.org ([209.51.188.92]:39540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboN-00084I-S0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpboK-0000IR-Dq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:37:02 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:35:05 +0100
Message-Id: <20190201163518.31157-15-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/27] block/vdi: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this.

Instead of passing UUID related functions the address of a possibly
unaligned QemuUUID struct, use local variables and then copy to/from
the struct field as appropriate.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 2380daa583..4cc726047c 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -235,7 +235,8 @@ static void vdi_header_to_le(VdiHeader *header)
=20
 static void vdi_header_print(VdiHeader *header)
 {
-    char uuid[37];
+    char uuidstr[37];
+    QemuUUID uuid;
     logout("text        %s", header->text);
     logout("signature   0x%08x\n", header->signature);
     logout("header size 0x%04x\n", header->header_size);
@@ -254,14 +255,18 @@ static void vdi_header_print(VdiHeader *header)
     logout("block extra 0x%04x\n", header->block_extra);
     logout("blocks tot. 0x%04x\n", header->blocks_in_image);
     logout("blocks all. 0x%04x\n", header->blocks_allocated);
-    qemu_uuid_unparse(&header->uuid_image, uuid);
-    logout("uuid image  %s\n", uuid);
-    qemu_uuid_unparse(&header->uuid_last_snap, uuid);
-    logout("uuid snap   %s\n", uuid);
-    qemu_uuid_unparse(&header->uuid_link, uuid);
-    logout("uuid link   %s\n", uuid);
-    qemu_uuid_unparse(&header->uuid_parent, uuid);
-    logout("uuid parent %s\n", uuid);
+    uuid =3D header->uuid_image;
+    qemu_uuid_unparse(&uuid, uuidstr);
+    logout("uuid image  %s\n", uuidstr);
+    uuid =3D header->uuid_last_snap;
+    qemu_uuid_unparse(&uuid, uuidstr);
+    logout("uuid snap   %s\n", uuidstr);
+    uuid =3D header->uuid_link;
+    qemu_uuid_unparse(&uuid, uuidstr);
+    logout("uuid link   %s\n", uuidstr);
+    uuid =3D header->uuid_parent;
+    qemu_uuid_unparse(&uuid, uuidstr);
+    logout("uuid parent %s\n", uuidstr);
 }
=20
 static int coroutine_fn vdi_co_check(BlockDriverState *bs, BdrvCheckResu=
lt *res,
@@ -368,6 +373,7 @@ static int vdi_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     size_t bmap_size;
     int ret;
     Error *local_err =3D NULL;
+    QemuUUID uuid_link, uuid_parent;
=20
     bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
@@ -395,6 +401,9 @@ static int vdi_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
         goto fail;
     }
=20
+    uuid_link =3D header.uuid_link;
+    uuid_parent =3D header.uuid_parent;
+
     if (header.disk_size % SECTOR_SIZE !=3D 0) {
         /* 'VBoxManage convertfromraw' can create images with odd disk s=
izes.
            We accept them but round the disk size to the next multiple o=
f
@@ -444,11 +453,11 @@ static int vdi_open(BlockDriverState *bs, QDict *op=
tions, int flags,
                    (uint64_t)header.blocks_in_image * header.block_size)=
;
         ret =3D -ENOTSUP;
         goto fail;
-    } else if (!qemu_uuid_is_null(&header.uuid_link)) {
+    } else if (!qemu_uuid_is_null(&uuid_link)) {
         error_setg(errp, "unsupported VDI image (non-NULL link UUID)");
         ret =3D -ENOTSUP;
         goto fail;
-    } else if (!qemu_uuid_is_null(&header.uuid_parent)) {
+    } else if (!qemu_uuid_is_null(&uuid_parent)) {
         error_setg(errp, "unsupported VDI image (non-NULL parent UUID)")=
;
         ret =3D -ENOTSUP;
         goto fail;
@@ -733,6 +742,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCrea=
teOptions *create_options,
     BlockDriverState *bs_file =3D NULL;
     BlockBackend *blk =3D NULL;
     uint32_t *bmap =3D NULL;
+    QemuUUID uuid;
=20
     assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_VDI);
     vdi_opts =3D &create_options->u.vdi;
@@ -819,8 +829,10 @@ static int coroutine_fn vdi_co_do_create(BlockdevCre=
ateOptions *create_options,
     if (image_type =3D=3D VDI_TYPE_STATIC) {
         header.blocks_allocated =3D blocks;
     }
-    qemu_uuid_generate(&header.uuid_image);
-    qemu_uuid_generate(&header.uuid_last_snap);
+    qemu_uuid_generate(&uuid);
+    header.uuid_image =3D uuid;
+    qemu_uuid_generate(&uuid);
+    header.uuid_last_snap =3D uuid;
     /* There is no need to set header.uuid_link or header.uuid_parent he=
re. */
     if (VDI_DEBUG) {
         vdi_header_print(&header);
--=20
2.20.1
