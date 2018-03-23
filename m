Received: from eggs.gnu.org ([2001:4830:134:3::10]:58637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNd-0007OB-A6
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNY-0005DM-Uc
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezNNY-0005D2-PL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:12 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Mar 2018 22:08:19 +0800
Message-Id: <20180323140821.28957-3-peterx@redhat.com>
In-Reply-To: <20180323140821.28957-1-peterx@redhat.com>
References: <20180323140821.28957-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 2/4] Revert "tests: qmp-test: add oob
 test"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This reverts commit d003f7a8f9cafe50119975844fa01afc2baf41fb.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 65 --------------------------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 07c0b87e27..2e4b599a4c 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -164,70 +164,6 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
-/* Tests for Out-Of-Band support. */
-static void test_qmp_oob(void)
-{
-    QDict *resp;
-    int acks = 0;
-    const char *cmd_id;
-
-    global_qtest = qtest_init_without_qmp_handshake(common_args);
-
-    /* Ignore the greeting message. */
-    resp = qmp_receive();
-    g_assert(qdict_get_qdict(resp, "QMP"));
-    QDECREF(resp);
-
-    /* Try a fake capability, it should fail. */
-    resp = qmp("{ 'execute': 'qmp_capabilities', "
-               "  'arguments': { 'enable': [ 'cap-does-not-exist' ] } }");
-    g_assert(qdict_haskey(resp, "error"));
-    QDECREF(resp);
-
-    /* Now, enable OOB in current QMP session, it should succeed. */
-    resp = qmp("{ 'execute': 'qmp_capabilities', "
-               "  'arguments': { 'enable': [ 'oob' ] } }");
-    g_assert(qdict_haskey(resp, "return"));
-    QDECREF(resp);
-
-    /*
-     * Try any command that does not support OOB but with OOB flag. We
-     * should get failure.
-     */
-    resp = qmp("{ 'execute': 'query-cpus',"
-               "  'control': { 'run-oob': true } }");
-    g_assert(qdict_haskey(resp, "error"));
-    QDECREF(resp);
-
-    /*
-     * First send the "x-oob-test" command with lock=true and
-     * oob=false, it should hang the dispatcher and main thread;
-     * later, we send another lock=false with oob=true to continue
-     * that thread processing.  Finally we should receive replies from
-     * both commands.
-     */
-    qmp_async("{ 'execute': 'x-oob-test',"
-              "  'arguments': { 'lock': true }, "
-              "  'id': 'lock-cmd'}");
-    qmp_async("{ 'execute': 'x-oob-test', "
-              "  'arguments': { 'lock': false }, "
-              "  'control': { 'run-oob': true }, "
-              "  'id': 'unlock-cmd' }");
-
-    /* Ignore all events.  Wait for 2 acks */
-    while (acks < 2) {
-        resp = qmp_receive();
-        cmd_id = qdict_get_str(resp, "id");
-        if (!g_strcmp0(cmd_id, "lock-cmd") ||
-            !g_strcmp0(cmd_id, "unlock-cmd")) {
-            acks++;
-        }
-        QDECREF(resp);
-    }
-
-    qtest_end();
-}
-
 static int query_error_class(const char *cmd)
 {
     static struct {
@@ -412,7 +348,6 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("qmp/protocol", test_qmp_protocol);
-    qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
 
-- 
2.14.3
