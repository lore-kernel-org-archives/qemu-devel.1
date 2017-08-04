Received: from eggs.gnu.org ([2001:4830:134:3::10]:60447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNl-00007g-9Z
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNk-0004Yv-78
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNj-0004WO-Ur
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6C0361474
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:50 -0500
Message-Id: <20170804012551.2714-22-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 21/22] libqtest: Drop now-unused qmp()
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

All callers have been converted to a form of qmp_cmd() or
qmp_args() that takes the command name with less boilerplate.
Therefore, we also know that all commands are using
interpolation, and can remove an assertion.

This also means that we have fixed the testsuite to comply with
-Wformat checking on the strings being interpolated for qmp()
(similar to what we previously did for strings used in hmp(), and
matching the checking present on qobject_from_jsonf()).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 20 +-------------------
 tests/libqtest.c | 32 ++++----------------------------
 2 files changed, 5 insertions(+), 47 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 193adf1eb9..04b36a7b11 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -457,15 +457,6 @@ static inline void qtest_end(void)
 }

 /**
- * qmp:
- * @fmt...: QMP message to send to qemu; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- *
- * Sends a QMP message to QEMU and returns the response.
- */
-QDict *qmp(const char *fmt, ...);
-
-/**
  * qmp_raw:
  * @msg: Raw QMP message to send to qemu.
  *
@@ -474,15 +465,6 @@ QDict *qmp(const char *fmt, ...);
 QDict *qmp_raw(const char *msg);

 /**
- * qmp_async:
- * @fmt...: QMP message to send to qemu; formats arguments through
- * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
- *
- * Sends a QMP message to QEMU and leaves the response in the stream.
- */
-void qmp_async(const char *fmt, ...);
-
-/**
  * qmp_cmd:
  * @cmd: QMP command, with no arguments.
  *
@@ -530,7 +512,7 @@ void qmp_args_async(const char *cmd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 /**
  * qmp_discard_response:
  *
- * Read and discard a QMP response, typically after qmp_async().
+ * Read and discard a QMP response, typically after qmp_cmd_async().
  */
 void qmp_discard_response(void);

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 5012ecf929..4597d4ac66 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -453,17 +453,12 @@ static void qtest_qmp_sendv(QTestState *s, const char *fmt, va_list ap)
     QString *qstr;
     const char *str;

-    assert(strstr(fmt, "execute"));
-
     /*
-     * A round trip through QObject is only needed if % interpolation
-     * is used.  We interpolate through QObject rather than sprintf in
-     * order to escape strings properly.
+     * A round trip through QObject (and not sprintf) is needed
+     * because % interpolation is used, and we must escape strings
+     * properly.
      */
-    if (!strchr(fmt, '%')) {
-        qmp_fd_send(s->qmp_fd, fmt);
-        return;
-    }
+    assert(strchr(fmt, '%'));

     qobj = qobject_from_jsonv(fmt, ap);
     qstr = qobject_to_json(qobj);
@@ -833,31 +828,12 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
     qtest_rsp(s, 0);
 }

-QDict *qmp(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    qtest_qmp_sendv(global_qtest, fmt, ap);
-    va_end(ap);
-    return qtest_qmp_receive(global_qtest);
-}
-
 QDict *qmp_raw(const char *msg)
 {
     qmp_fd_send(global_qtest->qmp_fd, msg);
     return qtest_qmp_receive(global_qtest);
 }

-void qmp_async(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    qtest_qmp_sendv(global_qtest, fmt, ap);
-    va_end(ap);
-}
-
 QDict *qmp_cmd(const char *cmd)
 {
     qmp_cmd_async(cmd);
-- 
2.13.3
