Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5aoE-0004w8-Dz
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5aoB-0001AT-O3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:56 +0800
Message-Id: <20170502163558.7611-22-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 21/23] file-posix: Add image locking to
 perm operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

This extends the permission bits of op blocker API to external using
Linux OFD locks.

Each permission in @perm and @shared_perm is represented by a locked
byte in the image file.  Requesting a permission in @perm is translated
to a shared lock of the corresponding byte; rejecting to share the same
permission is translated to a shared lock of a separate byte. With that,
we use 2x number of bytes of distinct permission types.

virtlockd in libvirt locks the first byte, so we do locking from a
higher offset.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 276 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 275 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 261563d..f1f924b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -129,12 +129,23 @@ do { \
 
 #define MAX_BLOCKSIZE	4096
 
+/* Posix file locking bytes. Libvirt takes byte 0, we start from higher bytes,
+ * leaving a few more bytes for its future use. */
+#define RAW_LOCK_PERM_BASE             100
+#define RAW_LOCK_SHARED_BASE           200
+
 typedef struct BDRVRawState {
     int fd;
+    int lock_fd;
+    bool use_lock;
     int type;
     int open_flags;
     size_t buf_align;
 
+    /* The current permissions. */
+    uint64_t perm;
+    uint64_t shared_perm;
+
 #ifdef CONFIG_XFS
     bool is_xfs:1;
 #endif
@@ -411,6 +422,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     BlockdevAioOptions aio, aio_default;
     int fd, ret;
     struct stat st;
+    OnOffAuto locking;
 
     opts = qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -440,6 +452,37 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
 
+    locking = qapi_enum_parse(OnOffAuto_lookup, qemu_opt_get(opts, "locking"),
+                              ON_OFF_AUTO__MAX, ON_OFF_AUTO_AUTO, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+    switch (locking) {
+    case ON_OFF_AUTO_ON:
+        s->use_lock = true;
+#ifndef F_OFD_SETLK
+        fprintf(stderr,
+                "File lock requested but OFD locking syscall is unavailable, "
+                "falling back to POSIX file locks.\n"
+                "Due to the implementation, locks can be lost unexpectedly.\n");
+#endif
+        break;
+    case ON_OFF_AUTO_OFF:
+        s->use_lock = false;
+        break;
+    case ON_OFF_AUTO_AUTO:
+#ifdef F_OFD_SETLK
+        s->use_lock = true;
+#else
+        s->use_lock = false;
+#endif
+        break;
+    default:
+        abort();
+    }
+
     s->open_flags = open_flags;
     raw_parse_flags(bdrv_flags, &s->open_flags);
 
@@ -455,6 +498,21 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->fd = fd;
 
+    s->lock_fd = -1;
+    if (s->use_lock) {
+        fd = qemu_open(filename, s->open_flags);
+        if (fd < 0) {
+            ret = -errno;
+            error_setg_errno(errp, errno, "Could not open '%s' for locking",
+                             filename);
+            qemu_close(s->fd);
+            goto fail;
+        }
+        s->lock_fd = fd;
+    }
+    s->perm = 0;
+    s->shared_perm = BLK_PERM_ALL;
+
 #ifdef CONFIG_LINUX_AIO
      /* Currently Linux does AIO only for files opened with O_DIRECT */
     if (s->use_linux_aio && !(s->open_flags & O_DIRECT)) {
@@ -542,6 +600,161 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     return raw_open_common(bs, options, flags, 0, errp);
 }
 
+typedef enum {
+    RAW_PL_PREPARE,
+    RAW_PL_COMMIT,
+    RAW_PL_ABORT,
+} RawPermLockOp;
+
+#define PERM_FOREACH(i) \
+    for ((i) = 0; (1ULL << (i)) <= BLK_PERM_ALL; i++)
+
+/* Lock bytes indicated by @perm_lock_bits and @shared_perm_lock_bits in the
+ * file; if @unlock == true, also unlock the unneeded bytes.
+ * @shared_perm_lock_bits is the mask of all permissions that are NOT shared.
+ */
+static int raw_apply_lock_bytes(BDRVRawState *s,
+                                uint64_t perm_lock_bits,
+                                uint64_t shared_perm_lock_bits,
+                                bool unlock, Error **errp)
+{
+    int ret;
+    int i;
+
+    PERM_FOREACH(i) {
+        int off = RAW_LOCK_PERM_BASE + i;
+        if (perm_lock_bits & (1ULL << i)) {
+            ret = qemu_lock_fd(s->lock_fd, off, 1, false);
+            if (ret) {
+                error_setg(errp, "Failed to lock byte %d", off);
+                return ret;
+            }
+        } else if (unlock) {
+            ret = qemu_unlock_fd(s->lock_fd, off, 1);
+            if (ret) {
+                error_setg(errp, "Failed to unlock byte %d", off);
+                return ret;
+            }
+        }
+    }
+    PERM_FOREACH(i) {
+        int off = RAW_LOCK_SHARED_BASE + i;
+        if (shared_perm_lock_bits & (1ULL << i)) {
+            ret = qemu_lock_fd(s->lock_fd, off, 1, false);
+            if (ret) {
+                error_setg(errp, "Failed to lock byte %d", off);
+                return ret;
+            }
+        } else if (unlock) {
+            ret = qemu_unlock_fd(s->lock_fd, off, 1);
+            if (ret) {
+                error_setg(errp, "Failed to unlock byte %d", off);
+                return ret;
+            }
+        }
+    }
+    return 0;
+}
+
+/* Check "unshared" bytes implied by @perm and ~@shared_perm in the file. */
+static int raw_check_lock_bytes(BDRVRawState *s,
+                                uint64_t perm, uint64_t shared_perm,
+                                Error **errp)
+{
+    int ret;
+    int i;
+
+    PERM_FOREACH(i) {
+        int off = RAW_LOCK_SHARED_BASE + i;
+        uint64_t p = 1ULL << i;
+        if (perm & p) {
+            ret = qemu_lock_fd_test(s->lock_fd, off, 1, true);
+            if (ret) {
+                char *perm_name = bdrv_perm_names(p);
+                error_setg(errp,
+                           "Failed to get \"%s\" lock",
+                           perm_name);
+                g_free(perm_name);
+                error_append_hint(errp,
+                                  "Is another process using the image?\n");
+                return ret;
+            }
+        }
+    }
+    PERM_FOREACH(i) {
+        int off = RAW_LOCK_PERM_BASE + i;
+        uint64_t p = 1ULL << i;
+        if (!(shared_perm & p)) {
+            ret = qemu_lock_fd_test(s->lock_fd, off, 1, true);
+            if (ret) {
+                char *perm_name = bdrv_perm_names(p);
+                error_setg(errp,
+                           "Failed to get shared \"%s\" lock",
+                           perm_name);
+                g_free(perm_name);
+                error_append_hint(errp,
+                                  "Is another process using the image?\n");
+                return ret;
+            }
+        }
+    }
+    return 0;
+}
+
+static int raw_handle_perm_lock(BlockDriverState *bs,
+                                RawPermLockOp op,
+                                uint64_t new_perm, uint64_t new_shared,
+                                Error **errp)
+{
+    BDRVRawState *s = bs->opaque;
+    int ret = 0;
+    Error *local_err = NULL;
+
+    if (!s->use_lock) {
+        return 0;
+    }
+
+    if (bdrv_get_flags(bs) & BDRV_O_INACTIVE) {
+        return 0;
+    }
+
+    assert(s->lock_fd > 0);
+
+    switch (op) {
+    case RAW_PL_PREPARE:
+        ret = raw_apply_lock_bytes(s, s->perm | new_perm,
+                                   ~s->shared_perm | ~new_shared,
+                                   false, errp);
+        if (!ret) {
+            ret = raw_check_lock_bytes(s, new_perm, new_shared, errp);
+            if (!ret) {
+                return 0;
+            }
+        }
+        op = RAW_PL_ABORT;
+        /* fall through to unlock bytes. */
+    case RAW_PL_ABORT:
+        raw_apply_lock_bytes(s, s->perm, ~s->shared_perm, true, &local_err);
+        if (local_err) {
+            /* Theoretically the above call only unlocks bytes and it cannot
+             * fail. Something weird happened, report it.
+             */
+            error_report_err(local_err);
+        }
+        break;
+    case RAW_PL_COMMIT:
+        raw_apply_lock_bytes(s, new_perm, ~new_shared, true, &local_err);
+        if (local_err) {
+            /* Theoretically the above call only unlocks bytes and it cannot
+             * fail. Something weird happened, report it.
+             */
+            error_report_err(local_err);
+        }
+        break;
+    }
+    return ret;
+}
+
 static int raw_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
@@ -1410,6 +1623,10 @@ static void raw_close(BlockDriverState *bs)
         qemu_close(s->fd);
         s->fd = -1;
     }
+    if (s->lock_fd >= 0) {
+        qemu_close(s->lock_fd);
+        s->lock_fd = -1;
+    }
 }
 
 static int raw_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
@@ -1954,6 +2171,54 @@ static QemuOptsList raw_create_opts = {
     }
 };
 
