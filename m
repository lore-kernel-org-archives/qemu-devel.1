Received: from eggs.gnu.org ([2001:4830:134:3::10]:43099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbY-0002vh-OS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbV-0008VO-VG
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:24 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:18 +0200
Message-Id: <20180809213528.14738-22-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 21/31] block: Add
 strong_runtime_opts to BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

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
 block/blkdebug.c          | 16 ++++++++++++++++
 block/blklogwrites.c      |  8 ++++++++
 block/crypto.c            |  8 ++++++++
 block/curl.c              | 21 +++++++++++++++++++++
 block/gluster.c           | 19 +++++++++++++++++++
 block/iscsi.c             | 18 ++++++++++++++++++
 block/nbd.c               | 14 ++++++++++++++
 block/nfs.c               | 11 +++++++++++
 block/null.c              |  9 +++++++++
 block/nvme.c              |  8 ++++++++
 block/qcow.c              |  7 +++++++
 block/qcow2.c             |  7 +++++++
 block/quorum.c            | 11 +++++++++++
 block/raw-format.c        | 10 +++++++++-
 block/rbd.c               | 14 ++++++++++++++
 block/replication.c       |  8 ++++++++
 block/sheepdog.c          | 12 ++++++++++++
 block/ssh.c               | 12 ++++++++++++
 block/throttle.c          |  7 +++++++
 block/vpc.c               |  7 +++++++
 block/vvfat.c             | 12 ++++++++++++
 block/vxhs.c              | 11 +++++++++++
 23 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 80a947e676..1f53adfd96 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -516,6 +516,13 @@ struct BlockDriver {
     void (*bdrv_register_buf)(BlockDriverState *bs, void *host, size_t size);
     void (*bdrv_unregister_buf)(BlockDriverState *bs, void *host);
     QLIST_ENTRY(BlockDriver) list;
+
+    /* Pointer to a NULL-terminated array of names of strong options
+     * that can be specified for bdrv_open(). A strong option is one
+     * that changes the data of a BDS.
+     * If this pointer is NULL, the array is considered empty.
+     * "filename" and "driver" are always considered strong. */
+    const char *const *strong_runtime_opts;
 };
 
 typedef struct BlockLimits {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 0759452925..71b4275b98 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -888,6 +888,20 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
     return 0;
 }
 
+static const char *const blkdebug_strong_runtime_opts[] = {
+    "config",
+    "inject-error.",
+    "set-state.",
+    "align",
+    "max-transfer",
+    "opt-write-zero",
+    "max-write-zero",
+    "opt-discard",
+    "max-discard",
+
+    NULL
+};
+
 static BlockDriver bdrv_blkdebug = {
     .format_name            = "blkdebug",
     .protocol_name          = "blkdebug",
@@ -917,6 +931,8 @@ static BlockDriver bdrv_blkdebug = {
                                 = blkdebug_debug_remove_breakpoint,
     .bdrv_debug_resume          = blkdebug_debug_resume,
     .bdrv_debug_is_suspended    = blkdebug_debug_is_suspended,
+
+    .strong_runtime_opts        = blkdebug_strong_runtime_opts,
 };
 
 static void bdrv_blkdebug_init(void)
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 8f1b589d54..1c8e200326 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -518,6 +518,13 @@ blk_log_writes_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
                                  LOG_DISCARD_FLAG, false);
 }
 
+static const char *const blk_log_writes_strong_runtime_opts[] = {
+    "log-append",
+    "log-sector-size",
+
+    NULL
+};
+
 static BlockDriver bdrv_blk_log_writes = {
     .format_name            = "blklogwrites",
     .instance_size          = sizeof(BDRVBlkLogWritesState),
@@ -537,6 +544,7 @@ static BlockDriver bdrv_blk_log_writes = {
     .bdrv_co_block_status   = bdrv_co_block_status_from_file,
 
     .is_filter              = true,
+    .strong_runtime_opts    = blk_log_writes_strong_runtime_opts,
 };
 
 static void bdrv_blk_log_writes_init(void)
diff --git a/block/crypto.c b/block/crypto.c
index 146d81c90a..5731899f17 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -621,6 +621,12 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs)
     return spec_info;
 }
 
+static const char *const block_crypto_strong_runtime_opts[] = {
+    BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
+
+    NULL
+};
+
 BlockDriver bdrv_crypto_luks = {
     .format_name        = "luks",
     .instance_size      = sizeof(BlockCrypto),
@@ -640,6 +646,8 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_getlength     = block_crypto_getlength,
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
+
+    .strong_runtime_opts = block_crypto_strong_runtime_opts,
 };
 
 static void block_crypto_init(void)
