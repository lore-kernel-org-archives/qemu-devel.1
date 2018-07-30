Received: from eggs.gnu.org ([2001:4830:134:3::10]:39363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cJ-0003Or-QU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cG-0004W4-S8
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cG-0004VT-NL
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:33:01 +0200
Message-Id: <20180730083317.11765-8-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/23] libqtest: Simplify qmp_fd_vsend() a
 bit
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
=20
-    /* qobject_from_jsonv() silently eats leading 0xff as invalid
-     * JSON, but we want to test sending them over the wire to force
-     * resyncs */
+    /*
+     * qobject_from_vjsonf_nofail() chokes on leading 0xff as invalid
+     * JSON, but tests/test-qga.c needs to send that to test QGA
+     * synchronization
+     */
     if (*fmt =3D=3D '\377') {
         socket_send(fd, fmt, 1);
         fmt++;
     }
=20
-    /* Going through qobject ensures we escape strings properly.
-     * This seemingly unnecessary copy is required in case va_list
-     * is an array type.
-     */
-    va_copy(ap_copy, ap);
-    qobj =3D qobject_from_jsonv(fmt, &ap_copy, &error_abort);
-    va_end(ap_copy);
+    /* Going through qobject ensures we escape strings properly */
+    qobj =3D qobject_from_vjsonf_nofail(fmt, ap);
=20
     /* No need to send anything for an empty QObject.  */
     if (qobj) {
--=20
2.17.1
