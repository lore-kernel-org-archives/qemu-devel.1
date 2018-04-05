Received: from eggs.gnu.org ([2001:4830:134:3::10]:59144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qp-0000oe-7d
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40ql-0006X0-DC
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f40ql-0006Wp-9M
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E917B722EA
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 09:06:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Apr 2018 11:05:10 +0200
Message-Id: <1522919113-158775-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
References: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v5 08/11] tests: extend qmp test with
 preconfig checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

Add permission checks for commands at 'preconfig' stage.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v5:
  * s/-preconfig/--preconfig/
v4:
  * s/is_err()/qmp_rsp_is_err()/
  * return true even if 'error' doesn't contain 'desc'
    (Eric Blake <eblake@redhat.com>)
---
 tests/qmp-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 772058f..8bba913 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -392,6 +392,49 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
+static bool qmp_rsp_is_err(QDict *rsp)
+{
+    QDict *error = qdict_get_qdict(rsp, "error");
+    QDECREF(rsp);
+    return !!error;
+}
+
+static void test_qmp_preconfig(void)
+{
+    QDict *rsp, *ret;
+    QTestState *qs = qtest_startf("%s --preconfig", common_args);
+
+    /* preconfig state */
+    /* enabled commands, no error expected  */
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-commands' }")));
+
+    /* forbidden commands, expected error */
+    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
+
+    /* check that query-status returns preconfig state */
+    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
+    ret = qdict_get_qdict(rsp, "return");
+    g_assert(ret);
+    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "preconfig");
+    QDECREF(rsp);
+
+    /* exit preconfig state */
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'cont' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    /* check that query-status returns running state */
+    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
+    ret = qdict_get_qdict(rsp, "return");
+    g_assert(ret);
+    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "running");
+    QDECREF(rsp);
+
+    /* enabled commands, no error expected  */
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
+
+    qtest_quit(qs);
+}
+
 int main(int argc, char *argv[])
 {
     QmpSchema schema;
@@ -403,6 +446,7 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
+    qtest_add_func("qmp/preconfig", test_qmp_preconfig);
 
     ret = g_test_run();
 
-- 
2.7.4
