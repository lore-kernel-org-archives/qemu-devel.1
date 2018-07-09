Received: from eggs.gnu.org ([2001:4830:134:3::10]:57391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcb90-0002du-C4
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcb8x-0005rq-5h
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:44:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fcb8x-0005rg-0o
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:44:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55E4F808255D
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 18:44:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  9 Jul 2018 20:44:10 +0200
Message-Id: <1531161850-6860-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] ui/sdl2: Fix broken -full-screen CLI option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

We've got to set the gui_fullscreen variable before creating the
SDL2 window, otherwise the initial window will not be created in
fullscreen mode.

Buglink: https://bugs.launchpad.net/bugs/1780812
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 ui/sdl2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 76e5942..01571dc 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -792,6 +792,8 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
 
+    gui_fullscreen = o->has_full_screen && o->full_screen;
+
     for (i = 0;; i++) {
         QemuConsole *con = qemu_console_lookup_by_index(i);
         if (!con) {
@@ -844,17 +846,14 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
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
1.8.3.1
