Received: from eggs.gnu.org ([2001:4830:134:3::10]:46219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA9-0004gH-Du
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOAA8-00008l-G3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOAA8-00007d-AQ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:25 -0300
Message-Id: <20180530230528.30166-10-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] tests: extend qmp test with preconfig
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Add permission checks for commands at 'preconfig' stage.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1526556524-267991-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/qmp-test.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 88f867f8c0..2ee441cdb3 100644
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
2.17.1
