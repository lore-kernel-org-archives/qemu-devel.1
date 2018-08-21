Received: from eggs.gnu.org ([2001:4830:134:3::10]:33980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002Sj-5i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4u-0007Kb-2Z
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:51293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4t-0007If-5q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:23 -0400
Received: by mail-wm0-x22f.google.com with SMTP id y2-v6so3646092wma.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:46 +0200
Message-Id: <1534870966-9287-75-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 74/74] test-char: add socket reconnect test
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

This test exhibits a regression fixed by the previous reverts.

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180817135224.22971-5-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 2a2ff32..2670ff6 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -307,7 +307,7 @@ static int socket_can_read_hello(void *opaque)
     return 10;
 }
 
-static void char_socket_test_common(Chardev *chr)
+static void char_socket_test_common(Chardev *chr, bool reconnect)
 {
     Chardev *chr_client;
     QObject *addr;
@@ -327,7 +327,8 @@ static void char_socket_test_common(Chardev *chr)
     addr = object_property_get_qobject(OBJECT(chr), "addr", &error_abort);
     qdict = qobject_to(QDict, addr);
     port = qdict_get_str(qdict, "port");
-    tmp = g_strdup_printf("tcp:127.0.0.1:%s", port);
+    tmp = g_strdup_printf("tcp:127.0.0.1:%s%s", port,
+                          reconnect ? ",reconnect=1" : "");
     qobject_unref(qdict);
 
     qemu_chr_fe_init(&be, chr, &error_abort);
@@ -368,7 +369,15 @@ static void char_socket_basic_test(void)
 {
     Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
 
-    char_socket_test_common(chr);
+    char_socket_test_common(chr, false);
+}
+
+
+static void char_socket_reconnect_test(void)
+{
+    Chardev *chr = qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowait");
+
+    char_socket_test_common(chr, true);
 }
 
 
@@ -400,7 +409,7 @@ static void char_socket_fdpass_test(void)
 
     qemu_opts_del(opts);
 
-    char_socket_test_common(chr);
+    char_socket_test_common(chr, false);
 }
 
 
@@ -819,6 +828,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
     g_test_add_func("/char/socket/basic", char_socket_basic_test);
+    g_test_add_func("/char/socket/reconnect", char_socket_reconnect_test);
     g_test_add_func("/char/socket/fdpass", char_socket_fdpass_test);
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
-- 
1.8.3.1
