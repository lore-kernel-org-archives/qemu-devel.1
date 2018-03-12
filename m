Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFu-0007K5-5Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1evNFq-0005Rj-6h
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1evNFq-0005Qa-1s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:42 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 12 Mar 2018 14:11:12 +0100
Message-Id: <1520860275-101576-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v4 6/9] tests: extend qmp test with preconfig
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
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

Add permission checks for commands at 'preconfig' stage.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
  * s/is_err()/qmp_rsp_is_err()/
  * return true even if 'error' doesn't contain 'desc'
    (Eric Blake <eblake@redhat.com>)
---
 tests/qmp-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 22445d9..cff880f 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -305,6 +305,49 @@ static void add_query_tests(QmpSchema *schema)
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
+    QTestState *qs = qtest_startf("%s -preconfig", common_args);
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
@@ -315,6 +358,7 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
+    qtest_add_func("qmp/preconfig", test_qmp_preconfig);
 
     ret = g_test_run();
 
-- 
2.7.4
