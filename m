Received: from eggs.gnu.org ([208.118.235.92]:36941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eheQ5-0003ad-Jd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehePP-0007vw-VU
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:42:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:58500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ehePP-0007uW-ND
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:41:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ehaGG-0003As-CV
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 12:16:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5D0F62E80CE
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 12:16:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Feb 2018 12:08:03 -0000
From: Gerd Hoffmann <1703795@bugs.launchpad.net>
Reply-To: Bug 1703795 <1703795@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149985188503.15456.11517595781983565935.malonedeb@wampee.canonical.com>
Message-Id: <20180202120803.11501-1-kraxel@redhat.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703795] [PATCH] sdl2: fix mouse grab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When qemu mouse mode changes from relative to absolute
we must turn off sdl relative mouse mode too.

Fixes: https://bugs.launchpad.net/qemu/+bug/1703795
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 812c315891..858e04d7c0 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -249,6 +249,7 @@ static void sdl_mouse_mode_change(Notifier *notify, voi=
d *data)
     if (qemu_input_is_absolute()) {
         if (!absolute_enabled) {
             absolute_enabled =3D 1;
+            SDL_SetRelativeMouseMode(SDL_FALSE);
             absolute_mouse_grab(&sdl2_console[0]);
         }
     } else if (absolute_enabled) {
-- =

2.9.3

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1703795

Title:
  Unable to release mouse in SDL2 mode

Status in QEMU:
  New

Bug description:
  Starting with commit 8f4ea9cd0b770dbe496d9d24f0ef8813fdbfe0d0 "sdl:
  prefer sdl2 over sdl1", I can no longer release mouse pointer grab
  unless I use --with-sdlabi=3D1.2 configure option.

  This easily reproduces in e.g. guest Kubuntu, when I let it start Xorg
  and then click into the QEMU window. After this the mouse is trapped
  and no matter how I combine Ctrl+Alt and motion of the cursor, the
  pointer never goes out from the window. When at the border, QEMU
  window switches from "Press Ctrl+Alt to exit grab" to "QEMU", i.e. it
  thinks that it has released the grab. But it hasn't really, so I have
  to go to VT1 and do "pkill qemu" from there to get my pointer back.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1703795/+subscriptions
