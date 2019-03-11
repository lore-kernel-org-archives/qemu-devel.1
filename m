Received: from eggs.gnu.org ([209.51.188.92]:60580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODJ-0006mi-7W
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODI-0002pu-Gg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODI-0002pD-7R
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id t6so5931326wrw.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:08 +0100
Message-Id: <1552323335-46779-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 04/31] tests: test-qgraph: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Spotted by ASAN when 'make check'.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190310160227.103090-1-liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: fc281c80202
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-qgraph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/test-qgraph.c b/tests/test-qgraph.c
index f6a6565..5c7e457 100644
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
1.8.3.1
