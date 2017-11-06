Received: from eggs.gnu.org ([2001:4830:134:3::10]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe4P-0007K8-Mw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe4K-0005mQ-Mj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe4K-0005m6-E7
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:51:48 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:43 +0800
Message-Id: <20171106094643.14881-28-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 27/27] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Test the new OOB capability.  Here we used the "dump-guest-memory"
command to hang the thread a bit to test working of OOB preemption.
Note that currently it is only running for x86/arm/ppc/s390x.

Note that for some platforms we may need to specify "-cpu" to make sure
the dump-guest-memory commands can really work.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 729ec59b0a..7c1b9f9b9e 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -157,6 +157,98 @@ static void test_qmp_protocol(void)
     qtest_end();
 }
 
+/* Tests for Out-Of-Band support. */
+static void test_qmp_oob(void)
+{
+    QDict *resp;
+    int acks = 0;
+    char *qtest_params;
+    const char *cmd_id, *extra_params;
+    const char *arch = qtest_get_arch();
+
+    /*
+     * Some archs need to specify cpu to make sure dump-guest-memory
+     * can work.  I chose CPU type randomly.
+     */
+    if (g_strcmp0(arch, "aarch64") == 0) {
+        extra_params = "-cpu cortex-a57";
+    } else if (g_strcmp0(arch, "ppc64") == 0) {
+        extra_params = "-cpu power8";
+    } else {
+        extra_params = "";
+    }
+
+    /*
+     * Let's have some memory to make sure dump-guest-memory will be
+     * time consuming.  That is required to test OOB functionaility.
+     */
+    qtest_params = g_strdup_printf("-nodefaults -machine none -m 1G %s",
+                                   extra_params);
+    global_qtest = qtest_init_without_qmp_handshake(qtest_params);
+    g_free(qtest_params);
+
+    /* Ignore the greeting message. */
+    resp = qmp_receive();
+    g_assert(qdict_get_qdict(resp, "QMP"));
+    QDECREF(resp);
+
+    /* Try a fake capability, it should fail. */
+    resp = qmp("{ 'execute': 'qmp_capabilities', "
+               "  'arguments': { 'enable': [ 'cap-does-not-exist' ] } }");
+    g_assert(qdict_haskey(resp, "error"));
+
+    /* Now, enable OOB in current QMP session, it should success. */
+    resp = qmp("{ 'execute': 'qmp_capabilities', "
+               "  'arguments': { 'enable': [ 'oob' ] } }");
+    g_assert(qdict_haskey(resp, "return"));
+
+    /*
+     * Try any command that does not support OOB but with OOB flag. We
+     * should get failure.
+     */
+    resp = qmp("{ 'execute': 'query-cpus',"
+               "  'control': { 'run-oob': true } }");
+    g_assert(qdict_haskey(resp, "error"));
+
+    /*
+     * Try a time-consuming command, following by a OOB command, make
+     * sure we get OOB command before the time-consuming one (which is
+     * run in the parser).
+     *
+     * When writting up this test script, the only command that
+     * support OOB is migrate-incoming.  It's not the best command to
+     * test OOB but we don't really have a choice here.  We will check
+     * arriving order but not command errors, which does not really
+     * matter to us.
+     */
+    qmp_async("{ 'execute': 'dump-guest-memory',"
+              "  'arguments': { 'paging': true, "
+              "                 'protocol': 'file:/dev/null' }, "
+              "  'id': 'time-consuming-cmd'}");
+    qmp_async("{ 'execute': 'migrate-incoming', "
+              "  'control': { 'run-oob': true }, "
+              "  'id': 'oob-cmd' }");
+
+    /* Ignore all events.  Wait for 2 acks */
+    while (acks < 2) {
+        resp = qmp_receive();
+        if (qdict_haskey(resp, "event")) {
+            /* Skip possible events */
+            continue;
+        }
+        cmd_id = qdict_get_str(resp, "id");
+        if (acks == 0) {
+            /* Need to receive OOB response first */
+            g_assert_cmpstr(cmd_id, ==, "oob-cmd");
+        } else if (acks == 1) {
+            g_assert_cmpstr(cmd_id, ==, "time-consuming-cmd");
+        }
+        acks++;
+    }
+
+    qtest_end();
+}
+
 static int query_error_class(const char *cmd)
 {
     static struct {
@@ -335,6 +427,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
 
-- 
2.13.5
