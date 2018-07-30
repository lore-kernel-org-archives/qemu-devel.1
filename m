Received: from eggs.gnu.org ([2001:4830:134:3::10]:39366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cJ-0003Ou-Qk
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cG-0004Vr-Kl
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cG-0004VD-FK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:32:55 +0200
Message-Id: <20180730083317.11765-2-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/23] libqtest: Document calling conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

From: Eric Blake <eblake@redhat.com>

We have two flavors of vararg usage in qtest: qtest_hmp() etc. work
like sprintf(), and qtest_qmp() etc. work like qobject_from_jsonf().
Spell that out in the comments.

Also add GCC_FMT_ATTR() to qtest_hmp() etc. so that the compiler can
flag incorrect use.

We have some cleanup work to do before we can do the same for
qtest_qmp() etc.  This would get us the same better-than-nothing
checking we already have for qobject_from_jsonf(): common incorrect
uses of supported conversion specifications will be flagged
(e.g. passing a double for %d), but use of unsupported ones won't.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rebased, comment wording tweaked, commit message rewritten]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.h | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index ac52872cbe..aa2b2cd7c1 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -76,7 +76,9 @@ void qtest_quit(QTestState *s);
 /**
  * qtest_qmp_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -85,7 +87,9 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -94,7 +98,9 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_async_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -103,7 +109,9 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmpv_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and consumes the response.
@@ -113,7 +121,9 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
 /**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and returns the response.
@@ -123,7 +133,9 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
 /**
  * qtest_async_qmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  * @ap: QMP message arguments
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
@@ -172,7 +184,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 /**
  * qtest_hmpv:
  * @s: #QTestState instance to operate on.
- * @fmt: HMP command to send to QEMU
+ * @fmt: HMP command to send to QEMU, formats arguments like vsprintf().
  * @ap: HMP command arguments
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
@@ -180,7 +192,8 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);
+char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_get_irq:
@@ -561,7 +574,9 @@ static inline void qtest_end(void)
 
 /**
  * qmp:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -569,7 +584,9 @@ QDict *qmp(const char *fmt, ...);
 
 /**
  * qmp_async:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -577,7 +594,9 @@ void qmp_async(const char *fmt, ...);
 
 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf().
+ * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-- 
2.17.1
