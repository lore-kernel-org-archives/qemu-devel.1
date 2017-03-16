Received: from eggs.gnu.org ([2001:4830:134:3::10]:47496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRcX-0005EP-6U
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRcW-0000nU-7p
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRcW-0000nA-1v
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22DC09D4E9
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:22:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:20 +0400
Message-Id: <20170316092121.25672-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 20/21] tests: add /char/udp test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 9971498391..19707bfcda 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -385,6 +385,51 @@ static void char_pipe_test(void)
 }
 #endif
=20
+static void char_udp_test(void)
+{
+    struct sockaddr_in addr =3D { 0, }, other;
+    SocketIdleData d =3D { 0, };
+    Chardev *chr;
+    CharBackend be;
+    socklen_t alen =3D sizeof(addr);
+    int ret, sock =3D qemu_socket(PF_INET, SOCK_DGRAM, 0);
+    char buf[10];
+    char *tmp;
+
+    g_assert_cmpint(sock, >, 0);
+    addr.sin_family =3D AF_INET ;
+    addr.sin_addr.s_addr =3D htonl(INADDR_ANY);
+    addr.sin_port =3D 0;
+    ret =3D bind(sock, (struct sockaddr *)&addr, sizeof(addr));
+    g_assert_cmpint(ret, =3D=3D, 0);
+    ret =3D getsockname(sock, (struct sockaddr *)&addr, &alen);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    tmp =3D g_strdup_printf("udp:127.0.0.1:%d",
+                          ntohs(addr.sin_port));
+    chr =3D qemu_chr_new("client", tmp);
+    g_assert_nonnull(chr);
+
+    d.chr =3D chr;
+    qemu_chr_fe_init(&be, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&be, socket_can_read_hello, socket_read_hel=
lo,
+                             NULL, &d, NULL, true);
+    ret =3D qemu_chr_write_all(chr, (uint8_t *)"hello", 5);
+    g_assert_cmpint(ret, =3D=3D, 5);
+
+    alen =3D sizeof(addr);
+    ret =3D recvfrom(sock, buf, sizeof(buf), 0,
+                   (struct sockaddr *)&other, &alen);
+    g_assert_cmpint(ret, =3D=3D, 5);
+    ret =3D sendto(sock, buf, 5, 0, (struct sockaddr *)&other, alen);
+    g_assert_cmpint(ret, =3D=3D, 5);
+
+    main_loop();
+
+    close(sock);
+    g_free(tmp);
+}
+
 static void char_file_test(void)
 {
     char *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
@@ -529,6 +574,7 @@ int main(int argc, char **argv)
 #endif
     g_test_add_func("/char/file", char_file_test);
     g_test_add_func("/char/socket", char_socket_test);
+    g_test_add_func("/char/udp", char_udp_test);
=20
     return g_test_run();
 }
--=20
2.12.0.191.gc5d8de91d
