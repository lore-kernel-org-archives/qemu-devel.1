Received: from eggs.gnu.org ([2001:4830:134:3::10]:52597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0007tf-Is
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN6-0001LD-LJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkN6-0001KC-Ed
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E21D3DE3E
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A23B1820B
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:48:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:23 +0100
Message-Id: <1490204908-26567-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 for-2.9 12/17] qapi: Fix string input visitor
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

Visiting a list when input is the empty string should result in an
empty list, not an error.  Noticed when commit 3d089ce belatedly added
tests, but simply accepted as weird then.  It's actually a regression:
broken in commit 74f24cb, v2.7.0.  Fix it, and throw in another test
case for empty string.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490026424-11330-2-git-send-email-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
