Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Ph9-0006dA-8w
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Ph6-0004C3-66
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:57:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:56:05 +0800
Message-Id: <20170421035606.448-20-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 19/20] file-posix: Add image locking in
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
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

virtlockd in libvirt locks the first byte, so we start looking at the
file bytes from 0x10.

The complication is in the transactional interface.  To make the reopen
logic managable, and allow better reuse, the code is internally
organized with a table from old mode to the new one.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 739 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 736 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2114720..c307493 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -129,8 +129,54 @@ do { \
 
 #define MAX_BLOCKSIZE	4096
 
+/* Posix file locking bytes. Libvirt takes byte 0, we start from byte 0x10,
+ * leaving a few more bytes for its future use. */
+#define RAW_LOCK_BYTE_MIN             0x10
+#define RAW_LOCK_BYTE_NO_OTHER_WRITER 0x10
+#define RAW_LOCK_BYTE_WRITE           0x11
+#ifdef F_OFD_SETLK
+#define RAW_LOCK_SUPPORTED 1
+#else
+#define RAW_LOCK_SUPPORTED 0
+#endif
+
+/*
+ ** reader that can tolerate writers: Don't do anything
+ *
+ ** reader that can't tolerate writers: Take shared lock on byte 0x10. Test
+ *  byte 0x11 is unlocked.
+ *
+ ** shared writer: Take shared lock on byte 0x11. Test byte 0x10 is unlocked.
+ *
+ ** exclusive writer: Take exclusive locks on both bytes.
+ */
+
+typedef enum {
+    /* Read only and accept other writers. */
+    RAW_L_READ_SHARE_RW,
+    /* Read only and try to forbid other writers. */
+    RAW_L_READ,
+    /* Read/write and accept other writers. */
+    RAW_L_WRITE_SHARE_RW,
+    /* Read/write and try to forbid other writers. */
+    RAW_L_WRITE,
+} BDRVRawLockMode;
+
+typedef struct BDRVRawLockUpdateState {
+    /* A dup of @fd used for acquiring lock. */
+    int image_fd;
+    int lock_fd;
+    int open_flags;
+    BDRVRawLockMode new_lock;
+    bool use_lock;
+} BDRVRawLockUpdateState;
+
 typedef struct BDRVRawState {
     int fd;
+    /* A dup of @fd to make manipulating lock easier, especially during reopen,
+     * where this will accept BDRVRawReopenState.lock_fd. */
+    int lock_fd;
+    bool use_lock;
     int type;
     int open_flags;
     size_t buf_align;
@@ -145,6 +191,11 @@ typedef struct BDRVRawState {
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
+    /* The current lock mode we are in. Note that in incoming migration this is
+     * the "desired" mode to be applied at bdrv_invalidate_cache. */
+    BDRVRawLockMode cur_lock_mode;
+    /* Used by raw_check_perm/raw_set_perm. */
+    BDRVRawLockUpdateState *lock_update;
 } BDRVRawState;
 
 typedef struct BDRVRawReopenState {
@@ -367,6 +418,59 @@ static void raw_parse_flags(int bdrv_flags, int *open_flags)
     }
 }
 
+static int raw_lock_fd(int fd, BDRVRawLockMode mode, Error **errp)
+{
+    int ret;
+    assert(fd >= 0);
+    assert(RAW_LOCK_SUPPORTED);
+    switch (mode) {
+    case RAW_L_READ_SHARE_RW:
+        ret = qemu_unlock_fd(fd, RAW_LOCK_BYTE_MIN, 2);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to unlock fd");
+            goto fail;
+        }
+        break;
+    case RAW_L_READ:
+        ret = qemu_lock_fd(fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock share byte");
+            goto fail;
+        }
+        ret = qemu_lock_fd_test(fd, RAW_LOCK_BYTE_WRITE, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Write byte lock is taken");
+            goto fail;
+        }
+        break;
+    case RAW_L_WRITE_SHARE_RW:
+        ret = qemu_lock_fd(fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock write byte");
+            goto fail;
+        }
+        ret = qemu_lock_fd_test(fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Share byte lock is taken");
+            goto fail;
+        }
+        break;
+    case RAW_L_WRITE:
+        ret = qemu_lock_fd(fd, RAW_LOCK_BYTE_MIN, 2, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock image");
+            goto fail;
+        }
+        break;
+    default:
+        abort();
+    }
+    return 0;
+fail:
+    qemu_unlock_fd(fd, RAW_LOCK_BYTE_MIN, 2);
+    return ret;
+}
+
 static void raw_parse_filename(const char *filename, QDict *options,
                                Error **errp)
 {
@@ -401,6 +505,23 @@ static QemuOptsList raw_runtime_opts = {
     },
 };
 
