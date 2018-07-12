Received: from eggs.gnu.org ([2001:4830:134:3::10]:47853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWN-00077J-Mf
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWL-0006p1-7V
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWK-0006nw-Tu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84AE9BB40D
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:08 +0200
Message-Id: <20180712111221.20326-8-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/20] libqtest: Simplify qmp_fd_vsend() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index c2c08a890c..3bfb062fcb 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -488,24 +488,20 @@ QDict *qtest_qmp_receive(QTestState *s)
  */
 void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
 {
-    va_list ap_copy;
     QObject *qobj;
 
-    /* qobject_from_jsonv() silently eats leading 0xff as invalid
-     * JSON, but we want to test sending them over the wire to force
-     * resyncs */
+    /*
+     * qobject_from_vjsonf_nofail() chokes on leading 0xff as invalid
+     * JSON, but tests/test-qga.c needs to send that to test QGA
+     * synchronization
+     */
     if (*fmt == '\377') {
         socket_send(fd, fmt, 1);
         fmt++;
     }
 
-    /* Going through qobject ensures we escape strings properly.
-     * This seemingly unnecessary copy is required in case va_list
-     * is an array type.
-     */
-    va_copy(ap_copy, ap);
-    qobj = qobject_from_jsonv(fmt, &ap_copy, &error_abort);
-    va_end(ap_copy);
+    /* Going through qobject ensures we escape strings properly */
+    qobj = qobject_from_vjsonf_nofail(fmt, ap);
 
     /* No need to send anything for an empty QObject.  */
     if (qobj) {
-- 
2.17.1
