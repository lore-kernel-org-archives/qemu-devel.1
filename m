Received: from eggs.gnu.org ([2001:4830:134:3::10]:45978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BA-000217-Jw
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7B8-00043N-Ph
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da7B8-00042m-FP
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94624C0BFD10
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:15:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:14 -0500
Message-Id: <20170725211523.3998-4-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com

We have two flavors of vararg usage in qtest; make it clear that
qmp() has different semantics than hmp(), and let the compiler
enforce that hmp() is used correctly. However, qmp() (and friends)
only accept a subset of printf flags look-alikes (namely, those
that our JSON parser understands), and what is worse, qmp("true")
(the JSON keyword 'true') is different from qmp("%s", "true")
(the JSON string '"true"'), and we have some intermediate cleanup
patches to do before we can mark those as printf-like.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: restore lost attributes, add comments on va_list forms, tweak
commit message to mention upcoming qmp cleanups
v2: several comment tweaks, explain why qmp() can't be marked
---
 tests/libqtest.h | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 38bc1e9953..82e89b4d4f 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -50,7 +50,8 @@ void qtest_quit(QTestState *s);
 /**
  * qtest_qmp_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -59,7 +60,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -68,7 +70,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_async_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -77,7 +80,8 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmpv_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and consumes the response.
@@ -87,7 +91,8 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
 /**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and returns the response.
@@ -97,7 +102,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
 /**
  * qtest_async_qmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
@@ -134,19 +140,19 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
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
  * @s: #QTestState instance to operate on.
- * @fmt: HMP command to send to QEMU
+ * @fmt: HMP command to send to QEMU, formats arguments like vsprintf().
  * @ap: HMP command arguments
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
@@ -154,7 +160,8 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...);
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);
+char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);

 /**
  * qtest_get_irq:
@@ -535,7 +542,8 @@ static inline void qtest_end(void)

 /**
  * qmp:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -543,7 +551,8 @@ QDict *qmp(const char *fmt, ...);

 /**
  * qmp_async:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -551,7 +560,8 @@ void qmp_async(const char *fmt, ...);

 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -592,13 +602,13 @@ static inline QDict *qmp_eventwait_ref(const char *event)

 /**
  * hmp:
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
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
2.13.3
