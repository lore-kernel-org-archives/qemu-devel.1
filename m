Received: from eggs.gnu.org ([2001:4830:134:3::10]:58765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxN-00083f-Pa
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1e6jxN-0000uT-0B
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:21 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:57249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1e6jxM-0000uF-Pr
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 17:08:20 -0400
Received: by mail-wm0-x243.google.com with SMTP id z3so5367048wme.5
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 14:08:20 -0700 (PDT)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Mon, 23 Oct 2017 23:07:58 +0200
Message-Id: <20171023210803.20998-3-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] sdl2: Do not quit the emulator when an
 auxilliary window is closed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jindrich Makovicka <makovick@gmail.com>

---
 ui/sdl2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 7f51933234..aa37b39547 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -566,9 +566,13 @@ static void handle_windowevent(SDL_Event *ev)
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
         }
         break;
     case SDL_WINDOWEVENT_SHOWN:
-- 
2.15.0.rc0
