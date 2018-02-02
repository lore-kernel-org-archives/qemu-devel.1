Received: from eggs.gnu.org ([208.118.235.92]:52516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehdNg-00012T-6B
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehdMG-0005ew-Oz
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehdMG-0005cf-3V
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:34:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7327E81DF5
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 07:17:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 08:17:49 +0100
Message-Id: <20180202071751.16316-2-kraxel@redhat.com>
In-Reply-To: <20180202071751.16316-1-kraxel@redhat.com>
References: <20180202071751.16316-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] ui: fix mixup between qnum and qcode in
 SDL1 key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The previous commit:

  commit 2ec78706d188df7d3dab43d07b19b05ef7800a44
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Wed Jan 17 16:47:15 2018 +0000

    ui: convert GTK and SDL1 frontends to keycodemapdb

changed the x_keymap.c keymap so that its target was qcodes instead of
qnums. It updated the GTK frontend to take account of this change, but
forgot to update the SDL1 frontend. Thus the SDL frontend was getting
qcodes but dispatching them as if they were qnums. IOW, keyboard input
was completely hosed with SDL1. Since the keyboard layout tables are
still all based on qnums, it is easier to just keep SDL1 using qnums as
it will be deleted in a few releases time.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20180201180033.14255-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/sdl.c b/ui/sdl.c
index c8f102bb9f..a6bff301eb 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -242,6 +242,7 @@ static const guint16 *sdl_get_keymap(size_t *maplen)
=20
 static uint8_t sdl_keyevent_to_keycode(const SDL_KeyboardEvent *ev)
 {
+    int qcode;
     if (!keycode_map) {
         return 0;
     }
@@ -249,7 +250,13 @@ static uint8_t sdl_keyevent_to_keycode(const SDL_Key=
boardEvent *ev)
         return 0;
     }
=20
-    return keycode_map[ev->keysym.scancode];
+    qcode =3D keycode_map[ev->keysym.scancode];
+
+    if (qcode > qemu_input_map_qcode_to_qnum_len) {
+        return 0;
+    }
+
+    return qemu_input_map_qcode_to_qnum[qcode];
 }
=20
 static void reset_keys(void)
--=20
2.9.3
