Received: from eggs.gnu.org ([2001:4830:134:3::10]:50519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmT-0000qd-3N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmL-0005DW-Ia
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmE-00059F-Ba
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60FF9401298C
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D55420180F4
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:44 +0200
Message-Id: <20180816083701.3932-9-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/25] libqtest: Simplify qmp_fd_vsend() a bit
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-9-armbru@redhat.com>
---
 tests/libqtest.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2fe0f4dc29..9e3870bb7d 100644
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
