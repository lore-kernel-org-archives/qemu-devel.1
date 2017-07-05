Received: from eggs.gnu.org ([2001:4830:134:3::10]:60432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dShSP-00006m-Ec
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dShSM-0002h8-3g
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:22:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  5 Jul 2017 11:22:30 +0100
Message-Id: <20170705102231.20711-2-stefanha@redhat.com>
In-Reply-To: <20170705102231.20711-1-stefanha@redhat.com>
References: <20170705102231.20711-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] block: rename .bdrv_create() to
 .bdrv_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

BlockDriver->bdrv_create() has been called from coroutine context since
commit 5b7e1542cfa41a281af9629d31cef03704d976e6 ("block: make
bdrv_create adopt coroutine").

Make this explicit by renaming to .bdrv_co_create() and add the
coroutine_fn annotation.  This makes it obvious to block driver authors
that they may yield, use CoMutex, or other coroutine_fn APIs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h |  3 ++-
 block.c                   |  4 ++--
 block/crypto.c            |  8 ++++----
 block/file-posix.c        | 15 ++++++++-------
 block/file-win32.c        |  3 ++-
 block/gluster.c           | 12 ++++++------
 block/iscsi.c             |  7 ++++---
 block/nfs.c               |  5 +++--
 block/parallels.c         |  6 ++++--
 block/qcow.c              |  5 +++--
 block/qcow2.c             |  5 +++--
 block/qed.c               |  6 ++++--
 block/raw-format.c        |  5 +++--
 block/rbd.c               |  6 ++++--
 block/sheepdog.c          | 10 +++++-----
 block/ssh.c               |  5 +++--
 block/vdi.c               |  5 +++--
 block/vhdx.c              |  5 +++--
 block/vmdk.c              |  5 +++--
 block/vpc.c               |  5 +++--
 20 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602..3f32c61 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -126,7 +126,8 @@ struct BlockDriver {
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
-    int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **errp);
+    int coroutine_fn (*bdrv_co_create)(const char *filename, QemuOpts *opts,
+                                       Error **errp);
     int (*bdrv_set_key)(BlockDriverState *bs, const char *key);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
diff --git a/block.c b/block.c
index 6943962..223ca3f 100644
--- a/block.c
+++ b/block.c
@@ -416,7 +416,7 @@ static void coroutine_fn bdrv_create_co_entry(void *opaque)
     CreateCo *cco = opaque;
     assert(cco->drv);
 
-    ret = cco->drv->bdrv_create(cco->filename, cco->opts, &local_err);
+    ret = cco->drv->bdrv_co_create(cco->filename, cco->opts, &local_err);
     error_propagate(&cco->err, local_err);
     cco->ret = ret;
 }
@@ -435,7 +435,7 @@ int bdrv_create(BlockDriver *drv, const char* filename,
         .err = NULL,
     };
 