+static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
+                          Error **errp)
+{
+    return raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, errp);
+}
+
+static void raw_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
+{
+    BDRVRawState *s = bs->opaque;
+    raw_handle_perm_lock(bs, RAW_PL_COMMIT, perm, shared, NULL);
+    s->perm = perm;
+    s->shared_perm = shared;
+}
+
+static void raw_abort_perm_update(BlockDriverState *bs)
+{
+    raw_handle_perm_lock(bs, RAW_PL_ABORT, 0, 0, NULL);
+}
+
+static int raw_inactivate(BlockDriverState *bs)
+{
+    int ret;
+    uint64_t perm = 0;
+    uint64_t shared = BLK_PERM_ALL;
+
+    ret = raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, NULL);
+    if (ret) {
+        return ret;
+    }
+    raw_handle_perm_lock(bs, RAW_PL_COMMIT, perm, shared, NULL);
+    return 0;
+}
+
+
+static void raw_invalidate_cache(BlockDriverState *bs, Error **errp)
+{
+    BDRVRawState *s = bs->opaque;
+    int ret;
+
+    assert(!(bdrv_get_flags(bs) & BDRV_O_INACTIVE));
+    ret = raw_handle_perm_lock(bs, RAW_PL_PREPARE, s->perm, s->shared_perm,
+                               errp);
+    if (ret) {
+        return;
+    }
+    raw_handle_perm_lock(bs, RAW_PL_COMMIT, s->perm, s->shared_perm, NULL);
+}
+
 BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
@@ -1984,7 +2249,11 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
-
+    .bdrv_inactivate = raw_inactivate,
+    .bdrv_invalidate_cache = raw_invalidate_cache,
+    .bdrv_check_perm = raw_check_perm,
+    .bdrv_set_perm   = raw_set_perm,
+    .bdrv_abort_perm_update = raw_abort_perm_update,
     .create_opts = &raw_create_opts,
 };
 
@@ -2443,6 +2712,11 @@ static BlockDriver bdrv_host_device = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
+    .bdrv_inactivate = raw_inactivate,
+    .bdrv_invalidate_cache = raw_invalidate_cache,
+    .bdrv_check_perm = raw_check_perm,
+    .bdrv_set_perm   = raw_set_perm,
+    .bdrv_abort_perm_update = raw_abort_perm_update,
     .bdrv_probe_blocksizes = hdev_probe_blocksizes,
     .bdrv_probe_geometry = hdev_probe_geometry,
 
-- 
2.9.3
