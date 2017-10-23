Received: from eggs.gnu.org ([2001:4830:134:3::10]:40363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ8-0001AZ-UD
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e6dZ4-0000dt-T8
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e6dZ4-0000dD-KE
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 10:18:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5F08883A4
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:18:49 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2017 15:18:13 +0100
Message-Id: <20171023141815.17709-8-marcandre.lureau@redhat.com>
In-Reply-To: <20171023141815.17709-1-marcandre.lureau@redhat.com>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 7/9] tests: keep compiling failing
 vhost-user tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Let's protect the failing tests under a QTEST_VHOST_USER_FIXME
environment variable, so we keep compiling the tests and we can easily
run them.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 4b98018478..7fc6f85888 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -31,8 +31,6 @@
 #include <linux/virtio_net.h>
 #include <sys/vfs.h>
=20
-#define VHOST_USER_NET_TESTS_WORKING 0 /* broken as of 2.10.0 */
-
 /* GLIB version compatibility flags */
 #if !GLIB_CHECK_VERSION(2, 26, 0)
 #define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
@@ -719,7 +717,7 @@ static void wait_for_rings_started(TestServer *s, siz=
e_t count)
     g_mutex_unlock(&s->data_mutex);
 }
=20
-#if VHOST_USER_NET_TESTS_WORKING && defined(CONFIG_HAS_GLIB_SUBPROCESS_T=
ESTS)
+#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
 static inline void test_server_connect(TestServer *server)
 {
     test_server_create_chr(server, ",reconnect=3D1");
@@ -965,16 +963,19 @@ int main(int argc, char **argv)
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
=20
-#if VHOST_USER_NET_TESTS_WORKING && defined(CONFIG_HAS_GLIB_SUBPROCESS_T=
ESTS)
-    qtest_add_func("/vhost-user/reconnect/subprocess",
-                   test_reconnect_subprocess);
-    qtest_add_func("/vhost-user/reconnect", test_reconnect);
-    qtest_add_func("/vhost-user/connect-fail/subprocess",
-                   test_connect_fail_subprocess);
-    qtest_add_func("/vhost-user/connect-fail", test_connect_fail);
-    qtest_add_func("/vhost-user/flags-mismatch/subprocess",
-                   test_flags_mismatch_subprocess);
-    qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch);
+#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
+    /* keeps failing on build-system since Aug 15 2017 */
+    if (getenv("QTEST_VHOST_USER_FIXME")) {
+        qtest_add_func("/vhost-user/reconnect/subprocess",
+                       test_reconnect_subprocess);
+        qtest_add_func("/vhost-user/reconnect", test_reconnect);
+        qtest_add_func("/vhost-user/connect-fail/subprocess",
+                       test_connect_fail_subprocess);
+        qtest_add_func("/vhost-user/connect-fail", test_connect_fail);
+        qtest_add_func("/vhost-user/flags-mismatch/subprocess",
+                       test_flags_mismatch_subprocess);
+        qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch=
);
+    }
 #endif
=20
     ret =3D g_test_run();
--=20
2.15.0.rc0.40.gaefcc5f6f