+static BDRVRawLockMode raw_get_lock_mode(bool write, bool shared)
+{
+    if (write) {
+        if (shared) {
+            return RAW_L_WRITE_SHARE_RW;
+        } else {
+            return RAW_L_WRITE;
+        }
+    } else {
+        if (shared) {
+            return RAW_L_READ_SHARE_RW;
+        } else {
+            return RAW_L_READ;
+        }
+    }
+}
+
 static int raw_open_common(BlockDriverState *bs, QDict *options,
                            int bdrv_flags, int open_flags, Error **errp)
 {
@@ -440,10 +561,13 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
 
+    s->use_lock = qemu_opt_get_bool(opts, "locking", true);
+
     s->open_flags = open_flags;
     raw_parse_flags(bdrv_flags, &s->open_flags);
 
     s->fd = -1;
+    s->lock_fd = -1;
     fd = qemu_open(filename, s->open_flags, 0644);
     if (fd < 0) {
         ret = -errno;
@@ -542,6 +666,509 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     return raw_open_common(bs, options, flags, 0, errp);
 }
 
+typedef enum {
+    RAW_LT_PREPARE,
+    RAW_LT_COMMIT,
+    RAW_LT_ABORT
+} RawLockTransOp;
+
+typedef int (*RawLockTransFunc)(RawLockTransOp op,
+                                int old_lock_fd, int new_lock_fd,
+                                BDRVRawLockMode old_lock,
+                                BDRVRawLockMode new_lock,
+                                Error **errp);
+
+static int raw_lt_nop(RawLockTransOp op,
+                      int old_lock_fd, int new_lock_fd,
+                      BDRVRawLockMode old_lock,
+                      BDRVRawLockMode new_lock,
+                      Error **errp)
+{
+    assert(old_lock == new_lock || new_lock == RAW_L_READ_SHARE_RW);
+    return 0;
+}
+
+static int raw_lt_from_unlock(RawLockTransOp op,
+                              int old_lock_fd, int new_lock_fd,
+                              BDRVRawLockMode old_lock,
+                              BDRVRawLockMode new_lock,
+                              Error **errp)
+{
+    assert(old_lock != new_lock);
+    assert(old_lock == RAW_L_READ_SHARE_RW);
+    switch (op) {
+    case RAW_LT_PREPARE:
+        return raw_lock_fd(new_lock_fd, new_lock, errp);
+    case RAW_LT_COMMIT:
+        break;
+    case RAW_LT_ABORT:
+        break;
+    }
+
+    return 0;
+}
+
+static int raw_lt_read_to_write_share(RawLockTransOp op,
+                                      int old_lock_fd, int new_lock_fd,
+                                      BDRVRawLockMode old_lock,
+                                      BDRVRawLockMode new_lock,
+                                      Error **errp)
+{
+    int ret = 0;
+
+    assert(old_lock == RAW_L_READ);
+    assert(new_lock == RAW_L_WRITE_SHARE_RW);
+
+    /*
+     *        lock byte "no other writer"      lock byte "write"
+     * old                S                           0
+     * new                0                           S
+     *
+     * (0 = unlocked; S = shared; X = exclusive.)
+     */
+    switch (op) {
+    case RAW_LT_PREPARE:
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (write byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (share byte)");
+            break;
+        }
+        ret = qemu_unlock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to unlock old fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to upgrade new fd (share byte)");
+            break;
+        }
+        ret = qemu_unlock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1);
+        if (ret) {
+            /* This is very unlikely, but catch it anyway. */
+            error_setg_errno(errp, -ret, "Failed to unlock new fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to downgrade new fd (write byte)");
+            break;
+        }
+        break;
+    case RAW_LT_COMMIT:
+        break;
+    case RAW_LT_ABORT:
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            /* As unlikely as above unlock failure, but report it anyway. */
+            error_report("Failed to restore lock on old fd (share byte)");
+        }
+        break;
+    }
+    return ret;
+}
+
+static int raw_lt_read_to_write(RawLockTransOp op,
+                                int old_lock_fd, int new_lock_fd,
+                                BDRVRawLockMode old_lock,
+                                BDRVRawLockMode new_lock,
+                                Error **errp)
+{
+    int ret = 0;
+
+    assert(old_lock == RAW_L_READ);
+    assert(new_lock == RAW_L_WRITE);
+    /*
+     *        lock byte "no other writer"      lock byte "write"
+     * old                S                           0
+     * new                X                           X
+     *
+     * (0 = unlocked; S = shared; X = exclusive.)
+     */
+    switch (op) {
+    case RAW_LT_PREPARE:
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (write byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (share byte)");
+            break;
+        }
+        ret = qemu_unlock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to unlock old fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to upgrade new fd (share byte)");
+            break;
+        }
+        break;
+    case RAW_LT_COMMIT:
+        break;
+    case RAW_LT_ABORT:
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to downgrade new fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_report("Failed to restore lock on old fd (share byte)");
+        }
+        break;
+    }
+    return ret;
+}
+
+static int raw_lt_write_share_to_read(RawLockTransOp op,
+                                      int old_lock_fd, int new_lock_fd,
+                                      BDRVRawLockMode old_lock,
+                                      BDRVRawLockMode new_lock,
+                                      Error **errp)
+{
+    int ret = 0;
+
+    assert(old_lock == RAW_L_WRITE_SHARE_RW);
+    assert(new_lock == RAW_L_READ);
+    /*
+     *        lock byte "no other writer"      lock byte "write"
+     * old                0                           S
+     * new                S                           0
+     *
+     * (0 = unlocked; S = shared; X = exclusive.)
+     */
+    switch (op) {
+    case RAW_LT_PREPARE:
+        /* Make sure there are no other writers. */
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock old fd (write byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (!ret) {
+            break;
+        }
+        error_setg_errno(errp, -ret, "Failed to lock new fd (share byte)");
+        /* fall through */
+    case RAW_LT_ABORT:
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_report("Failed to downgrade old fd (write byte)");
+        }
+        break;
+    case RAW_LT_COMMIT:
+        break;
+    }
+    return ret;
+}
+
+static int raw_lt_write_share_to_write(RawLockTransOp op,
+                                       int old_lock_fd, int new_lock_fd,
+                                       BDRVRawLockMode old_lock,
+                                       BDRVRawLockMode new_lock,
+                                       Error **errp)
+{
+    int ret = 0;
+
+    assert(old_lock == RAW_L_WRITE_SHARE_RW);
+    assert(new_lock == RAW_L_WRITE);
+    /*
+     *        lock byte "no other writer"      lock byte "write"
+     * old                0                           S
+     * new                X                           X
+     *
+     * (0 = unlocked; S = shared; X = exclusive.)
+     */
+    switch (op) {
+    case RAW_LT_PREPARE:
+        /* Make sure there are no other writers. */
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (write byte)");
+            break;
+        }
+        ret = qemu_unlock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to unlock old fd (write byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to upgrade new fd (write byte)");
+            break;
+        }
+        break;
+    case RAW_LT_COMMIT:
+        break;
+    case RAW_LT_ABORT:
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to downgrade new fd (write byte)");
+            break;
+        }
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to restore old fd (write byte)");
+            break;
+        }
+        break;
+    }
+    return ret;
+}
+
+static int raw_lt_write_to_read(RawLockTransOp op,
+                                int old_lock_fd, int new_lock_fd,
+                                BDRVRawLockMode old_lock,
+                                BDRVRawLockMode new_lock,
+                                Error **errp)
+{
+    int ret = 0;
+
+    assert(old_lock == RAW_L_WRITE);
+    assert(new_lock == RAW_L_READ);
+    /*
+     *        lock byte "no other writer"      lock byte "write"
+     * old                X                           X
+     * new                S                           0
+     *
+     * (0 = unlocked; S = shared; X = exclusive.)
+     */
+    switch (op) {
+    case RAW_LT_PREPARE:
+        break;
+    case RAW_LT_COMMIT:
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to downgrade old fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, false);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (share byte)");
+            break;
+        }
+        break;
+    case RAW_LT_ABORT:
+        break;
+    }
+    return ret;
+}
+
+static int raw_lt_write_to_write_share(RawLockTransOp op,
+                                       int old_lock_fd, int new_lock_fd,
+                                       BDRVRawLockMode old_lock,
+                                       BDRVRawLockMode new_lock,
+                                       Error **errp)
+{
+    int ret = 0;
+
+    assert(old_lock == RAW_L_WRITE);
+    assert(new_lock == RAW_L_WRITE_SHARE_RW);
+    /*
+     *        lock byte "no other writer"      lock byte "write"
+     * old                X                           X
+     * new                0                           S
+     *
+     * (0 = unlocked; S = shared; X = exclusive.)
+     */
+    switch (op) {
+    case RAW_LT_PREPARE:
+        break;
+    case RAW_LT_COMMIT:
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_report("Failed to downgrade old fd (share byte)");
+            break;
+        }
+        ret = qemu_lock_fd(new_lock_fd, RAW_LOCK_BYTE_WRITE, 1, false);
+        if (ret) {
+            error_report("Failed to lock new fd (write byte)");
+        }
+        break;
+    case RAW_LT_ABORT:
+        break;
+    }
+    return ret;
+}
+
+/**
+ * Transactionally moving between possible locking states is tricky and must be
+ * done carefully. That is mostly because downgrading an exclusive lock to
+ * shared or unlocked is not guaranteed to be revertible. As a result, in such
+ * cases we have to defer the downgrading to "commit", given that no revert will
+ * happen after that point, and that downgrading a lock should never fail.
+ *
+ * On the other hand, upgrading a lock (e.g. from unlocked or shared to
+ * exclusive lock) must happen in "prepare" because it may fail.
+ *
+ * Manage the operation matrix with this state transition table to make
+ * fulfilling above conditions easier.
+ */
+static const struct RawLockTransOp {
+    BDRVRawLockMode old_lock;
+    BDRVRawLockMode new_lock;
+    RawLockTransFunc func;
+    bool need_lock_fd;
+    bool close_old_lock_fd;
+} raw_lock_trans_ops[] = {
+
+    {RAW_L_READ_SHARE_RW,  RAW_L_READ_SHARE_RW,  raw_lt_nop,                  false, false},
+    {RAW_L_READ_SHARE_RW,  RAW_L_READ,           raw_lt_from_unlock,          true},
+    {RAW_L_READ_SHARE_RW,  RAW_L_WRITE_SHARE_RW, raw_lt_from_unlock,          true},
+    {RAW_L_READ_SHARE_RW,  RAW_L_WRITE,          raw_lt_from_unlock,          true},
+
+    {RAW_L_READ,           RAW_L_READ_SHARE_RW,  raw_lt_nop,                  false, true},
+    {RAW_L_READ,           RAW_L_READ,           raw_lt_nop,                  false, false},
+    {RAW_L_READ,           RAW_L_WRITE_SHARE_RW, raw_lt_read_to_write_share,  true},
+    {RAW_L_READ,           RAW_L_WRITE,          raw_lt_read_to_write,        true},
+
+    {RAW_L_WRITE_SHARE_RW, RAW_L_READ_SHARE_RW,  raw_lt_nop,                  false, true},
+    {RAW_L_WRITE_SHARE_RW, RAW_L_READ,           raw_lt_write_share_to_read,  true},
+    {RAW_L_WRITE_SHARE_RW, RAW_L_WRITE_SHARE_RW, raw_lt_nop,                  false, false},
+    {RAW_L_WRITE_SHARE_RW, RAW_L_WRITE,          raw_lt_write_share_to_write, true},
+
+    {RAW_L_WRITE,          RAW_L_READ_SHARE_RW,  raw_lt_nop,                  false, true},
+    {RAW_L_WRITE,          RAW_L_READ,           raw_lt_write_to_read,        true},
+    {RAW_L_WRITE,          RAW_L_WRITE_SHARE_RW, raw_lt_write_to_write_share, true},
+    {RAW_L_WRITE,          RAW_L_WRITE,          raw_lt_nop,                  false, false},
+};
+
+static int raw_handle_lock_update(BlockDriverState *bs,
+                                  RawLockTransOp op,
+                                  Error **errp)
+{
+    BDRVRawState *s = bs->opaque;
+    BDRVRawLockMode old_lock, new_lock;
+    const struct RawLockTransOp *rec;
+    int ret = 0;
+    Error *local_err = NULL;
+    BDRVRawLockUpdateState *lu = s->lock_update;
+    int lock_fd = -1;
+
+    if (!RAW_LOCK_SUPPORTED) {
+        goto cleanup;
+    }
+
+    if (bdrv_get_flags(bs) & BDRV_O_INACTIVE) {
+        /* leave the work to bdrv_invalidate_cache. */
+        return 0;
+    }
+
+    if (op == RAW_LT_PREPARE) {
+        lock_fd = qemu_open(bs->filename, lu->open_flags);
+        if (lock_fd == -1) {
+            if (errno == ENOENT) {
+                /* The file is gone, probably BDRV_O_SNAPSHOT? Skip locking. */
+                lu->use_lock = false;
+            } else {
+                /* other errors handled later. */
+            }
+        }
+    }
+
+    old_lock = s->cur_lock_mode;
+    new_lock = lu->use_lock ? lu->new_lock : RAW_L_READ_SHARE_RW;
+    for (rec = &raw_lock_trans_ops[0];
+         rec < &raw_lock_trans_ops[ARRAY_SIZE(raw_lock_trans_ops)];
+         rec++) {
+        if (rec->old_lock == old_lock && rec->new_lock == new_lock) {
+            break;
+        }
+    }
+    assert(rec != &raw_lock_trans_ops[ARRAY_SIZE(raw_lock_trans_ops)]);
+
+    assert(old_lock == RAW_L_READ_SHARE_RW || s->lock_fd >= 0);
+
+    DPRINTF("handle lock %p old lock %d new lock %d op %d func %p\n", bs,
+            old_lock, new_lock, op, rec->func);
+    switch (op) {
+    case RAW_LT_PREPARE:
+        if (rec->need_lock_fd) {
+            if (lock_fd >= 0) {
+                lu->lock_fd = lock_fd;
+            } else {
+                error_setg(errp, "Failed to initialize lock fd");
+            }
+        } else {
+            if (lock_fd >= 0) {
+                qemu_close(lock_fd);
+                lock_fd = -1;
+            }
+        }
+        ret = rec->func(op, s->lock_fd, lu->lock_fd, old_lock, new_lock, errp);
+        if (!ret) {
+            break;
+        }
+        /* Only succeeded preparation will be reverted by block layer, we
+         * need to clean up this failure manually. */
+        op = RAW_LT_ABORT;
+        /* fall through */
+    case RAW_LT_ABORT:
+        rec->func(op, s->lock_fd, lu->lock_fd, old_lock, new_lock, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+        if (lu->lock_fd >= 0) {
+            qemu_close(lu->lock_fd);
+            lu->lock_fd = -1;
+        }
+        goto cleanup;
+    case RAW_LT_COMMIT:
+        rec->func(op, s->lock_fd, lu->lock_fd, old_lock, new_lock, &error_abort);
+        if ((rec->need_lock_fd || rec->close_old_lock_fd) && s->lock_fd >= 0) {
+            raw_lock_fd(s->lock_fd, RAW_L_READ_SHARE_RW, NULL);
+            qemu_close(s->lock_fd);
+            s->lock_fd = -1;
+        }
+        if (rec->need_lock_fd) {
+            s->lock_fd = lu->lock_fd;
+        }
+        assert(s->lock_fd >= 0 || new_lock == RAW_L_READ_SHARE_RW);
+        s->cur_lock_mode = new_lock;
+        s->use_lock = lu->use_lock;
+        goto cleanup;
+    }
+    return ret;
+cleanup:
+    g_free(s->lock_update);
+    s->lock_update = NULL;
+    return ret;
+}
+
+static void raw_init_lock_update(BlockDriverState *bs,
+                                 int image_fd,
+                                 bool write, bool shared,
+                                 bool use_lock)
+{
+    BDRVRawState *s = bs->opaque;
+
+    assert(!s->lock_update);
+    s->lock_update = g_new0(BDRVRawLockUpdateState, 1);
+    *s->lock_update = (BDRVRawLockUpdateState) {
+        .image_fd = image_fd,
+        .new_lock = raw_get_lock_mode(write, shared),
+        .use_lock = use_lock,
+        .open_flags = (s->open_flags & ~(O_RDWR | O_RDONLY)) |
+                       (write ? O_RDWR : O_RDONLY),
+    };
+}
+
 static int raw_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
@@ -549,6 +1176,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     BDRVRawReopenState *rs;
     int ret = 0;
     Error *local_err = NULL;
+    bool shared;
 
     assert(state != NULL);
     assert(state->bs != NULL);
@@ -613,13 +1241,27 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     if (rs->fd != -1) {
         raw_probe_alignment(state->bs, rs->fd, &local_err);
         if (local_err) {
-            qemu_close(rs->fd);
-            rs->fd = -1;
             error_propagate(errp, local_err);
             ret = -EINVAL;
+            goto fail;
         }
     }
+    shared = s->cur_lock_mode == RAW_L_READ_SHARE_RW ||
+        s->cur_lock_mode == RAW_L_WRITE_SHARE_RW;
+    /* Shared perm doesn't change during reopen. */
+    raw_init_lock_update(state->bs, rs->fd, state->flags & BDRV_O_RDWR, shared,
+                         s->use_lock);
 
+    qdict_del(state->options, "locking");
+    ret = raw_handle_lock_update(state->bs, RAW_LT_PREPARE, errp);
+    if (ret) {
+        goto fail;
+    }
+
+    return 0;
+fail:
+    qemu_close(rs->fd);
+    rs->fd = -1;
     return ret;
 }
 
