Received: from eggs.gnu.org ([2001:4830:134:3::10]:36041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5c5-0005se-By
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5c1-0004tF-B1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:29 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com
	([104.47.1.108]:65168
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5c0-0004se-Rn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:10:25 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:56 +0300
Message-ID: <1499342940-56739-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 09/13] test-char: add hotswap test
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 71 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index de72974..9ca233f 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -662,6 +662,76 @@ static void char_invalid_test(void)
     g_assert_null(chr);
 }
=20
+static int chardev_change(void *opaque)
+{
+    return 0;
+}
+
+static int chardev_change_denied(void *opaque)
+{
+    return -1;
+}
+
+static void char_hotswap_test(void)
+{
+    char *chr_args;
+    Chardev *chr;
+    CharBackend be;
+
+    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+    char *filename =3D g_build_filename(tmp_path, "file", NULL);
+    ChardevFile file =3D { .out =3D filename };
+    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
+                               .u.file.data =3D &file };
+    ChardevReturn *ret;
+
+    int port;
+    int sock =3D make_udp_socket(&port);
+    g_assert_cmpint(sock, >, 0);
+
+    chr_args =3D g_strdup_printf("udp:127.0.0.1:%d", port);
+
+    chr =3D qemu_chr_new("chardev", chr_args);
+    qemu_chr_fe_init(&be, chr, &error_abort);
+
+    /* check that chardev operates correctly */
+    char_udp_test_internal(chr, sock);
+
+    /* set the handler that denies the hotswap */
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             NULL, chardev_change_denied, NULL, NULL, true=
);
+
+    /* now, change is denied and has to keep the old backend operating */
+    ret =3D qmp_chardev_change("chardev", &backend, NULL);
+    g_assert(!ret);
+    g_assert(be.chr =3D=3D chr);
+
+    char_udp_test_internal(chr, sock);
+
+    /* now allow the change */
+    qemu_chr_fe_set_handlers(&be, NULL, NULL,
+                             NULL, chardev_change, NULL, NULL, true);
+
+    /* has to succeed now */
+    ret =3D qmp_chardev_change("chardev", &backend, &error_abort);
+    g_assert(be.chr !=3D chr);
+
+    close(sock);
+    chr =3D be.chr;
+
+    /* run the file chardev test */
+    char_file_test_internal(chr, filename);
+
+    object_unparent(OBJECT(chr));
+
+    qapi_free_ChardevReturn(ret);
+    g_unlink(filename);
+    g_free(filename);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(chr_args);
+}
+
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
@@ -696,6 +766,7 @@ int main(int argc, char **argv)
 #ifdef HAVE_CHARDEV_SERIAL
     g_test_add_func("/char/serial", char_serial_test);
 #endif
+    g_test_add_func("/char/hotswap", char_hotswap_test);
=20
     return g_test_run();
 }
--=20
2.7.4
