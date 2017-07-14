Received: from eggs.gnu.org ([2001:4830:134:3::10]:54177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5x4-0002J2-Dp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5x3-00021R-AV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dW5x3-000216-20
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 14:08:24 -0500
Message-Id: <20170714190827.4083-3-eblake@redhat.com>
In-Reply-To: <20170714190827.4083-1-eblake@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] tests: Enhance qobject output to cover
 partial visit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Add a test that proves (at least when run under valgrind) that
we are correctly handling allocated memory even when a visit
is aborted in the middle for whatever other reason.

See commit f24582d "qapi: fix double free in
qmp_output_visitor_cleanup()" for a fix that was lacking
testsuite exposure prior to this patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/test-qobject-output-visitor.c | 46 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 749c540..1e9a5d1 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -1,7 +1,7 @@
 /*
  * QObject Output Visitor unit-tests.
  *
- * Copyright (C) 2011-2016 Red Hat Inc.
+ * Copyright (C) 2011-2017 Red Hat Inc.
  *
  * Authors:
  *  Luiz Capitulino <lcapitulino@redhat.com>
@@ -251,6 +251,48 @@ static void test_visitor_out_struct_errors(TestOutputVisitorData *data,
 }


+static void test_visitor_out_partial_visit(TestOutputVisitorData *data,
+                                           const void *unused)
+{
+    /* Various checks that a mid-visit abort doesn't leak or double-free. */
+    const char *str = "hi";
+    Error *err = NULL;
+    UserDefAlternate uda = {
+        .type = QTYPE_QDICT,
+        .u.udfu = { .integer = 1,
+                    .string = (char *) "bye",
+                    .enum1 = -1 } /* intentionally bad */
+    };
+    UserDefAlternate *obj = &uda;
+
+    /* Abort within a nested object with no data members */
+    visit_start_struct(data->ov, NULL, NULL, 0, &error_abort);
+    visit_start_struct(data->ov, "nested", NULL, 0, &error_abort);
+    visitor_reset(data);
+
+    /* Abort in the middle of a list of strings */
+    visit_start_list(data->ov, "list", NULL, 0, &error_abort);
+    visit_type_str(data->ov, NULL, (char **)&str, &error_abort);
+    visit_type_str(data->ov, NULL, (char **)&str, &error_abort);
+    visitor_reset(data);
+
+    /*
+     * Abort in the middle of an alternate. Alternates can't be
+     * virtually visited, so we get to inline the first half of
+     * visit_type_UserDefAlternate().
+     */
+    visit_start_alternate(data->ov, NULL, (GenericAlternate **)&obj,
+                          sizeof(uda), &error_abort);
+    visit_start_struct(data->ov, NULL, NULL, 0, &error_abort);
+    visit_type_UserDefUnionBase_members(data->ov,
+                                        (UserDefUnionBase *)&uda.u.udfu,
+                                        &err);
+    /* error expected because of bad "enum1" discriminator value */
+    error_free_or_abort(&err);
+    visitor_reset(data);
+}
+
+
 static void test_visitor_out_list(TestOutputVisitorData *data,
                                   const void *unused)
 {
@@ -815,6 +857,8 @@ int main(int argc, char **argv)
                             &out_visitor_data, test_visitor_out_struct_nested);
     output_visitor_test_add("/visitor/output/struct-errors",
                             &out_visitor_data, test_visitor_out_struct_errors);
+    output_visitor_test_add("/visitor/output/partial-visit",
+                            &out_visitor_data, test_visitor_out_partial_visit);
     output_visitor_test_add("/visitor/output/list",
                             &out_visitor_data, test_visitor_out_list);
     output_visitor_test_add("/visitor/output/any",
-- 
2.9.4
