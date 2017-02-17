Received: from eggs.gnu.org ([2001:4830:134:3::10]:48966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceowk-00076E-Na
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceowg-0000r4-Ja
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:16:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ceowg-0000q3-Do
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:15:58 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:15:54 +0100
Message-Id: <1487362554-5688-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Use error_free_or_abort() where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

Done with this Coccinelle semantic patch:

    @@
    expression E;
    @@
    -    g_assert(E);
    -    error_free(E);
    +    error_free_or_abort(&E);

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qemu-opts.c              | 3 +--
 tests/test-qobject-output-visitor.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index a505a3e..d08e8a6 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -79,8 +79,7 @@ static void test_find_unknown_opts(void)
     /* should not return anything, we don't have an "unknown" option */
     list = qemu_find_opts_err("unknown", &err);
     g_assert(list == NULL);
-    g_assert(err);
-    error_free(err);
+    error_free_or_abort(&err);
 }
 
 static void test_qemu_find_opts(void)
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 4e2d79c..58019e2 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -146,8 +146,7 @@ static void test_visitor_out_enum_errors(TestOutputVisitorData *data,
     for (i = 0; i < ARRAY_SIZE(bad_values) ; i++) {
         err = NULL;
         visit_type_EnumOne(data->ov, "unused", &bad_values[i], &err);
-        g_assert(err);
-        error_free(err);
+        error_free_or_abort(&err);
         visitor_reset(data);
     }
 }
@@ -251,8 +250,7 @@ static void test_visitor_out_struct_errors(TestOutputVisitorData *data,
         u.has_enum1 = true;
         u.enum1 = bad_values[i];
         visit_type_UserDefOne(data->ov, "unused", &pu, &err);
-        g_assert(err);
-        error_free(err);
+        error_free_or_abort(&err);
         visitor_reset(data);
     }
 }
-- 
2.7.4
