Received: from eggs.gnu.org ([2001:4830:134:3::10]:56988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJBB-000647-IX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJBA-0000cN-9d
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYJBA-0000bM-0t
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1458624DF
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 21:40:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 20 Jul 2017 16:40:08 -0500
Message-Id: <20170720214008.28494-5-eblake@redhat.com>
In-Reply-To: <20170720214008.28494-1-eblake@redhat.com>
References: <20170720214008.28494-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] qtest: Document calling conventions
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
enforce that hmp() is used correctly. However, qmp() (and friends)
only accept a subset of printf flags look-alikes (namely, those
that our JSON parser understands), and what is worse, qmp("true")
(the JSON keyword 'true') is different from qmp("%s", "true")
(the JSON string '"true"'), so marking those as printf-like would
produce more harm from bogus warnings than it helps (we may have
made a mistake in previously marking qobject_from_jsonf(), but
this patch is not addressing that).

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: several comment tweaks, explain why qmp() can't be marked
---
 tests/libqtest.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 38bc1e9953..ae57282130 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -50,7 +50,8 @@ void qtest_quit(QTestState *s);
 /**
  * qtest_qmp_discard_response:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -59,7 +60,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -68,7 +70,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 /**
  * qtest_async_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -134,7 +137,7 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  * QMP events are discarded.
@@ -535,7 +538,8 @@ static inline void qtest_end(void)

 /**
  * qmp:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
  *
  * Sends a QMP message to QEMU and returns the response.
  */
@@ -543,7 +547,8 @@ QDict *qmp(const char *fmt, ...);

 /**
  * qmp_async:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
@@ -551,7 +556,8 @@ void qmp_async(const char *fmt, ...);

 /**
  * qmp_discard_response:
- * @fmt...: QMP message to send to qemu
+ * @fmt...: QMP message to send to qemu; formats arguments through
+ * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
@@ -592,7 +598,7 @@ static inline QDict *qmp_eventwait_ref(const char *event)

 /**
  * hmp:
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  *
-- 
2.13.3
