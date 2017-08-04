Received: from eggs.gnu.org ([2001:4830:134:3::10]:59678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNN-0008H2-DK
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNM-0003pV-Gz
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNM-0003on-Bf
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F1D8C047B6E
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:33 -0500
Message-Id: <20170804012551.2714-5-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/22] tests: Add assertion for no qmp("")
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

Now that the previous patches have fixed all callers to avoid an
empty message, we can tweak qmp_fd_sendv() to assert that we
don't introduce new callers, and reindent accordingly.  The
additional assertions will also help verify that later refactoring
is not breaking anything.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 7e5425d704..99a07c246f 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -450,6 +450,9 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
 {
     va_list ap_copy;
     QObject *qobj;
+    int log = getenv("QTEST_LOG") != NULL;
+    QString *qstr;
+    const char *str;

     /* qobject_from_jsonv() silently eats leading 0xff as invalid
      * JSON, but we want to test sending them over the wire to force
@@ -458,6 +461,7 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
         socket_send(fd, fmt, 1);
         fmt++;
     }
+    assert(*fmt);

     /* Going through qobject ensures we escape strings properly.
      * This seemingly unnecessary copy is required in case va_list
@@ -466,29 +470,23 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
     va_copy(ap_copy, ap);
     qobj = qobject_from_jsonv(fmt, &ap_copy, &error_abort);
     va_end(ap_copy);
+    qstr = qobject_to_json(qobj);

-    /* No need to send anything for an empty QObject.  */
-    if (qobj) {
-        int log = getenv("QTEST_LOG") != NULL;
-        QString *qstr = qobject_to_json(qobj);
-        const char *str;
+    /*
+     * BUG: QMP doesn't react to input until it sees a newline, an
+     * object, or an array.  Work-around: give it a newline.
+     */
+    qstring_append_chr(qstr, '\n');
+    str = qstring_get_str(qstr);

-        /*
-         * BUG: QMP doesn't react to input until it sees a newline, an
-         * object, or an array.  Work-around: give it a newline.
-         */
-        qstring_append_chr(qstr, '\n');
-        str = qstring_get_str(qstr);
-
-        if (log) {
-            fprintf(stderr, "%s", str);
-        }
-        /* Send QMP request */
-        socket_send(fd, str, qstring_get_length(qstr));
-
-        QDECREF(qstr);
-        qobject_decref(qobj);
+    if (log) {
+        fprintf(stderr, "%s", str);
     }
+    /* Send QMP request */
+    socket_send(fd, str, qstring_get_length(qstr));
+
+    QDECREF(qstr);
+    qobject_decref(qobj);
 }

 void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap)
-- 
2.13.3
