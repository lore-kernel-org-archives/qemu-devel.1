Received: from eggs.gnu.org ([209.51.188.92]:33157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gnO62-00036p-S7
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 08:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptsneves@gmail.com>) id 1gnO61-0004xY-Vw
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 08:34:06 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ptsneves@gmail.com>) id 1gnO61-0004x0-P4
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 08:34:05 -0500
Received: by mail-lj1-x243.google.com with SMTP id l15-v6so10619914lja.9
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 05:34:04 -0800 (PST)
From: Paulo Neves <ptsneves@gmail.com>
Date: Sat, 26 Jan 2019 14:33:55 +0100
Message-Id: <1548509635-15776-1-git-send-email-ptsneves@gmail.com>
Subject: [Qemu-devel] [PATCH v3] chardev: Allow for pty path passing.
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

Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 chardev/char-pty.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 chardev/char.c     |  6 +++++-
 qapi/char.json     |  4 ++--
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index f681d63..5c312ce 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -28,12 +28,14 @@
 #include "io/channel-file.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
+#include "qemu/option.h"
 
 #include "chardev/char-io.h"
 
 typedef struct {
     Chardev parent;
     QIOChannel *ioc;
+    char *link_name;
     int read_bytes;
 
     /* Protected by the Chardev chr_write_lock.  */
@@ -234,6 +236,12 @@ static void char_pty_finalize(Object *obj)
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
+
+    if (s->link_name) {
+        unlink(s->link_name);
+        g_free(s->link_name);
+    }
+
     pty_chr_timer_cancel(s);
     qemu_mutex_unlock(&chr->chr_write_lock);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
@@ -244,8 +252,9 @@ static void char_pty_open(Chardev *chr,
                           bool *be_opened,
                           Error **errp)
 {
+    ChardevHostdev *opts = backend->u.pty.data;
     PtyChardev *s;
-    int master_fd, slave_fd;
+    int master_fd, slave_fd, symlink_ret;
     char pty_name[PATH_MAX];
     char *name;
 
@@ -256,6 +265,17 @@ static void char_pty_open(Chardev *chr,
     }
 
     close(slave_fd);
+
+    s = PTY_CHARDEV(chr);
+    s->link_name = g_strdup(opts->device);
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
@@ -271,6 +291,24 @@ static void char_pty_open(Chardev *chr,
     *be_opened = false;
 }
 
+static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
+                                Error **errp)
+{
+    const char *symlink_path = qemu_opt_get(opts, "path");
+    if (symlink_path == NULL) {
+        error_setg(errp, "chardev: pty symlink: no device path given");
+        return;
+
+    }
+
+    ChardevHostdev *dev;
+
+    backend->type = CHARDEV_BACKEND_KIND_PTY;
+    dev = backend->u.pipe.data = g_new0(ChardevHostdev, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
+    dev->device = g_strdup(symlink_path);
+}
+
 static void char_pty_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -279,6 +317,7 @@ static void char_pty_class_init(ObjectClass *oc, void *data)
     cc->chr_write = char_pty_chr_write;
     cc->chr_update_read_handler = pty_chr_update_read_handler;
     cc->chr_add_watch = pty_chr_add_watch;
+    cc->parse = char_pty_parse;
 }
 
 static const TypeInfo char_pty_type_info = {
diff --git a/chardev/char.c b/chardev/char.c
index ccba36b..43fce4a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -373,7 +373,6 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
     }
 
     if (strcmp(filename, "null")    == 0 ||
-        strcmp(filename, "pty")     == 0 ||
         strcmp(filename, "msmouse") == 0 ||
         strcmp(filename, "wctablet") == 0 ||
         strcmp(filename, "braille") == 0 ||
@@ -418,6 +417,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
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
         strstart(filename, "tn3270:", &p) ||
diff --git a/qapi/char.json b/qapi/char.json
index 77ed847..88c62bd 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -229,7 +229,7 @@
 ##
 # @ChardevHostdev:
 #
-# Configuration info for device and pipe chardevs.
+# Configuration info for device, pty and pipe chardevs.
 #
 # @device: The name of the special file for the device,
 #          i.e. /dev/ttyS0 on Unix or COM1: on Windows
@@ -395,7 +395,7 @@
             'pipe': 'ChardevHostdev',
             'socket': 'ChardevSocket',
             'udp': 'ChardevUdp',
-            'pty': 'ChardevCommon',
+            'pty': 'ChardevHostdev',
             'null': 'ChardevCommon',
             'mux': 'ChardevMux',
             'msmouse': 'ChardevCommon',
-- 
2.7.4
