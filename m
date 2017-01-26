Received: from eggs.gnu.org ([2001:4830:134:3::10]:45806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9L-0001y7-8D
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9J-0006Jk-G4
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:27 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:26 +0000
Message-Id: <20170126101827.22378-18-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 17/18] block: remove all encryption handling
 APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Now that all encryption keys must be provided upfront via
the QCryptoSecret API and associated block driver properties
there is no need for any explicit encryption handling APIs
in the block layer. Encryption can be handled transparently
within the block driver. We only retain an API for querying
whether an image is encrypted or not, since that is a
potentially useful piece of metadata to report to the user.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block.c                   | 77 +----------------------------------------------
 block/crypto.c            |  1 -
 block/qapi.c              |  2 +-
 block/qcow.c              |  1 -
 block/qcow2.c             |  1 -
 blockdev.c                | 37 ++---------------------
 include/block/block.h     |  3 --
 include/block/block_int.h |  1 -
 include/qapi/error.h      |  1 -
 qapi/block-core.json      |  3 +-
 qapi/common.json          |  5 +--
 11 files changed, 6 insertions(+), 126 deletions(-)

diff --git a/block.c b/block.c
index 39ddea3..27cca49 100644
--- a/block.c
+++ b/block.c
@@ -1865,15 +1865,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         goto close_and_fail;
     }
 
-    if (!bdrv_key_required(bs)) {
-        bdrv_parent_cb_change_media(bs, true);
-    } else if (!runstate_check(RUN_STATE_PRELAUNCH)
-               && !runstate_check(RUN_STATE_INMIGRATE)
-               && !runstate_check(RUN_STATE_PAUSED)) { /* HACK */
-        error_setg(errp,
-                   "Guest must be stopped for opening of encrypted image");
-        goto close_and_fail;
-    }
+    bdrv_parent_cb_change_media(bs, true);
 
     QDECREF(options);
 
@@ -2354,7 +2346,6 @@ static void bdrv_close(BlockDriverState *bs)
         bs->backing_format[0] = '\0';
         bs->total_sectors = 0;
         bs->encrypted = false;
-        bs->valid_key = false;
         bs->sg = false;
         QDECREF(bs->options);
         QDECREF(bs->explicit_options);
@@ -2723,72 +2714,6 @@ bool bdrv_is_encrypted(BlockDriverState *bs)
     return bs->encrypted;
 }
 
-bool bdrv_key_required(BlockDriverState *bs)
-{
-    BdrvChild *backing = bs->backing;
-
-    if (backing && backing->bs->encrypted && !backing->bs->valid_key) {
-        return true;
-    }
-    return (bs->encrypted && !bs->valid_key);
-}
-
-int bdrv_set_key(BlockDriverState *bs, const char *key)
-{
-    int ret;
-    if (bs->backing && bs->backing->bs->encrypted) {
-        ret = bdrv_set_key(bs->backing->bs, key);
-        if (ret < 0)
-            return ret;
-        if (!bs->encrypted)
-            return 0;
-    }
-    if (!bs->encrypted) {
-        return -EINVAL;
-    } else if (!bs->drv || !bs->drv->bdrv_set_key) {
-        return -ENOMEDIUM;
-    }
-    ret = bs->drv->bdrv_set_key(bs, key);
-    if (ret < 0) {
-        bs->valid_key = false;
-    } else if (!bs->valid_key) {
-        /* call the change callback now, we skipped it on open */
-        bs->valid_key = true;
-        bdrv_parent_cb_change_media(bs, true);
-    }
-    return ret;
-}
-
-/*
- * Provide an encryption key for @bs.
- * If @key is non-null:
- *     If @bs is not encrypted, fail.
- *     Else if the key is invalid, fail.
- *     Else set @bs's key to @key, replacing the existing key, if any.
- * If @key is null:
- *     If @bs is encrypted and still lacks a key, fail.
- *     Else do nothing.
- * On failure, store an error object through @errp if non-null.
- */
-void bdrv_add_key(BlockDriverState *bs, const char *key, Error **errp)
-{
-    if (key) {
-        if (!bdrv_is_encrypted(bs)) {
-            error_setg(errp, "Node '%s' is not encrypted",
-                      bdrv_get_device_or_node_name(bs));
-        } else if (bdrv_set_key(bs, key) < 0) {
-            error_setg(errp, QERR_INVALID_PASSWORD);
-        }
-    } else {
-        if (bdrv_key_required(bs)) {
-            error_set(errp, ERROR_CLASS_DEVICE_ENCRYPTED,
-                      "'%s' (%s) is encrypted",
-                      bdrv_get_device_or_node_name(bs),
-                      bdrv_get_encrypted_filename(bs));
-        }
-    }
-}
-
 const char *bdrv_get_format_name(BlockDriverState *bs)
 {
     return bs->drv ? bs->drv->format_name : NULL;
diff --git a/block/crypto.c b/block/crypto.c
index 9201cb0..6d6bd90 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -381,7 +381,6 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     }
 
     bs->encrypted = true;
-    bs->valid_key = true;
 
     ret = 0;
  cleanup:
diff --git a/block/qapi.c b/block/qapi.c
index a62e862..68cab56 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -45,7 +45,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
     info->ro                     = bs->read_only;
     info->drv                    = g_strdup(bs->drv->format_name);
     info->encrypted              = bs->encrypted;
