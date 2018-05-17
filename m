Received: from eggs.gnu.org ([2001:4830:134:3::10]:40648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fJH6D-0003ED-Af
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fJH6A-000350-2R
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:29:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fJH69-00034S-T7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 07:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FAE7805A532
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 11:29:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 17 May 2018 13:28:44 +0200
Message-Id: <1526556524-267991-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <7f80806c-3685-f679-c5af-1ca7a9b0052b@redhat.com>
References: <7f80806c-3685-f679-c5af-1ca7a9b0052b@redhat.com>
Subject: [Qemu-devel] [PATCH v8 08/11] tests: extend qmp test with preconfig
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, eblake@redhat.com

Add permission checks for commands at 'preconfig' stage.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v8:
  * there isn't QDECREF anymore use qobject_unref instead
  * add negative test for exit-preconfig
v6:
  * replace 'cont' with 'exit-preconfig' command
v5:
  * s/-preconfig/--preconfig/
v4:
  * s/is_err()/qmp_rsp_is_err()/
  * return true even if 'error' doesn't contain 'desc'
    (Eric Blake <eblake@redhat.com>)
---
 tests/qmp-test.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 88f867f..2ee441c 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -392,6 +392,52 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
+static bool qmp_rsp_is_err(QDict *rsp)
+{
+    QDict *error = qdict_get_qdict(rsp, "error");
+    qobject_unref(rsp);
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
+    qobject_unref(rsp);
+
+    /* exit preconfig state */
+    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    /* check that query-status returns running state */
+    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
+    ret = qdict_get_qdict(rsp, "return");
+    g_assert(ret);
+    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "running");
+    qobject_unref(rsp);
+
+    /* check that exit-preconfig returns error after exiting preconfig */
+    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'exit-preconfig' }")));
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
@@ -403,6 +449,7 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
+    qtest_add_func("qmp/preconfig", test_qmp_preconfig);
 
     ret = g_test_run();
 
-- 
2.7.4
