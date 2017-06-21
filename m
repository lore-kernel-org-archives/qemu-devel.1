Received: from eggs.gnu.org ([2001:4830:134:3::10]:34331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf70-0008Ku-Tf
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNf6z-0005Si-2P
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:51:58 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 14:50:40 +0200
Message-Id: <20170621125047.30294-19-mreitz@redhat.com>
In-Reply-To: <20170621125047.30294-1-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

This new field can be set by block drivers to list the runtime options
they accept that may influence the contents of the respective BDS. As of
a follow-up patch, this list will be used by the common
bdrv_refresh_filename() implementation to decide which options to put
into BDS.full_open_options (and consequently whether a JSON filename has
to be created), thus freeing the drivers of having to implement that
logic themselves.

Additionally, this patch adds the field to all of the block drivers that
need it and sets it accordingly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  7 +++++++
 block/blkdebug.c          |  6 ++++++
 block/crypto.c            |  5 +++++
 block/curl.c              | 21 +++++++++++++++++++++
 block/gluster.c           | 19 +++++++++++++++++++
 block/iscsi.c             | 18 ++++++++++++++++++
 block/nbd.c               | 14 ++++++++++++++
 block/nfs.c               |  4 ++++
 block/null.c              |  9 +++++++++
 block/quorum.c            |  8 ++++++++
 block/rbd.c               |  5 +++++
 block/replication.c       |  5 +++++
 block/sheepdog.c          | 12 ++++++++++++
 block/ssh.c               |  5 +++++
 block/vpc.c               |  4 ++++
 block/vvfat.c             |  4 ++++
 block/vxhs.c              |  8 ++++++++
 17 files changed, 154 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 8a7fc2d..1ec1d70 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -388,6 +388,13 @@ struct BlockDriver {
                              uint64_t *nperm, uint64_t *nshared);
 
     QLIST_ENTRY(BlockDriver) list;
+
+    /* Pointer to a NULL-terminated array of names of significant options that
+     * can be specified for bdrv_open(). A significant option is one that
+     * changes the data of a BDS.
+     * If this pointer is NULL, the array is considered empty.
+     * "filename" and "driver" are always considered significant. */
+    const char *const *sgfnt_runtime_opts;
 };
 
 typedef struct BlockLimits {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index f508ede..06c7924 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -923,6 +923,12 @@ static BlockDriver bdrv_blkdebug = {
                                 = blkdebug_debug_remove_breakpoint,
     .bdrv_debug_resume          = blkdebug_debug_resume,
     .bdrv_debug_is_suspended    = blkdebug_debug_is_suspended,
+
+    .sgfnt_runtime_opts         = (const char *const[]) { "config",
+                                                          "inject-error.",
+                                                          "set-state.",
+                                                          "suspend.",
+                                                          NULL },
 };
 
 static void bdrv_blkdebug_init(void)
diff --git a/block/crypto.c b/block/crypto.c
index 10e5ddc..295b83e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -639,6 +639,11 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_getlength     = block_crypto_getlength,
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
+
+    .sgfnt_runtime_opts = (const char *const[]) {
+                              BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
+                              NULL
+                          },
 };
 
 static void block_crypto_init(void)
diff --git a/block/curl.c b/block/curl.c
index 2a244e2..11318a9 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -957,6 +957,19 @@ static int64_t curl_getlength(BlockDriverState *bs)
     return s->len;
 }
 
