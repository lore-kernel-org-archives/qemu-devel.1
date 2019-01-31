Received: from eggs.gnu.org ([209.51.188.92]:57511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gpCg9-0004v5-Mn
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gpCg7-0003YR-3A
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:46:53 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Thu, 31 Jan 2019 16:46:43 +0300
Message-Id: <1548942405-760115-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v11 1/3] bdrv_query_image_info Error parameter
 added
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

Inform a user in case qcow2_get_specific_info fails to obtain
QCOW2 image specific information. This patch is preliminary to
the print of bitmap information in the 'qemu-img info' output.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                   |  5 +++--
 block/crypto.c            |  4 ++--
 block/qapi.c              |  7 ++++++-
 block/qcow2.c             | 10 ++++++++--
 block/vmdk.c              |  3 ++-
 include/block/block.h     |  3 ++-
 include/block/block_int.h |  3 ++-
 qemu-io-cmds.c            |  7 ++++++-
 8 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index 4f5ff2c..1eb35ef 100644
--- a/block.c
+++ b/block.c
@@ -4307,11 +4307,12 @@ int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return drv->bdrv_get_info(bs, bdi);
 }
 
-ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs)
+ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
+                                          Error **errp)
 {
     BlockDriver *drv = bs->drv;
     if (drv && drv->bdrv_get_specific_info) {
-        return drv->bdrv_get_specific_info(bs);
+        return drv->bdrv_get_specific_info(bs, errp);
     }
     return NULL;
 }
diff --git a/block/crypto.c b/block/crypto.c
index f0a5f6b..4ede833 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -594,13 +594,13 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
 }
 
 static ImageInfoSpecific *
-block_crypto_get_specific_info_luks(BlockDriverState *bs)
+block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *info;
 
-    info = qcrypto_block_get_info(crypto->block, NULL);
+    info = qcrypto_block_get_info(crypto->block, errp);
     if (!info) {
         return NULL;
     }
diff --git a/block/qapi.c b/block/qapi.c
index c66f949..f53f100 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -282,7 +282,12 @@ void bdrv_query_image_info(BlockDriverState *bs,
         info->dirty_flag = bdi.is_dirty;
         info->has_dirty_flag = true;
     }
-    info->format_specific     = bdrv_get_specific_info(bs);
+    info->format_specific     = bdrv_get_specific_info(bs, &err);
+    if (err) {
+        error_propagate(errp, err);
+        qapi_free_ImageInfo(info);
+        goto out;
+    }
     info->has_format_specific = info->format_specific != NULL;
 
     backing_filename = bs->backing_file;
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897aba..27e5a2c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4367,14 +4367,20 @@ static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
-static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
+static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
+                                                  Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *encrypt_info = NULL;
+    Error *local_err = NULL;
 
     if (s->crypto != NULL) {
-        encrypt_info = qcrypto_block_get_info(s->crypto, &error_abort);
+        encrypt_info = qcrypto_block_get_info(s->crypto, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return NULL;
+        }
     }
 
     spec_info = g_new(ImageInfoSpecific, 1);
diff --git a/block/vmdk.c b/block/vmdk.c
index 2c9e86d..544c10d 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2314,7 +2314,8 @@ static int coroutine_fn vmdk_co_check(BlockDriverState *bs,
     return ret;
 }
 
-static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs)
+static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs,
+                                                 Error **errp)
 {
     int i;
     BDRVVmdkState *s = bs->opaque;
diff --git a/include/block/block.h b/include/block/block.h
index f70a843..9899c24 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -477,7 +477,8 @@ const char *bdrv_get_device_name(const BlockDriverState *bs);
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
index f605622..0075baf 100644
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
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c39124..2187036 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1661,6 +1661,7 @@ static int info_f(BlockBackend *blk, int argc, char **argv)
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverInfo bdi;
     ImageInfoSpecific *spec_info;
+    Error *local_err = NULL;
     char s1[64], s2[64];
     int ret;
 
@@ -1682,7 +1683,11 @@ static int info_f(BlockBackend *blk, int argc, char **argv)
     printf("cluster size: %s\n", s1);
     printf("vm state offset: %s\n", s2);
 
-    spec_info = bdrv_get_specific_info(bs);
+    spec_info = bdrv_get_specific_info(bs, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EIO;
+    }
     if (spec_info) {
         printf("Format specific information:\n");
         bdrv_image_info_specific_dump(fprintf, stdout, spec_info);
-- 
1.8.3.1
