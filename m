Received: from eggs.gnu.org ([2001:4830:134:3::10]:50743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4D-0004BR-JW
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4A-0000Mk-JD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4A-0000ML-BQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:52:59 -0300
Message-Id: <20170613165313.20954-2-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 01/15] tests: Test cases for error API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/test-qapi-util.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  2 +-
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index e8697577a5..3695034c32 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -75,11 +75,110 @@ static void test_parse_qapi_name(void)
     g_assert(ret == -1);
 }
 
+static void successfn(Error **errp)
+{
+    g_assert(!errp || !*errp);
+}
+
+static void fail1(Error **errp)
+{
+    g_assert(!errp || !*errp);
+
+    error_setg(errp, "error1");
+
+    g_assert(!errp || *errp);
+}
+
+static void fail2(Error **errp)
+{
+    g_assert(!errp || !*errp);
+
+    error_setg(errp, "error2");
+
+    g_assert(!errp || *errp);
+}
+
+static void multifn(Error **errp)
+{
+    Error *err1 = NULL, *err2 = NULL;
+    successfn(&err1);
+    g_assert(!err1);
+
+    fail1(&err1);
+    g_assert(err1);
+    g_assert_cmpstr(error_get_pretty(err1), ==, "error1");
+
+    fail2(&err2);
+    g_assert(err2);
+    g_assert_cmpstr(error_get_pretty(err2), ==, "error2");
+
+    error_propagate(&err1, err2);
+    g_assert(err1);
+    g_assert_cmpstr(error_get_pretty(err1), ==, "error1");
+
+    error_propagate(errp, err1);
+}
+
+static void test_propagate(void (*fn)(Error **), Error **errp)
+{
+    bool failed;
+    Error *local_err = NULL;
+
+    g_assert(!errp || !*errp);
+
+    fn(&local_err);
+    failed = !!local_err;
+    error_propagate(errp, local_err);
+
+    g_assert(!errp || (failed == !!*errp));
+}
+
+static void test_error_api(void)
+{
+    Error *err = NULL;
+
+    successfn(NULL);
+    test_propagate(successfn, NULL);
+
+    fail1(NULL);
+    test_propagate(fail1, NULL);
+
+    multifn(NULL);
+    test_propagate(multifn, NULL);
+
+    successfn(&err);
+    g_assert(!err);
+
+    test_propagate(successfn, &err);
+    g_assert(!err);
+
+    fail1(&err);
+    g_assert(err);
+    g_assert_cmpstr(error_get_pretty(err), ==, "error1");
+    error_free_or_abort(&err);
+
+    test_propagate(fail1, &err);
+    g_assert(err);
+    g_assert_cmpstr(error_get_pretty(err), ==, "error1");
+    error_free_or_abort(&err);
+
+    multifn(&err);
+    g_assert(err);
+    g_assert_cmpstr(error_get_pretty(err), ==, "error1");
+    error_free_or_abort(&err);
+
+    test_propagate(multifn, &err);
+    g_assert(err);
+    g_assert_cmpstr(error_get_pretty(err), ==, "error1");
+    error_free_or_abort(&err);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/qapi/util/qapi_enum_parse", test_qapi_enum_parse);
     g_test_add_func("/qapi/util/parse_qapi_name", test_parse_qapi_name);
+    g_test_add_func("/qapi/util/error", test_error_api);
     g_test_run();
     return 0;
 }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3dfa72..e38abfabeb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -129,7 +129,7 @@ check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
-gcov-files-test-qapi-util-y = qapi/qapi-util.c
+gcov-files-test-qapi-util-y = qapi/qapi-util.c qapi/error.c
 
 check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
-- 
2.11.0.259.g40922b1
