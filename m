Received: from eggs.gnu.org ([2001:4830:134:3::10]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpzwM-0000Du-Lj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpzwJ-0004l7-FL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpzwJ-0004kl-9S
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:13:47 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 17:13:43 +0100
Message-Id: <1490026424-11330-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490026424-11330-1-git-send-email-armbru@redhat.com>
References: <1490026424-11330-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 1/2] qapi: Fix string input visitor
 regression for empty lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Visiting a list when input is the empty string should result in an
empty list, not an error.  Noticed when commit 3d089ce belatedly added
tests, but simply accepted as weird then.  It's actually a regression:
broken in commit 74f24cb, v2.7.0.  Fix it, and throw in another test
case for empty string.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/string-input-visitor.c       |  4 ++++
 tests/test-string-input-visitor.c | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 806b01ae..c089491 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -54,6 +54,10 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
         return 0;
     }
 
+    if (!*str) {
+        return 0;
+    }
+
     do {
         errno = 0;
         start = strtoll(str, &endptr, 0);
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 6db850b..79313a7 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -63,6 +63,11 @@ static void test_visitor_in_int(TestInputVisitorData *data,
 
     visit_type_int(v, NULL, &res, &err);
     error_free_or_abort(&err);
+
+    v = visitor_input_test_init(data, "");
+
+    visit_type_int(v, NULL, &res, &err);
+    error_free_or_abort(&err);
 }
 
 static void check_ilist(Visitor *v, int64_t *expected, size_t n)
@@ -140,11 +145,11 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
     v = visitor_input_test_init(data, "18446744073709551615");
     check_ulist(v, expect4, ARRAY_SIZE(expect4));
 
-    /* Empty list is invalid (weird) */
+    /* Empty list */
 
     v = visitor_input_test_init(data, "");
-    visit_type_int64List(v, NULL, &res, &err);
-    error_free_or_abort(&err);
+    visit_type_int64List(v, NULL, &res, &error_abort);
+    g_assert(!res);
 
     /* Not a list */
 
-- 
2.7.4
