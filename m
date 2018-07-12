Received: from eggs.gnu.org ([2001:4830:134:3::10]:47934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWQ-00079S-3K
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWM-0006rR-GW
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWM-0006qb-7q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D704E406EA4F
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:21 +0200
Message-Id: <20180712111221.20326-21-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 20/20] libqtest: Enable compile-time format
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
to qobject_from_vjsonf_nofail().  Unlike qobject_from_jsonv(), they
aren't decorated with GCC_FMT_ATTR().  Fix that to get compile-time
format string checking.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 68b767fc88..087d6793eb 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -81,7 +81,8 @@ void qtest_quit(QTestState *s);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
+void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_qmp:
@@ -91,7 +92,8 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
+QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_qmp_send:
@@ -101,7 +103,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_qmp_send(QTestState *s, const char *fmt, ...);
+void qtest_qmp_send(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_qmpv_discard_response:
@@ -112,7 +115,8 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
+void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_qmpv:
@@ -123,7 +127,8 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
+QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_qmp_vsend:
@@ -134,7 +139,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap);
+void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /**
  * qtest_receive:
@@ -590,7 +596,7 @@ static inline void qtest_end(void)
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qmp(const char *fmt, ...);
+QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * qmp_send:
@@ -599,7 +605,7 @@ QDict *qmp(const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qmp_send(const char *fmt, ...);
+void qmp_send(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * qmp_discard_response:
@@ -608,7 +614,7 @@ void qmp_send(const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qmp_discard_response(const char *fmt, ...);
+void qmp_discard_response(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * qmp_receive:
@@ -967,10 +973,10 @@ static inline int64_t clock_set(int64_t val)
 }
 
 QDict *qmp_fd_receive(int fd);
-void qmp_fd_vsend(int fd, const char *fmt, va_list ap);
-void qmp_fd_send(int fd, const char *fmt, ...);
-QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
-QDict *qmp_fd(int fd, const char *fmt, ...);
+void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+QDict *qmp_fdv(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_cb_for_every_machine:
-- 
2.17.1
