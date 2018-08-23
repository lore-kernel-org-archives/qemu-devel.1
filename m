Received: from eggs.gnu.org ([2001:4830:134:3::10]:32915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssgU-0003Z5-Bh
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fsses-0003Xq-Rv
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fsses-0003XC-Ik
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:40:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Aug 2018 18:39:34 +0200
Message-Id: <20180823164025.12553-8-armbru@redhat.com>
In-Reply-To: <20180823164025.12553-1-armbru@redhat.com>
References: <20180823164025.12553-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/58] test-qga: Clean up how we test QGA
 synchronization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

To permit recovering from arbitrary JSON parse errors, the JSON parser
resets itself on lexical errors.  We recommend sending a 0xff byte for
that purpose, and test-qga covers this usage since commit 5229564b832.
That commit had to add an ugly hack to qmp_fd_vsend() to make capable
of sending this byte (it's designed to send only valid JSON).

The previous commit added a way to send arbitrary text.  Put that to
use for this purpose, and drop the hack from qmp_fd_vsend().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 39 +++++++++++++++++++++------------------
 tests/libqtest.h |  2 ++
 tests/test-qga.c |  3 ++-
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index dc42347da3..a7ad09fc86 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -507,16 +507,6 @@ void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
 {
     QObject *qobj;
 
-    /*
-     * qobject_from_vjsonf_nofail() chokes on leading 0xff as invalid
-     * JSON, but tests/test-qga.c needs to send that to test QGA
-     * synchronization
-     */
-    if (*fmt == '\377') {
-        socket_send(fd, fmt, 1);
-        fmt++;
-    }
-
     /* Going through qobject ensures we escape strings properly */
     qobj = qobject_from_vjsonf_nofail(fmt, ap);
 
@@ -604,23 +594,36 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }
 
-void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
+void qmp_fd_vsend_raw(int fd, const char *fmt, va_list ap)
 {
     bool log = getenv("QTEST_LOG") != NULL;
-    va_list ap;
-    char *str;
-
-    va_start(ap, fmt);
-    str = g_strdup_vprintf(fmt, ap);
-    va_end(ap);
+    char *str = g_strdup_vprintf(fmt, ap);
 
     if (log) {
         fprintf(stderr, "%s", str);
     }
-    socket_send(s->qmp_fd, str, strlen(str));
+    socket_send(fd, str, strlen(str));
     g_free(str);
 }
 
+void qmp_fd_send_raw(int fd, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    qmp_fd_vsend_raw(fd, fmt, ap);
+    va_end(ap);
+}
+
+void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    qmp_fd_vsend_raw(s->qmp_fd, fmt, ap);
+    va_end(ap);
+}
+
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
 {
     QDict *response;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 1e831973ff..2d1eb4b282 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -959,6 +959,8 @@ static inline int64_t clock_set(int64_t val)
 QDict *qmp_fd_receive(int fd);
 void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
 void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+void qmp_fd_send_raw(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+void qmp_fd_vsend_raw(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
 QDict *qmp_fdv(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
 QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
diff --git a/tests/test-qga.c b/tests/test-qga.c
index c552cc0125..f69cdf6c03 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -147,8 +147,9 @@ static void test_qga_sync_delimited(gconstpointer fix)
     unsigned char c;
     QDict *ret;
 
+    qmp_fd_send_raw(fixture->fd, "\xff");
     qmp_fd_send(fixture->fd,
-                "\xff{'execute': 'guest-sync-delimited',"
+                "{'execute': 'guest-sync-delimited',"
                 " 'arguments': {'id': %u } }",
                 r);
 
-- 
2.17.1
