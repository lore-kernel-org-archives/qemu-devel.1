Received: from eggs.gnu.org ([2001:4830:134:3::10]:33060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qF-K3
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002gH-SA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47737 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002f9-BZ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:28 +0300
Message-Id: <20170525152628.37628-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 7/7] block: rename _get_allocated_file_size()
 to _get_fs_allocated_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

To be in contrast with _get_format_allocated_size()

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c                   |  8 ++++----
 block/file-posix.c        | 14 +++++---------
 block/file-win32.c        |  8 +++-----
 block/gluster.c           |  8 ++++----
 block/nfs.c               |  8 ++++----
 block/qapi.c              |  2 +-
 block/sheepdog.c          |  8 ++++----
 block/vmdk.c              |  8 ++++----
 include/block/block.h     |  2 +-
 include/block/block_int.h |  2 +-
 10 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/block.c b/block.c
index 6e1a435490..9f4bb37c54 100644
--- a/block.c
+++ b/block.c
@@ -3391,17 +3391,17 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
  * Size of allocated in underlying file system area. Sparseness is taken into
  * account for sparse file systems. Return < 0 if error or unknown.
  */
-int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
+int64_t bdrv_get_fs_allocated_size(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
     if (!drv) {
         return -ENOMEDIUM;
     }
-    if (drv->bdrv_get_allocated_file_size) {
-        return drv->bdrv_get_allocated_file_size(bs);
+    if (drv->bdrv_get_fs_allocated_size) {
+        return drv->bdrv_get_fs_allocated_size(bs);
     }
     if (bs->file) {
-        return bdrv_get_allocated_file_size(bs->file->bs);
+        return bdrv_get_fs_allocated_size(bs->file->bs);
     }
     return -ENOTSUP;
 }
diff --git a/block/file-posix.c b/block/file-posix.c
index 4354d49642..46ca4728b3 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1829,7 +1829,7 @@ static int64_t raw_getlength(BlockDriverState *bs)
 }
 #endif
 
