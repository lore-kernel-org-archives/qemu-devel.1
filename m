Received: from eggs.gnu.org ([208.118.235.92]:42417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gdBwF-0006Ek-SK
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gdBf4-0007zG-M5
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:16:07 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ptsneves@gmail.com>) id 1gdBf4-0007yp-EA
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 05:16:06 -0500
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so20459975lji.10
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 02:16:06 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
Date: Sat, 29 Dec 2018 11:15:51 +0100
Message-Id: <1546078551-6109-2-git-send-email-ptsneves@gmail.com>
In-Reply-To: <1546078551-6109-1-git-send-email-ptsneves@gmail.com>
References: <1546078551-6109-1-git-send-email-ptsneves@gmail.com>
Subject: [Qemu-devel] [PATCH] chardev: Allow for pty path passing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paulo Neves <ptsneves@gmail.com>

If a user requires a virtual serial device like provided
by the pty char device, the user needs to accept the
returned device name. This makes the program need to
have smarts to parse or communicate with qemu to get the
pty device.
With this patch the program can pass the path where
a symlink to the pty device will be, removing the
need for 2 way communication or smarts.
---
 chardev/char-pty.c | 38 ++++++++++++++++++++++++++++++++++++--
 chardev/char.c     |  6 +++++-
 qapi/char.json     |  4 ++--
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 761ae6d..b465263 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -38,6 +38,7 @@
 typedef struct {
     Chardev parent;
     QIOChannel *ioc;
+    char *link_name;
     int read_bytes;
 
     /* Protected by the Chardev chr_write_lock.  */
@@ -231,6 +232,11 @@ static void char_pty_finalize(Object *obj)
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
+
+    if (s->link_name) {
+        unlink(s->link_name);
+    }
+
     if (s->timer_tag) {
         g_source_remove(s->timer_tag);
         s->timer_tag = 0;
@@ -244,8 +250,9 @@ static void char_pty_open(Chardev *chr,
                           bool *be_opened,
                           Error **errp)
 {
+    ChardevHostdev *opts = backend->u.pty.data;
     PtyChardev *s;
-    int master_fd, slave_fd;
+    int master_fd, slave_fd, symlink_ret;
     char pty_name[PATH_MAX];
     char *name;
 
@@ -256,13 +263,23 @@ static void char_pty_open(Chardev *chr,
     }
 
     close(slave_fd);
+
+    s = PTY_CHARDEV(chr);
+    s->link_name = opts->device;
+    symlink_ret = symlink(pty_name, s->link_name);
+
+    if (symlink_ret < 0) {
+        close(master_fd);
+        error_setg_errno(errp, errno, "Failed to create symlink to PTY");
+        return;
+    }
+
     qemu_set_nonblock(master_fd);
 
     chr->filename = g_strdup_printf("pty:%s", pty_name);
     error_report("char device redirected to %s (label %s)",
                  pty_name, chr->label);
 
-    s = PTY_CHARDEV(chr);
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
@@ -271,6 +288,22 @@ static void char_pty_open(Chardev *chr,
     *be_opened = false;
 }
 
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
+                                Error **errp)
+{
+    const char *symlink_path = qemu_opt_get(opts, "path");
+    if(symlink_path == NULL) {
+        error_setg(errp, "chardev: pty symlink: no device path given");
+        return;
+
+    }
+    ChardevHostdev *dev;
+
+    backend->type = CHARDEV_BACKEND_KIND_PTY;
+    dev = backend->u.pipe.data = g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
+    dev->device = g_strdup(symlink_path);
+}
 static void char_pty_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -279,6 +312,7 @@ static void char_pty_class_init(ObjectClass *oc, void *data)
     cc->chr_write = char_pty_chr_write;
     cc->chr_update_read_handler = pty_chr_update_read_handler;
     cc->chr_add_watch = pty_chr_add_watch;
+    cc->parse = char_pty_parse;
 }
 
 static const TypeInfo char_pty_type_info = {
diff --git a/chardev/char.c b/chardev/char.c
index 5d52cd5..e4c5371 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -357,7 +357,6 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
     }
 
     if (strcmp(filename, "null")    == 0 ||
-        strcmp(filename, "pty")     == 0 ||
         strcmp(filename, "msmouse") == 0 ||
         strcmp(filename, "wctablet") == 0 ||
         strcmp(filename, "braille") == 0 ||
@@ -402,6 +401,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
         qemu_opt_set(opts, "path", p, &error_abort);
         return opts;
     }
+    if (strstart(filename, "pty:", &p)) {
+        qemu_opt_set(opts, "backend", "pty", &error_abort);
+        qemu_opt_set(opts, "path", p, &error_abort);
+        return opts;
+    }
     if (strstart(filename, "tcp:", &p) ||
         strstart(filename, "telnet:", &p) ||
         strstart(filename, "tn3270:", &p)) {
diff --git a/qapi/char.json b/qapi/char.json
index 6de0f29..dae4231 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -224,7 +224,7 @@
 ##
 # @ChardevHostdev:
 #
-# Configuration info for device and pipe chardevs.
+# Configuration info for device, pty and pipe chardevs.
 #
 # @device: The name of the special file for the device,
 #          i.e. /dev/ttyS0 on Unix or COM1: on Windows
@@ -380,7 +380,7 @@
                                        'pipe'   : 'ChardevHostdev',
                                        'socket' : 'ChardevSocket',
                                        'udp'    : 'ChardevUdp',
-                                       'pty'    : 'ChardevCommon',
+                                       'pty'    : 'ChardevHostdev',
                                        'null'   : 'ChardevCommon',
                                        'mux'    : 'ChardevMux',
                                        'msmouse': 'ChardevCommon',
-- 
2.7.4
