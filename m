Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDsc-0000l5-1G
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDsZ-0003nd-Af
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:39:58 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 22:38:14 +0800
Message-Id: <20170119143816.21972-15-famz@redhat.com>
In-Reply-To: <20170119143816.21972-1-famz@redhat.com>
References: <20170119143816.21972-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 14/16] file-posix: Implement image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

This implements open flag sensible image locking for local file
and host device protocol.

virtlockd in libvirt locks the first byte, so we start looking at the
file bytes from 1.

Quoting what was proposed by Kevin Wolf <kwolf@redhat.com>, there are
four locking modes by combining two bits (BDRV_O_RDWR and
BDRV_O_SHARE_RW), and implemented by taking two locks:

Lock bytes:

* byte 1: I can't allow other processes to write to the image
* byte 2: I am writing to the image

Lock modes:

* shared writer (BDRV_O_RDWR | BDRV_O_SHARE_RW): Take shared lock on
  byte 2. Test whether byte 1 is locked using an exclusive lock, and
  fail if so.

* exclusive writer (BDRV_O_RDWR only): Take shared lock on byte 2. Test
  whether byte 1 is locked using an exclusive lock, and fail if so. Then
  take shared lock on byte 1. I suppose this is racy, but we can
  probably tolerate that.

* reader that can tolerate writers (BDRV_O_SHARE_RW only): Don't do anything

* reader that can't tolerate writers (neither bit is set): Take shared
  lock on byte 1. Test whether byte 2 is locked, and fail if so.

The complication is in the transactional reopen.  To make the reopen
logic managable, and allow better reuse, the code is internally
organized with a table from old mode to the new one.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 667 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 664 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 28b47d9..fabce04 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -131,8 +131,39 @@ do { \
 
 #define MAX_BLOCKSIZE	4096
 
+/* Posix file locking bytes. Libvirt takes byte 0, so start from byte 1. */
+#define RAW_LOCK_BYTE_MIN             1
+#define RAW_LOCK_BYTE_NO_OTHER_WRITER 1
+#define RAW_LOCK_BYTE_WRITE           2
+
+/*
+ ** reader that can tolerate writers: Don't do anything
+ *
+ ** reader that can't tolerate writers: Take shared lock on byte 1. Test
+ *  byte 2 is unlocked.
+ *
+ ** shared writer: Take shared lock on byte 2. Test byte 1 is unlocked.
+ *
+ ** exclusive writer: Take exclusive locks on both bytes.
+ */
+
+typedef enum {
+    /* Read only and accept other writers. */
+    RAW_L_READ_SHARE_RW,
+    /* Read only and try to forbid other writers. */
+    RAW_L_READ,
+    /* Read write and accept other writers. */
+    RAW_L_WRITE_SHARE_RW,
+    /* Read write and try to forbid other writers. */
+    RAW_L_WRITE,
+} BDRVRawLockMode;
+
 typedef struct BDRVRawState {
     int fd;
+    /* A dup of @fd to make manipulating lock easier, especially during reopen,
+     * where this will accept BDRVRawReopenState.lock_fd. */
+    int lock_fd;
+    bool disable_lock;
     int type;
     int open_flags;
     size_t buf_align;
@@ -146,11 +177,15 @@ typedef struct BDRVRawState {
     bool use_linux_aio:1;
     bool has_fallocate;
     bool needs_alignment;
+    BDRVRawLockMode cur_lock_mode;
 } BDRVRawState;
 
 typedef struct BDRVRawReopenState {
     int fd;
+    /* A dup of @fd used for acquiring lock. */
+    int lock_fd;
     int open_flags;
+    bool disable_lock;
 } BDRVRawReopenState;
 
 static int fd_open(BlockDriverState *bs);
@@ -368,6 +403,58 @@ static void raw_parse_flags(int bdrv_flags, int *open_flags)
     }
 }
 
+static int raw_lock_fd(int fd, BDRVRawLockMode mode, Error **errp)
+{
+    int ret;
+    assert(fd >= 0);
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
@@ -393,10 +480,88 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "host AIO implementation (threads, native)",
         },
