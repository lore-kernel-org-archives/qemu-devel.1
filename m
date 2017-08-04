Received: from eggs.gnu.org ([2001:4830:134:3::10]:60164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNb-0008Tr-W3
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNZ-00049t-Rc
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNZ-00047L-JL
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69FDF883B4
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:44 -0500
Message-Id: <20170804012551.2714-16-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 15/22] libqtest: Delete qtest_qmp() wrappers
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

None of our tests were directly using qtest_qmp() and friends;
even tests like postcopy-test.c that manage multiple connections
get along just fine changing global_qtest as needed (other than
one callsite where it forgot to use the inlined form).  It's
also annoying that we have qmp_async() but qtest_async_qmp(),
with inconsistent naming for tracing through the wrappers.

As future patches are about to add some convenience functions
for easier generation of QMP commands, it's easier if we don't
have to percolate the changes through as many layers of the stack,
by getting rid of the layer that no one uses, and just documenting
that callers have to massage the global variable as needed. (Yes,
this is backwards from good design that says all state should be
passed as parameters rather than via a global variable - but such
is life in maintaining a testsuite, where it is easier to write
concise tests than it is to retrofit all existing tests to pass
the extra parameter everywhere.)

Internally, we rename qmp_fd_sendv() to qtest_qmp_sendv(), as
well as give it a ... counterpart qmp_fd_send(), but the overall
reduction in code makes this file a bit less repetitive.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h      | 75 +++++----------------------------------------------
 tests/libqtest.c      | 71 +++++++++++++-----------------------------------
 tests/postcopy-test.c |  2 +-
 3 files changed, 25 insertions(+), 123 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 6bae0223aa..684cfb3507 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -21,6 +21,11 @@

 typedef struct QTestState QTestState;

+/*
+ * The various qmp_*() commands operate on global_qtest.  Tests can
+ * alternate between two parallel connections by switching which state
+ * is current before issuing commands.
+ */
 extern QTestState *global_qtest;

 /**
@@ -48,49 +53,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 void qtest_quit(QTestState *s);

 /**
- * qtest_qmp:
- * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- *
- * Sends a QMP message to QEMU and returns the response.
- */
-QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
-
-/**
- * qtest_async_qmp:
- * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- *
- * Sends a QMP message to QEMU and leaves the response in the stream.
- */
-void qtest_async_qmp(QTestState *s, const char *fmt, ...);
-
-/**
- * qtest_qmpv:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and returns the response.
- */
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
-
-/**
- * qtest_async_qmpv:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and leaves the response in the stream.
- */
-void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap);
-
-/**
- * qtest_receive:
+ * qtest_qmp_receive:
  * @s: #QTestState instance to operate on.
  *
  * Reads a QMP message from QEMU and returns the response.
@@ -117,32 +80,6 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);

 /**
- * qtest_hmp:
- * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
- *
- * Send HMP command to QEMU via QMP's human-monitor-command.
- * QMP events are discarded.
- *
- * Returns: the command's output.  The caller should g_free() it.
- */
-char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
-
-/**
- * qtest_hmpv:
- * @s: #QTestState instance to operate on.
- * @fmt: HMP command to send to QEMU, formats arguments like vsprintf().
- * @ap: HMP command arguments
- *
- * Send HMP command to QEMU via QMP's human-monitor-command.
- * QMP events are discarded.
- *
- * Returns: the command's output.  The caller should g_free() it.
- */
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
-    GCC_FMT_ATTR(2, 0);
-
-/**
  * qtest_get_irq:
  * @s: #QTestState instance to operate on.
  * @num: Interrupt to observe.
diff --git a/tests/libqtest.c b/tests/libqtest.c
index f9781d67f5..2df01682c0 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -233,9 +233,10 @@ QTestState *qtest_init(const char *extra_args)
     QDict *greeting;

     /* Read the QMP greeting and then do the handshake */
-    greeting = qtest_qmp_receive(s);
+    greeting = qmp_fd_receive(s->qmp_fd);
     QDECREF(greeting);
-    greeting = qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }");
+    qmp_fd_send(s->qmp_fd, "{ 'execute': 'qmp_capabilities' }");
+    greeting = qmp_fd_receive(s->qmp_fd);
     QDECREF(greeting);

     return s;
