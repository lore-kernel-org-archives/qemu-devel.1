Received: from eggs.gnu.org ([2001:4830:134:3::10]:39873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxo-0001dU-D6
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDxxn-0008Dy-1u
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:40 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDxxm-0008Dp-RT
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 14:30:38 -0500
Received: by mail-wm0-x241.google.com with SMTP id n74so11661501wmi.1
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 11:30:38 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 20:30:26 +0100
Message-Id: <20171112193032.9724-3-makovick@gmail.com>
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 2/8] sdl2: Do not quit the emulator when an
 auxilliary window is closed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/sdl2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 774904cbf2..dfbd0de791 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -566,9 +566,14 @@ static void handle_windowevent(SDL_Event *ev)
         update_displaychangelistener(&scon->dcl, 500);
         break;
     case SDL_WINDOWEVENT_CLOSE:
-        if (!no_quit) {
-            no_shutdown = 0;
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
+        if (qemu_console_is_graphic(scon->dcl.con)) {
+            if (!no_quit) {
+                no_shutdown = 0;
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
+            }
+        } else {
+            SDL_HideWindow(scon->real_window);
+            scon->hidden = true;
         }
         break;
     case SDL_WINDOWEVENT_SHOWN:
-- 
2.15.0