+        {
+            .name = "disable-lock",
+            .type = QEMU_OPT_BOOL,
+            .help = "don't lock the file",
+        },
         { /* end of list */ }
     },
 };
 
+static BDRVRawLockMode raw_get_lock_mode(int flags)
+{
+    switch (flags & (BDRV_O_RDWR | BDRV_O_SHARE_RW)) {
+    case BDRV_O_RDWR:
+        return RAW_L_WRITE;
+    case BDRV_O_RDWR | BDRV_O_SHARE_RW:
+        return RAW_L_WRITE_SHARE_RW;
+    case BDRV_O_SHARE_RW:
+        return RAW_L_READ_SHARE_RW;
+    case 0:
+        return RAW_L_READ;
+    default:
+        abort();
+    }
+}
+
+static int raw_open_lockfd(const char *filename, int flags,
+                           BDRVRawLockMode *lock_mode, Error **errp)
+{
+    int ret = -1;
+    const char *normalized_filename = filename;
+
+    ret = raw_normalize_devicepath(&normalized_filename);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not normalize device path");
+    } else {
+        assert(!(flags & O_CREAT));
+        ret = qemu_open(normalized_filename, flags);
+        if (ret == -1) {
+            error_setg_errno(errp, errno, "Could not open file: %s",
+                             normalized_filename);
+            ret = -errno;
+        }
+    }
+    return ret;
+}
+
+static bool raw_lock_enabled(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+
+    return !(s->disable_lock || bdrv_get_flags(bs) & BDRV_O_INACTIVE);
+}
+
+static int raw_apply_image_lock(BlockDriverState *bs, int bdrv_flags,
+                                Error **errp)
+{
+    int ret;
+    BDRVRawState *s = bs->opaque;
+    BDRVRawLockMode lock_mode;
+
+    if (!raw_lock_enabled(bs)) {
+        return 0;
+    }
+    assert(s->cur_lock_mode == RAW_L_READ_SHARE_RW);
+    lock_mode = raw_get_lock_mode(bdrv_flags);
+    ret = raw_open_lockfd(bs->exact_filename, s->open_flags, &lock_mode,
+                          errp);
+    if (ret < 0) {
+        return ret;
+    }
+    s->lock_fd = ret;
+    if (lock_mode == RAW_L_READ_SHARE_RW) {
+        return 0;
+    }
+    ret = raw_lock_fd(s->lock_fd, lock_mode, errp);
+    if (ret) {
+        return ret;
+    }
+    s->cur_lock_mode = lock_mode;
+    return 0;
+}
+
 static int raw_open_common(BlockDriverState *bs, QDict *options,
                            int bdrv_flags, int open_flags, Error **errp)
 {
@@ -440,6 +605,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     raw_parse_flags(bdrv_flags, &s->open_flags);
 
     s->fd = -1;
+    s->lock_fd = -1;
     fd = qemu_open(filename, s->open_flags, 0644);
     if (fd < 0) {
         ret = -errno;
@@ -451,6 +617,13 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->fd = fd;
 
+    s->disable_lock = qemu_opt_get_bool(opts, "disable-lock", false);
+
+    ret = raw_apply_image_lock(bs, bdrv_flags, errp);
+    if (ret) {
+        goto fail;
+    }
+
 #ifdef CONFIG_LINUX_AIO
      /* Currently Linux does AIO only for files opened with O_DIRECT */
     if (s->use_linux_aio && !(s->open_flags & O_DIRECT)) {
@@ -538,6 +711,462 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     return raw_open_common(bs, options, flags, 0, errp);
 }
 
+typedef enum {
+    RAW_LT_PREPARE,
+    RAW_LT_COMMIT,
+    RAW_LT_ABORT
+} RawLockTransOp;
+
+typedef int (*RawReopenFunc)(RawLockTransOp op,
+                             int old_lock_fd, int new_lock_fd,
+                             BDRVRawLockMode old_lock,
+                             BDRVRawLockMode new_lock,
+                             Error **errp);
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
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to lock new fd (share byte)");
+            break;
+        }
+        break;
+    case RAW_LT_COMMIT:
+        break;
+    case RAW_LT_ABORT:
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
+    case RAW_LT_COMMIT:
+        break;
+    case RAW_LT_ABORT:
+        ret = qemu_lock_fd(old_lock_fd, RAW_LOCK_BYTE_NO_OTHER_WRITER, 1, true);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to restore old fd (share byte)");
+        }
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
+            error_report("Failed to unlock new fd (share byte)");
+            break;
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
+static const struct RawReopenFuncRecord {
+    BDRVRawLockMode old_lock;
+    BDRVRawLockMode new_lock;
+    RawReopenFunc func;
+    bool need_lock_fd;
+    bool close_old_lock_fd;
+} reopen_functions[] = {
+
+    {RAW_L_READ_SHARE_RW, RAW_L_READ_SHARE_RW, raw_lt_nop, false, false},
+    {RAW_L_READ_SHARE_RW, RAW_L_READ, raw_lt_from_unlock, true},
+    {RAW_L_READ_SHARE_RW, RAW_L_WRITE_SHARE_RW, raw_lt_from_unlock, true},
+    {RAW_L_READ_SHARE_RW, RAW_L_WRITE, raw_lt_from_unlock, true},
+
+    {RAW_L_READ, RAW_L_READ_SHARE_RW, raw_lt_nop, false, true},
+    {RAW_L_READ, RAW_L_READ, raw_lt_nop, false, false},
+    {RAW_L_READ, RAW_L_WRITE_SHARE_RW, raw_lt_read_to_write_share, true},
+    {RAW_L_READ, RAW_L_WRITE, raw_lt_read_to_write, true},
+
+    {RAW_L_WRITE_SHARE_RW, RAW_L_READ_SHARE_RW, raw_lt_nop, false, true},
+    {RAW_L_WRITE_SHARE_RW, RAW_L_READ, raw_lt_write_share_to_read, true},
+    {RAW_L_WRITE_SHARE_RW, RAW_L_WRITE_SHARE_RW, raw_lt_nop, false, false},
+    {RAW_L_WRITE_SHARE_RW, RAW_L_WRITE, raw_lt_write_share_to_write, true},
+
+    {RAW_L_WRITE, RAW_L_READ_SHARE_RW, raw_lt_nop, false, true},
+    {RAW_L_WRITE, RAW_L_READ, raw_lt_write_to_read, true},
+    {RAW_L_WRITE, RAW_L_WRITE_SHARE_RW, raw_lt_write_to_write_share, true},
+    {RAW_L_WRITE, RAW_L_WRITE, raw_lt_nop, false, false},
+};
+
+static int raw_reopen_handle_lock(BDRVReopenState *state,
+                                  RawLockTransOp op,
+                                  Error **errp)
+{
+    BDRVRawReopenState *rs = state->opaque;
+    BDRVRawState *s = state->bs->opaque;
+    BDRVRawLockMode old_lock, new_lock;
+    const struct RawReopenFuncRecord *rec;
+    int ret;
+
+    old_lock = s->cur_lock_mode;
+    rs->disable_lock = qdict_get_try_bool(state->options, "disable-lock",
+                                          false);
+    qdict_del(state->options, "disable-lock");
+
+    if (rs->disable_lock) {
+        new_lock = RAW_L_READ_SHARE_RW;
+    } else {
+        new_lock = raw_get_lock_mode(state->flags);
+    }
+
+    for (rec = &reopen_functions[0];
+         rec < &reopen_functions[ARRAY_SIZE(reopen_functions)];
+         rec++) {
+        if (rec->old_lock == old_lock && rec->new_lock == new_lock) {
+            break;
+        }
+    }
+    assert(rec != &reopen_functions[ARRAY_SIZE(reopen_functions)]);
+
+    switch (op) {
+    case RAW_LT_PREPARE:
+        if (rec->need_lock_fd) {
+            ret = raw_open_lockfd(state->bs->exact_filename,
+                                  rs->open_flags, &new_lock, errp);
+            if (ret < 0) {
+                return ret;
+            }
+            rs->lock_fd = ret;
+        } else {
+            rs->lock_fd = -1;
+        }
+        ret = rec->func(op, s->lock_fd, rs->lock_fd, old_lock, new_lock, errp);
+        if (!ret) {
+            return ret;
+        }
+        /* Only succeeded preparation will be reverted by block layer, we
+         * need to clean up this failure manually. */
+        op = RAW_LT_ABORT;
+        /* fall through */
+    case RAW_LT_ABORT:
+        rec->func(op, s->lock_fd, rs->lock_fd, old_lock, new_lock, &error_abort);
+        if (rs->lock_fd >= 0) {
+            qemu_close(rs->lock_fd);
+            rs->lock_fd = -1;
+        }
+        break;
+    case RAW_LT_COMMIT:
+        rec->func(op, s->lock_fd, rs->lock_fd, old_lock, new_lock, &error_abort);
+        if ((rec->need_lock_fd || rec->close_old_lock_fd) && s->lock_fd >= 0) {
+            qemu_close(s->lock_fd);
+            s->lock_fd = -1;
+        }
+        if (rec->need_lock_fd) {
+            s->lock_fd = rs->lock_fd;
+        }
+        s->cur_lock_mode = new_lock;
+        s->disable_lock = rs->disable_lock;
+        break;
+    }
+    return 0;
+}
+
 static int raw_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
