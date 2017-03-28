Received: from eggs.gnu.org ([2001:4830:134:3::10]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1csteD-0005G5-Cg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cste9-0006RV-65
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cste9-0006Qt-0O
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 293CF81235
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 16:06:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Mar 2017 18:06:46 +0200
Message-Id: <20170328160646.21250-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vnc: allow to connect with add_client when
 -vnc none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Do not skip VNC initialization, in particular of auth method when vnc is
configured without sockets, since we should still allow connections
through QMP add_client.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1434551

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 821acdd8b0..243e99bb95 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3786,10 +3786,6 @@ void vnc_display_open(const char *id, Error **errp=
)
         goto fail;
     }
=20
-    if (saddr =3D=3D NULL) {
-        return;
-    }
-
     password =3D qemu_opt_get_bool(opts, "password", false);
     if (password) {
         if (fips_get_state()) {
@@ -3974,6 +3970,10 @@ void vnc_display_open(const char *id, Error **errp=
)
         register_displaychangelistener(&vd->dcl);
     }
=20
+    if (saddr =3D=3D NULL) {
+        goto cleanup;
+    }
+
     if (reverse) {
         if (vnc_display_connect(vd, saddr, nsaddr, wsaddr, nwsaddr, errp=
) < 0) {
             goto fail;
--=20
2.12.0.191.gc5d8de91d
