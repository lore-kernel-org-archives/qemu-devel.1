Received: from eggs.gnu.org ([2001:4830:134:3::10]:33710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r9-0005G1-1A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r7-0004Bb-O9
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:23 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r7-0004BA-F3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:21 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so58372242wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:36 +0100
Message-Id: <1485524749-118532-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/41] char: fold single-user functions in caller
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

This shortens the code a bit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-char.c | 95 +++++++++++++++++++------------------------------------------
 1 file changed, 29 insertions(+), 66 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index ce8d4bb..4719ad6 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1891,22 +1891,6 @@ static void qemu_chr_free_tty(CharDriverState *chr)
 {
     fd_chr_free(chr);
 }
-
-static CharDriverState *qemu_chr_open_tty_fd(const CharDriver *driver,
-                                             int fd,
-                                             ChardevCommon *backend,
-                                             bool *be_opened,
-                                             Error **errp)
-{
-    CharDriverState *chr;
-
-    tty_serial_init(fd, 115200, 'N', 8, 1);
-    chr = qemu_chr_open_fd(driver, fd, fd, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    return chr;
-}
 #endif /* __linux__ || __sun__ */
 
 #if defined(__linux__)
@@ -2327,29 +2311,6 @@ static int win_chr_poll(void *opaque)
     return 0;
 }
 
-static CharDriverState *qemu_chr_open_win_path(const CharDriver *driver,
-                                               const char *filename,
-                                               ChardevCommon *backend,
-                                               Error **errp)
-{
-    CharDriverState *chr;
-    WinCharState *s;
-
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s = g_new0(WinCharState, 1);
-    chr->opaque = s;
-
-    if (win_chr_init(chr, filename, errp) < 0) {
-        g_free(s);
-        qemu_chr_free_common(chr);
-        return NULL;
-    }
-    return chr;
-}
-
 static int win_chr_pipe_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
@@ -2806,30 +2767,6 @@ static void udp_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static CharDriverState *qemu_chr_open_udp(const CharDriver *driver,
-                                          QIOChannelSocket *sioc,
-                                          ChardevCommon *backend,
-                                          bool *be_opened,
-                                          Error **errp)
-{
-    CharDriverState *chr = NULL;
-    NetCharDriver *s = NULL;
-
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s = g_new0(NetCharDriver, 1);
-
-    s->ioc = QIO_CHANNEL(sioc);
-    s->bufcnt = 0;
-    s->bufptr = 0;
-    chr->opaque = s;
-    /* be isn't opened until we get a connection */
-    *be_opened = false;
-    return chr;
-}
-
 /***********************************************************/
 /* TCP Net console */
 
@@ -4614,8 +4551,23 @@ static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
 {
     ChardevHostdev *serial = backend->u.serial.data;
     ChardevCommon *common = qapi_ChardevHostdev_base(serial);
+    CharDriverState *chr;
+    WinCharState *s;
+
+    chr = qemu_chr_alloc(driver, common, errp);
+    if (!chr) {
+        return NULL;
+    }
 
-    return qemu_chr_open_win_path(driver, serial->device, common, errp);
+    s = g_new0(WinCharState, 1);
+    chr->opaque = s;
+    if (win_chr_init(chr, serial->device, errp) < 0) {
+        g_free(s);
+        qemu_chr_free_common(chr);
+        return NULL;
+    }
+
+    return chr;
 }
 
 #else /* WIN32 */
@@ -4684,8 +4636,9 @@ static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
         return NULL;
     }
     qemu_set_nonblock(fd);
+    tty_serial_init(fd, 115200, 'N', 8, 1);
 
-    return qemu_chr_open_tty_fd(driver, fd, common, be_opened, errp);
+    return qemu_chr_open_fd(driver, fd, fd, common, errp);
 }
 #endif
 
@@ -4941,6 +4894,7 @@ static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
     QIOChannelSocket *sioc = qio_channel_socket_new();
     char *name;
     CharDriverState *chr;
+    NetCharDriver *s;
 
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4949,12 +4903,21 @@ static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
         return NULL;
     }
 
-    chr = qemu_chr_open_udp(driver, sioc, common, be_opened, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
+    if (!chr) {
+        return NULL;
+    }
 
     name = g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
 
+    s = g_new0(NetCharDriver, 1);
+    s->ioc = QIO_CHANNEL(sioc);
+    chr->opaque = s;
+    /* be isn't opened until we get a connection */
+    *be_opened = false;
+
     return chr;
 }
 
-- 
1.8.3.1