diff --git a/block/curl.c b/block/curl.c
index 229bb84a27..86e45cfde8 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -958,6 +958,19 @@ static int64_t curl_getlength(BlockDriverState *bs)
     return s->len;
 }
 
+static const char *const curl_strong_runtime_opts[] = {
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
@@ -972,6 +985,8 @@ static BlockDriver bdrv_http = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_https = {
@@ -988,6 +1003,8 @@ static BlockDriver bdrv_https = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_ftp = {
@@ -1004,6 +1021,8 @@ static BlockDriver bdrv_ftp = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_ftps = {
@@ -1020,6 +1039,8 @@ static BlockDriver bdrv_ftps = {
 
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
+
+    .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
 static void curl_block_init(void)
diff --git a/block/gluster.c b/block/gluster.c
index 4fd55a9cc5..9f3611f443 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1487,6 +1487,21 @@ static int coroutine_fn qemu_gluster_co_block_status(BlockDriverState *bs,
 }
 
 
+static const char *const gluster_strong_open_opts[] = {
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
@@ -1514,6 +1529,7 @@ static BlockDriver bdrv_gluster = {
 #endif
     .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .strong_runtime_opts          = gluster_strong_open_opts,
 };
 
 static BlockDriver bdrv_gluster_tcp = {
@@ -1543,6 +1559,7 @@ static BlockDriver bdrv_gluster_tcp = {
 #endif
     .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .strong_runtime_opts          = gluster_strong_open_opts,
 };
 
 static BlockDriver bdrv_gluster_unix = {
@@ -1572,6 +1589,7 @@ static BlockDriver bdrv_gluster_unix = {
 #endif
     .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .strong_runtime_opts          = gluster_strong_open_opts,
 };
 
 /* rdma is deprecated (actually never supported for volfile fetch).
@@ -1607,6 +1625,7 @@ static BlockDriver bdrv_gluster_rdma = {
 #endif
     .bdrv_co_block_status         = qemu_gluster_co_block_status,
     .create_opts                  = &qemu_gluster_create_opts,
+    .strong_runtime_opts          = gluster_strong_open_opts,
 };
 
 static void bdrv_gluster_init(void)
diff --git a/block/iscsi.c b/block/iscsi.c
index bb69faf34a..ecee7117ff 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2421,6 +2421,20 @@ static QemuOptsList iscsi_create_opts = {
     }
 };
 
+static const char *const iscsi_strong_runtime_opts[] = {
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
@@ -2455,6 +2469,8 @@ static BlockDriver bdrv_iscsi = {
 
     .bdrv_detach_aio_context = iscsi_detach_aio_context,
     .bdrv_attach_aio_context = iscsi_attach_aio_context,
+
+    .strong_runtime_opts = iscsi_strong_runtime_opts,
 };
 
 #if LIBISCSI_API_VERSION >= (20160603)
@@ -2492,6 +2508,8 @@ static BlockDriver bdrv_iser = {
 
     .bdrv_detach_aio_context = iscsi_detach_aio_context,
     .bdrv_attach_aio_context = iscsi_attach_aio_context,
+
+    .strong_runtime_opts = iscsi_strong_runtime_opts,
 };
 #endif
 
diff --git a/block/nbd.c b/block/nbd.c
index bca127c8f5..5b4e4cf1db 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -574,6 +574,17 @@ static char *nbd_dirname(BlockDriverState *bs, Error **errp)
     return NULL;
 }
 
+static const char *const nbd_strong_runtime_opts[] = {
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
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
     .bdrv_dirname               = nbd_dirname,
+    .strong_runtime_opts        = nbd_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -614,6 +626,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
     .bdrv_dirname               = nbd_dirname,
+    .strong_runtime_opts        = nbd_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -635,6 +648,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_co_block_status       = nbd_client_co_block_status,
     .bdrv_dirname               = nbd_dirname,
+    .strong_runtime_opts        = nbd_strong_runtime_opts,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/block/nfs.c b/block/nfs.c
index 19ee07c321..6985a44b89 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -878,6 +878,15 @@ static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
 }
 #endif
 
+static const char *nfs_strong_runtime_opts[] = {
+    "path",
+    "user",
+    "group",
+    "server.",
+
+    NULL
+};
+
 static BlockDriver bdrv_nfs = {
     .format_name                    = "nfs",
     .protocol_name                  = "nfs",
@@ -905,6 +914,8 @@ static BlockDriver bdrv_nfs = {
     .bdrv_refresh_filename          = nfs_refresh_filename,
     .bdrv_dirname                   = nfs_dirname,
 
+    .strong_runtime_opts            = nfs_strong_runtime_opts,
+
 #ifdef LIBNFS_FEATURE_PAGECACHE
     .bdrv_co_invalidate_cache       = nfs_co_invalidate_cache,
 #endif
diff --git a/block/null.c b/block/null.c
index 5d610fdfba..07acb4f732 100644
--- a/block/null.c
+++ b/block/null.c
@@ -256,6 +256,13 @@ static void null_refresh_filename(BlockDriverState *bs, QDict *opts)
     bs->full_open_options = qobject_ref(opts);
 }
 
+static const char *const null_strong_runtime_opts[] = {
+    BLOCK_OPT_SIZE,
+    NULL_OPT_ZEROES,
+
+    NULL
+};
+
 static BlockDriver bdrv_null_co = {
     .format_name            = "null-co",
     .protocol_name          = "null-co",
@@ -274,6 +281,7 @@ static BlockDriver bdrv_null_co = {
     .bdrv_co_block_status   = null_co_block_status,
 
     .bdrv_refresh_filename  = null_refresh_filename,
+    .strong_runtime_opts    = null_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_null_aio = {
@@ -294,6 +302,7 @@ static BlockDriver bdrv_null_aio = {
     .bdrv_co_block_status   = null_co_block_status,
 
     .bdrv_refresh_filename  = null_refresh_filename,
+    .strong_runtime_opts    = null_strong_runtime_opts,
 };
 
 static void bdrv_null_init(void)
diff --git a/block/nvme.c b/block/nvme.c
index 6f71122bf5..b0548e4e37 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1154,6 +1154,13 @@ static void nvme_unregister_buf(BlockDriverState *bs, void *host)
     qemu_vfio_dma_unmap(s->vfio, host);
 }
 
+static const char *const nvme_strong_runtime_opts[] = {
+    NVME_BLOCK_OPT_DEVICE,
+    NVME_BLOCK_OPT_NAMESPACE,
+
+    NULL
+};
+
 static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
@@ -1171,6 +1178,7 @@ static BlockDriver bdrv_nvme = {
 
     .bdrv_refresh_filename    = nvme_refresh_filename,
     .bdrv_refresh_limits      = nvme_refresh_limits,
+    .strong_runtime_opts      = nvme_strong_runtime_opts,
 
     .bdrv_detach_aio_context  = nvme_detach_aio_context,
     .bdrv_attach_aio_context  = nvme_attach_aio_context,
diff --git a/block/qcow.c b/block/qcow.c
index 20f610ec74..61c3c70b0a 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1186,6 +1186,12 @@ static QemuOptsList qcow_create_opts = {
     }
 };
 
+static const char *const qcow_strong_runtime_opts[] = {
+    "encrypt." BLOCK_CRYPTO_OPT_QCOW_KEY_SECRET,
+
+    NULL
+};
+
 static BlockDriver bdrv_qcow = {
     .format_name	= "qcow",
     .instance_size	= sizeof(BDRVQcowState),
@@ -1209,6 +1215,7 @@ static BlockDriver bdrv_qcow = {
     .bdrv_get_info          = qcow_get_info,
 
     .create_opts            = &qcow_create_opts,
+    .strong_runtime_opts    = qcow_strong_runtime_opts,
 };
 
 static void bdrv_qcow_init(void)
diff --git a/block/qcow2.c b/block/qcow2.c
index 6ca57b7d21..97c406d95f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4745,6 +4745,12 @@ static QemuOptsList qcow2_create_opts = {
     }
 };
 
+static const char *const qcow2_strong_runtime_opts[] = {
+    "encrypt." BLOCK_CRYPTO_OPT_QCOW_KEY_SECRET,
+
+    NULL
+};
+
 BlockDriver bdrv_qcow2 = {
     .format_name        = "qcow2",
     .instance_size      = sizeof(BDRVQcow2State),
@@ -4793,6 +4799,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_inactivate            = qcow2_inactivate,
 
     .create_opts         = &qcow2_create_opts,
+    .strong_runtime_opts = qcow2_strong_runtime_opts,
     .bdrv_co_check       = qcow2_co_check,
     .bdrv_amend_options  = qcow2_amend_options,
 
diff --git a/block/quorum.c b/block/quorum.c
index beec8209d1..fdc0e7d16d 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1111,6 +1111,15 @@ static char *quorum_dirname(BlockDriverState *bs, Error **errp)
     return NULL;
 }
 
+static const char *const quorum_strong_runtime_opts[] = {
+    QUORUM_OPT_VOTE_THRESHOLD,
+    QUORUM_OPT_BLKVERIFY,
+    QUORUM_OPT_REWRITE,
+    QUORUM_OPT_READ_PATTERN,
+
+    NULL
+};
+
 static BlockDriver bdrv_quorum = {
     .format_name                        = "quorum",
 
@@ -1135,6 +1144,8 @@ static BlockDriver bdrv_quorum = {
 
     .is_filter                          = true,
     .bdrv_recurse_is_first_non_filter   = quorum_recurse_is_first_non_filter,
+
+    .strong_runtime_opts                = quorum_strong_runtime_opts,
 };
 
 static void bdrv_quorum_init(void)
diff --git a/block/raw-format.c b/block/raw-format.c
index a9ddb362a0..42aebafb8a 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -536,6 +536,13 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                  read_flags, write_flags);
 }
 
+static const char *const raw_strong_runtime_opts[] = {
+    "offset",
+    "size",
+
+    NULL
+};
+
 BlockDriver bdrv_raw = {
     .format_name          = "raw",
     .instance_size        = sizeof(BDRVRawState),
@@ -566,7 +573,8 @@ BlockDriver bdrv_raw = {
     .bdrv_lock_medium     = &raw_lock_medium,
     .bdrv_co_ioctl        = &raw_co_ioctl,
     .create_opts          = &raw_create_opts,
-    .bdrv_has_zero_init   = &raw_has_zero_init
+    .bdrv_has_zero_init   = &raw_has_zero_init,
+    .strong_runtime_opts  = raw_strong_runtime_opts,
 };
 
 static void bdrv_raw_init(void)
diff --git a/block/rbd.c b/block/rbd.c
index ca8e5bbace..bb098e66e0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1172,6 +1172,18 @@ static QemuOptsList qemu_rbd_create_opts = {
     }
 };
 
+static const char *const qemu_rbd_strong_runtime_opts[] = {
+    "pool",
+    "image",
+    "conf",
+    "snapshot",
+    "user",
+    "server.",
+    "password-secret",
+
+    NULL
+};
+
 static BlockDriver bdrv_rbd = {
     .format_name            = "rbd",
     .instance_size          = sizeof(BDRVRBDState),
@@ -1209,6 +1221,8 @@ static BlockDriver bdrv_rbd = {
 #ifdef LIBRBD_SUPPORTS_INVALIDATE
     .bdrv_co_invalidate_cache = qemu_rbd_co_invalidate_cache,
 #endif
+
+    .strong_runtime_opts    = qemu_rbd_strong_runtime_opts,
 };
 
 static void bdrv_rbd_init(void)
diff --git a/block/replication.c b/block/replication.c
index d5e39be5eb..0bc24c0e12 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -703,6 +703,13 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
     aio_context_release(aio_context);
 }
 
+static const char *const replication_strong_runtime_opts[] = {
+    REPLICATION_MODE,
+    REPLICATION_TOP_ID,
+
+    NULL
+};
+
 BlockDriver bdrv_replication = {
     .format_name                = "replication",
     .instance_size              = sizeof(BDRVReplicationState),
@@ -719,6 +726,7 @@ BlockDriver bdrv_replication = {
     .bdrv_recurse_is_first_non_filter = replication_recurse_is_first_non_filter,
 
     .has_variable_length        = true,
+    .strong_runtime_opts        = replication_strong_runtime_opts,
 };
 
 static void bdrv_replication_init(void)
diff --git a/block/sheepdog.c b/block/sheepdog.c
index b229a664d9..3cc62d3d68 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3216,6 +3216,15 @@ static QemuOptsList sd_create_opts = {
     }
 };
 
+static const char *const sd_strong_runtime_opts[] = {
+    "vdi",
+    "snap-id",
+    "tag",
+    "server.",
+
+    NULL
+};
+
 static BlockDriver bdrv_sheepdog = {
     .format_name                  = "sheepdog",
     .protocol_name                = "sheepdog",
@@ -3251,6 +3260,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .strong_runtime_opts          = sd_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_tcp = {
@@ -3288,6 +3298,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .strong_runtime_opts          = sd_strong_runtime_opts,
 };
 
 static BlockDriver bdrv_sheepdog_unix = {
@@ -3325,6 +3336,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_attach_aio_context      = sd_attach_aio_context,
 
     .create_opts                  = &sd_create_opts,
+    .strong_runtime_opts          = sd_strong_runtime_opts,
 };
 
 static void bdrv_sheepdog_init(void)
diff --git a/block/ssh.c b/block/ssh.c
index 7fbc27abdf..350ad463b2 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1266,6 +1266,17 @@ static int coroutine_fn ssh_co_truncate(BlockDriverState *bs, int64_t offset,
     return ssh_grow_file(s, offset, errp);
 }
 
+static const char *const ssh_strong_runtime_opts[] = {
+    "host",
+    "port",
+    "path",
+    "user",
+    "host_key_check",
+    "server.",
+
+    NULL
+};
+
 static BlockDriver bdrv_ssh = {
     .format_name                  = "ssh",
     .protocol_name                = "ssh",
@@ -1282,6 +1293,7 @@ static BlockDriver bdrv_ssh = {
     .bdrv_co_truncate             = ssh_co_truncate,
     .bdrv_co_flush_to_disk        = ssh_co_flush,
     .create_opts                  = &ssh_create_opts,
+    .strong_runtime_opts          = ssh_strong_runtime_opts,
 };
 
 static void bdrv_ssh_init(void)
diff --git a/block/throttle.c b/block/throttle.c
index 636c9764aa..f64dcc27b9 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -227,6 +227,12 @@ static void coroutine_fn throttle_co_drain_end(BlockDriverState *bs)
     atomic_dec(&tgm->io_limits_disabled);
 }
 
+static const char *const throttle_strong_runtime_opts[] = {
+    QEMU_OPT_THROTTLE_GROUP_NAME,
+
+    NULL
+};
+
 static BlockDriver bdrv_throttle = {
     .format_name                        =   "throttle",
     .instance_size                      =   sizeof(ThrottleGroupMember),
@@ -259,6 +265,7 @@ static BlockDriver bdrv_throttle = {
     .bdrv_co_drain_end                  =   throttle_co_drain_end,
 
     .is_filter                          =   true,
+    .strong_runtime_opts                =   throttle_strong_runtime_opts,
 };
 
 static void bdrv_throttle_init(void)
diff --git a/block/vpc.c b/block/vpc.c
index 717809cc24..b5d8f86422 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1214,6 +1214,12 @@ static QemuOptsList vpc_create_opts = {
     }
 };
 
+static const char *const vpc_strong_runtime_opts[] = {
+    VPC_OPT_SIZE_CALC,
+
+    NULL
+};
+
 static BlockDriver bdrv_vpc = {
     .format_name    = "vpc",
     .instance_size  = sizeof(BDRVVPCState),
@@ -1234,6 +1240,7 @@ static BlockDriver bdrv_vpc = {
 
     .create_opts            = &vpc_create_opts,
     .bdrv_has_zero_init     = vpc_has_zero_init,
+    .strong_runtime_opts    = vpc_strong_runtime_opts,
 };
 
 static void bdrv_vpc_init(void)
diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841a5c..14c0644d1c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3244,6 +3244,16 @@ static void vvfat_close(BlockDriverState *bs)
     }
 }
 
+static const char *const vvfat_strong_runtime_opts[] = {
+    "dir",
+    "fat-type",
+    "floppy",
+    "label",
+    "rw",
+
+    NULL
+};
+
 static BlockDriver bdrv_vvfat = {
     .format_name            = "vvfat",
     .protocol_name          = "fat",
@@ -3258,6 +3268,8 @@ static BlockDriver bdrv_vvfat = {
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
     .bdrv_co_block_status   = vvfat_co_block_status,
+
+    .strong_runtime_opts    = vvfat_strong_runtime_opts,
 };
 
 static void bdrv_vvfat_init(void)
diff --git a/block/vxhs.c b/block/vxhs.c
index 0cb0a007e9..2e18229ba4 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -556,6 +556,16 @@ static int64_t vxhs_getlength(BlockDriverState *bs)
     return vdisk_size;
 }
 
+static const char *const vxhs_strong_runtime_opts[] = {
+    VXHS_OPT_VDISK_ID,
+    "tls-creds",
+    VXHS_OPT_HOST,
+    VXHS_OPT_PORT,
+    VXHS_OPT_SERVER".",
+
+    NULL
+};
+
 static BlockDriver bdrv_vxhs = {
     .format_name                  = "vxhs",
     .protocol_name                = "vxhs",
@@ -567,6 +577,7 @@ static BlockDriver bdrv_vxhs = {
     .bdrv_getlength               = vxhs_getlength,
     .bdrv_aio_preadv              = vxhs_aio_preadv,
     .bdrv_aio_pwritev             = vxhs_aio_pwritev,
+    .strong_runtime_opts          = vxhs_strong_runtime_opts,
 };
 
 static void bdrv_vxhs_init(void)
-- 
2.17.1
