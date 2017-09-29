Received: from eggs.gnu.org ([2001:4830:134:3::10]:47472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyaD-0002V4-VS
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyaC-0004Gj-4H
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:14 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:40 +0200
Message-Id: <20170929165347.29658-19-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

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
 block/throttle.c          |  4 ++++
 block/vpc.c               |  4 ++++
 block/vvfat.c             |  4 ++++
 block/vxhs.c              |  8 ++++++++
 18 files changed, 158 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3c53a373e1..19d8d6801a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -444,6 +444,13 @@ struct BlockDriver {
                                                 Error **errp);
 
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
index 46e53f2f09..976dc43f17 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -905,6 +905,12 @@ static BlockDriver bdrv_blkdebug = {
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
index 60ddf8623e..7c3681ff04 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -626,6 +626,11 @@ BlockDriver bdrv_crypto_luks = {
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
index 2a244e2439..11318a9a29 100644
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
index 0f4265a3a4..e47bda97df 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1414,6 +1414,21 @@ static int64_t coroutine_fn qemu_gluster_co_get_block_status(
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
@@ -1440,6 +1455,7 @@ static BlockDriver bdrv_gluster = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static BlockDriver bdrv_gluster_tcp = {
@@ -1468,6 +1484,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static BlockDriver bdrv_gluster_unix = {
@@ -1496,6 +1513,7 @@ static BlockDriver bdrv_gluster_unix = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 /* rdma is deprecated (actually never supported for volfile fetch).
@@ -1530,6 +1548,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static void bdrv_gluster_init(void)
diff --git a/block/iscsi.c b/block/iscsi.c
index 4683f3b244..5da74e3ccb 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2161,6 +2161,20 @@ static QemuOptsList iscsi_create_opts = {
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
@@ -2193,6 +2207,8 @@ static BlockDriver bdrv_iscsi = {
 
     .bdrv_detach_aio_context = iscsi_detach_aio_context,
     .bdrv_attach_aio_context = iscsi_attach_aio_context,
+
+    .sgfnt_runtime_opts = iscsi_sgfnt_runtime_opts,
 };
 
 #if LIBISCSI_API_VERSION >= (20160603)
@@ -2228,6 +2244,8 @@ static BlockDriver bdrv_iser = {
 
     .bdrv_detach_aio_context = iscsi_detach_aio_context,
     .bdrv_attach_aio_context = iscsi_attach_aio_context,
+
+    .sgfnt_runtime_opts = iscsi_sgfnt_runtime_opts,
 };
 #endif
 
diff --git a/block/nbd.c b/block/nbd.c
index ed921fa333..0a36394b73 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -575,6 +575,17 @@ static char *nbd_dirname(BlockDriverState *bs, Error **errp)
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
@@ -593,6 +604,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -613,6 +625,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -633,6 +646,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/block/nfs.c b/block/nfs.c
index 0152a9bd32..e8cff25fd3 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -923,6 +923,10 @@ static BlockDriver bdrv_nfs = {
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
index dd9c13f9ba..59673d2449 100644
--- a/block/null.c
+++ b/block/null.c
@@ -255,6 +255,13 @@ static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
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
@@ -273,6 +280,7 @@ static BlockDriver bdrv_null_co = {
     .bdrv_co_get_block_status   = null_co_get_block_status,
 
     .bdrv_refresh_filename  = null_refresh_filename,
+    .sgfnt_runtime_opts     = null_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_null_aio = {
@@ -293,6 +301,7 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_co_get_block_status   = null_co_get_block_status,
 
     .bdrv_refresh_filename  = null_refresh_filename,
+    .sgfnt_runtime_opts     = null_sgfnt_runtime_opts,
 };
 
 static void bdrv_null_init(void)
diff --git a/block/quorum.c b/block/quorum.c
index e5a844335e..fa7b0f6da6 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1130,6 +1130,14 @@ static BlockDriver bdrv_quorum = {
 
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
index 144f350e1f..79db69e767 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1151,6 +1151,11 @@ static BlockDriver bdrv_rbd = {
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
index 3a4e6822e4..68795221fd 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -694,6 +694,11 @@ BlockDriver bdrv_replication = {
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
index 696a71442a..1b788534b6 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3077,6 +3077,15 @@ static QemuOptsList sd_create_opts = {
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
@@ -3111,6 +3120,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_attach_aio_context = sd_attach_aio_context,
 
     .create_opts    = &sd_create_opts,
+    .sgfnt_runtime_opts = sd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_tcp = {
@@ -3147,6 +3157,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_attach_aio_context = sd_attach_aio_context,
 
     .create_opts    = &sd_create_opts,
+    .sgfnt_runtime_opts = sd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_unix = {
@@ -3183,6 +3194,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_attach_aio_context = sd_attach_aio_context,
 
     .create_opts    = &sd_create_opts,
+    .sgfnt_runtime_opts = sd_sgfnt_runtime_opts,
 };
 
 static void bdrv_sheepdog_init(void)
diff --git a/block/ssh.c b/block/ssh.c
index b049a16eb9..35387cf20d 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1209,6 +1209,11 @@ static BlockDriver bdrv_ssh = {
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
diff --git a/block/throttle.c b/block/throttle.c
index 5bca76300f..93341f8151 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -227,6 +227,10 @@ static BlockDriver bdrv_throttle = {
     .bdrv_co_get_block_status           =   bdrv_co_get_block_status_from_file,
 
     .is_filter                          =   true,
+    .sgfnt_runtime_opts                 =   (const char *const[]) {
+                                                QEMU_OPT_THROTTLE_GROUP_NAME,
+                                                NULL
+                                            },
 };
 
 static void bdrv_throttle_init(void)
diff --git a/block/vpc.c b/block/vpc.c
index 1576d7b595..f351a652b3 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1103,6 +1103,10 @@ static BlockDriver bdrv_vpc = {
 
     .create_opts            = &vpc_create_opts,
     .bdrv_has_zero_init     = vpc_has_zero_init,
+    .sgfnt_runtime_opts     = (const char *const[]) {
+                                  VPC_OPT_SIZE_CALC,
+                                  NULL
+                              },
 };
 
 static void bdrv_vpc_init(void)
diff --git a/block/vvfat.c b/block/vvfat.c
index a0f2335894..c667f03a14 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3252,6 +3252,10 @@ static BlockDriver bdrv_vvfat = {
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
index 75cc6c8672..08cdc3b525 100644
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
2.13.6