-static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
+static int64_t raw_get_fs_allocated_size(BlockDriverState *bs)
 {
     struct stat st;
     BDRVRawState *s = bs->opaque;
@@ -2218,8 +2218,7 @@ BlockDriver bdrv_file = {
     .bdrv_truncate = raw_truncate,
     .bdrv_getlength = raw_getlength,
     .bdrv_get_info = raw_get_info,
-    .bdrv_get_allocated_file_size
-                        = raw_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = raw_get_fs_allocated_size,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -2679,8 +2678,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_truncate      = raw_truncate,
     .bdrv_getlength	= raw_getlength,
     .bdrv_get_info = raw_get_info,
-    .bdrv_get_allocated_file_size
-                        = raw_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = raw_get_fs_allocated_size,
     .bdrv_check_perm = raw_check_perm,
     .bdrv_set_perm   = raw_set_perm,
     .bdrv_abort_perm_update = raw_abort_perm_update,
@@ -2803,8 +2801,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_truncate      = raw_truncate,
     .bdrv_getlength      = raw_getlength,
     .has_variable_length = true,
-    .bdrv_get_allocated_file_size
-                        = raw_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = raw_get_fs_allocated_size,
 
     /* removable device support */
     .bdrv_is_inserted   = cdrom_is_inserted,
@@ -2933,8 +2930,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_truncate      = raw_truncate,
     .bdrv_getlength      = raw_getlength,
     .has_variable_length = true,
-    .bdrv_get_allocated_file_size
-                        = raw_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = raw_get_fs_allocated_size,
 
     /* removable device support */
     .bdrv_is_inserted   = cdrom_is_inserted,
diff --git a/block/file-win32.c b/block/file-win32.c
index 8f14f0bdcd..e246b8954b 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -524,7 +524,7 @@ static int64_t raw_getlength(BlockDriverState *bs)
     return l.QuadPart;
 }
 
-static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
+static int64_t raw_get_fs_allocated_size(BlockDriverState *bs)
 {
     typedef DWORD (WINAPI * get_compressed_t)(const char *filename,
                                               DWORD * high);
@@ -604,8 +604,7 @@ BlockDriver bdrv_file = {
 
     .bdrv_truncate	= raw_truncate,
     .bdrv_getlength	= raw_getlength,
-    .bdrv_get_allocated_file_size
-                        = raw_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = raw_get_fs_allocated_size,
 
     .create_opts        = &raw_create_opts,
 };
@@ -773,8 +772,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_getlength      = raw_getlength,
     .has_variable_length = true,
 
-    .bdrv_get_allocated_file_size
-                        = raw_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = raw_get_fs_allocated_size,
 };
 
 static void bdrv_file_init(void)
diff --git a/block/gluster.c b/block/gluster.c
index 7c76cd0988..4509602d83 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1407,7 +1407,7 @@ static BlockDriver bdrv_gluster = {
     .bdrv_close                   = qemu_gluster_close,
     .bdrv_create                  = qemu_gluster_create,
     .bdrv_getlength               = qemu_gluster_getlength,
-    .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
+    .bdrv_get_fs_allocated_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
@@ -1435,7 +1435,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .bdrv_close                   = qemu_gluster_close,
     .bdrv_create                  = qemu_gluster_create,
     .bdrv_getlength               = qemu_gluster_getlength,
-    .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
+    .bdrv_get_fs_allocated_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
@@ -1463,7 +1463,7 @@ static BlockDriver bdrv_gluster_unix = {
     .bdrv_close                   = qemu_gluster_close,
     .bdrv_create                  = qemu_gluster_create,
     .bdrv_getlength               = qemu_gluster_getlength,
-    .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
+    .bdrv_get_fs_allocated_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
@@ -1497,7 +1497,7 @@ static BlockDriver bdrv_gluster_rdma = {
     .bdrv_close                   = qemu_gluster_close,
     .bdrv_create                  = qemu_gluster_create,
     .bdrv_getlength               = qemu_gluster_getlength,
-    .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
+    .bdrv_get_fs_allocated_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
     .bdrv_co_readv                = qemu_gluster_co_readv,
     .bdrv_co_writev               = qemu_gluster_co_writev,
diff --git a/block/nfs.c b/block/nfs.c
index 848b2c0bb0..0aa5288a07 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -719,7 +719,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
 
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
-nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
+nfs_get_fs_allocated_size_cb(int ret, struct nfs_context *nfs, void *data,
                                void *private_data)
 {
     NFSRPC *task = private_data;
@@ -734,7 +734,7 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     bdrv_wakeup(task->bs);
 }
 
-static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
+static int64_t nfs_get_fs_allocated_size(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task = {0};
@@ -747,7 +747,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 
     task.bs = bs;
     task.st = &st;
-    if (nfs_fstat_async(client->context, client->fh, nfs_get_allocated_file_size_cb,
+    if (nfs_fstat_async(client->context, client->fh, nfs_get_fs_allocated_size_cb,
                         &task) != 0) {
         return -ENOMEM;
     }
@@ -880,7 +880,7 @@ static BlockDriver bdrv_nfs = {
     .create_opts                    = &nfs_create_opts,
 
     .bdrv_has_zero_init             = nfs_has_zero_init,
-    .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size   = nfs_get_fs_allocated_size,
     .bdrv_truncate                  = nfs_file_truncate,
 
     .bdrv_file_open                 = nfs_file_open,
diff --git a/block/qapi.c b/block/qapi.c
index d249d97142..6dc3575785 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -246,7 +246,7 @@ void bdrv_query_image_info(BlockDriverState *bs,
     info->filename        = g_strdup(bs->filename);
     info->format          = g_strdup(bdrv_get_format_name(bs));
     info->virtual_size    = size;
-    info->actual_size     = bdrv_get_allocated_file_size(bs);
+    info->actual_size     = bdrv_get_fs_allocated_size(bs);
     info->has_actual_size = info->actual_size >= 0;
     if (bdrv_is_encrypted(bs)) {
         info->encrypted = true;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a18315a1ca..d6195981d4 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3003,7 +3003,7 @@ sd_co_get_block_status(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
     return ret;
 }
 
-static int64_t sd_get_allocated_file_size(BlockDriverState *bs)
+static int64_t sd_get_fs_allocated_size(BlockDriverState *bs)
 {
     BDRVSheepdogState *s = bs->opaque;
     SheepdogInode *inode = &s->inode;
@@ -3066,7 +3066,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_create    = sd_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_getlength = sd_getlength,
-    .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = sd_get_fs_allocated_size,
     .bdrv_truncate  = sd_truncate,
 
     .bdrv_co_readv  = sd_co_readv,
@@ -3102,7 +3102,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_create    = sd_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_getlength = sd_getlength,
-    .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = sd_get_fs_allocated_size,
     .bdrv_truncate  = sd_truncate,
 
     .bdrv_co_readv  = sd_co_readv,
@@ -3138,7 +3138,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_create    = sd_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_getlength = sd_getlength,
-    .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = sd_get_fs_allocated_size,
     .bdrv_truncate  = sd_truncate,
 
     .bdrv_co_readv  = sd_co_readv,
diff --git a/block/vmdk.c b/block/vmdk.c
index 55581b03fe..bfb53204c6 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2134,14 +2134,14 @@ static coroutine_fn int vmdk_co_flush(BlockDriverState *bs)
     return ret;
 }
 
-static int64_t vmdk_get_allocated_file_size(BlockDriverState *bs)
+static int64_t vmdk_get_fs_allocated_size(BlockDriverState *bs)
 {
     int i;
     int64_t ret = 0;
     int64_t r;
     BDRVVmdkState *s = bs->opaque;
 
-    ret = bdrv_get_allocated_file_size(bs->file->bs);
+    ret = bdrv_get_fs_allocated_size(bs->file->bs);
     if (ret < 0) {
         return ret;
     }
@@ -2149,7 +2149,7 @@ static int64_t vmdk_get_allocated_file_size(BlockDriverState *bs)
         if (s->extents[i].file == bs->file) {
             continue;
         }
-        r = bdrv_get_allocated_file_size(s->extents[i].file->bs);
+        r = bdrv_get_fs_allocated_size(s->extents[i].file->bs);
         if (r < 0) {
             return r;
         }
@@ -2363,7 +2363,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_create                  = vmdk_create,
     .bdrv_co_flush_to_disk        = vmdk_co_flush,
     .bdrv_co_get_block_status     = vmdk_co_get_block_status,
-    .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
+    .bdrv_get_fs_allocated_size = vmdk_get_fs_allocated_size,
     .bdrv_has_zero_init           = vmdk_has_zero_init,
     .bdrv_get_specific_info       = vmdk_get_specific_info,
     .bdrv_refresh_limits          = vmdk_refresh_limits,
diff --git a/include/block/block.h b/include/block/block.h
index c36b9ccae4..11ec88d18d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -303,7 +303,7 @@ void bdrv_refresh_filename(BlockDriverState *bs);
 int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp);
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
-int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
+int64_t bdrv_get_fs_allocated_size(BlockDriverState *bs);
 int64_t bdrv_get_format_allocated_size(BlockDriverState *bs);
 void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index e562fa7a5a..ab58746148 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -207,7 +207,7 @@ struct BlockDriver {
 
     int64_t (*bdrv_getlength)(BlockDriverState *bs);
     bool has_variable_length;
-    int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
+    int64_t (*bdrv_get_fs_allocated_size)(BlockDriverState *bs);
     int64_t (*bdrv_get_format_allocated_size)(BlockDriverState *bs);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
-- 
2.11.1
