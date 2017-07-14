Received: from eggs.gnu.org ([2001:4830:134:3::10]:54207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5x6-0002OH-Gp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dW5x5-00022F-HE
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dW5x5-00021x-8g
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 15:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 594C8F810
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 19:08:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 14:08:27 -0500
Message-Id: <20170714190827.4083-6-eblake@redhat.com>
In-Reply-To: <20170714190827.4083-1-eblake@redhat.com>
References: <20170714190827.4083-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
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

We have two flavors of vararg usage in qtest; make it clear that
qmp() has different semantics than hmp(), and let the compiler
enforce that hmp() is used correctly. Since qmp() only accepts
a subset of printf flags (namely, those that our JSON parser
understands), I figured that it is probably not worth adding a
format attribute to qmp() at this time.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 38bc1e9..762ed13 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -50,7 +50,8 @@ void qtest_quit(QTestState *s);
 /**
  * qtest_qmp_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; only recognizes formats
+ * understood by json-lexer.c
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -59,7 +60,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; only recognizes formats
+ * understood by json-lexer.c
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -134,14 +136,14 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, passed through sprintf()
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  * QMP events are discarded.
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmp(QTestState *s, const char *fmt, ...);
+char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);

 /**
  * qtest_hmpv:
@@ -535,7 +537,8 @@ static inline void qtest_end(void)

 /**
  * qmp:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; only recognizes formats
+ * understood by json-lexer.c
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -543,7 +546,8 @@ QDict *qmp(const char *fmt, ...);

 /**
  * qmp_async:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; only recognizes formats
+ * understood by json-lexer.c
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -551,7 +555,8 @@ void qmp_async(const char *fmt, ...);

 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; only recognizes formats
+ * understood by json-lexer.c
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -592,13 +597,13 @@ static inline QDict *qmp_eventwait_ref(const char *event)

 /**
  * hmp:
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, passed through printf()
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *hmp(const char *fmt, ...);
+char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
  * get_irq:
-- 
2.9.4
