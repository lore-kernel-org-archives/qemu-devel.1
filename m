Received: from eggs.gnu.org ([2001:4830:134:3::10]:56146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIo-0007RK-OH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIj-0001t7-SQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIj-0001sP-KJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B600281E19
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:04:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:32 -0500
Message-Id: <20170901180340.30009-22-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 21/29] qmp-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

As a general rule, we prefer avoiding implicit global state
because it makes code harder to safely copy and paste without
thinking about the global state.  Although qmp-test does not
maintain parallel qtest connections, it was the last test
assigning to global_qtest.  It's just as easy to be explicit
about the state; once all tests have been cleaned up, a later
patch can then get rid of global_qtest and a layer of wrappers
in libqtest.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qmp-test.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5d0260b2be..cf523b325e 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -40,32 +40,32 @@ static void test_version(QObject *version)
     visit_free(v);
 }

-static void test_malformed(void)
+static void test_malformed(QTestState *qts)
 {
     QDict *resp;

     /* Not even a dictionary */
-    resp = qmp("null");
+    resp = qtest_qmp(qts, "null");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* No "execute" key */
-    resp = qmp("{}");
+    resp = qtest_qmp(qts, "{}");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* "execute" isn't a string */
-    resp = qmp("{ 'execute': true }");
+    resp = qtest_qmp(qts, "{ 'execute': true }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* "arguments" isn't a dictionary */
-    resp = qmp("{ 'execute': 'no-such-cmd', 'arguments': [] }");
+    resp = qtest_qmp(qts, "{ 'execute': 'no-such-cmd', 'arguments': [] }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* extra key */
-    resp = qmp("{ 'execute': 'no-such-cmd', 'extra': true }");
+    resp = qtest_qmp(qts, "{ 'execute': 'no-such-cmd', 'extra': true }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);
 }
@@ -74,11 +74,12 @@ static void test_qmp_protocol(void)
 {
     QDict *resp, *q, *ret;
     QList *capabilities;
+    QTestState *qts;

-    global_qtest = qtest_init_without_qmp_handshake(common_args);
+    qts = qtest_init_without_qmp_handshake(common_args);

     /* Test greeting */
-    resp = qmp_receive();
+    resp = qtest_qmp_receive(qts);
     q = qdict_get_qdict(resp, "QMP");
     g_assert(q);
     test_version(qdict_get(q, "version"));
@@ -87,46 +88,46 @@ static void test_qmp_protocol(void)
     QDECREF(resp);

     /* Test valid command before handshake */
-    resp = qmp("{ 'execute': 'query-version' }");
+    resp = qtest_qmp(qts, "{ 'execute': 'query-version' }");
     g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
     QDECREF(resp);

     /* Test malformed commands before handshake */
-    test_malformed();
+    test_malformed(qts);

     /* Test handshake */
-    resp = qmp("{ 'execute': 'qmp_capabilities' }");
+    resp = qtest_qmp(qts, "{ 'execute': 'qmp_capabilities' }");
     ret = qdict_get_qdict(resp, "return");
     g_assert(ret && !qdict_size(ret));
     QDECREF(resp);

     /* Test repeated handshake */
-    resp = qmp("{ 'execute': 'qmp_capabilities' }");
+    resp = qtest_qmp(qts, "{ 'execute': 'qmp_capabilities' }");
     g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
     QDECREF(resp);

     /* Test valid command */
-    resp = qmp("{ 'execute': 'query-version' }");
+    resp = qtest_qmp(qts, "{ 'execute': 'query-version' }");
     test_version(qdict_get(resp, "return"));
     QDECREF(resp);

     /* Test malformed commands */
-    test_malformed();
+    test_malformed(qts);

     /* Test 'id' */
-    resp = qmp("{ 'execute': 'query-name', 'id': 'cookie#1' }");
+    resp = qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 'cookie#1' }");
     ret = qdict_get_qdict(resp, "return");
     g_assert(ret);
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
     QDECREF(resp);

     /* Test command failure with 'id' */
-    resp = qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
+    resp = qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id': 2 }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
     QDECREF(resp);

-    qtest_end();
+    qtest_quit(qts);
 }

 int main(int argc, char *argv[])
-- 
2.13.5