@@ -630,6 +1272,8 @@ static void raw_reopen_commit(BDRVReopenState *state)
 
     s->open_flags = rs->open_flags;
 
+    raw_handle_lock_update(state->bs, RAW_LT_COMMIT, &error_abort);
+
     qemu_close(s->fd);
     s->fd = rs->fd;
 
@@ -647,6 +1291,8 @@ static void raw_reopen_abort(BDRVReopenState *state)
         return;
     }
 
+    raw_handle_lock_update(state->bs, RAW_LT_ABORT, &error_abort);
+
     if (rs->fd >= 0) {
         qemu_close(rs->fd);
         rs->fd = -1;
@@ -1410,6 +2056,10 @@ static void raw_close(BlockDriverState *bs)
         qemu_close(s->fd);
         s->fd = -1;
     }
+    if (s->lock_fd >= 0) {
+        qemu_close(s->lock_fd);
+        s->lock_fd = -1;
+    }
 }
 
 static int raw_truncate(BlockDriverState *bs, int64_t offset)
@@ -1947,6 +2597,85 @@ static QemuOptsList raw_create_opts = {
     }
 };
 
+static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
+                          Error **errp)
+{
+    bool is_shared;
+    BDRVRawState *s = bs->opaque;
+
+    if (!RAW_LOCK_SUPPORTED) {
+        return 0;
+    }
+    if (s->lock_update) {
+        /* Override the previously stashed update. */
+        g_free(s->lock_update);
+        s->lock_update = NULL;
+    }
+    is_shared = shared & BLK_PERM_WRITE;
+    DPRINTF("raw check perm %p rw %d shared %d\n",
+            bs, perm & BLK_PERM_WRITE ? 1 : 0,
+            is_shared);
+    raw_init_lock_update(bs, s->fd,
+                         perm & BLK_PERM_WRITE, is_shared, s->use_lock);
+
+    return raw_handle_lock_update(bs, RAW_LT_PREPARE, errp);
+}
+
+static void raw_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
+{
+    BDRVRawState *s = bs->opaque;
+
+    if (!RAW_LOCK_SUPPORTED) {
+        return;
+    }
+    assert(s->lock_update);
+
+    raw_handle_lock_update(bs, RAW_LT_COMMIT, NULL);
+}
+
+static void raw_abort_perm_update(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+
+    if (!RAW_LOCK_SUPPORTED) {
+        return;
+    }
+    if (!s->lock_update) {
+        return;
+    }
+    raw_handle_lock_update(bs, RAW_LT_ABORT, NULL);
+}
+
+static int raw_inactivate(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+    int r = 0;
+
+    if (RAW_LOCK_SUPPORTED && s->cur_lock_mode != RAW_L_READ_SHARE_RW) {
+        r = raw_lock_fd(s->lock_fd, RAW_L_READ_SHARE_RW, NULL);
+    }
+    return r;
+}
+
+static void raw_invalidate_cache(BlockDriverState *bs, Error **errp)
+{
+    int r;
+    BDRVRawState *s = bs->opaque;
+
+    if (!RAW_LOCK_SUPPORTED) {
+        return;
+    }
+    if (s->lock_update) {
+        /* Apply the pending lock update from perm or reopen. */
+        r = raw_handle_lock_update(bs, RAW_LT_PREPARE, errp);
+        if (r) {
+            return;
+        }
+        raw_handle_lock_update(bs, RAW_LT_COMMIT, errp);
+        assert(!s->lock_update);
+    }
+}
+
 BlockDriver bdrv_file = {
     .format_name = "file",
     .protocol_name = "file",
@@ -1977,7 +2706,11 @@ BlockDriver bdrv_file = {
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
 
-- 
2.9.3
