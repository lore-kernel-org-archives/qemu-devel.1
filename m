Received: from eggs.gnu.org ([2001:4830:134:3::10]:44260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vex-0006AM-S6
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vew-0000j2-SC
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6vew-0000is-Io
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC18E81DF1
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 10:42:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 12:42:29 +0200
Message-Id: <20181001104230.17779-3-kraxel@redhat.com>
In-Reply-To: <20181001104230.17779-1-kraxel@redhat.com>
References: <20181001104230.17779-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] vnc: call sasl_server_init() only when
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
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
Message-id: 20180907063634.359-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 916a16d312..cf221c83cc 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3821,9 +3821,6 @@ void vnc_display_open(const char *id, Error **errp)
     bool reverse =3D false;
     const char *credid;
     bool sasl =3D false;
-#ifdef CONFIG_VNC_SASL
-    int saslErr;
-#endif
     int acl =3D 0;
     int lock_key_sync =3D 1;
     int key_delay_ms;
@@ -3963,10 +3960,14 @@ void vnc_display_open(const char *id, Error **err=
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
2.9.3
