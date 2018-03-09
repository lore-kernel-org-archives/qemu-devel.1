Received: from eggs.gnu.org ([2001:4830:134:3::10]:42066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDv5-0000cH-La
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDuz-0000PF-NH
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDuz-0000P5-HO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:25 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 17:00:06 +0800
Message-Id: <20180309090006.10018-24-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 23/23] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Test the new OOB capability.  Here we used the new "x-oob-test" command.
Firstly, we send a lock=true and oob=false command to hang the main
thread.  Then send another lock=false and oob=true command (which will
be run inside parser this time) to free that hanged command.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index caf3ec4a78..4c591cbc80 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -164,6 +164,70 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
+/* Tests for Out-Of-Band support. */
+static void test_qmp_oob(void)
+{
+    QDict *resp;
+    int acks = 0;
+    const char *cmd_id;
+
+    global_qtest = qtest_init_without_qmp_handshake(common_args);
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
+    QDECREF(resp);
+
+    /* Now, enable OOB in current QMP session, it should success. */
+    resp = qmp("{ 'execute': 'qmp_capabilities', "
+               "  'arguments': { 'enable': [ 'oob' ] } }");
+    g_assert(qdict_haskey(resp, "return"));
+    QDECREF(resp);
+
+    /*
+     * Try any command that does not support OOB but with OOB flag. We
+     * should get failure.
+     */
+    resp = qmp("{ 'execute': 'query-cpus',"
+               "  'control': { 'run-oob': true } }");
+    g_assert(qdict_haskey(resp, "error"));
+    QDECREF(resp);
+
+    /*
+     * Firstly send the "x-oob-test" command with lock=true and
+     * oob=false, it should hang the dispatcher and main thread;
+     * later, we send another lock=false with oob=true to continue
+     * that thread processing.  Finally we should receive replies from
+     * both commands.
+     */
+    qmp_async("{ 'execute': 'x-oob-test',"
+              "  'arguments': { 'lock': true }, "
+              "  'id': 'lock-cmd'}");
+    qmp_async("{ 'execute': 'x-oob-test', "
+              "  'arguments': { 'lock': false }, "
+              "  'control': { 'run-oob': true }, "
+              "  'id': 'unlock-cmd' }");
+
+    /* Ignore all events.  Wait for 2 acks */
+    while (acks < 2) {
+        resp = qmp_receive();
+        cmd_id = qdict_get_str(resp, "id");
+        if (!g_strcmp0(cmd_id, "lock-cmd") ||
+            !g_strcmp0(cmd_id, "unlock-cmd")) {
+            acks++;
+        }
+        QDECREF(resp);
+    }
+
+    qtest_end();
+}
+
 static int query_error_class(const char *cmd)
 {
     static struct {
@@ -343,6 +407,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
 
-- 
2.14.3
