Received: from eggs.gnu.org ([2001:4830:134:3::10]:59841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNS-0008Ks-Ar
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNQ-0003uT-QH
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNQ-0003tN-Gy
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84ADBDB935
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:07 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:38 -0500
Message-Id: <20170804012551.2714-10-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/22] qtest: Document calling conventions
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

We have two flavors of vararg usage in qtest: hmp() etc. work
like sprintf(), and qmp() etc. work like qobject_from_jsonf().
Spell that out in the comments.

Also add GCC_FMT_ATTR() to qtest_hmp() etc. so that the compiler
can flag incorrect use.

We have some cleanup work to do before we can do the same for
qtest_qmp() etc.  This will get us the same better-than-nothing
checking we already have for qobject_from_jsonf(): common
incorrect uses of supported conversion specifications will be
flagged (e.g. passing a double for %d), but use of unsupported
ones won't.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: rebase to %% handling, update commit message
v3: restore lost attributes, add comments on va_list forms, tweak
commit message to mention upcoming qmp cleanups
v2: several comment tweaks, explain why qmp() can't be marked
---
 tests/libqtest.h | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 3ae570927a..38148af66b 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -50,7 +50,8 @@ void qtest_quit(QTestState *s);
 /**
  * qtest_qmp_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -59,7 +60,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -68,7 +70,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_async_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -77,7 +80,8 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmpv_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and consumes the response.
@@ -87,7 +91,8 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
 /**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and returns the response.
@@ -97,7 +102,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
 /**
  * qtest_async_qmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
@@ -134,19 +140,19 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
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
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -543,7 +551,8 @@ QDict *qmp(const char *fmt, ...);

 /**
  * qmp_async:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -551,7 +560,8 @@ void qmp_async(const char *fmt, ...);

 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -592,13 +602,13 @@ static inline QDict *qmp_eventwait_ref(const char *event)

 /**
  * hmp:
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
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