+static const char *const curl_sgfnt_runtime_opts[] = {
+    CURL_BLOCK_OPT_URL,
+    CURL_BLOCK_OPT_SSLVERIFY,
+    CURL_BLOCK_OPT_COOKIE,
+    CURL_BLOCK_OPT_COOKIE_SECRET,
+    CURL_BLOCK_OPT_USERNAME,
+    CURL_BLOCK_OPT_PASSWORD_SECRET,
+    CURL_BLOCK_OPT_PROXY_USERNAME,
+    CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET,
+
+    NULL
+};
+
 static BlockDriver bdrv_http = {
     .format_name                = "http",
     .protocol_name              = "http",
@@ -971,6 +984,8 @@ static BlockDriver bdrv_http = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_https = {
@@ -987,6 +1002,8 @@ static BlockDriver bdrv_https = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_ftp = {
@@ -1003,6 +1020,8 @@ static BlockDriver bdrv_ftp = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_ftps = {
@@ -1019,6 +1038,8 @@ static BlockDriver bdrv_ftps = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static void curl_block_init(void)
diff --git a/block/gluster.c b/block/gluster.c
index addceed..2bf4290 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1412,6 +1412,21 @@ static int64_t coroutine_fn qemu_gluster_co_get_block_status(
 }
 
 
+static const char *const gluster_sgfnt_open_opts[] = {
+    GLUSTER_OPT_VOLUME,
+    GLUSTER_OPT_PATH,
+    GLUSTER_OPT_TYPE,
+    GLUSTER_OPT_SERVER_PATTERN,
+    GLUSTER_OPT_HOST,
+    GLUSTER_OPT_PORT,
+    GLUSTER_OPT_TO,
+    GLUSTER_OPT_IPV4,
+    GLUSTER_OPT_IPV6,
+    GLUSTER_OPT_SOCKET,
+
+    NULL
+};
+
 static BlockDriver bdrv_gluster = {
     .format_name                  = "gluster",
     .protocol_name                = "gluster",
@@ -1438,6 +1453,7 @@ static BlockDriver bdrv_gluster = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static BlockDriver bdrv_gluster_tcp = {
@@ -1466,6 +1482,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static BlockDriver bdrv_gluster_unix = {
@@ -1494,6 +1511,7 @@ static BlockDriver bdrv_gluster_unix = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 /* rdma is deprecated (actually never supported for volfile fetch).
@@ -1528,6 +1546,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static void bdrv_gluster_init(void)
diff --git a/block/iscsi.c b/block/iscsi.c
index 54067e2..bd5962e 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2187,6 +2187,20 @@ static QemuOptsList iscsi_create_opts = {
     }
 };
 
+static const char *const iscsi_sgfnt_runtime_opts[] = {
+    "transport",
+    "portal",
+    "target",
+    "user",
+    "password",
+    "password-secret",
+    "lun",
+    "initiator-name",
+    "header-digest",
+
+    NULL
+};
+
 static BlockDriver bdrv_iscsi = {
     .format_name     = "iscsi",
     .protocol_name   = "iscsi",
@@ -2219,6 +2233,8 @@ static BlockDriver bdrv_iscsi = {
 
     .bdrv_detach_aio_context = iscsi_detach_aio_context,
     .bdrv_attach_aio_context = iscsi_attach_aio_context,
+
+    .sgfnt_runtime_opts = iscsi_sgfnt_runtime_opts,
 };
 
 #if LIBISCSI_API_VERSION >= (20160603)
@@ -2254,6 +2270,8 @@ static BlockDriver bdrv_iser = {
 
     .bdrv_detach_aio_context = iscsi_detach_aio_context,
     .bdrv_attach_aio_context = iscsi_attach_aio_context,
+
+    .sgfnt_runtime_opts = iscsi_sgfnt_runtime_opts,
 };
 #endif
 
diff --git a/block/nbd.c b/block/nbd.c
index f896fc4..7c10ede 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -568,6 +568,17 @@ static char *nbd_dirname(BlockDriverState *bs, Error **errp)
     return NULL;
 }
 
+static const char *const nbd_sgfnt_runtime_opts[] = {
+    "path",
+    "host",
+    "port",
+    "export",
+    "tls-creds",
+    "server.",
+
+    NULL
+};
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -586,6 +597,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -606,6 +618,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -626,6 +639,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/block/nfs.c b/block/nfs.c
index 976d96f..b7fa1a3 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -910,6 +910,10 @@ static BlockDriver bdrv_nfs = {
     .bdrv_refresh_filename          = nfs_refresh_filename,
     .bdrv_dirname                   = nfs_dirname,
 
+    .sgfnt_runtime_opts             = (const char *const[]) { "path", "uid",
+                                                              "gid", "server.",
+                                                              NULL },
+
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_invalidate_cache          = nfs_invalidate_cache,
 #endif
diff --git a/block/null.c b/block/null.c
index 876f909..7d99552 100644
--- a/block/null.c
+++ b/block/null.c
@@ -236,6 +236,13 @@ static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
     bs->full_open_options = opts;
 }
 
+static const char *const null_sgfnt_runtime_opts[] = {
+    BLOCK_OPT_SIZE,
+    NULL_OPT_ZEROES,
+
+    NULL
+};
+
 static BlockDriver bdrv_null_co = {
     .format_name            = "null-co",
     .protocol_name          = "null-co",
@@ -253,6 +260,7 @@ static BlockDriver bdrv_null_co = {
     .bdrv_co_get_block_status   = null_co_get_block_status,
 
     .bdrv_refresh_filename  = null_refresh_filename,
+    .sgfnt_runtime_opts     = null_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_null_aio = {
@@ -272,6 +280,7 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_co_get_block_status   = null_co_get_block_status,
 
     .bdrv_refresh_filename  = null_refresh_filename,
+    .sgfnt_runtime_opts     = null_sgfnt_runtime_opts,
 };
 
 static void bdrv_null_init(void)
diff --git a/block/quorum.c b/block/quorum.c
index 1e40b9e..768dcf3 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1143,6 +1143,14 @@ static BlockDriver bdrv_quorum = {
 
     .is_filter                          = true,
     .bdrv_recurse_is_first_non_filter   = quorum_recurse_is_first_non_filter,
+
+    .sgfnt_runtime_opts                 = (const char *const[]) {
+                                              QUORUM_OPT_VOTE_THRESHOLD,
+                                              QUORUM_OPT_BLKVERIFY,
+                                              QUORUM_OPT_REWRITE,
+                                              QUORUM_OPT_READ_PATTERN,
+                                              NULL
+                                          },
 };
 
 static void bdrv_quorum_init(void)
diff --git a/block/rbd.c b/block/rbd.c
index 9da02cd..1e29215 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1144,6 +1144,11 @@ static BlockDriver bdrv_rbd = {
 #ifdef LIBRBD_SUPPORTS_INVALIDATE
     .bdrv_invalidate_cache  = qemu_rbd_invalidate_cache,
 #endif
+
+    .sgfnt_runtime_opts     = (const char *const[]) { "pool", "image", "conf",
+                                                      "snapshot", "user",
+                                                      "server.",
+                                                      "password-secret", NULL },
 };
 
 static void bdrv_rbd_init(void)
diff --git a/block/replication.c b/block/replication.c
index 3885f04..3a46485 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -682,6 +682,11 @@ BlockDriver bdrv_replication = {
     .bdrv_recurse_is_first_non_filter = replication_recurse_is_first_non_filter,
 
     .has_variable_length        = true,
+    .sgfnt_runtime_opts         = (const char *const[]) {
+                                      REPLICATION_MODE,
+                                      REPLICATION_TOP_ID,
+                                      NULL
+                                  },
 };
 
 static void bdrv_replication_init(void)
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2ae04b7..18830fd 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3053,6 +3053,15 @@ static QemuOptsList sd_create_opts = {
     }
 };
 
+static const char *const sd_sgfnt_runtime_opts[] = {
+    "vdi",
+    "snap-id",
+    "tag",
+    "server.",
+
+    NULL
+};
+
 static BlockDriver bdrv_sheepdog = {
     .format_name    = "sheepdog",
     .protocol_name  = "sheepdog",
@@ -3087,6 +3096,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_attach_aio_context = sd_attach_aio_context,
 
     .create_opts    = &sd_create_opts,
+    .sgfnt_runtime_opts = sd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_tcp = {
@@ -3123,6 +3133,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_attach_aio_context = sd_attach_aio_context,
 
     .create_opts    = &sd_create_opts,
+    .sgfnt_runtime_opts = sd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_unix = {
@@ -3159,6 +3170,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_attach_aio_context = sd_attach_aio_context,
 
     .create_opts    = &sd_create_opts,
+    .sgfnt_runtime_opts = sd_sgfnt_runtime_opts,
 };
 
 static void bdrv_sheepdog_init(void)
diff --git a/block/ssh.c b/block/ssh.c
index 27f06ec..14345bb 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1200,6 +1200,11 @@ static BlockDriver bdrv_ssh = {
     .bdrv_getlength               = ssh_getlength,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
     .create_opts                  = &ssh_create_opts,
+    .sgfnt_runtime_opts           = (const char *const[]) {
+                                        "host", "port", "path", "user",
+                                        "host_key_check", "server.",
+                                        NULL
+                                    },
 };
 
 static void bdrv_ssh_init(void)
diff --git a/block/vpc.c b/block/vpc.c
index 4240ba9..e9fa9f6 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1080,6 +1080,10 @@ static BlockDriver bdrv_vpc = {
 
     .create_opts            = &vpc_create_opts,
     .bdrv_has_zero_init     = vpc_has_zero_init,
+    .sgfnt_runtime_opts     = (const char *const[]) {
+                                  VPC_OPT_SIZE_CALC,
+                                  NULL
+                              },
 };
 
 static void bdrv_vpc_init(void)
diff --git a/block/vvfat.c b/block/vvfat.c
index 426ca70..d384c1b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3130,6 +3130,10 @@ static BlockDriver bdrv_vvfat = {
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
     .bdrv_co_get_block_status = vvfat_co_get_block_status,
+
+    .sgfnt_runtime_opts     = (const char *const[]) { "dir", "fat-type",
+                                                      "floppy", "label", "rw",
+                                                      NULL },
 };
 
 static void bdrv_vvfat_init(void)
diff --git a/block/vxhs.c b/block/vxhs.c
index 75cc6c8..08cdc3b 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -565,6 +565,14 @@ static BlockDriver bdrv_vxhs = {
     .bdrv_getlength               = vxhs_getlength,
     .bdrv_aio_readv               = vxhs_aio_readv,
     .bdrv_aio_writev              = vxhs_aio_writev,
+    .sgfnt_runtime_opts           = (const char *const[]) {
+                                        VXHS_OPT_VDISK_ID,
+                                        "tls-creds",
+                                        VXHS_OPT_HOST,
+                                        VXHS_OPT_PORT,
+                                        VXHS_OPT_SERVER".",
+                                        NULL
+                                    },
 };
 
 static void bdrv_vxhs_init(void)
-- 
2.9.4
