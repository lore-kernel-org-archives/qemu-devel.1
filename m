Received: from eggs.gnu.org ([2001:4830:134:3::10]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJB9-00062X-1e
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJB8-0000aa-02
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYJB7-0000aK-Mo
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 20 Jul 2017 16:40:05 -0500
Message-Id: <20170720214008.28494-2-eblake@redhat.com>
In-Reply-To: <20170720214008.28494-1-eblake@redhat.com>
References: <20170720214008.28494-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] tests: Enhance qobject output to cover
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
v2: tweak partial alternate visit
---
 tests/test-qobject-output-visitor.c | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 749c54065f..ce2fb8f368 100644
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
@@ -251,6 +251,44 @@ static void test_visitor_out_struct_errors(TestOutputVisitorData *data,
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
+     * Abort in the middle of an alternate, due to bad "enum1"
+     * discriminator value.  Since alternates don't support virtual
+     * visits, we perform a real one, relying on our knowledge that
+     * visit_type_UserDefAlternate() calls visit_start_alternate()
+     * under the hood.
+     */
+    visit_type_UserDefAlternate(data->ov, NULL, &obj, &err);
+    error_free_or_abort(&err);
+    visitor_reset(data);
+}
+
+
 static void test_visitor_out_list(TestOutputVisitorData *data,
                                   const void *unused)
 {
@@ -815,6 +853,8 @@ int main(int argc, char **argv)
                             &out_visitor_data, test_visitor_out_struct_nested);
     output_visitor_test_add("/visitor/output/struct-errors",
                             &out_visitor_data, test_visitor_out_struct_errors);
+    output_visitor_test_add("/visitor/output/partial-visit",
+                            &out_visitor_data, test_visitor_out_partial_visit);
     output_visitor_test_add("/visitor/output/list",
                             &out_visitor_data, test_visitor_out_list);
     output_visitor_test_add("/visitor/output/any",
-- 
2.13.3
