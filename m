Received: from eggs.gnu.org ([2001:4830:134:3::10]:33048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4C-0001Wz-LS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA45-00069j-DR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3v-0005nP-55
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:25 -0400
Received: by mail-wr1-x42f.google.com with SMTP id j26-v6so645938wre.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:47 +0200
Message-Id: <1534870966-9287-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/74] tests/device-introspection: Check that
 the qom-tree and qtree do not change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Introspection should not change the qom-tree / qtree, so we should check
this in the device-introspect-test, too. This patch helped to find lots
of instrospection bugs during the QEMU v3.0 soft/hard-freeze period in the
last two months.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1534419358-10932-7-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/device-introspect-test.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index 0b4f221..a38193b 100644
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
+    g_test_message("Testing device '%s'", type);
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
