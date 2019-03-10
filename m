Received: from eggs.gnu.org ([209.51.188.92]:50825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h317x-0002cx-Ox
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h30uN-0002AM-5U
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:02:39 -0400
Received: from m12-15.163.com ([220.181.12.15]:54318)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1h30uK-00029K-V7
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:02:39 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sun, 10 Mar 2019 09:02:27 -0700
Message-Id: <20190310160227.103090-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] tests: test-qgraph: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, e.emanuelegiuseppe@gmail.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Spotted by ASAN when 'make check'.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/test-qgraph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-qgraph.c b/tests/test-qgraph.c
index f6a6565e31..5c7e457075 100644
--- a/tests/test-qgraph.c
+++ b/tests/test-qgraph.c
@@ -122,7 +122,7 @@ static void check_driver(const char *driver)
 static void check_test(const char *test, const char *interface)
 {
     QOSGraphEdge *edge;
-    const char *full_name = g_strdup_printf("%s-tests/%s", interface, test);
+    char *full_name = g_strdup_printf("%s-tests/%s", interface, test);
 
     qos_add_test(test, interface, testfunct, NULL);
     g_assert_cmpint(qos_graph_has_machine(test), ==, FALSE);
@@ -138,6 +138,7 @@ static void check_test(const char *test, const char *interface)
     g_assert_cmpint(qos_graph_get_node_availability(full_name), ==, TRUE);
     qos_graph_node_set_availability(full_name, FALSE);
     g_assert_cmpint(qos_graph_get_node_availability(full_name), ==, FALSE);
+    g_free(full_name);
 }
 
 static void count_each_test(QOSGraphNode *path, int len)
-- 
2.17.1
