Received: from eggs.gnu.org ([2001:4830:134:3::10]:40022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ec9Xz-0001E5-SA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ec9Xx-0004WV-An
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:43:59 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Jan 2018 13:43:45 +0100
Message-Id: <1516279431-30424-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
References: <1516279431-30424-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] block: rename .bdrv_create() to
 .bdrv_co_create_opts()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

BlockDriver->bdrv_create() has been called from coroutine context since
commit 5b7e1542cfa41a281af9629d31cef03704d976e6 ("block: make
bdrv_create adopt coroutine").

Make this explicit by renaming to .bdrv_co_create_opts() and add the
coroutine_fn annotation.  This makes it obvious to block driver authors
that they may yield, use CoMutex, or other coroutine_fn APIs.
bdrv_co_create is reserved for the QAPI-based version that Kevin is
working on.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170705102231.20711-2-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c                   |  4 ++--
 block/crypto.c            |  8 ++++----
 block/file-posix.c        | 15 ++++++++-------
 block/file-win32.c        |  5 +++--
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
 include/block/block_int.h |  3 ++-
 20 files changed, 73 insertions(+), 54 deletions(-)

diff --git a/block.c b/block.c
index a8da4f2..cf33135 100644
--- a/block.c
+++ b/block.c
@@ -417,7 +417,7 @@ static void coroutine_fn bdrv_create_co_entry(void *opaque)
     CreateCo *cco = opaque;
     assert(cco->drv);
 
-    ret = cco->drv->bdrv_create(cco->filename, cco->opts, &local_err);
+    ret = cco->drv->bdrv_co_create_opts(cco->filename, cco->opts, &local_err);
     error_propagate(&cco->err, local_err);
     cco->ret = ret;
 }
@@ -436,7 +436,7 @@ int bdrv_create(BlockDriver *drv, const char* filename,
         .err = NULL,
     };
 
-    if (!drv->bdrv_create) {
+    if (!drv->bdrv_co_create_opts) {
         error_setg(errp, "Driver '%s' does not support image creation", drv->format_name);
         ret = -ENOTSUP;
         goto out;
diff --git a/block/crypto.c b/block/crypto.c
index 60ddf86..4acff45 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -554,9 +554,9 @@ static int block_crypto_open_luks(BlockDriverState *bs,
                                      bs, options, flags, errp);
 }
 
-static int block_crypto_create_luks(const char *filename,
-                                    QemuOpts *opts,
-                                    Error **errp)
+static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
+                                                         QemuOpts *opts,
+                                                         Error **errp)
 {
     return block_crypto_create_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
                                        filename, opts, errp);
@@ -616,7 +616,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_open          = block_crypto_open_luks,
     .bdrv_close         = block_crypto_close,
     .bdrv_child_perm    = bdrv_format_default_perms,
