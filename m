Received: from eggs.gnu.org ([2001:4830:134:3::10]:49031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqq-0005GJ-6y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqn-0007ZM-RJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUwqn-0007XX-ID
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCA2513AA4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:50:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  6 Dec 2018 17:49:55 +0100
Message-Id: <1544114998-1513-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1544114998-1513-1-git-send-email-thuth@redhat.com>
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 2/5] tests/test-filter: Make tests
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, eblake@redhat.com

Apart from using qmp() in the qmp_discard_response() macro, these
tests do not have any dependencies to the global_qtest variable,
so we can simply get rid of it here by replacing the qmp() with
qtest_qmp() in the macro.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-filter-mirror.c     |  9 +++++----
 tests/test-filter-redirector.c | 16 +++++++++-------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index d15917e..7ab2aed 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -17,7 +17,7 @@
 #include "qemu/main-loop.h"
 
 /* TODO actually test the results and get rid of this */
-#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+#define qmp_discard_response(qs, ...) qobject_unref(qtest_qmp(qs, __VA_ARGS__))
 
 static void test_mirror(void)
 {
@@ -29,6 +29,7 @@ static void test_mirror(void)
     uint32_t size = sizeof(send_buf);
     size = htonl(size);
     const char *devstr = "e1000";
+    QTestState *qts;
 
     if (g_str_equal(qtest_get_arch(), "s390x")) {
         devstr = "virtio-net-ccw";
@@ -40,7 +41,7 @@ static void test_mirror(void)
     ret = mkstemp(sock_path);
     g_assert_cmpint(ret, !=, -1);
 
-    global_qtest = qtest_initf(
+    qts = qtest_initf(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=mirror0,path=%s,server,nowait "
@@ -61,7 +62,7 @@ static void test_mirror(void)
     };
 
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
     ret = iov_send(send_sock[0], iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
     close(send_sock[0]);
@@ -78,6 +79,7 @@ static void test_mirror(void)
     g_free(recv_buf);
     close(recv_sock);
     unlink(sock_path);
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
@@ -88,7 +90,6 @@ int main(int argc, char **argv)
 
     qtest_add_func("/netfilter/mirror", test_mirror);
     ret = g_test_run();
-    qtest_end();
 
     return ret;
 }
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 615ff5c..9ca9fea 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -59,7 +59,7 @@
 #include "qemu/main-loop.h"
 
 /* TODO actually test the results and get rid of this */
-#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+#define qmp_discard_response(qs, ...) qobject_unref(qtest_qmp(qs, __VA_ARGS__))
 
 static const char *get_devstr(void)
 {
@@ -81,6 +81,7 @@ static void test_redirector_tx(void)
     char *recv_buf;
     uint32_t size = sizeof(send_buf);
     size = htonl(size);
+    QTestState *qts;
 
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
     g_assert_cmpint(ret, !=, -1);
@@ -90,7 +91,7 @@ static void test_redirector_tx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);
 
-    global_qtest = qtest_initf(
+    qts = qtest_initf(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=redirector0,path=%s,server,nowait "
@@ -108,7 +109,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=, -1);
 
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
 
     struct iovec iov[] = {
         {
@@ -137,7 +138,7 @@ static void test_redirector_tx(void)
     close(recv_sock);
     unlink(sock_path0);
     unlink(sock_path1);
-    qtest_end();
+    qtest_quit(qts);
 }
 
 static void test_redirector_rx(void)
@@ -150,6 +151,7 @@ static void test_redirector_rx(void)
     char *recv_buf;
     uint32_t size = sizeof(send_buf);
     size = htonl(size);
+    QTestState *qts;
 
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
     g_assert_cmpint(ret, !=, -1);
@@ -159,7 +161,7 @@ static void test_redirector_rx(void)
     ret = mkstemp(sock_path1);
     g_assert_cmpint(ret, !=, -1);
 
-    global_qtest = qtest_initf(
+    qts = qtest_initf(
         "-netdev socket,id=qtest-bn0,fd=%d "
         "-device %s,netdev=qtest-bn0,id=qtest-e0 "
         "-chardev socket,id=redirector0,path=%s,server,nowait "
@@ -186,7 +188,7 @@ static void test_redirector_rx(void)
     send_sock = unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=, -1);
     /* send a qmp command to guarantee that 'connected' is setting to true. */
-    qmp_discard_response("{ 'execute' : 'query-status'}");
+    qmp_discard_response(qts, "{ 'execute' : 'query-status'}");
 
     ret = iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_buf));
     g_assert_cmpint(ret, ==, sizeof(send_buf) + sizeof(size));
@@ -204,7 +206,7 @@ static void test_redirector_rx(void)
     g_free(recv_buf);
     unlink(sock_path0);
     unlink(sock_path1);
-    qtest_end();
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1
