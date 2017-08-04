Received: from eggs.gnu.org ([2001:4830:134:3::10]:59845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNS-0008Kx-DC
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNR-0003vM-Ft
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNR-0003uF-8g
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44FD8C04B30E
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:39 -0500
Message-Id: <20170804012551.2714-11-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/22] libqtest: Skip round-trip through
 QObject
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

When we don't have to do any % interpolation in qmp() and friends,
there is no point wasting time allocating a QObject from the format
string only to then format it back into the string we send over
the wire.

This is a temporary measure: it becomes important in the next
patch, where test-qga will be refactored to do interpolation in
place, and where we must not re-interpolate the string; but will
go away when further refactoring makes it easier to directly
output a string without going through qmp_fd_sendv().

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index cde737ec5a..0cb439eefa 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -448,7 +448,7 @@ QDict *qtest_qmp_receive(QTestState *s)
  */
 void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
 {
-    QObject *qobj;
+    QObject *qobj = NULL;
     int log = getenv("QTEST_LOG") != NULL;
     QString *qstr;
     const char *str;
@@ -462,9 +462,17 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
     }
     assert(*fmt);

-    /* Going through qobject ensures we escape strings properly. */
-    qobj = qobject_from_jsonv(fmt, ap);
-    qstr = qobject_to_json(qobj);
+    /*
+     * A round trip through QObject is only needed if % interpolation
+     * is used.  We interpolate through QObject rather than sprintf in
+     * order to escape strings properly.
+     */
+    if (strchr(fmt, '%')) {
+        qobj = qobject_from_jsonv(fmt, ap);
+        qstr = qobject_to_json(qobj);
+    } else {
+        qstr = qstring_from_str(fmt);
+    }

     /*
      * BUG: QMP doesn't react to input until it sees a newline, an
-- 
2.13.3
