Received: from eggs.gnu.org ([2001:4830:134:3::10]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amade@asmblr.net>) id 1fT9WT-0001AI-93
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amade@asmblr.net>) id 1fT9WO-0005LX-1K
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:25:29 -0400
Received: from srv2.anyservers.com ([77.79.239.202]:46046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amade@asmblr.net>) id 1fT9WN-0005Ej-Oz
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:25:23 -0400
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
Date: Wed, 13 Jun 2018 19:27:07 +0200
Message-Id: <20180613172707.31530-1-amade@asmblr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] sdl2: restore window dimensions by resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>

instead of destroying and recreating window, fixes segfault caused by
handle_keyup trying to access no more existing window when using
Ctrl-Alt-U to restore window "un-scaled" dimensions

 Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 0x7ffff7f92b80 (LWP 3711)]
 handle_keyup (ev=0x7fffffffd010) at ui/sdl2.c:416
 416         scon->ignore_hotkeys = false;
 (gdb) bt
 #0  handle_keyup (ev=0x7fffffffd010) at ui/sdl2.c:416
 #1  sdl2_poll_events (scon=0x100fee5a8) at ui/sdl2.c:608
 #2  0x0000000100585bf2 in dpy_refresh (s=0x101ad3e00) at ui/console.c:1658
 #3  gui_update (opaque=0x101ad3e00) at ui/console.c:205
 #4  0x0000000100690f2c in timerlist_run_timers (timer_list=0x100ede130) at util/qemu-timer.c:536
 #5  0x0000000100691177 in qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME) at util/qemu-timer.c:547
 #6  qemu_clock_run_all_timers () at util/qemu-timer.c:674
 #7  0x0000000100691651 in main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:503
 #8  0x00000001003d650f in main_loop () at vl.c:1848
 #9  0x0000000100289681 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4605

Signed-off-by: Amadeusz Sławiński <amade@asmblr.net>
---
 ui/sdl2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index a0f9b16bc1..3ae4719c32 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -371,8 +371,7 @@ static void handle_keydown(SDL_Event *ev)
             }
             break;
         case SDL_SCANCODE_U:
-            sdl2_window_destroy(scon);
-            sdl2_window_create(scon);
+            sdl2_window_resize(scon);
             if (!scon->opengl) {
                 /* re-create scon->texture */
                 sdl2_2d_switch(&scon->dcl, scon->surface);
-- 
2.17.1
