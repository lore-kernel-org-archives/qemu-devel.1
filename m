Received: from eggs.gnu.org ([2001:4830:134:3::10]:35958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bt-0005hv-A6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bp-0004qn-9m
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:17 -0400
Received: from mail-db5eur01on0096.outbound.protection.outlook.com
	([104.47.2.96]:45343
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5bo-0004qN-RJ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:13 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:54 +0300
Message-ID: <1499342940-56739-8-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 07/13] test-char: split char_udp_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

makes it possible to test the existing chardev-udp

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 56 +++++++++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 6add1aa..1265224 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -411,16 +411,11 @@ static void char_pipe_test(void)
 }
 #endif
=20
-static void char_udp_test(void)
+static int make_udp_socket(int *port)
 {
-    struct sockaddr_in addr =3D { 0, }, other;
-    SocketIdleData d =3D { 0, };
-    Chardev *chr;
-    CharBackend be;
+    struct sockaddr_in addr =3D { 0, };
     socklen_t alen =3D sizeof(addr);
     int ret, sock =3D qemu_socket(PF_INET, SOCK_DGRAM, 0);
-    char buf[10];
-    char *tmp;
=20
     g_assert_cmpint(sock, >, 0);
     addr.sin_family =3D AF_INET ;
@@ -431,19 +426,41 @@ static void char_udp_test(void)
     ret =3D getsockname(sock, (struct sockaddr *)&addr, &alen);
     g_assert_cmpint(ret, =3D=3D, 0);
=20
-    tmp =3D g_strdup_printf("udp:127.0.0.1:%d",
-                          ntohs(addr.sin_port));
-    chr =3D qemu_chr_new("client", tmp);
-    g_assert_nonnull(chr);
+    *port =3D ntohs(addr.sin_port);
+    return sock;
+}
+
+static void char_udp_test_internal(Chardev *reuse_chr, int sock)
+{
+    struct sockaddr_in other;
+    SocketIdleData d =3D { 0, };
+    Chardev *chr;
+    CharBackend *be;
+    socklen_t alen =3D sizeof(other);
+    int ret;
+    char buf[10];
+    char *tmp =3D NULL;
+
+    if (reuse_chr) {
+        chr =3D reuse_chr;
+        be =3D chr->be;
+    } else {
+        int port;
+        sock =3D make_udp_socket(&port);
+        tmp =3D g_strdup_printf("udp:127.0.0.1:%d", port);
+        chr =3D qemu_chr_new("client", tmp);
+        g_assert_nonnull(chr);
+
+        be =3D g_alloca(sizeof(CharBackend));
+        qemu_chr_fe_init(be, chr, &error_abort);
+    }
=20
     d.chr =3D chr;
-    qemu_chr_fe_init(&be, chr, &error_abort);
-    qemu_chr_fe_set_handlers(&be, socket_can_read_hello, socket_read_hello=
,
+    qemu_chr_fe_set_handlers(be, socket_can_read_hello, socket_read_hello,
                              NULL, NULL, &d, NULL, true);
     ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello", 5);
     g_assert_cmpint(ret, =3D=3D, 5);
=20
-    alen =3D sizeof(addr);
     ret =3D recvfrom(sock, buf, sizeof(buf), 0,
                    (struct sockaddr *)&other, &alen);
     g_assert_cmpint(ret, =3D=3D, 5);
@@ -452,9 +469,16 @@ static void char_udp_test(void)
=20
     main_loop();
=20
-    close(sock);
+    if (!reuse_chr) {
+        close(sock);
+        qemu_chr_fe_deinit(be, true);
+    }
     g_free(tmp);
-    qemu_chr_fe_deinit(&be, true);
+}
+
+static void char_udp_test(void)
+{
+    char_udp_test_internal(NULL, 0);
 }
=20
 #ifdef HAVE_CHARDEV_SERIAL
--=20
2.7.4
