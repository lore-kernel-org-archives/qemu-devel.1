Received: from eggs.gnu.org ([2001:4830:134:3::10]:46099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BP-0002DV-PQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BO-0004S8-Nk
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da7BO-0004Q9-FY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A36FA9659
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:15:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:18 -0500
Message-Id: <20170725211523.3998-8-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd() and
 friends
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

When interpolating a QMP command from the testsuite, we have
a very common pattern that the command to be executed is a
string constant, while the arguments may need to be crafted
from qobject_from_jsonf() or even by hand.  Make it easier to
craft the arguments without having to save all the interpolation
to the final qmp() call, by adding new helper functions; the
function takes QObject instead of QDict in order to reduce the
number of conversions between the two.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 31 +++++++++++++++++++++++++++++++
 tests/libqtest.c | 25 +++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 82e89b4d4f..26930fed4d 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -68,6 +68,17 @@ void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
 QDict *qtest_qmp(QTestState *s, const char *fmt, ...);

 /**
+ * qtest_qmp_cmd:
+ * @s: #QTestState instance to operate on.
+ * @cmd: Command name to send
+ * @args: Arguments to transfer to the command, or NULL.
+ *
+ * Sends a QMP message to QEMU and returns the response. Calling this will
+ * reduce the reference count of @args.
+ */
+QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args);
+
+/**
  * qtest_async_qmp:
  * @s: #QTestState instance to operate on.
  * @fmt...: QMP message to send to qemu; formats arguments through
@@ -550,6 +561,16 @@ static inline void qtest_end(void)
 QDict *qmp(const char *fmt, ...);

 /**
+ * qmp_cmd:
+ * @cmd: Command name to send
+ * @args: Arguments to transfer to the command, or NULL.
+ *
+ * Sends a QMP message to QEMU and returns the response. Calling this will
+ * reduce the reference count of @args.
+ */
+QDict *qmp_cmd(const char *cmd, QObject *args);
+
+/**
  * qmp_async:
  * @fmt...: QMP message to send to qemu; formats arguments through
  * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf])').
@@ -568,6 +589,16 @@ void qmp_async(const char *fmt, ...);
 void qmp_discard_response(const char *fmt, ...);

 /**
+ * qmp_cmd_discard_response:
+ * @cmd: Command name to send
+ * @args: Arguments to transfer to the command, or NULL.
+ *
+ * Sends a QMP message to QEMU and consumes the response. Calling this will
+ * reduce the reference count of @args.
+ */
+void qmp_cmd_discard_response(const char *cmd, QObject *args);
+
+/**
  * qmp_receive:
  *
  * Reads a QMP message from QEMU and returns the response.
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4a5492a603..1b57cedca1 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -540,6 +540,17 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
     return response;
 }

+QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args)
+{
+    QDict *dict = qdict_new();
+
+    qdict_put_str(dict, "execute", cmd);
+    if (args) {
+        qdict_put_obj(dict, "arguments", args);
+    }
+    return qtest_qmp(s, "%p", QOBJECT(dict));
+}
+
 void qtest_async_qmp(QTestState *s, const char *fmt, ...)
 {
     va_list ap;
@@ -925,6 +936,11 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }

+QDict *qmp_cmd(const char *cmd, QObject *args)
+{
+    return qtest_qmp_cmd(global_qtest, cmd, args);
+}
+
 void qmp_async(const char *fmt, ...)
 {
     va_list ap;
@@ -942,6 +958,15 @@ void qmp_discard_response(const char *fmt, ...)
     qtest_qmpv_discard_response(global_qtest, fmt, ap);
     va_end(ap);
 }
+
+void qmp_cmd_discard_response(const char *cmd, QObject *args)
+{
+    QDict *response;
+
+    response = qmp_cmd(cmd, args);
+    QDECREF(response);
+}
+
 char *hmp(const char *fmt, ...)
 {
     va_list ap;
-- 
2.13.3