@@ -446,7 +447,7 @@ QDict *qtest_qmp_receive(QTestState *s)
  * Internal code that converts from interpolated JSON into a message
  * to send over the wire, without waiting for a reply.
  */
-static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
+static void qtest_qmp_sendv(QTestState *s, const char *fmt, va_list ap)
 {
     QObject *qobj = NULL;
     QString *qstr;
@@ -460,7 +461,7 @@ static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
      * order to escape strings properly.
      */
     if (!strchr(fmt, '%')) {
-        qmp_fd_send(fd, fmt);
+        qmp_fd_send(s->qmp_fd, fmt);
         return;
     }

@@ -469,23 +470,19 @@ static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
     str = qstring_get_str(qstr);

     /* Send QMP request */
-    qmp_fd_send(fd, str);
+    qmp_fd_send(s->qmp_fd, str);

     QDECREF(qstr);
     qobject_decref(qobj);
 }

-void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap)
+static void qtest_qmp_send(QTestState *s, const char *fmt, ...)
 {
-    qmp_fd_sendv(s->qmp_fd, fmt, ap);
-}
+    va_list ap;

-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
-{
-    qtest_async_qmpv(s, fmt, ap);
-
-    /* Receive reply */
-    return qtest_qmp_receive(s);
+    va_start(ap, fmt);
+    qtest_qmp_sendv(s, fmt, ap);
+    va_end(ap);
 }

 void qmp_fd_send(int fd, const char *msg)
@@ -499,26 +496,6 @@ void qmp_fd_send(int fd, const char *msg)
     socket_send(fd, msg, strlen(msg));
 }

-QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *response;
-
-    va_start(ap, fmt);
-    response = qtest_qmpv(s, fmt, ap);
-    va_end(ap);
-    return response;
-}
-
-void qtest_async_qmp(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    qtest_async_qmpv(s, fmt, ap);
-    va_end(ap);
-}
-
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
 {
     QDict *response;
@@ -541,16 +518,16 @@ void qtest_qmp_eventwait(QTestState *s, const char *event)
     QDECREF(response);
 }

-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+static char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
 {
     char *cmd;
     QDict *resp;
     char *ret;

     cmd = g_strdup_vprintf(fmt, ap);
-    resp = qtest_qmp(s, "{'execute': 'human-monitor-command',"
-                     " 'arguments': {'command-line': %s}}",
-                     cmd);
+    qtest_qmp_send(s, "{'execute': 'human-monitor-command',"
+                   " 'arguments': {'command-line': %s}}", cmd);
+    resp = qtest_qmp_receive(s);
     ret = g_strdup(qdict_get_try_str(resp, "return"));
     while (ret == NULL && qdict_get_try_str(resp, "event")) {
         /* Ignore asynchronous QMP events */
@@ -564,17 +541,6 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
     return ret;
 }

-char *qtest_hmp(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-    char *ret;
-
-    va_start(ap, fmt);
-    ret = qtest_hmpv(s, fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
 const char *qtest_get_arch(void)
 {
     const char *qemu = getenv("QTEST_QEMU_BINARY");
@@ -870,12 +836,11 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
 QDict *qmp(const char *fmt, ...)
 {
     va_list ap;
-    QDict *response;

     va_start(ap, fmt);
-    response = qtest_qmpv(global_qtest, fmt, ap);
+    qtest_qmp_sendv(global_qtest, fmt, ap);
     va_end(ap);
-    return response;
+    return qtest_qmp_receive(global_qtest);
 }

 QDict *qmp_raw(const char *msg)
@@ -889,7 +854,7 @@ void qmp_async(const char *fmt, ...)
     va_list ap;

     va_start(ap, fmt);
-    qtest_async_qmpv(global_qtest, fmt, ap);
+    qtest_qmp_sendv(global_qtest, fmt, ap);
     va_end(ap);
 }

diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index ceaed823eb..61f4b4180a 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -236,7 +236,7 @@ static QDict *return_or_event(QDict *response)
         got_stop = true;
     }
     QDECREF(response);
-    return return_or_event(qtest_qmp_receive(global_qtest));
+    return return_or_event(qmp_receive());
 }


-- 
2.13.3