@@ -609,13 +1238,20 @@ static int raw_reopen_prepare(BDRVReopenState *state,
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
+    ret = raw_reopen_handle_lock(state, RAW_LT_PREPARE, errp);
+    if (ret) {
+        goto fail;
+    }
 
+    return 0;
+fail:
+    qemu_close(rs->fd);
+    rs->fd = -1;
     return ret;
 }
 
@@ -626,6 +1262,8 @@ static void raw_reopen_commit(BDRVReopenState *state)
 
     s->open_flags = rs->open_flags;
 
+    raw_reopen_handle_lock(state, RAW_LT_COMMIT, &error_abort);
+
     qemu_close(s->fd);
     s->fd = rs->fd;
 
@@ -643,6 +1281,8 @@ static void raw_reopen_abort(BDRVReopenState *state)
         return;
     }
 
+    raw_reopen_handle_lock(state, RAW_LT_ABORT, &error_abort);
+
     if (rs->fd >= 0) {
         qemu_close(rs->fd);
         rs->fd = -1;
@@ -1332,6 +1972,10 @@ static void raw_close(BlockDriverState *bs)
         qemu_close(s->fd);
         s->fd = -1;
     }
+    if (s->lock_fd >= 0) {
+        qemu_close(s->lock_fd);
+        s->lock_fd = -1;
+    }
 }
 
 static int raw_truncate(BlockDriverState *bs, int64_t offset)
@@ -1832,6 +2476,22 @@ static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
+static int raw_inactivate(BlockDriverState *bs)
+{
+    BDRVRawState *s = bs->opaque;
+    int r = 0;
+
+    if (s->cur_lock_mode != RAW_L_READ_SHARE_RW) {
+        r = raw_lock_fd(s->lock_fd, RAW_L_READ_SHARE_RW, NULL);
+    }
+    return r;
+}
+
+static void raw_invalidate_cache(BlockDriverState *bs, Error **errp)
+{
+    raw_apply_image_lock(bs, bdrv_get_flags(bs), errp);
+}
+
 static QemuOptsList raw_create_opts = {
     .name = "raw-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(raw_create_opts.head),
@@ -1885,7 +2545,8 @@ BlockDriver bdrv_file = {
     .bdrv_get_info = raw_get_info,
     .bdrv_get_allocated_file_size
                         = raw_get_allocated_file_size,
-
+    .bdrv_inactivate = raw_inactivate,
+    .bdrv_invalidate_cache = raw_invalidate_cache,
     .create_opts = &raw_create_opts,
 };
 
-- 
2.9.3
