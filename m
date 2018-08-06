Received: from eggs.gnu.org ([2001:4830:134:3::10]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOr-0001Xl-33
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOo-0008AA-7a
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fmZOn-00089D-Uz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:50 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Aug 2018 08:53:42 +0200
Message-Id: <20180806065344.7103-22-armbru@redhat.com>
In-Reply-To: <20180806065344.7103-1-armbru@redhat.com>
References: <20180806065344.7103-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/23] libqtest: Enable compile-time format
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
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

qtest_qmp() & friends pass their format string and variable arguments
to qobject_from_vjsonf_nofail().  Unlike qobject_from_jsonv(), they
aren't decorated with GCC_FMT_ATTR().  Fix that to get compile-time
format string checking.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index d3da42623e..712ac023d6 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -82,7 +82,8 @@ void qtest_quit(QTestState *s);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
+QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
=20
 /**
  * qtest_qmp_send:
@@ -93,7 +94,8 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_qmp_send(QTestState *s, const char *fmt, ...);
+void qtest_qmp_send(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
=20
 /**
  * qtest_qmpv:
@@ -105,7 +107,8 @@ void qtest_qmp_send(QTestState *s, const char *fmt, .=
..);
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
+QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
=20
 /**
  * qtest_qmp_vsend:
@@ -117,7 +120,8 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_=
list ap);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap);
+void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
=20
 /**
  * qtest_receive:
@@ -574,7 +578,7 @@ static inline void qtest_end(void)
  *
  * Sends a QMP message to QEMU and returns the response.
  */
-QDict *qmp(const char *fmt, ...);
+QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
 /**
  * qmp_send:
@@ -584,7 +588,7 @@ QDict *qmp(const char *fmt, ...);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qmp_send(const char *fmt, ...);
+void qmp_send(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
 /**
  * qmp_receive:
@@ -943,10 +947,10 @@ static inline int64_t clock_set(int64_t val)
 }
=20
 QDict *qmp_fd_receive(int fd);
-void qmp_fd_vsend(int fd, const char *fmt, va_list ap);
-void qmp_fd_send(int fd, const char *fmt, ...);
-QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
-QDict *qmp_fd(int fd, const char *fmt, ...);
+void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0=
);
+void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+QDict *qmp_fdv(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
=20
 /**
  * qtest_cb_for_every_machine:
--=20
2.17.1
