Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Ln6-0002NZ-NZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Ln3-0006nD-UT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Ln3-0006n3-Q9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66C8D402B023
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:39:01 +0800
Message-Id: <20180326063901.27425-9-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 8/8] tests: qmp-test: add test for new
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
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Test the new OOB capability. It's mostly the reverted OOB test, but
differs in that:

- It uses the new qtest_init_with_qmp_format() to create the monitor
  with the new monitor parameter "-mon x-oob"
- Squashed the capability tests on greeting message
- Don't use qtest_global any more, instead use self-maintained
  QTestState, which is the trend

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 558e83540c..4d15b0fca5 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -134,6 +134,89 @@ static void test_qmp_protocol(void)
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
+    const char *qmp_params = "-chardev socket,path=%s,nowait,id=char0 "
+                             "-mon chardev=char0,mode=control,x-oob=on";
+
+    qts = qtest_init_with_qmp_format(common_args, qmp_params);
+
+    /* Ignore the greeting message. */
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
@@ -318,6 +401,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
 
-- 
2.14.3
