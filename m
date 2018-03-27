Received: from eggs.gnu.org ([2001:4830:134:3::10]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0dZO-0005pG-Cg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0dZM-0007kM-J7
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:38:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58806 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0dZM-0007kG-De
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 21:38:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 26 Mar 2018 20:36:20 -0500
Message-Id: <20180327013620.1644387-5-eblake@redhat.com>
In-Reply-To: <20180327013620.1644387-1-eblake@redhat.com>
References: <20180327013620.1644387-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] tests: qmp-test: add test for new
 "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, marcandre.lureau@redhat.com, borntraeger@de.ibm.com, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

Test the new OOB capability. It's mostly the reverted OOB test
(see commit 4fd78ad7), but differs in that:

- It uses the new qtest_init_without_qmp_handshake() parameter to
  create the monitor with "x-oob"
- Squashed the capability tests on greeting message
- Don't use qtest_global any more, instead use self-maintained
  QTestState, which is the trend

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180326063901.27425-9-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: rebase to qtest_init changes]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 2134d95db97..772058fc4c4 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -135,6 +135,87 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }

+/* Tests for Out-Of-Band support. */
+static void test_qmp_oob(void)
+{
+    QTestState *qts;
+    QDict *resp, *q;
+    int acks = 0;
+    const QListEntry *entry;
+    QList *capabilities;
+    QString *qstr;
+    const char *cmd_id;
+
+    qts = qtest_init_without_qmp_handshake(true, common_args);
+
+    /* Check the greeting message. */
+    resp = qtest_qmp_receive(qts);
+    q = qdict_get_qdict(resp, "QMP");
+    g_assert(q);
+    capabilities = qdict_get_qlist(q, "capabilities");
+    g_assert(capabilities && !qlist_empty(capabilities));
+    entry = qlist_first(capabilities);
+    g_assert(entry);
+    qstr = qobject_to(QString, entry->value);
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), ==, "oob");
+    QDECREF(resp);
+
+    /* Try a fake capability, it should fail. */
+    resp = qtest_qmp(qts,
+                     "{ 'execute': 'qmp_capabilities', "
+                     "  'arguments': { 'enable': [ 'cap-does-not-exist' ] } }");
+    g_assert(qdict_haskey(resp, "error"));
+    QDECREF(resp);
+
+    /* Now, enable OOB in current QMP session, it should succeed. */
+    resp = qtest_qmp(qts,
+                     "{ 'execute': 'qmp_capabilities', "
+                     "  'arguments': { 'enable': [ 'oob' ] } }");
+    g_assert(qdict_haskey(resp, "return"));
+    QDECREF(resp);
+
+    /*
+     * Try any command that does not support OOB but with OOB flag. We
+     * should get failure.
+     */
+    resp = qtest_qmp(qts,
+                     "{ 'execute': 'query-cpus',"
+                     "  'control': { 'run-oob': true } }");
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
+    qtest_async_qmp(qts,
+                    "{ 'execute': 'x-oob-test',"
+                    "  'arguments': { 'lock': true }, "
+                    "  'id': 'lock-cmd'}");
+    qtest_async_qmp(qts,
+                    "{ 'execute': 'x-oob-test', "
+                    "  'arguments': { 'lock': false }, "
+                    "  'control': { 'run-oob': true }, "
+                    "  'id': 'unlock-cmd' }");
+
+    /* Ignore all events.  Wait for 2 acks */
+    while (acks < 2) {
+        resp = qtest_qmp_receive(qts);
+        cmd_id = qdict_get_str(resp, "id");
+        if (!g_strcmp0(cmd_id, "lock-cmd") ||
+            !g_strcmp0(cmd_id, "unlock-cmd")) {
+            acks++;
+        }
+        QDECREF(resp);
+    }
+
+    qtest_quit(qts);
+}
+
 static int query_error_class(const char *cmd)
 {
     static struct {
@@ -319,6 +400,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);

     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);

-- 
2.14.3
