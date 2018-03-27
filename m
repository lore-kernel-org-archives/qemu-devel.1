Received: from eggs.gnu.org ([2001:4830:134:3::10]:49306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcR-0007Xk-JE
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcO-000507-Na
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcO-0004zt-Dv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 151FD818B11B
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:30:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:13 -0500
Message-Id: <20180327143014.1767669-14-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/14] tests: qmp-test: add test for new "x-oob"
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
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
+    int acks =3D 0;
+    const QListEntry *entry;
+    QList *capabilities;
+    QString *qstr;
+    const char *cmd_id;
+
+    qts =3D qtest_init_without_qmp_handshake(true, common_args);
+
+    /* Check the greeting message. */
+    resp =3D qtest_qmp_receive(qts);
+    q =3D qdict_get_qdict(resp, "QMP");
+    g_assert(q);
+    capabilities =3D qdict_get_qlist(q, "capabilities");
+    g_assert(capabilities && !qlist_empty(capabilities));
+    entry =3D qlist_first(capabilities);
+    g_assert(entry);
+    qstr =3D qobject_to(QString, entry->value);
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "oob");
+    QDECREF(resp);
+
+    /* Try a fake capability, it should fail. */
+    resp =3D qtest_qmp(qts,
+                     "{ 'execute': 'qmp_capabilities', "
+                     "  'arguments': { 'enable': [ 'cap-does-not-exist' =
] } }");
+    g_assert(qdict_haskey(resp, "error"));
+    QDECREF(resp);
+
+    /* Now, enable OOB in current QMP session, it should succeed. */
+    resp =3D qtest_qmp(qts,
+                     "{ 'execute': 'qmp_capabilities', "
+                     "  'arguments': { 'enable': [ 'oob' ] } }");
+    g_assert(qdict_haskey(resp, "return"));
+    QDECREF(resp);
+
+    /*
+     * Try any command that does not support OOB but with OOB flag. We
+     * should get failure.
+     */
+    resp =3D qtest_qmp(qts,
+                     "{ 'execute': 'query-cpus',"
+                     "  'control': { 'run-oob': true } }");
+    g_assert(qdict_haskey(resp, "error"));
+    QDECREF(resp);
+
+    /*
+     * First send the "x-oob-test" command with lock=3Dtrue and
+     * oob=3Dfalse, it should hang the dispatcher and main thread;
+     * later, we send another lock=3Dfalse with oob=3Dtrue to continue
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
+        resp =3D qtest_qmp_receive(qts);
+        cmd_id =3D qdict_get_str(resp, "id");
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

--=20
2.14.3
