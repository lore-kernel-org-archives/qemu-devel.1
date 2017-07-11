Received: from eggs.gnu.org ([2001:4830:134:3::10]:44703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxjE-0007GV-0S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxjC-0005fu-3F
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:05 +0200
Message-Id: <20170711160814.20941-17-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 16/85] block: rip out all traces of password
 prompting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Now that qcow & qcow2 are wired up to get encryption keys
via the QCryptoSecret object, nothing is relying on the
interactive prompting for passwords. All the code related
to password prompting can thus be ripped out.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-17-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi-schema.json          | 10 +------
 include/monitor/monitor.h |  7 -----
 include/qemu/osdep.h      |  2 --
 hmp.c                     | 31 ---------------------
 monitor.c                 | 68 -----------------------------------------------
 qemu-img.c                | 31 ---------------------
 qemu-io.c                 | 20 --------------
 qmp.c                     | 12 +--------
 util/oslib-posix.c        | 66 ---------------------------------------------
 util/oslib-win32.c        | 24 -----------------
 10 files changed, 2 insertions(+), 269 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 37c4b95..485767f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2431,8 +2431,6 @@
 # Since:  0.14.0
 #
 # Returns:  If successful, nothing
-#           If QEMU was started with an encrypted block device and a key has
-#              not yet been set, DeviceEncrypted.
 #
 # Notes:  This command will succeed if the guest is currently running.  It
 #         will also succeed if the guest is in the "inmigrate" state; in
@@ -2713,8 +2711,7 @@
 #        * This command is stateless, this means that commands that depend
 #          on state information (such as getfd) might not work
 #
-#        * Commands that prompt the user for data (eg. 'cont' when the block
-#          device is encrypted) don't currently work
+#        * Commands that prompt the user for data don't currently work
 #
 # Example:
 #
@@ -3019,11 +3016,6 @@
 #
 # Returns: Nothing on success.
 #          If @device is not a valid block device, DeviceNotFound
-#          If the new block device is encrypted, DeviceEncrypted.  Note that
-#          if this error is returned, the device has been opened successfully
-#          and an additional call to @block_passwd is required to set the
-#          device's password.  The behavior of reads and writes to the block
-#          device between when these calls are executed is undefined.
 #
 # Notes:  This interface is deprecated, and it is strongly recommended that you
 #         avoid using it.  For changing block devices, use
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d2b3aaf..83ea4a1 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -23,13 +23,6 @@ void monitor_cleanup(void);
 int monitor_suspend(Monitor *mon);
 void monitor_resume(Monitor *mon);
 
-int monitor_read_bdrv_key_start(Monitor *mon, BlockDriverState *bs,
-                                BlockCompletionFunc *completion_cb,
-                                void *opaque);
-int monitor_read_block_device_key(Monitor *mon, const char *device,
-                                  BlockCompletionFunc *completion_cb,
-                                  void *opaque);
-
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 8559634..3b74f6f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -457,8 +457,6 @@ void qemu_set_tty_echo(int fd, bool echo);
 void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
                      Error **errp);
 
