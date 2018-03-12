Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJf-0000ws-Tl
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJe-00066W-Si
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJe-00066J-Nx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 550D14000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:25 -0500
Message-Id: <20180312183628.394722-35-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 34/36] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

Test the new OOB capability.  Here we used the new "x-oob-test" command.
First, we send a lock=true and oob=false command to hang the main
thread.  Then send another lock=false and oob=true command (which will
be run inside parser this time) to free that hanged command.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-24-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: grammar tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index fd4033a13fd..17cf4ccf4c9 100644
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
+    /* Now, enable OOB in current QMP session, it should succeed. */
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
+     * First send the "x-oob-test" command with lock=true and
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
