Received: from eggs.gnu.org ([2001:4830:134:3::10]:45073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSg-0004uI-CT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSf-0005AS-9F
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:54 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSf-0005AG-1Z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:53 -0500
Received: by mail-wm0-x242.google.com with SMTP id 141so27960501wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:54 +0100
Message-Id: <1517858941-5538-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/47] tests: keep compiling failing vhost-user
 tests
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

Let's protect the failing tests under a QTEST_VHOST_USER_FIXME
environment variable, so we keep compiling the tests and we can easily
run them.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-6-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index ec6ac9d..713ff5c 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -30,8 +30,6 @@
 #include <linux/virtio_net.h>
 #include <sys/vfs.h>
 
-#define VHOST_USER_NET_TESTS_WORKING 0 /* broken as of 2.10.0 */
-
 /* GLIB version compatibility flags */
 #if !GLIB_CHECK_VERSION(2, 26, 0)
 #define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
@@ -765,7 +763,7 @@ static void wait_for_rings_started(TestServer *s, size_t count)
     g_mutex_unlock(&s->data_mutex);
 }
 
-#if VHOST_USER_NET_TESTS_WORKING && defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
+#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
 static inline void test_server_connect(TestServer *server)
 {
     test_server_create_chr(server, ",reconnect=1");
@@ -956,16 +954,19 @@ int main(int argc, char **argv)
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
 
-#if VHOST_USER_NET_TESTS_WORKING && defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
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
+        qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch);
+    }
 #endif
 
     ret = g_test_run();
-- 
1.8.3.1
