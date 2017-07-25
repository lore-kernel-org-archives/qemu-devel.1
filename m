Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7Bg-0002QC-6v
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7Bc-0004dA-0Y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da7Bb-0004cm-Nq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7FBFC0587E5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:16:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:23 -0500
Message-Id: <20170725211523.3998-13-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/12] tests/libqtest: Enable compile-time
 format string checking
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

From: Markus Armbruster <armbru@redhat.com>

qtest_qmp() & friends pass their format string and variable arguments
to qobject_from_jsonv().  Unlike qobject_from_jsonv(), they aren't
decorated with GCC_FMT_ATTR().  Fix that to get compile-time format
string checking.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1500645206-13559-10-git-send-email-armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 26930fed4d..7e1bd474aa 100644
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
  * qtest_qmp_cmd:
@@ -86,7 +88,8 @@ QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_async_qmp(QTestState *s, const char *fmt, ...);
+void qtest_async_qmp(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);

 /**
  * qtest_qmpv_discard_response:
@@ -97,7 +100,8 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
+void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);

 /**
  * qtest_qmpv:
@@ -108,7 +112,8 @@ void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
+QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);

 /**
  * qtest_async_qmpv:
@@ -119,7 +124,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap);
+void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);

 /**
  * qtest_receive:
@@ -558,7 +564,7 @@ static inline void qtest_end(void)
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qmp(const char *fmt, ...);
+QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
  * qmp_cmd:
@@ -577,7 +583,7 @@ QDict *qmp_cmd(const char *cmd, QObject *args);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qmp_async(const char *fmt, ...);
+void qmp_async(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
  * qmp_discard_response:
@@ -586,7 +592,7 @@ void qmp_async(const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and consumes the response.
  */
-void qmp_discard_response(const char *fmt, ...);
+void qmp_discard_response(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

 /**
  * qmp_cmd_discard_response:
@@ -955,10 +961,10 @@ static inline int64_t clock_set(int64_t val)
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
2.13.3
