Received: from eggs.gnu.org ([2001:4830:134:3::10]:47533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRcg-0005M8-FK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRcb-0000p8-EQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRcb-0000or-8W
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:23:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57FCB64D8A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:23:01 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:21 +0400
Message-Id: <20170316092121.25672-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/21] tests: add /char/console test
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
 tests/test-char.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index 19707bfcda..773a1c36ba 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -57,6 +57,32 @@ static void fe_event(void *opaque, int event)
 }
=20
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
+#ifdef _WIN32
+static void char_console_test_subprocess(void)
+{
+    QemuOpts *opts;
+    Chardev *chr;
+
+    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "console-label"=
,
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "console", &error_abort);
+
+    chr =3D qemu_chr_new_from_opts(opts, NULL);
+    g_assert_nonnull(chr);
+
+    qemu_chr_write_all(chr, (const uint8_t *)"CONSOLE", 7);
+
+    qemu_opts_del(opts);
+    object_unparent(OBJECT(chr));
+}
+
+static void char_console_test(void)
+{
+    g_test_trap_subprocess("/char/console/subprocess", 0, 0);
+    g_test_trap_assert_passed();
+    g_test_trap_assert_stdout("CONSOLE");
+}
+#endif
 static void char_stdio_test_subprocess(void)
 {
     Chardev *chr;
@@ -83,7 +109,6 @@ static void char_stdio_test(void)
 }
 #endif
=20
-
 static void char_ringbuf_test(void)
 {
     QemuOpts *opts;
@@ -566,6 +591,10 @@ int main(int argc, char **argv)
     g_test_add_func("/char/ringbuf", char_ringbuf_test);
     g_test_add_func("/char/mux", char_mux_test);
 #ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
+#ifdef _WIN32
+    g_test_add_func("/char/console/subprocess", char_console_test_subpro=
cess);
+    g_test_add_func("/char/console", char_console_test);
+#endif
     g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess=
);
     g_test_add_func("/char/stdio", char_stdio_test);
 #endif
--=20
2.12.0.191.gc5d8de91d