-    if (!drv->bdrv_create) {
+    if (!drv->bdrv_co_create) {
         error_setg(errp, "Driver '%s' does not support image creation", drv->format_name);
         ret = -ENOTSUP;
         goto out;
diff --git a/block/crypto.c b/block/crypto.c
index 10e5ddc..8d2f403 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -568,9 +568,9 @@ static int block_crypto_open_luks(BlockDriverState *bs,
                                      bs, options, flags, errp);
 }
 
-static int block_crypto_create_luks(const char *filename,
-                                    QemuOpts *opts,
-                                    Error **errp)
+static int coroutine_fn block_crypto_co_create_luks(const char *filename,
+                                                    QemuOpts *opts,
+                                                    Error **errp)
 {
     return block_crypto_create_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
                                        filename, opts, errp);
@@ -630,7 +630,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_open          = block_crypto_open_luks,
     .bdrv_close         = block_crypto_close,
     .bdrv_child_perm    = bdrv_format_default_perms,
-    .bdrv_create        = block_crypto_create_luks,
+    .bdrv_co_create     = block_crypto_co_create_luks,
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 3927fab..aefcae0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1835,7 +1835,8 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return (int64_t)st.st_blocks * 512;
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn raw_co_create(const char *filename, QemuOpts *opts,
+                                      Error **errp)
 {
     int fd;
     int result = 0;
@@ -2197,7 +2198,7 @@ BlockDriver bdrv_file = {
     .bdrv_reopen_commit = raw_reopen_commit,
     .bdrv_reopen_abort = raw_reopen_abort,
     .bdrv_close = raw_close,
-    .bdrv_create = raw_create,
+    .bdrv_co_create = raw_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = raw_co_get_block_status,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
@@ -2592,8 +2593,8 @@ static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
     return -ENOTSUP;
 }
 
-static int hdev_create(const char *filename, QemuOpts *opts,
-                       Error **errp)
+static int coroutine_fn hdev_co_create(const char *filename, QemuOpts *opts,
+                                       Error **errp)
 {
     int fd;
     int ret = 0;
@@ -2656,7 +2657,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
     .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_create         = hdev_create,
+    .bdrv_co_create      = hdev_co_create,
     .create_opts         = &raw_create_opts,
     .bdrv_co_pwrite_zeroes = hdev_co_pwrite_zeroes,
 
@@ -2778,7 +2779,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
     .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_create         = hdev_create,
+    .bdrv_co_create      = hdev_co_create,
     .create_opts         = &raw_create_opts,
 
 
@@ -2909,7 +2910,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
     .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_create        = hdev_create,
+    .bdrv_co_create      = hdev_co_create,
     .create_opts        = &raw_create_opts,
 
     .bdrv_co_preadv         = raw_co_preadv,
diff --git a/block/file-win32.c b/block/file-win32.c
index ef2910b..424f862 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -544,7 +544,8 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return st.st_size;
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn raw_create(const char *filename, QemuOpts *opts,
+                                   Error **errp)
 {
     int fd;
     int64_t total_size = 0;
diff --git a/block/gluster.c b/block/gluster.c
index addceed..0b5f192 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -965,8 +965,8 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
 }
 #endif
 
-static int qemu_gluster_create(const char *filename,
-                               QemuOpts *opts, Error **errp)
+static int coroutine_fn qemu_gluster_co_create(const char *filename,
+                                               QemuOpts *opts, Error **errp)
 {
     BlockdevOptionsGluster *gconf;
     struct glfs *glfs;
@@ -1422,7 +1422,7 @@ static BlockDriver bdrv_gluster = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
@@ -1450,7 +1450,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
@@ -1478,7 +1478,7 @@ static BlockDriver bdrv_gluster_unix = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
@@ -1512,7 +1512,7 @@ static BlockDriver bdrv_gluster_rdma = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create               = qemu_gluster_co_create,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
diff --git a/block/iscsi.c b/block/iscsi.c
index 54067e2..7aab379 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2107,7 +2107,8 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
     return 0;
 }
 
-static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn iscsi_co_create(const char *filename, QemuOpts *opts,
+                                        Error **errp)
 {
     int ret = 0;
     int64_t total_size = 0;
@@ -2195,7 +2196,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_parse_filename    = iscsi_parse_filename,
     .bdrv_file_open         = iscsi_open,
     .bdrv_close             = iscsi_close,
-    .bdrv_create            = iscsi_create,
+    .bdrv_co_create         = iscsi_co_create,
     .create_opts            = &iscsi_create_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
@@ -2230,7 +2231,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_parse_filename    = iscsi_parse_filename,
     .bdrv_file_open         = iscsi_open,
     .bdrv_close             = iscsi_close,
-    .bdrv_create            = iscsi_create,
+    .bdrv_co_create         = iscsi_co_create,
     .create_opts            = &iscsi_create_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
diff --git a/block/nfs.c b/block/nfs.c
index c3c5de0..06e0c6f 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -679,7 +679,8 @@ static QemuOptsList nfs_create_opts = {
     }
 };
 
-static int nfs_file_create(const char *url, QemuOpts *opts, Error **errp)
+static int coroutine_fn nfs_file_co_create(const char *url, QemuOpts *opts,
+                                           Error **errp)
 {
     int ret = 0;
     int64_t total_size = 0;
@@ -886,7 +887,7 @@ static BlockDriver bdrv_nfs = {
 
     .bdrv_file_open                 = nfs_file_open,
     .bdrv_close                     = nfs_file_close,
-    .bdrv_create                    = nfs_file_create,
+    .bdrv_co_create                 = nfs_file_co_create,
     .bdrv_reopen_prepare            = nfs_reopen_prepare,
 
     .bdrv_co_preadv                 = nfs_co_preadv,
diff --git a/block/parallels.c b/block/parallels.c
index 8be46a7..82c6dd9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -472,7 +472,9 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
 }
 
 
-static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn parallels_co_create(const char *filename,
+                                            QemuOpts *opts,
+                                            Error **errp)
 {
     int64_t total_size, cl_size;
     uint8_t tmp[BDRV_SECTOR_SIZE];
@@ -781,7 +783,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_readv  = parallels_co_readv,
     .bdrv_co_writev = parallels_co_writev,
 
-    .bdrv_create    = parallels_create,
+    .bdrv_co_create = parallels_co_create,
     .bdrv_check     = parallels_check,
     .create_opts    = &parallels_create_opts,
 };
diff --git a/block/qcow.c b/block/qcow.c
index 7bd94dc..e765cf1 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -796,7 +796,8 @@ static void qcow_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
 
-static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn qcow_co_create(const char *filename, QemuOpts *opts,
+                                       Error **errp)
 {
     int header_size, backing_filename_len, l1_size, shift, i;
     QCowHeader header;
@@ -1056,7 +1057,7 @@ static BlockDriver bdrv_qcow = {
     .bdrv_close		= qcow_close,
     .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_reopen_prepare    = qcow_reopen_prepare,
-    .bdrv_create            = qcow_create,
+    .bdrv_co_create         = qcow_co_create,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .supports_backing       = true,
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 2f94f03..5279839 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2390,7 +2390,8 @@ out:
     return ret;
 }
 
-static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn qcow2_co_create(const char *filename, QemuOpts *opts,
+                                        Error **errp)
 {
     char *backing_file = NULL;
     char *backing_fmt = NULL;
@@ -3473,7 +3474,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_reopen_abort    = qcow2_reopen_abort,
     .bdrv_join_options    = qcow2_join_options,
     .bdrv_child_perm      = bdrv_format_default_perms,
-    .bdrv_create        = qcow2_create,
+    .bdrv_co_create       = qcow2_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = qcow2_co_get_block_status,
     .bdrv_set_key       = qcow2_set_key,
diff --git a/block/qed.c b/block/qed.c
index 385381a..69027be 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -622,7 +622,9 @@ out:
     return ret;
 }
 
-static int bdrv_qed_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn bdrv_qed_co_create(const char *filename,
+                                           QemuOpts *opts,
+                                           Error **errp)
 {
     uint64_t image_size = 0;
     uint32_t cluster_size = QED_DEFAULT_CLUSTER_SIZE;
@@ -1532,7 +1534,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_close               = bdrv_qed_close,
     .bdrv_reopen_prepare      = bdrv_qed_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
-    .bdrv_create              = bdrv_qed_create,
+    .bdrv_co_create           = bdrv_qed_co_create,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
     .bdrv_co_readv            = bdrv_qed_co_readv,
diff --git a/block/raw-format.c b/block/raw-format.c
index 0d185fe..0cace4f 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -375,7 +375,8 @@ static int raw_has_zero_init(BlockDriverState *bs)
     return bdrv_has_zero_init(bs->file->bs);
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn raw_co_create(const char *filename, QemuOpts *opts,
+                                      Error **errp)
 {
     return bdrv_create_file(filename, opts, errp);
 }
@@ -470,7 +471,7 @@ BlockDriver bdrv_raw = {
     .bdrv_open            = &raw_open,
     .bdrv_close           = &raw_close,
     .bdrv_child_perm      = bdrv_filter_default_perms,
-    .bdrv_create          = &raw_create,
+    .bdrv_co_create       = &raw_co_create,
     .bdrv_co_preadv       = &raw_co_preadv,
     .bdrv_co_pwritev      = &raw_co_pwritev,
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
diff --git a/block/rbd.c b/block/rbd.c
index 9da02cd..68c04a0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -348,7 +348,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn qemu_rbd_co_create(const char *filename,
+                                           QemuOpts *opts,
+                                           Error **errp)
 {
     Error *local_err = NULL;
     int64_t bytes = 0;
@@ -1116,7 +1118,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_file_open         = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
     .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
-    .bdrv_create            = qemu_rbd_create,
+    .bdrv_co_create         = qemu_rbd_co_create,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .bdrv_get_info          = qemu_rbd_getinfo,
     .create_opts            = &qemu_rbd_create_opts,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 08d7b11..32a4ee9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1952,8 +1952,8 @@ static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
     return 0;
 }
 
-static int sd_create(const char *filename, QemuOpts *opts,
-                     Error **errp)
+static int coroutine_fn sd_co_create(const char *filename, QemuOpts *opts,
+                                     Error **errp)
 {
     Error *err = NULL;
     int ret = 0;
@@ -3063,7 +3063,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_reopen_commit     = sd_reopen_commit,
     .bdrv_reopen_abort      = sd_reopen_abort,
     .bdrv_close     = sd_close,
-    .bdrv_create    = sd_create,
+    .bdrv_co_create = sd_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_getlength = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
@@ -3099,7 +3099,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_reopen_commit     = sd_reopen_commit,
     .bdrv_reopen_abort      = sd_reopen_abort,
     .bdrv_close     = sd_close,
-    .bdrv_create    = sd_create,
+    .bdrv_co_create = sd_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_getlength = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
@@ -3135,7 +3135,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_reopen_commit     = sd_reopen_commit,
     .bdrv_reopen_abort      = sd_reopen_abort,
     .bdrv_close     = sd_close,
-    .bdrv_create    = sd_create,
+    .bdrv_co_create = sd_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_getlength = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
diff --git a/block/ssh.c b/block/ssh.c
index 5296441..17755a9 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -813,7 +813,8 @@ static QemuOptsList ssh_create_opts = {
     }
 };
 
-static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn ssh_co_create(const char *filename, QemuOpts *opts,
+                                      Error **errp)
 {
     int r, ret;
     int64_t total_size = 0;
@@ -1191,7 +1192,7 @@ static BlockDriver bdrv_ssh = {
     .instance_size                = sizeof(BDRVSSHState),
     .bdrv_parse_filename          = ssh_parse_filename,
     .bdrv_file_open               = ssh_file_open,
-    .bdrv_create                  = ssh_create,
+    .bdrv_co_create               = ssh_co_create,
     .bdrv_close                   = ssh_close,
     .bdrv_has_zero_init           = ssh_has_zero_init,
     .bdrv_co_readv                = ssh_co_readv,
diff --git a/block/vdi.c b/block/vdi.c
index 79af477..1d6e779 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -716,7 +716,8 @@ vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     return ret;
 }
 
-static int vdi_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vdi_co_create(const char *filename, QemuOpts *opts,
+                                      Error **errp)
 {
     int ret = 0;
     uint64_t bytes = 0;
@@ -893,7 +894,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_close = vdi_close,
     .bdrv_reopen_prepare = vdi_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
-    .bdrv_create = vdi_create,
+    .bdrv_co_create = vdi_co_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = vdi_co_get_block_status,
     .bdrv_make_empty = vdi_make_empty,
diff --git a/block/vhdx.c b/block/vhdx.c
index 8b270b5..e42a417 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1787,7 +1787,8 @@ exit:
  *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ -----------.
  *   1MB
  */
-static int vhdx_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vhdx_co_create(const char *filename, QemuOpts *opts,
+                                       Error **errp)
 {
     int ret = 0;
     uint64_t image_size = (uint64_t) 2 * GiB;
@@ -1998,7 +1999,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_co_readv          = vhdx_co_readv,
     .bdrv_co_writev         = vhdx_co_writev,
-    .bdrv_create            = vhdx_create,
+    .bdrv_co_create         = vhdx_co_create,
     .bdrv_get_info          = vhdx_get_info,
     .bdrv_check             = vhdx_check,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
diff --git a/block/vmdk.c b/block/vmdk.c
index 55581b0..2579cfb 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1857,7 +1857,8 @@ static int filename_decompose(const char *filename, char *path, char *prefix,
     return VMDK_OK;
 }
 
-static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vmdk_co_create(const char *filename, QemuOpts *opts,
+                                       Error **errp)
 {
     int idx = 0;
     BlockBackend *new_blk = NULL;
@@ -2360,7 +2361,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_co_pwritev_compressed   = vmdk_co_pwritev_compressed,
     .bdrv_co_pwrite_zeroes        = vmdk_co_pwrite_zeroes,
     .bdrv_close                   = vmdk_close,
-    .bdrv_create                  = vmdk_create,
+    .bdrv_co_create               = vmdk_co_create,
     .bdrv_co_flush_to_disk        = vmdk_co_flush,
     .bdrv_co_get_block_status     = vmdk_co_get_block_status,
     .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
diff --git a/block/vpc.c b/block/vpc.c
index 4240ba9..eed03a3 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -872,7 +872,8 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
     return ret;
 }
 
-static int vpc_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vpc_co_create(const char *filename, QemuOpts *opts,
+                                      Error **errp)
 {
     uint8_t buf[1024];
     VHDFooter *footer = (VHDFooter *) buf;
@@ -1070,7 +1071,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_close             = vpc_close,
     .bdrv_reopen_prepare    = vpc_reopen_prepare,
     .bdrv_child_perm        = bdrv_format_default_perms,
-    .bdrv_create            = vpc_create,
+    .bdrv_co_create         = vpc_co_create,
 
     .bdrv_co_preadv             = vpc_co_preadv,
     .bdrv_co_pwritev            = vpc_co_pwritev,
-- 
2.9.4
