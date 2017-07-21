Received: from eggs.gnu.org ([2001:4830:134:3::10]:48353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN3-0007hk-Of
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN1-00046l-VC
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYN1-00045n-Mj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A28B746269
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:53:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Jul 2017 15:53:26 +0200
Message-Id: <1500645206-13559-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-1-git-send-email-armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] tests/libqtest: Enable compile-time format
 string checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qtest_qmp() & friends pass their format string and variable arguments
to qobject_from_jsonv().  Unlike qobject_from_jsonv(), they aren't
decorated with GCC_FMT_ATTR().  Fix that to get compile-time format
string checking.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.h | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index ae57282..435012d 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -55,7 +55,8 @@ void qtest_quit(QTestState *s);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
+void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_qmp:
@@ -65,7 +66,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
+QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_async_qmp:
@@ -75,7 +77,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_async_qmp(QTestState *s, const char *fmt, ...);
+void qtest_async_qmp(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_qmpv_discard_response:
@@ -85,7 +88,8 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
+void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_qmpv:
@@ -95,7 +99,8 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
+QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_async_qmpv:
@@ -105,7 +110,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap);
+void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_receive:
@@ -144,7 +150,8 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmp(QTestState *s, const char *fmt, ...);
+char *qtest_hmp(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_hmpv:
@@ -157,7 +164,8 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...);
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);
+char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_get_irq:
@@ -543,7 +551,7 @@ static inline void qtest_end(void)
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qmp(const char *fmt, ...);
+QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * qmp_async:
@@ -552,7 +560,7 @@ QDict *qmp(const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qmp_async(const char *fmt, ...);
+void qmp_async(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * qmp_discard_response:
@@ -561,7 +569,7 @@ void qmp_async(const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qmp_discard_response(const char *fmt, ...);
+void qmp_discard_response(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * qmp_receive:
@@ -604,7 +612,7 @@ static inline QDict *qmp_eventwait_ref(const char *event)
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *hmp(const char *fmt, ...);
+char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * get_irq:
@@ -920,10 +928,10 @@ static inline int64_t clock_set(int64_t val)
 }
 
 QDict *qmp_fd_receive(int fd);
-void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
-void qmp_fd_send(int fd, const char *fmt, ...);
-QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
-QDict *qmp_fd(int fd, const char *fmt, ...);
+void qmp_fd_sendv(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+QDict *qmp_fdv(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_cb_for_every_machine:
-- 
2.7.5