-    info->encryption_key_missing = bdrv_key_required(bs);
+    info->encryption_key_missing = false;
 
     info->cache = g_new(BlockdevCacheInfo, 1);
     *info->cache = (BlockdevCacheInfo) {
diff --git a/block/qcow.c b/block/qcow.c
index 9bec081..cf05449 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -209,7 +209,6 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
         bs->encrypted = true;
-        bs->valid_key = true;
     }
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
diff --git a/block/qcow2.c b/block/qcow2.c
index 4dc7a64..7c8e602 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1144,7 +1144,6 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
         }
 
         bs->encrypted = true;
-        bs->valid_key = true;
     }
 
     s->l2_bits = s->cluster_bits - 3; /* L2 is always one cluster */
diff --git a/blockdev.c b/blockdev.c
index 245e1e1..d6cf191 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -587,10 +587,6 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
 
         bs->detect_zeroes = detect_zeroes;
 
-        if (bdrv_key_required(bs)) {
-            autostart = 0;
-        }
-
         block_acct_init(blk_get_stats(blk), account_invalid, account_failed);
 
         if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
@@ -2244,24 +2240,8 @@ void qmp_block_passwd(bool has_device, const char *device,
                       bool has_node_name, const char *node_name,
                       const char *password, Error **errp)
 {
-    Error *local_err = NULL;
-    BlockDriverState *bs;
-    AioContext *aio_context;
-
-    bs = bdrv_lookup_bs(has_device ? device : NULL,
-                        has_node_name ? node_name : NULL,
-                        &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    aio_context = bdrv_get_aio_context(bs);
-    aio_context_acquire(aio_context);
-
-    bdrv_add_key(bs, password, errp);
-
-    aio_context_release(aio_context);
+    error_setg(errp,
+               "Setting block passwords directly is no longer supported");
 }
 
 /*
@@ -2556,12 +2536,6 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,
         goto fail;
     }
 
-    bdrv_add_key(medium_bs, NULL, &err);
-    if (err) {
-        error_propagate(errp, err);
-        goto fail;
-    }
-
     rc = do_open_tray(has_device ? device : NULL,
                       has_id ? id : NULL,
                       false, &err);
@@ -3832,13 +3806,6 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
 
     QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
 
-    if (bs && bdrv_key_required(bs)) {
-        QTAILQ_REMOVE(&monitor_bdrv_states, bs, monitor_list);
-        bdrv_unref(bs);
-        error_setg(errp, "blockdev-add doesn't support encrypted devices");
-        goto fail;
-    }
-
 fail:
     visit_free(v);
 }
diff --git a/include/block/block.h b/include/block/block.h
index 8b0dcda..b18c113 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -412,9 +412,6 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it);
 
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
 bool bdrv_is_encrypted(BlockDriverState *bs);
-bool bdrv_key_required(BlockDriverState *bs);
-int bdrv_set_key(BlockDriverState *bs, const char *key);
-void bdrv_add_key(BlockDriverState *bs, const char *key, Error **errp);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 95e630e..a26ed00 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -436,7 +436,6 @@ struct BlockDriverState {
     int open_flags; /* flags used to open the file, re-used for re-open */
     bool read_only; /* if true, the media is read only */
     bool encrypted; /* if true, the media is encrypted */
-    bool valid_key; /* if true, a valid encryption key has been set */
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
 
diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7e532d0..5d5e737 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -125,7 +125,6 @@
 typedef enum ErrorClass {
     ERROR_CLASS_GENERIC_ERROR = QAPI_ERROR_CLASS_GENERICERROR,
     ERROR_CLASS_COMMAND_NOT_FOUND = QAPI_ERROR_CLASS_COMMANDNOTFOUND,
-    ERROR_CLASS_DEVICE_ENCRYPTED = QAPI_ERROR_CLASS_DEVICEENCRYPTED,
     ERROR_CLASS_DEVICE_NOT_ACTIVE = QAPI_ERROR_CLASS_DEVICENOTACTIVE,
     ERROR_CLASS_DEVICE_NOT_FOUND = QAPI_ERROR_CLASS_DEVICENOTFOUND,
     ERROR_CLASS_KVM_MISSING_CAP = QAPI_ERROR_CLASS_KVMMISSINGCAP,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d15c6a9..a29a5b4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -258,8 +258,7 @@
 #
 # @encrypted: true if the backing device is encrypted
 #
-# @encryption_key_missing: true if the backing device is encrypted but an
-#                          valid encryption key is missing
+# @encryption_key_missing: Deprecated; always false
 #
 # @detect_zeroes: detect and optimize zero writes (Since 2.1)
 #
diff --git a/qapi/common.json b/qapi/common.json
index b626647..8355d5a 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -14,9 +14,6 @@
 #
 # @CommandNotFound: the requested command has not been found
 #
-# @DeviceEncrypted: the requested operation can't be fulfilled because the
-#                   selected device is encrypted
-#
 # @DeviceNotActive: a device has failed to be become active
 #
 # @DeviceNotFound: the requested device has not been found
@@ -28,7 +25,7 @@
 ##
 { 'enum': 'QapiErrorClass',
   # Keep this in sync with ErrorClass in error.h
-  'data': [ 'GenericError', 'CommandNotFound', 'DeviceEncrypted',
+  'data': [ 'GenericError', 'CommandNotFound',
             'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
 
 ##
-- 
2.9.3
