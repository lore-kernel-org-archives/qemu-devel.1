Received: from eggs.gnu.org ([2001:4830:134:3::10]:53954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyAO1-000872-TO
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyANy-0005z8-NJ
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:36:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fyANy-0005w5-Gf
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCE31402315B
	for <qemu-devel@nongnu.org>; Fri,  7 Sep 2018 06:36:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  7 Sep 2018 10:36:34 +0400
Message-Id: <20180907063634.359-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] vnc: call sasl_server_init() only when
 required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, dgilbert@redhat.com, berrange@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

VNC server is calling sasl_server_init() during startup of QEMU, even
if SASL auth has not been enabled.

This may create undesirable warnings like "Could not find keytab file:
/etc/qemu/krb5.tab" when the user didn't configure SASL on host and
started VNC server.

Instead, only initialize SASL when needed. Note that HMP/QMP "change
vnc" calls vnc_display_open() again, which will initialize SASL if
needed.

Fix assignment in if condition, while touching this code.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1609327

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 ui/vnc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index ccb1335d86..458e1d0fcb 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3822,9 +3822,6 @@ void vnc_display_open(const char *id, Error **errp)
     bool reverse =3D false;
     const char *credid;
     bool sasl =3D false;
-#ifdef CONFIG_VNC_SASL
-    int saslErr;
-#endif
     int acl =3D 0;
     int lock_key_sync =3D 1;
     int key_delay_ms;
@@ -3964,10 +3961,14 @@ void vnc_display_open(const char *id, Error **err=
p)
     trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
=20
 #ifdef CONFIG_VNC_SASL
-    if ((saslErr =3D sasl_server_init(NULL, "qemu")) !=3D SASL_OK) {
-        error_setg(errp, "Failed to initialize SASL auth: %s",
-                   sasl_errstring(saslErr, NULL, NULL));
-        goto fail;
+    if (sasl) {
+        int saslErr =3D sasl_server_init(NULL, "qemu");
+
+        if (saslErr !=3D SASL_OK) {
+            error_setg(errp, "Failed to initialize SASL auth: %s",
+                       sasl_errstring(saslErr, NULL, NULL));
+            goto fail;
+        }
     }
 #endif
     vd->lock_key_sync =3D lock_key_sync;
--=20
2.19.0.rc1
