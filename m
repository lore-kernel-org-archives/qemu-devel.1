Received: from eggs.gnu.org ([2001:4830:134:3::10]:56239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpGmP-0007Hp-LN
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpGmK-0001CL-Px
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:37:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpGmK-0001CE-Kh
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:37:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 13 Aug 2018 19:37:10 +0200
Message-Id: <1534181830-6055-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/device-introspection: Check that the
 qom-tree and qtree do not change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

Introspection should not change the qom-tree / qtree, so we should check
this in the device-introspect-test, too. This patch helped to find lots
of instrospection bugs during the QEMU v3.0 soft/hard-freeze period in the
last two months.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/device-introspect-test.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index 0b4f221..5b7ec05 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -103,7 +103,14 @@ static QList *device_type_list(bool abstract)
 static void test_one_device(const char *type)
 {
     QDict *resp;
-    char *help, *qom_tree;
+    char *help;
+    char *qom_tree_start, *qom_tree_end;
+    char *qtree_start, *qtree_end;
+
+    g_debug("Testing device '%s'", type);
+
+    qom_tree_start = hmp("info qom-tree");
+    qtree_start = hmp("info qtree");
 
     resp = qmp("{'execute': 'device-list-properties',"
                " 'arguments': {'typename': %s}}",
@@ -115,10 +122,18 @@ static void test_one_device(const char *type)
 
     /*
      * Some devices leave dangling pointers in QOM behind.
-     * "info qom-tree" has a good chance at crashing then
+     * "info qom-tree" or "info qtree" have a good chance at crashing then.
+     * Also make sure that the tree did not change.
      */
-    qom_tree = hmp("info qom-tree");
-    g_free(qom_tree);
+    qom_tree_end = hmp("info qom-tree");
+    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
+    g_free(qom_tree_start);
+    g_free(qom_tree_end);
+
+    qtree_end = hmp("info qtree");
+    g_assert_cmpstr(qtree_start, ==, qtree_end);
+    g_free(qtree_start);
+    g_free(qtree_end);
 }
 
 static void test_device_intro_list(void)
-- 
1.8.3.1
