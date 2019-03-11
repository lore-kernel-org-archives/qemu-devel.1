Received: from eggs.gnu.org ([209.51.188.92]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h3Lns-0000Sx-Ic
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h3Li2-000316-L8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:15:19 -0400
Received: from m12-15.163.com ([220.181.12.15]:40873)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h3Li0-0002pC-VQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:15:17 -0400
From: Li Qiang <liq3ea@163.com>
Date: Mon, 11 Mar 2019 07:14:57 -0700
Message-Id: <20190311141457.109436-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2] tests: test-announce-self: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vyasevic@redhat.com, dgilbert@redhat.com, mst@redhat.com, jasowang@redhat.com, thuth@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Spotted by ASAN while running 'make check'.

Fixes: 4b9b7000(tests: Add a test for qemu
self announcements)

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
Changes since v1: Use Thomas's patch
 tests/test-announce-self.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
index 1644d34a3f..662c3aaf06 100644
--- a/tests/test-announce-self.c
+++ b/tests/test-announce-self.c
@@ -21,18 +21,8 @@
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
 
-static void test_announce(int socket)
+static void test_announce(QTestState *qs, int socket)
 {
     char buffer[60];
     int len;
@@ -40,7 +30,7 @@ static void test_announce(int socket)
     int ret;
     uint16_t *proto = (uint16_t *)&buffer[12];
 
-    rsp = qmp("{ 'execute' : 'announce-self', "
+    rsp = qtest_qmp(qs, "{ 'execute' : 'announce-self', "
                   " 'arguments': {"
                       " 'initial': 50, 'max': 550,"
                       " 'rounds': 10, 'step': 50 } }");
@@ -59,14 +49,15 @@ static void test_announce(int socket)
 static void setup(gconstpointer data)
 {
     QTestState *qs;
-    void (*func) (int socket) = data;
+    void (*func) (QTestState *qs, int socket) = data;
     int sv[2], ret;
 
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
     g_assert_cmpint(ret, !=, -1);
 
-    qs = test_init(sv[1]);
-    func(sv[0]);
+    qs = qtest_initf("-netdev socket,fd=%d,id=hs0 -device "
+                           "virtio-net-pci,netdev=hs0", sv[1]);
+    func(qs, sv[0]);
 
     /* End test */
     close(sv[0]);
-- 
2.17.1
