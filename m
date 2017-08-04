Received: from eggs.gnu.org ([2001:4830:134:3::10]:59972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNV-0008Ot-UV
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNU-0003yX-Bd
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNU-0003xJ-2e
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A703D4DD49
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:42 -0500
Message-Id: <20170804012551.2714-14-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 13/22] libqtest: Add qmp_raw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

The majority of calls into libqtest's qmp() and friends are passing
a JSON object that includes a command name; we can prove this by
adding an assertion.  The only outlier is qmp-test, which is testing
appropriate error responses to protocol violations and id support,
by sending raw strings, where those raw strings don't need
interpolation anyways.

Adding a new entry-point makes a clean separation of which input
needs interpolation, so that upcoming patches can refactor qmp()
to be more like the recent additions to test-qga in taking the
command name separately from the arguments for an overall
reduction in testsuite boilerplate.

This change also lets us move the workaround for the QMP parser
limitation of not ending a parse until } or newline: all calls
through qmp() are passing an object ending in }, so only the
few callers of qmp_raw() have to worry about a trailing newline.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h |  8 ++++++++
 tests/libqtest.c | 13 +++++++------
 tests/qmp-test.c | 19 ++++++++++++-------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 33af3ae8ff..917ec5cf92 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -550,6 +550,14 @@ static inline void qtest_end(void)
 QDict *qmp(const char *fmt, ...);

 /**
+ * qmp_raw:
+ * @msg: Raw QMP message to send to qemu.
+ *
+ * Sends a QMP message to QEMU and returns the response.
+ */
+QDict *qmp_raw(const char *msg);
+
+/**
  * qmp_async:
  * @fmt...: QMP message to send to qemu; formats arguments through
  * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0fa32928c8..3071be2efb 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -451,7 +451,7 @@ static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
     QString *qstr;
     const char *str;

-    assert(*fmt);
+    assert(strstr(fmt, "execute"));

     /*
      * A round trip through QObject is only needed if % interpolation
@@ -496,11 +496,6 @@ void qmp_fd_send(int fd, const char *msg)
     }
     /* Send QMP request */
     socket_send(fd, msg, strlen(msg));
-    /*
-     * BUG: QMP doesn't react to input until it sees a newline, an
-     * object, or an array.  Work-around: give it a newline.
-     */
-    socket_send(fd, "\n", 1);
 }

 QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
@@ -899,6 +894,12 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }

+QDict *qmp_raw(const char *msg)
+{
+    qmp_fd_send(global_qtest->qmp_fd, msg);
+    return qtest_qmp_receive(global_qtest);
+}
+
 void qmp_async(const char *fmt, ...)
 {
     va_list ap;
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5d0260b2be..905fb4b3e5 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -44,28 +44,33 @@ static void test_malformed(void)
 {
     QDict *resp;

+    /*
+     * BUG: QMP doesn't react to input until it sees a newline, an
+     * object, or an array.  Work-around: give it a newline.
+     */
+
     /* Not even a dictionary */
-    resp = qmp("null");
+    resp = qmp_raw("null\n");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* No "execute" key */
-    resp = qmp("{}");
+    resp = qmp_raw("{}");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* "execute" isn't a string */
-    resp = qmp("{ 'execute': true }");
+    resp = qmp_raw("{ 'execute': true }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* "arguments" isn't a dictionary */
-    resp = qmp("{ 'execute': 'no-such-cmd', 'arguments': [] }");
+    resp = qmp_raw("{ 'execute': 'no-such-cmd', 'arguments': [] }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);

     /* extra key */
-    resp = qmp("{ 'execute': 'no-such-cmd', 'extra': true }");
+    resp = qmp_raw("{ 'execute': 'no-such-cmd', 'extra': true }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     QDECREF(resp);
 }
@@ -114,14 +119,14 @@ static void test_qmp_protocol(void)
     test_malformed();

     /* Test 'id' */
-    resp = qmp("{ 'execute': 'query-name', 'id': 'cookie#1' }");
+    resp = qmp_raw("{ 'execute': 'query-name', 'id': 'cookie#1' }");
     ret = qdict_get_qdict(resp, "return");
     g_assert(ret);
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
     QDECREF(resp);

     /* Test command failure with 'id' */
-    resp = qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
+    resp = qmp_raw("{ 'execute': 'human-monitor-command', 'id': 2 }");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
     QDECREF(resp);
-- 
2.13.3
