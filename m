Received: from eggs.gnu.org ([2001:4830:134:3::10]:47837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqfBI-0001PA-A6
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fqfBH-0007Ct-IR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:52:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fqfBH-0007C0-DH
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13D576F4C7
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 13:52:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Aug 2018 15:52:24 +0200
Message-Id: <20180817135224.22971-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180817135224.22971-1-marcandre.lureau@redhat.com>
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] test-char: add socket reconnect test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This test exhibits a regression fixed by the previous reverts.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 5905d31441..d99742d86d 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -309,7 +309,7 @@ static int socket_can_read_hello(void *opaque)
     return 10;
 }
=20
-static void char_socket_test_common(Chardev *chr)
+static void char_socket_test_common(Chardev *chr, bool reconnect)
 {
     Chardev *chr_client;
     QObject *addr;
@@ -329,7 +329,8 @@ static void char_socket_test_common(Chardev *chr)
     addr =3D object_property_get_qobject(OBJECT(chr), "addr", &error_abo=
rt);
     qdict =3D qobject_to(QDict, addr);
     port =3D qdict_get_str(qdict, "port");
-    tmp =3D g_strdup_printf("tcp:127.0.0.1:%s", port);
+    tmp =3D g_strdup_printf("tcp:127.0.0.1:%s%s", port,
+                          reconnect ? ",reconnect=3D1" : "");
     qobject_unref(qdict);
=20
     qemu_chr_fe_init(&be, chr, &error_abort);
@@ -370,7 +371,15 @@ static void char_socket_basic_test(void)
 {
     Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
=20
-    char_socket_test_common(chr);
+    char_socket_test_common(chr, false);
+}
+
+
+static void char_socket_reconnect_test(void)
+{
+    Chardev *chr =3D qemu_chr_new("server", "tcp:127.0.0.1:0,server,nowa=
it");
+
+    char_socket_test_common(chr, true);
 }
=20
=20
@@ -402,7 +411,7 @@ static void char_socket_fdpass_test(void)
=20
     qemu_opts_del(opts);
=20
-    char_socket_test_common(chr);
+    char_socket_test_common(chr, false);
 }
=20
=20
@@ -823,6 +832,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
     g_test_add_func("/char/socket/basic", char_socket_basic_test);
+    g_test_add_func("/char/socket/reconnect", char_socket_reconnect_test=
);
     g_test_add_func("/char/socket/fdpass", char_socket_fdpass_test);
     g_test_add_func("/char/udp", char_udp_test);
 #ifdef HAVE_CHARDEV_SERIAL
--=20
2.18.0.547.g1d89318c48
