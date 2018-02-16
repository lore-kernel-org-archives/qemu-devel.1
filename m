Received: from eggs.gnu.org ([2001:4830:134:3::10]:44369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI6-0004SQ-7M
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1emfI3-0003af-5C
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:39:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1emfI3-0003aV-16
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:38:59 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 16 Feb 2018 13:37:18 +0100
Message-Id: <1518784641-43151-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/9] tests: extend qmp test with pereconfig
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

Add permission checks for commands in 'preconfig' state.

It should work for all targets, but won't work with
machine 'none' as it's limited to -smp 1 only.
So use PC machine for testing preconfig and 'runstate'
parameter.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qmp-test.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5808483..3adc485 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -304,8 +304,54 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
+static bool is_err(QDict *rsp)
+{
+    const char *desc = NULL;
+    QDict *error = qdict_get_qdict(rsp, "error");
+    if (error) {
+        desc = qdict_get_try_str(error, "desc");
+    }
+    QDECREF(rsp);
+    return !!desc;
+}
+
+static void test_qmp_preconfig(void)
+{
+    QDict *rsp, *ret;
+    QTestState *qs = qtest_startf("-nodefaults -preconfig -smp 2");
+
+    /* preconfig state */
+    /* enabled commands, no error expected  */
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-commands' }")));
+
+    /* forbidden commands, expected error */
+    g_assert(is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
+
+    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
+    ret = qdict_get_qdict(rsp, "return");
+    g_assert(ret);
+    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "preconfig");
+    QDECREF(rsp);
+
+    /* exit preconfig state */
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'cont' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    rsp = qtest_qmp(qs, "{ 'execute': 'query-status' }");
+    ret = qdict_get_qdict(rsp, "return");
+    g_assert(ret);
+    g_assert_cmpstr(qdict_get_try_str(ret, "status"), ==, "running");
+    QDECREF(rsp);
+
+    /* enabled commands, no error expected  */
+    g_assert(!is_err(qtest_qmp(qs, "{ 'execute': 'query-cpus' }")));
+
+    qtest_quit(qs);
+}
+
 int main(int argc, char *argv[])
 {
+    const char *arch = qtest_get_arch();
     QmpSchema schema;
     int ret;
 
@@ -314,6 +360,9 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
+    if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
+        qtest_add_func("qmp/preconfig", test_qmp_preconfig);
+    }
 
     ret = g_test_run();
 
-- 
2.7.4