-    .bdrv_create        = block_crypto_create_luks,
+    .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 36ee89e..39d2795 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1979,7 +1979,8 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return (int64_t)st.st_blocks * 512;
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
 {
     int fd;
     int result = 0;
@@ -2278,7 +2279,7 @@ BlockDriver bdrv_file = {
     .bdrv_reopen_commit = raw_reopen_commit,
     .bdrv_reopen_abort = raw_reopen_abort,
     .bdrv_close = raw_close,
-    .bdrv_create = raw_create,
+    .bdrv_co_create_opts = raw_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = raw_co_get_block_status,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
@@ -2682,8 +2683,8 @@ static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
     return -ENOTSUP;
 }
 
-static int hdev_create(const char *filename, QemuOpts *opts,
-                       Error **errp)
+static int coroutine_fn hdev_co_create_opts(const char *filename, QemuOpts *opts,
+                                            Error **errp)
 {
     int fd;
     int ret = 0;
@@ -2756,7 +2757,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
     .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_create         = hdev_create,
+    .bdrv_co_create_opts = hdev_co_create_opts,
     .create_opts         = &raw_create_opts,
     .bdrv_co_pwrite_zeroes = hdev_co_pwrite_zeroes,
 
@@ -2878,7 +2879,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
     .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_create         = hdev_create,
+    .bdrv_co_create_opts = hdev_co_create_opts,
     .create_opts         = &raw_create_opts,
 
 
@@ -3009,7 +3010,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_reopen_prepare = raw_reopen_prepare,
     .bdrv_reopen_commit  = raw_reopen_commit,
     .bdrv_reopen_abort   = raw_reopen_abort,
-    .bdrv_create        = hdev_create,
+    .bdrv_co_create_opts = hdev_co_create_opts,
     .create_opts        = &raw_create_opts,
 
     .bdrv_co_preadv         = raw_co_preadv,
diff --git a/block/file-win32.c b/block/file-win32.c
index 9e02214..4d88b14 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -550,7 +550,8 @@ static int64_t raw_get_allocated_file_size(BlockDriverState *bs)
     return st.st_size;
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
 {
     int fd;
     int64_t total_size = 0;
@@ -596,7 +597,7 @@ BlockDriver bdrv_file = {
     .bdrv_file_open     = raw_open,
     .bdrv_refresh_limits = raw_probe_alignment,
     .bdrv_close         = raw_close,
-    .bdrv_create        = raw_create,
+    .bdrv_co_create_opts = raw_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
 
     .bdrv_aio_readv     = raw_aio_readv,
diff --git a/block/gluster.c b/block/gluster.c
index 0f4265a..9419e0c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -962,8 +962,8 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
 }
 #endif
 
-static int qemu_gluster_create(const char *filename,
-                               QemuOpts *opts, Error **errp)
+static int coroutine_fn qemu_gluster_co_create_opts(const char *filename,
+                                                    QemuOpts *opts, Error **errp)
 {
     BlockdevOptionsGluster *gconf;
     struct glfs *glfs;
@@ -1424,7 +1424,7 @@ static BlockDriver bdrv_gluster = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
@@ -1452,7 +1452,7 @@ static BlockDriver bdrv_gluster_tcp = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
@@ -1480,7 +1480,7 @@ static BlockDriver bdrv_gluster_unix = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
@@ -1514,7 +1514,7 @@ static BlockDriver bdrv_gluster_rdma = {
     .bdrv_reopen_commit           = qemu_gluster_reopen_commit,
     .bdrv_reopen_abort            = qemu_gluster_reopen_abort,
     .bdrv_close                   = qemu_gluster_close,
-    .bdrv_create                  = qemu_gluster_create,
+    .bdrv_co_create_opts          = qemu_gluster_co_create_opts,
     .bdrv_getlength               = qemu_gluster_getlength,
     .bdrv_get_allocated_file_size = qemu_gluster_allocated_file_size,
     .bdrv_truncate                = qemu_gluster_truncate,
diff --git a/block/iscsi.c b/block/iscsi.c
index 6a1c537..5f358f9 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2103,7 +2103,8 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-static int iscsi_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn iscsi_co_create_opts(const char *filename, QemuOpts *opts,
+                                             Error **errp)
 {
     int ret = 0;
     int64_t total_size = 0;
@@ -2191,7 +2192,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_parse_filename    = iscsi_parse_filename,
     .bdrv_file_open         = iscsi_open,
     .bdrv_close             = iscsi_close,
-    .bdrv_create            = iscsi_create,
+    .bdrv_co_create_opts    = iscsi_co_create_opts,
     .create_opts            = &iscsi_create_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
@@ -2226,7 +2227,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_parse_filename    = iscsi_parse_filename,
     .bdrv_file_open         = iscsi_open,
     .bdrv_close             = iscsi_close,
-    .bdrv_create            = iscsi_create,
+    .bdrv_co_create_opts    = iscsi_co_create_opts,
     .create_opts            = &iscsi_create_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
diff --git a/block/nfs.c b/block/nfs.c
index effc871..8029dc2 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -684,7 +684,8 @@ static QemuOptsList nfs_create_opts = {
     }
 };
 
-static int nfs_file_create(const char *url, QemuOpts *opts, Error **errp)
+static int coroutine_fn nfs_file_co_create_opts(const char *url, QemuOpts *opts,
+                                                Error **errp)
 {
     int64_t ret, total_size;
     NFSClient *client = g_new0(NFSClient, 1);
@@ -897,7 +898,7 @@ static BlockDriver bdrv_nfs = {
 
     .bdrv_file_open                 = nfs_file_open,
     .bdrv_close                     = nfs_file_close,
-    .bdrv_create                    = nfs_file_create,
+    .bdrv_co_create_opts            = nfs_file_co_create_opts,
     .bdrv_reopen_prepare            = nfs_reopen_prepare,
 
     .bdrv_co_preadv                 = nfs_co_preadv,
diff --git a/block/parallels.c b/block/parallels.c
index 9545761..5f1497d 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -479,7 +479,9 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
 }
 
 
-static int parallels_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn parallels_co_create_opts(const char *filename,
+                                                 QemuOpts *opts,
+                                                 Error **errp)
 {
     int64_t total_size, cl_size;
     uint8_t tmp[BDRV_SECTOR_SIZE];
@@ -799,7 +801,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_readv  = parallels_co_readv,
     .bdrv_co_writev = parallels_co_writev,
 
-    .bdrv_create    = parallels_create,
+    .bdrv_co_create_opts = parallels_co_create_opts,
     .bdrv_check     = parallels_check,
     .create_opts    = &parallels_create_opts,
 };
diff --git a/block/qcow.c b/block/qcow.c
index 9569dee..ebb7cea 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -789,7 +789,8 @@ static void qcow_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
 
-static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn qcow_co_create_opts(const char *filename, QemuOpts *opts,
+                                            Error **errp)
 {
     int header_size, backing_filename_len, l1_size, shift, i;
     QCowHeader header;
@@ -1105,7 +1106,7 @@ static BlockDriver bdrv_qcow = {
     .bdrv_close		= qcow_close,
     .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_reopen_prepare    = qcow_reopen_prepare,
-    .bdrv_create            = qcow_create,
+    .bdrv_co_create_opts    = qcow_co_create_opts,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .supports_backing       = true,
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 4348b2c..be2d485 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2881,7 +2881,8 @@ out:
     return ret;
 }
 
-static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opts,
+                                             Error **errp)
 {
     char *backing_file = NULL;
     char *backing_fmt = NULL;
@@ -4318,7 +4319,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_reopen_abort    = qcow2_reopen_abort,
     .bdrv_join_options    = qcow2_join_options,
     .bdrv_child_perm      = bdrv_format_default_perms,
-    .bdrv_create        = qcow2_create,
+    .bdrv_co_create_opts  = qcow2_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = qcow2_co_get_block_status,
 
diff --git a/block/qed.c b/block/qed.c
index 821dcaa..e0e08ce 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -638,7 +638,9 @@ out:
     return ret;
 }
 
-static int bdrv_qed_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn bdrv_qed_co_create_opts(const char *filename,
+                                                QemuOpts *opts,
+                                                Error **errp)
 {
     uint64_t image_size = 0;
     uint32_t cluster_size = QED_DEFAULT_CLUSTER_SIZE;
@@ -1593,7 +1595,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_close               = bdrv_qed_close,
     .bdrv_reopen_prepare      = bdrv_qed_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
-    .bdrv_create              = bdrv_qed_create,
+    .bdrv_co_create_opts      = bdrv_qed_co_create_opts,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = bdrv_qed_co_get_block_status,
     .bdrv_co_readv            = bdrv_qed_co_readv,
diff --git a/block/raw-format.c b/block/raw-format.c
index ab552c0..92b4753 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -396,7 +396,8 @@ static int raw_has_zero_init(BlockDriverState *bs)
     return bdrv_has_zero_init(bs->file->bs);
 }
 
-static int raw_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
 {
     return bdrv_create_file(filename, opts, errp);
 }
@@ -491,7 +492,7 @@ BlockDriver bdrv_raw = {
     .bdrv_open            = &raw_open,
     .bdrv_close           = &raw_close,
     .bdrv_child_perm      = bdrv_filter_default_perms,
-    .bdrv_create          = &raw_create,
+    .bdrv_co_create_opts  = &raw_co_create_opts,
     .bdrv_co_preadv       = &raw_co_preadv,
     .bdrv_co_pwritev      = &raw_co_pwritev,
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
diff --git a/block/rbd.c b/block/rbd.c
index a76a5e8..67ac2ee 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -348,7 +348,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
+                                                QemuOpts *opts,
+                                                Error **errp)
 {
     Error *local_err = NULL;
     int64_t bytes = 0;
@@ -1129,7 +1131,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_file_open         = qemu_rbd_open,
     .bdrv_close             = qemu_rbd_close,
     .bdrv_reopen_prepare    = qemu_rbd_reopen_prepare,
-    .bdrv_create            = qemu_rbd_create,
+    .bdrv_co_create_opts    = qemu_rbd_co_create_opts,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
     .bdrv_get_info          = qemu_rbd_getinfo,
     .create_opts            = &qemu_rbd_create_opts,
diff --git a/block/sheepdog.c b/block/sheepdog.c
index f684477..c90bdc3 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1964,8 +1964,8 @@ static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
     return 0;
 }
 
-static int sd_create(const char *filename, QemuOpts *opts,
-                     Error **errp)
+static int coroutine_fn sd_co_create_opts(const char *filename, QemuOpts *opts,
+                                          Error **errp)
 {
     Error *err = NULL;
     int ret = 0;
@@ -3086,7 +3086,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_reopen_commit           = sd_reopen_commit,
     .bdrv_reopen_abort            = sd_reopen_abort,
     .bdrv_close                   = sd_close,
-    .bdrv_create                  = sd_create,
+    .bdrv_co_create_opts          = sd_co_create_opts,
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
@@ -3122,7 +3122,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_reopen_commit           = sd_reopen_commit,
     .bdrv_reopen_abort            = sd_reopen_abort,
     .bdrv_close                   = sd_close,
-    .bdrv_create                  = sd_create,
+    .bdrv_co_create_opts          = sd_co_create_opts,
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
@@ -3158,7 +3158,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_reopen_commit           = sd_reopen_commit,
     .bdrv_reopen_abort            = sd_reopen_abort,
     .bdrv_close                   = sd_close,
-    .bdrv_create                  = sd_create,
+    .bdrv_co_create_opts          = sd_co_create_opts,
     .bdrv_has_zero_init           = bdrv_has_zero_init_1,
     .bdrv_getlength               = sd_getlength,
     .bdrv_get_allocated_file_size = sd_get_allocated_file_size,
diff --git a/block/ssh.c b/block/ssh.c
index b049a16..72f44ce 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -813,7 +813,8 @@ static QemuOptsList ssh_create_opts = {
     }
 };
 
-static int ssh_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn ssh_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
 {
     int r, ret;
     int64_t total_size = 0;
@@ -1201,7 +1202,7 @@ static BlockDriver bdrv_ssh = {
     .instance_size                = sizeof(BDRVSSHState),
     .bdrv_parse_filename          = ssh_parse_filename,
     .bdrv_file_open               = ssh_file_open,
-    .bdrv_create                  = ssh_create,
+    .bdrv_co_create_opts          = ssh_co_create_opts,
     .bdrv_close                   = ssh_close,
     .bdrv_has_zero_init           = ssh_has_zero_init,
     .bdrv_co_readv                = ssh_co_readv,
diff --git a/block/vdi.c b/block/vdi.c
index 8da5dfc..01501d7 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -716,7 +716,8 @@ nonallocating_write:
     return ret;
 }
 
-static int vdi_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vdi_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
 {
     int ret = 0;
     uint64_t bytes = 0;
@@ -894,7 +895,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_close = vdi_close,
     .bdrv_reopen_prepare = vdi_reopen_prepare,
     .bdrv_child_perm          = bdrv_format_default_perms,
-    .bdrv_create = vdi_create,
+    .bdrv_co_create_opts = vdi_co_create_opts,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = vdi_co_get_block_status,
     .bdrv_make_empty = vdi_make_empty,
diff --git a/block/vhdx.c b/block/vhdx.c
index 9956933..7fad8b2 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1792,7 +1792,8 @@ exit:
  *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ -----------.
  *   1MB
  */
-static int vhdx_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vhdx_co_create_opts(const char *filename, QemuOpts *opts,
+                                            Error **errp)
 {
     int ret = 0;
     uint64_t image_size = (uint64_t) 2 * GiB;
@@ -2003,7 +2004,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_child_perm        = bdrv_format_default_perms,
     .bdrv_co_readv          = vhdx_co_readv,
     .bdrv_co_writev         = vhdx_co_writev,
-    .bdrv_create            = vhdx_create,
+    .bdrv_co_create_opts    = vhdx_co_create_opts,
     .bdrv_get_info          = vhdx_get_info,
     .bdrv_check             = vhdx_check,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
diff --git a/block/vmdk.c b/block/vmdk.c
index c665bcc..d4beb25 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1875,7 +1875,8 @@ static int filename_decompose(const char *filename, char *path, char *prefix,
     return VMDK_OK;
 }
 
-static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts,
+                                            Error **errp)
 {
     int idx = 0;
     BlockBackend *new_blk = NULL;
@@ -2391,7 +2392,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_co_pwritev_compressed   = vmdk_co_pwritev_compressed,
     .bdrv_co_pwrite_zeroes        = vmdk_co_pwrite_zeroes,
     .bdrv_close                   = vmdk_close,
-    .bdrv_create                  = vmdk_create,
+    .bdrv_co_create_opts          = vmdk_co_create_opts,
     .bdrv_co_flush_to_disk        = vmdk_co_flush,
     .bdrv_co_get_block_status     = vmdk_co_get_block_status,
     .bdrv_get_allocated_file_size = vmdk_get_allocated_file_size,
diff --git a/block/vpc.c b/block/vpc.c
index 1576d7b..1817f72 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -895,7 +895,8 @@ static int create_fixed_disk(BlockBackend *blk, uint8_t *buf,
     return ret;
 }
 
-static int vpc_create(const char *filename, QemuOpts *opts, Error **errp)
+static int coroutine_fn vpc_co_create_opts(const char *filename, QemuOpts *opts,
+                                           Error **errp)
 {
     uint8_t buf[1024];
     VHDFooter *footer = (VHDFooter *) buf;
@@ -1093,7 +1094,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_close             = vpc_close,
     .bdrv_reopen_prepare    = vpc_reopen_prepare,
     .bdrv_child_perm        = bdrv_format_default_perms,
-    .bdrv_create            = vpc_create,
+    .bdrv_co_create_opts    = vpc_co_create_opts,
 
     .bdrv_co_preadv             = vpc_co_preadv,
     .bdrv_co_pwritev            = vpc_co_pwritev,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4..05f498f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -130,7 +130,8 @@ struct BlockDriver {
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
-    int (*bdrv_create)(const char *filename, QemuOpts *opts, Error **errp);
+    int coroutine_fn (*bdrv_co_create_opts)(const char *filename, QemuOpts *opts,
+                                       Error **errp);
     int (*bdrv_make_empty)(BlockDriverState *bs);
 
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
-- 
1.8.3.1