-int qemu_read_password(char *buf, int buf_size);
-
 /**
  * qemu_get_pid_name:
  * @pid: pid of a process
diff --git a/hmp.c b/hmp.c
index dee4028..6d32c40 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1088,37 +1088,12 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qdict)
     g_free(data);
 }
 
-static void hmp_cont_cb(void *opaque, int err)
-{
-    if (!err) {
-        qmp_cont(NULL);
-    }
-}
-
-static bool key_is_missing(const BlockInfo *bdev)
-{
-    return (bdev->inserted && bdev->inserted->encryption_key_missing);
-}
-
 void hmp_cont(Monitor *mon, const QDict *qdict)
 {
-    BlockInfoList *bdev_list, *bdev;
     Error *err = NULL;
 
-    bdev_list = qmp_query_block(NULL);
-    for (bdev = bdev_list; bdev; bdev = bdev->next) {
-        if (key_is_missing(bdev->value)) {
-            monitor_read_block_device_key(mon, bdev->value->device,
-                                          hmp_cont_cb, NULL);
-            goto out;
-        }
-    }
-
     qmp_cont(&err);
     hmp_handle_error(mon, &err);
-
-out:
-    qapi_free_BlockInfoList(bdev_list);
 }
 
 void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
@@ -1741,12 +1716,6 @@ void hmp_change(Monitor *mon, const QDict *qdict)
         qmp_blockdev_change_medium(true, device, false, NULL, target,
                                    !!arg, arg, !!read_only, read_only_mode,
                                    &err);
-        if (err &&
-            error_get_class(err) == ERROR_CLASS_DEVICE_ENCRYPTED) {
-            error_free(err);
-            monitor_read_block_device_key(mon, device, NULL, NULL);
-            return;
-        }
     }
 
     hmp_handle_error(mon, &err);
diff --git a/monitor.c b/monitor.c
index d8ac20f..fa3e3ac 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4136,74 +4136,6 @@ void monitor_cleanup(void)
     qemu_mutex_unlock(&monitor_lock);
 }
 
-static void bdrv_password_cb(void *opaque, const char *password,
-                             void *readline_opaque)
-{
-    Monitor *mon = opaque;
-    BlockDriverState *bs = readline_opaque;
-    int ret = 0;
-    Error *local_err = NULL;
-
-    bdrv_add_key(bs, password, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        ret = -EPERM;
-    }
-    if (mon->password_completion_cb)
-        mon->password_completion_cb(mon->password_opaque, ret);
-
-    monitor_read_command(mon, 1);
-}
-
-int monitor_read_bdrv_key_start(Monitor *mon, BlockDriverState *bs,
-                                BlockCompletionFunc *completion_cb,
-                                void *opaque)
-{
-    int err;
-
-    monitor_printf(mon, "%s (%s) is encrypted.\n", bdrv_get_device_name(bs),
-                   bdrv_get_encrypted_filename(bs));
-
-    mon->password_completion_cb = completion_cb;
-    mon->password_opaque = opaque;
-
-    err = monitor_read_password(mon, bdrv_password_cb, bs);
-
-    if (err && completion_cb)
-        completion_cb(opaque, err);
-
-    return err;
-}
-
-int monitor_read_block_device_key(Monitor *mon, const char *device,
-                                  BlockCompletionFunc *completion_cb,
-                                  void *opaque)
-{
-    Error *err = NULL;
-    BlockBackend *blk;
-
-    blk = blk_by_name(device);
-    if (!blk) {
-        monitor_printf(mon, "Device not found %s\n", device);
-        return -1;
-    }
-    if (!blk_bs(blk)) {
-        monitor_printf(mon, "Device '%s' has no medium\n", device);
-        return -1;
-    }
-
-    bdrv_add_key(blk_bs(blk), NULL, &err);
-    if (err) {
-        error_free(err);
-        return monitor_read_bdrv_key_start(mon, blk_bs(blk), completion_cb, opaque);
-    }
-
-    if (completion_cb) {
-        completion_cb(opaque, 0);
-    }
-    return 0;
-}
-
 QemuOptsList qemu_mon_opts = {
     .name = "mon",
     .implied_opt_name = "chardev",
diff --git a/qemu-img.c b/qemu-img.c
index ae4fe6d..7f1de74 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -260,29 +260,6 @@ static int print_block_option_help(const char *filename, const char *fmt)
 }
 
 
-static int img_open_password(BlockBackend *blk, const char *filename,
-                             int flags, bool quiet)
-{
-    BlockDriverState *bs;
-    char password[256];
-
-    bs = blk_bs(blk);
-    if (bdrv_is_encrypted(bs) && bdrv_key_required(bs) &&
-        !(flags & BDRV_O_NO_IO)) {
-        qprintf(quiet, "Disk image '%s' is encrypted.\n", filename);
-        if (qemu_read_password(password, sizeof(password)) < 0) {
-            error_report("No password given");
-            return -1;
-        }
-        if (bdrv_set_key(bs, password) < 0) {
-            error_report("invalid password");
-            return -1;
-        }
-    }
-    return 0;
-}
-
-
 static BlockBackend *img_open_opts(const char *optstr,
                                    QemuOpts *opts, int flags, bool writethrough,
                                    bool quiet, bool force_share)
@@ -307,10 +284,6 @@ static BlockBackend *img_open_opts(const char *optstr,
     }
     blk_set_enable_write_cache(blk, !writethrough);
 
-    if (img_open_password(blk, optstr, flags, quiet) < 0) {
-        blk_unref(blk);
-        return NULL;
-    }
     return blk;
 }
 
@@ -340,10 +313,6 @@ static BlockBackend *img_open_file(const char *filename,
     }
     blk_set_enable_write_cache(blk, !writethrough);
 
-    if (img_open_password(blk, filename, flags, quiet) < 0) {
-        blk_unref(blk);
-        return NULL;
-    }
     return blk;
 }
 
diff --git a/qemu-io.c b/qemu-io.c
index 8074656..4cfa41c 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -58,7 +58,6 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
                     QDict *opts)
 {
     Error *local_err = NULL;
-    BlockDriverState *bs;
 
     if (qemuio_blk) {
         error_report("file open already, try 'help close'");
@@ -85,28 +84,9 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
         return 1;
     }
 
-    bs = blk_bs(qemuio_blk);
-    if (bdrv_is_encrypted(bs) && bdrv_key_required(bs)) {
-        char password[256];
-        printf("Disk image '%s' is encrypted.\n", name);
-        if (qemu_read_password(password, sizeof(password)) < 0) {
-            error_report("No password given");
-            goto error;
-        }
-        if (bdrv_set_key(bs, password) < 0) {
-            error_report("invalid password");
-            goto error;
-        }
-    }
-
     blk_set_enable_write_cache(qemuio_blk, !writethrough);
 
     return 0;
-
- error:
-    blk_unref(qemuio_blk);
-    qemuio_blk = NULL;
-    return 1;
 }
 
 static void open_help(void)
diff --git a/qmp.c b/qmp.c
index 7ee9bcf..84a4f29 100644
--- a/qmp.c
+++ b/qmp.c
@@ -164,10 +164,8 @@ SpiceInfo *qmp_query_spice(Error **errp)
 
 void qmp_cont(Error **errp)
 {
-    Error *local_err = NULL;
     BlockBackend *blk;
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    Error *local_err = NULL;
 
     /* if there is a dump in background, we should wait until the dump
      * finished */
