Received: from eggs.gnu.org ([2001:4830:134:3::10]:33867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rL-0005UT-Au
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rJ-0004Hr-HT
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:35 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:34311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rJ-0004HR-Bu
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:33 -0500
Received: by mail-wj0-x243.google.com with SMTP id ip10so5995012wjb.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:44 +0100
Message-Id: <1485524749-118532-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/41] char: use error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Prefer error_report() over fprintf(stderr..)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-char.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index c82d6d2..113c4a8 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -451,8 +451,8 @@ int qemu_chr_fe_get_msgfd(CharBackend *be)
     int fd;
     int res = (qemu_chr_fe_get_msgfds(be, &fd, 1) == 1) ? fd : -1;
     if (s && qemu_chr_replay(s)) {
-        fprintf(stderr,
-                "Replay: get msgfd is not supported for serial devices yet\n");
+        error_report("Replay: get msgfd is not supported "
+                     "for serial devices yet");
         exit(1);
     }
     return res;
@@ -1680,8 +1680,8 @@ static Chardev *qemu_chr_open_pty(const CharDriver *driver,
     ret->pty = g_strdup(pty_name);
     ret->has_pty = true;
 
-    fprintf(stderr, "char device redirected to %s (label %s)\n",
-            pty_name, id);
+    error_report("char device redirected to %s (label %s)",
+                 pty_name, id);
 
     s = (PtyChardev *)chr;
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
@@ -3383,8 +3383,8 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
      * in TLS and telnet cases, only wait for an accepted socket */
     while (!s->ioc) {
         if (s->is_listen) {
-            fprintf(stderr, "QEMU waiting for connection on: %s\n",
-                    chr->filename);
+            error_report("QEMU waiting for connection on: %s",
+                         chr->filename);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
             tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
             qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, NULL);
@@ -4146,16 +4146,19 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
     }
 
     if (is_help_option(name)) {
-        fprintf(stderr, "Available chardev backend types:\n");
+        GString *str = g_string_new("");
         for (i = 0; i < ARRAY_SIZE(backends); i++) {
             cd = backends[i];
             if (cd) {
-                fprintf(stderr, "%s\n", ChardevBackendKind_lookup[cd->kind]);
+                g_string_append_printf(str, "\n%s", ChardevBackendKind_lookup[cd->kind]);
                 if (cd->alias) {
-                    fprintf(stderr, "%s\n", cd->alias);
+                    g_string_append_printf(str, "\n%s", cd->alias);
                 }
             }
         }
+
+        error_report("Available chardev backend types: %s", str->str);
+        g_string_free(str, true);
         exit(0);
     }
 
@@ -4267,8 +4270,8 @@ Chardev *qemu_chr_new(const char *label, const char *filename)
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
         }
         if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
-            fprintf(stderr,
-                    "Replay: ioctl is not supported for serial devices yet\n");
+            error_report("Replay: ioctl is not supported "
+                         "for serial devices yet");
         }
         replay_register_char_driver(chr);
     }
-- 
1.8.3.1
