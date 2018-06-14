Received: from eggs.gnu.org ([2001:4830:134:3::10]:39389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNgl-00076F-Ot
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fTNgk-0000o6-Dx
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fTNgk-0000nu-9j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:33:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Jun 2018 10:32:58 +0200
Message-Id: <20180614083258.14618-3-kraxel@redhat.com>
In-Reply-To: <20180614083258.14618-1-kraxel@redhat.com>
References: <20180614083258.14618-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] sdl2: restore window dimensions by resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>

From: Amadeusz S=C5=82awi=C5=84ski <amade@asmblr.net>

instead of destroying and recreating window, fixes segfault caused by
handle_keyup trying to access no more existing window when using
Ctrl-Alt-U to restore window "un-scaled" dimensions

 Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
 [Switching to Thread 0x7ffff7f92b80 (LWP 3711)]
 handle_keyup (ev=3D0x7fffffffd010) at ui/sdl2.c:416
 416         scon->ignore_hotkeys =3D false;
 (gdb) bt
 #0  handle_keyup (ev=3D0x7fffffffd010) at ui/sdl2.c:416
 #1  sdl2_poll_events (scon=3D0x100fee5a8) at ui/sdl2.c:608
 #2  0x0000000100585bf2 in dpy_refresh (s=3D0x101ad3e00) at ui/console.c:=
1658
 #3  gui_update (opaque=3D0x101ad3e00) at ui/console.c:205
 #4  0x0000000100690f2c in timerlist_run_timers (timer_list=3D0x100ede130=
) at util/qemu-timer.c:536
 #5  0x0000000100691177 in qemu_clock_run_timers (type=3DQEMU_CLOCK_REALT=
IME) at util/qemu-timer.c:547
 #6  qemu_clock_run_all_timers () at util/qemu-timer.c:674
 #7  0x0000000100691651 in main_loop_wait (nonblocking=3D<optimized out>)=
 at util/main-loop.c:503
 #8  0x00000001003d650f in main_loop () at vl.c:1848
 #9  0x0000000100289681 in main (argc=3D<optimized out>, argv=3D<optimize=
d out>, envp=3D<optimized out>) at vl.c:4605

Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amade@asmblr.net>
Message-id: 20180613172707.31530-1-amade@asmblr.net
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
--=20
2.9.3