@@ -187,14 +185,6 @@ void qmp_cont(Error **errp)
         blk_iostatus_reset(blk);
     }
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        bdrv_add_key(bs, NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-
     /* Continuing after completed migration. Images have been inactivated to
      * allow the destination to take control. Need to get control back now.
      *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5e8b4b3..b2dea48 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -414,72 +414,6 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
 }
 
 
-static struct termios oldtty;
-
-static void term_exit(void)
-{
-    tcsetattr(0, TCSANOW, &oldtty);
-}
-
-static void term_init(void)
-{
-    struct termios tty;
-
-    tcgetattr(0, &tty);
-    oldtty = tty;
-
-    tty.c_iflag &= ~(IGNBRK|BRKINT|PARMRK|ISTRIP
-                          |INLCR|IGNCR|ICRNL|IXON);
-    tty.c_oflag |= OPOST;
-    tty.c_lflag &= ~(ECHO|ECHONL|ICANON|IEXTEN);
-    tty.c_cflag &= ~(CSIZE|PARENB);
-    tty.c_cflag |= CS8;
-    tty.c_cc[VMIN] = 1;
-    tty.c_cc[VTIME] = 0;
-
-    tcsetattr(0, TCSANOW, &tty);
-
-    atexit(term_exit);
-}
-
-int qemu_read_password(char *buf, int buf_size)
-{
-    uint8_t ch;
-    int i, ret;
-
-    printf("password: ");
-    fflush(stdout);
-    term_init();
-    i = 0;
-    for (;;) {
-        ret = read(0, &ch, 1);
-        if (ret == -1) {
-            if (errno == EAGAIN || errno == EINTR) {
-                continue;
-            } else {
-                break;
-            }
-        } else if (ret == 0) {
-            ret = -1;
-            break;
-        } else {
-            if (ch == '\r' ||
-                ch == '\n') {
-                ret = 0;
-                break;
-            }
-            if (i < (buf_size - 1)) {
-                buf[i++] = ch;
-            }
-        }
-    }
-    term_exit();
-    buf[i] = '\0';
-    printf("\n");
-    return ret;
-}
-
-
 char *qemu_get_pid_name(pid_t pid)
 {
     char *name = NULL;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 3de9e77..69a6286 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -552,30 +552,6 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
 }
 
 
-/* XXX: put correct support for win32 */
-int qemu_read_password(char *buf, int buf_size)
-{
-    int c, i;
-
-    printf("Password: ");
-    fflush(stdout);
-    i = 0;
-    for (;;) {
-        c = getchar();
-        if (c < 0) {
-            buf[i] = '\0';
-            return -1;
-        } else if (c == '\n') {
-            break;
-        } else if (i < (buf_size - 1)) {
-            buf[i++] = c;
-        }
-    }
-    buf[i] = '\0';
-    return 0;
-}
-
-
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
-- 
2.9.4
