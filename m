Received: from eggs.gnu.org ([2001:4830:134:3::10]:42486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY4-0006eP-BK
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdY1-00063O-5m
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdY0-00060p-Vf
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:06:57 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:06:49 +0100
Message-Id: <20171117100653.13015-2-kraxel@redhat.com>
In-Reply-To: <20171117100653.13015-1-kraxel@redhat.com>
References: <20171117100653.13015-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] sdl2: Do not quit the emulator when an
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
Cc: Jindrich Makovicka <makovick@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Jindrich Makovicka <makovick@gmail.com>

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
Message-Id: <20171112193032.9724-3-makovick@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 53dd447fd2..05729af971 100644
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
2.9.3
