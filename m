Received: from eggs.gnu.org ([2001:4830:134:3::10]:39897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmMR-00020k-CJ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmMQ-00070E-8L
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fsmMP-0006yz-Ph
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1386040216E6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:57:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Aug 2018 11:56:50 +0200
Message-Id: <20180823095653.14556-10-kraxel@redhat.com>
In-Reply-To: <20180823095653.14556-1-kraxel@redhat.com>
References: <20180823095653.14556-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] ui/sdl2: Fix broken -full-screen CLI
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We've got to set the gui_fullscreen variable before creating the
SDL2 window, otherwise the initial window will not be created in
fullscreen mode.

Buglink: https://bugs.launchpad.net/bugs/1780812
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1531161850-6860-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 755a7134ff..0a9a18a964 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -790,6 +790,8 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
 
+    gui_fullscreen = o->has_full_screen && o->full_screen;
+
     for (i = 0;; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
         if (!con) {
@@ -842,17 +844,14 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         g_free(filename);
     }
 
-    if (sdl2_console->opts->has_full_screen &&
-        sdl2_console->opts->full_screen) {
-        gui_fullscreen = 1;
+    gui_grab = 0;
+    if (gui_fullscreen) {
         sdl_grab_start(0);
     }
 
     mouse_mode_notifier.notify = sdl_mouse_mode_change;
     qemu_add_mouse_mode_change_notifier(&mouse_mode_notifier);
 
-    gui_grab = 0;
-
     sdl_cursor_hidden = SDL_CreateCursor(&data, &data, 8, 1, 0, 0);
     sdl_cursor_normal = SDL_GetCursor();
 
-- 
2.9.3
