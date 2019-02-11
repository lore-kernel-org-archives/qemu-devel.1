Received: from eggs.gnu.org ([209.51.188.92]:53643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYX-0007C5-1d
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYK-0006eQ-FD
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Feb 2019 14:51:26 -0600
Message-Id: <20190211205128.27146-3-eblake@redhat.com>
In-Reply-To: <20190211205128.27146-1-eblake@redhat.com>
References: <20190211205128.27146-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] bdrv_query_image_info Error parameter added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Inform a user in case qcow2_get_specific_info fails to obtain
QCOW2 image specific information. This patch is preliminary to
the one "qcow2: Add list of bitmaps to ImageInfoSpecificQCow2".

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1549638368-530182-2-git-send-email-andrey.shinkevich@virtuoz=
zo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h     |  3 ++-
 include/block/block_int.h |  3 ++-
 block.c                   |  5 +++--
 block/crypto.c            |  9 +++------
 block/qapi.c              |  7 ++++++-
 block/qcow2.c             | 10 ++++++++--
 block/vmdk.c              |  3 ++-
 qemu-io-cmds.c            |  7 ++++++-
 8 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 57233cf2c0c..73357c6c250 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -478,7 +478,8 @@ const char *bdrv_get_device_name(const BlockDriverSta=
te *bs);
 const char *bdrv_get_device_or_node_name(const BlockDriverState *bs);
 int bdrv_get_flags(BlockDriverState *bs);
 int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
-ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs);
+ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
+                                          Error **errp);
 void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, int64_t bytes,
                             int64_t *cluster_offset,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216d..0075bafd105 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -319,7 +319,8 @@ struct BlockDriver {
                                   const char *name,
                                   Error **errp);
     int (*bdrv_get_info)(BlockDriverState *bs, BlockDriverInfo *bdi);
-    ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs);
+    ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs,
+                                                 Error **errp);

     int coroutine_fn (*bdrv_save_vmstate)(BlockDriverState *bs,
                                           QEMUIOVector *qiov,
diff --git a/block.c b/block.c
index b67d9b7b657..4ad0e90d7e3 100644
--- a/block.c
+++ b/block.c
@@ -4462,11 +4462,12 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriv=
erInfo *bdi)
     return drv->bdrv_get_info(bs, bdi);
 }

-ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs)
+ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
+                                          Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
     if (drv && drv->bdrv_get_specific_info) {
-        return drv->bdrv_get_specific_info(bs);
+        return drv->bdrv_get_specific_info(bs, errp);
     }
     return NULL;
 }
diff --git a/block/crypto.c b/block/crypto.c
index f0a5f6b9873..d5b1da66a1d 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -594,20 +594,17 @@ static int block_crypto_get_info_luks(BlockDriverSt=
ate *bs,
 }

 static ImageInfoSpecific *
-block_crypto_get_specific_info_luks(BlockDriverState *bs)
+block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
 {
     BlockCrypto *crypto =3D bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *info;

-    info =3D qcrypto_block_get_info(crypto->block, NULL);
+    info =3D qcrypto_block_get_info(crypto->block, errp);
     if (!info) {
         return NULL;
     }
-    if (info->format !=3D Q_CRYPTO_BLOCK_FORMAT_LUKS) {
-        qapi_free_QCryptoBlockInfo(info);
-        return NULL;
-    }
+    assert(info->format =3D=3D Q_CRYPTO_BLOCK_FORMAT_LUKS);

     spec_info =3D g_new(ImageInfoSpecific, 1);
     spec_info->type =3D IMAGE_INFO_SPECIFIC_KIND_LUKS;
diff --git a/block/qapi.c b/block/qapi.c
index c66f949db83..00291f91059 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -282,7 +282,12 @@ void bdrv_query_image_info(BlockDriverState *bs,
         info->dirty_flag =3D bdi.is_dirty;
         info->has_dirty_flag =3D true;
     }
-    info->format_specific     =3D bdrv_get_specific_info(bs);
+    info->format_specific =3D bdrv_get_specific_info(bs, &err);
+    if (err) {
+        error_propagate(errp, err);
+        qapi_free_ImageInfo(info);
+        goto out;
+    }
     info->has_format_specific =3D info->format_specific !=3D NULL;

     backing_filename =3D bs->backing_file;
diff --git a/block/qcow2.c b/block/qcow2.c
index 8c91b928653..bcb80d0270c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4368,14 +4368,20 @@ static int qcow2_get_info(BlockDriverState *bs, B=
lockDriverInfo *bdi)
     return 0;
 }

-static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
+static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
+                                                  Error **errp)
 {
     BDRVQcow2State *s =3D bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *encrypt_info =3D NULL;
+    Error *local_err =3D NULL;

     if (s->crypto !=3D NULL) {
-        encrypt_info =3D qcrypto_block_get_info(s->crypto, &error_abort)=
;
+        encrypt_info =3D qcrypto_block_get_info(s->crypto, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return NULL;
+        }
     }

     spec_info =3D g_new(ImageInfoSpecific, 1);
diff --git a/block/vmdk.c b/block/vmdk.c
index 682ad93aa1e..096e8eb6627 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2543,7 +2543,8 @@ static int coroutine_fn vmdk_co_check(BlockDriverSt=
ate *bs,
     return ret;
 }

-static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs)
+static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs,
+                                                 Error **errp)
 {
     int i;
     BDRVVmdkState *s =3D bs->opaque;
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index ee8f56e46ae..b9f189f09bb 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1661,6 +1661,7 @@ static int info_f(BlockBackend *blk, int argc, char=
 **argv)
     BlockDriverState *bs =3D blk_bs(blk);
     BlockDriverInfo bdi;
     ImageInfoSpecific *spec_info;
+    Error *local_err =3D NULL;
     char s1[64], s2[64];
     int ret;

@@ -1682,7 +1683,11 @@ static int info_f(BlockBackend *blk, int argc, cha=
r **argv)
     printf("cluster size: %s\n", s1);
     printf("vm state offset: %s\n", s2);

-    spec_info =3D bdrv_get_specific_info(bs);
+    spec_info =3D bdrv_get_specific_info(bs, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EIO;
+    }
     if (spec_info) {
         printf("Format specific information:\n");
         bdrv_image_info_specific_dump(fprintf, stdout, spec_info);
--=20
2.20.1
