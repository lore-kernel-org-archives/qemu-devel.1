Received: from eggs.gnu.org ([2001:4830:134:3::10]:41629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0j-0002Sf-N0
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ciO0i-0002nO-3Q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ciO0h-0002mo-SX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:18:51 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Feb 2017 17:18:43 +0100
Message-Id: <1488212323-26882-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
References: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] vnc: fix double free issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Reported by Coverity: CID 1371242, 1371243, 1371244.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1487682332-29154-1-git-send-email-kraxel@redhat.com
---
 ui/vnc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 62e85ed..51f4b30 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3181,6 +3181,7 @@ static void vnc_display_close(VncDisplay *vd)
     g_free(vd->lsock);
     g_free(vd->lsock_tag);
     vd->lsock =3D NULL;
+    vd->lsock_tag =3D NULL;
     vd->nlsock =3D 0;
=20
     for (i =3D 0; i < vd->nlwebsock; i++) {
@@ -3192,6 +3193,7 @@ static void vnc_display_close(VncDisplay *vd)
     g_free(vd->lwebsock);
     g_free(vd->lwebsock_tag);
     vd->lwebsock =3D NULL;
+    vd->lwebsock_tag =3D NULL;
     vd->nlwebsock =3D 0;
=20
     vd->auth =3D VNC_AUTH_INVALID;
@@ -3204,6 +3206,7 @@ static void vnc_display_close(VncDisplay *vd)
     vd->tlsaclname =3D NULL;
     if (vd->lock_key_sync) {
         qemu_remove_led_event_handler(vd->led);
+        vd->led =3D NULL;
     }
 }
=20
--=20
1.8.3.1
