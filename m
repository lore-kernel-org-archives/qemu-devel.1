Received: from eggs.gnu.org ([2001:4830:134:3::10]:46365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEFN-0002Fl-3r
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEFL-0004IG-Ra
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:51:21 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:51:03 +0100
Message-Id: <20170116205110.32105-1-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 18/25] block: Add sgfnt_runtime_opts to
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

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
 block/curl.c              | 20 ++++++++++++++++++++
 block/gluster.c           | 19 +++++++++++++++++++
 block/nbd.c               |  8 ++++++++
 block/nfs.c               |  3 +++
 block/null.c              |  9 +++++++++
 block/quorum.c            |  8 ++++++++
 block/rbd.c               |  2 ++
 block/vvfat.c             |  4 ++++
 10 files changed, 86 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 30fc1def4a..799c892558 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -322,6 +322,13 @@ struct BlockDriver {
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
index acccf85666..1551b2099a 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -756,6 +756,12 @@ static BlockDriver bdrv_blkdebug = {
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
diff --git a/block/curl.c b/block/curl.c
index 792fef8269..34a5b0f7e3 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -872,6 +872,18 @@ static int64_t curl_getlength(BlockDriverState *bs)
     return s->len;
 }
 
+static const char *const curl_sgfnt_runtime_opts[] = {
+    CURL_BLOCK_OPT_URL,
+    CURL_BLOCK_OPT_SSLVERIFY,
+    CURL_BLOCK_OPT_COOKIE,
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
@@ -886,6 +898,8 @@ static BlockDriver bdrv_http = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_https = {
@@ -902,6 +916,8 @@ static BlockDriver bdrv_https = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_ftp = {
@@ -918,6 +934,8 @@ static BlockDriver bdrv_ftp = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_ftps = {
@@ -934,6 +952,8 @@ static BlockDriver bdrv_ftps = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
 static void curl_block_init(void)
diff --git a/block/gluster.c b/block/gluster.c
index 1a22f2982d..ded13fb5fb 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1402,6 +1402,21 @@ static int64_t coroutine_fn qemu_gluster_co_get_block_status(
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
@@ -1428,6 +1443,7 @@ static BlockDriver bdrv_gluster = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static BlockDriver bdrv_gluster_tcp = {
@@ -1456,6 +1472,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static BlockDriver bdrv_gluster_unix = {
@@ -1484,6 +1501,7 @@ static BlockDriver bdrv_gluster_unix = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 /* rdma is deprecated (actually never supported for volfile fetch).
@@ -1518,6 +1536,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #endif
     .bdrv_co_get_block_status     = qemu_gluster_co_get_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .sgfnt_runtime_opts           = gluster_sgfnt_open_opts,
 };
 
 static void bdrv_gluster_init(void)
diff --git a/block/nbd.c b/block/nbd.c
index 42f0cd638c..130798903f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -580,6 +580,11 @@ static char *nbd_dirname(BlockDriverState *bs, Error **errp)
     return NULL;
 }
 
+static const char *const nbd_sgfnt_runtime_opts[] = {
+    "path", "host", "port", "export", "tls-creds", "server.",
+    NULL
+};
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -598,6 +603,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -618,6 +624,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -638,6 +645,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirname               = nbd_dirname,
+    .sgfnt_runtime_opts         = nbd_sgfnt_runtime_opts,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/block/nfs.c b/block/nfs.c
index a6addff557..d4ca2757a1 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -877,6 +877,9 @@ static BlockDriver bdrv_nfs = {
     .bdrv_refresh_filename          = nfs_refresh_filename,
     .bdrv_dirname                   = nfs_dirname,
 
+    .sgfnt_runtime_opts             = (const char *const[]) { "path", "uid",
+                                                              "gid", NULL },
+
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_invalidate_cache          = nfs_invalidate_cache,
 #endif
diff --git a/block/null.c b/block/null.c
index b300390944..16ef8b2a09 100644
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
index 3b5da08ec3..878b8cfa9a 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1138,6 +1138,14 @@ static BlockDriver bdrv_quorum = {
 
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
index a57b3e3c5d..b09a18f097 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1005,6 +1005,8 @@ static BlockDriver bdrv_rbd = {
 #ifdef LIBRBD_SUPPORTS_INVALIDATE
     .bdrv_invalidate_cache  = qemu_rbd_invalidate_cache,
 #endif
+
+    .sgfnt_runtime_opts     = (const char *const[]) { "password-secret", NULL },
 };
 
 static void bdrv_rbd_init(void)
diff --git a/block/vvfat.c b/block/vvfat.c
index ded21092ee..94f28606c7 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3077,6 +3077,10 @@ static BlockDriver bdrv_vvfat = {
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
     .bdrv_co_get_block_status = vvfat_co_get_block_status,
+
+    .sgfnt_runtime_opts     = (const char *const[]) { "dir", "fat-type",
+                                                      "floppy", "label", "rw",
+                                                      NULL },
 };
 
 static void bdrv_vvfat_init(void)
-- 
2.11.0
