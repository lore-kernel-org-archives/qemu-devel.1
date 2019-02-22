Received: from eggs.gnu.org ([209.51.188.92]:60425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eN-0006xp-EW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eL-0001Xk-UU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eL-0001QY-CE
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD467305B239
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:12 +0100
Message-Id: <20190222075326.9850-2-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/15] kbd-state: don't block auto-repeat events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190220100235.20914-1-kraxel@redhat.com
---
 ui/kbd-state.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index ac14add70eab..f3ab2d7a665d 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -42,14 +42,18 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qc=
ode, bool down)
 {
     bool state =3D test_bit(qcode, kbd->keys);
=20
-    if (state =3D=3D down) {
+    if (down =3D=3D false  /* got key-up event   */ &&
+        state =3D=3D false /* key is not pressed */) {
         /*
-         * Filter out events which don't change the keyboard state.
+         * Filter out suspicious key-up events.
          *
-         * Most notably this allows to simply send along all key-up
-         * events, and this function will filter out everything where
-         * the corresponding key-down event wasn't send to the guest,
-         * for example due to being a host hotkey.
+         * This allows simply sending along all key-up events, and
+         * this function will filter out everything where the
+         * corresponding key-down event wasn't sent to the guest, for
+         * example due to being a host hotkey.
+         *
+         * Note that key-down events on already pressed keys are *not*
+         * suspicious, those are keyboard autorepeat events.
          */
         return;
     }
--=20
2.9.3
