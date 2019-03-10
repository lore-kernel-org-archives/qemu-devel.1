Received: from eggs.gnu.org ([209.51.188.92]:57400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2yFY-000462-Tu
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2yFW-0005nK-TC
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:12:20 -0400
Received: from m12-15.163.com ([220.181.12.15]:36875)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h2yFV-0005lw-U8
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:12:18 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sun, 10 Mar 2019 06:12:05 -0700
Message-Id: <20190310131205.75856-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] tests: test-announce-self: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vyasevic@redhat.com, dgilbert@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Spotted by ASAN when 'make check'.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/test-announce-self.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
index 1644d34a3f..3f370d8bf5 100644
--- a/tests/test-announce-self.c
+++ b/tests/test-announce-self.c
@@ -21,17 +21,6 @@
 #define ETH_P_RARP 0x8035
 #endif
 
-static QTestState *test_init(int socket)
-{
-    char *args;
-
-    args = g_strdup_printf("-netdev socket,fd=%d,id=hs0 -device "
-                           "virtio-net-pci,netdev=hs0", socket);
-
-    return qtest_start(args);
-}
-
-
 static void test_announce(int socket)
 {
     char buffer[60];
@@ -58,19 +47,22 @@ static void test_announce(int socket)
 
 static void setup(gconstpointer data)
 {
-    QTestState *qs;
     void (*func) (int socket) = data;
     int sv[2], ret;
+    char *args;
 
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
     g_assert_cmpint(ret, !=, -1);
 
-    qs = test_init(sv[1]);
+    args = g_strdup_printf("-netdev socket,fd=%d,id=hs0 -device "
+                           "virtio-net-pci,netdev=hs0", sv[1]);
+    qtest_start(args);
     func(sv[0]);
 
     /* End test */
     close(sv[0]);
-    qtest_quit(qs);
+    qtest_end();
+    g_free(args);
 }
 
 int main(int argc, char **argv)
-- 
2.17.1
