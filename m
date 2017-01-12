Received: from eggs.gnu.org ([2001:4830:134:3::10]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cRiou-0003rC-B2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cRiop-0003S7-O8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:05:48 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:60191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1cRiop-0003Qv-61
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:05:43 -0500
Date: Thu, 12 Jan 2017 18:05:39 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170112170539.GS2832@var.bordeaux.inria.fr>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<1483967385-12891-6-git-send-email-kraxel@redhat.com>
	<a277b56c-3bb9-dcb1-eafc-0844cd77b8eb@weilnetz.de>
	<1484236609.5151.16.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1484236609.5151.16.camel@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 05/11] sdl2: set window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Weil <stefan.weil@weilnetz.de>, qemu-devel@nongnu.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Gerd Hoffmann, on Thu 12 Jan 2017 16:56:49 +0100, wrote:
> On Do, 2017-01-12 at 16:10 +0100, Stefan Weil wrote:
> > This commit breaks builds for Windows. See below for details.
> 
> > Windows does not use X11. gcc fails:
> > 
> >   CC      ui/sdl2.o
> > /qemu/ui/sdl2.c: In function ‘sdl_display_init’:
> > /qemu/ui/sdl2.c:821:54: error: ‘union <anonymous>’ has no member named ‘x11’
> >              qemu_console_set_window_id(con, info.info.x11.window);
> 
> Oops.

Oops, sorry, it seems to have been overlooked indeed.  Can you easily
test the attached patch?

Samuel

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9a79b17b92..0f41d1fa90 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -762,6 +762,9 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
     char *filename;
     int i;
     SDL_SysWMinfo info;
+#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
+    int window_id;
+#endif
 
     if (no_frame) {
         gui_noframe = 1;
@@ -817,9 +820,17 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
         sdl2_console[i].dcl.con = con;
         register_displaychangelistener(&sdl2_console[i].dcl);
 
+#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
         if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
-            qemu_console_set_window_id(con, info.info.x11.window);
+#ifdef SDL_VIDEO_DRIVER_WINDOWS
+            window_id = (int)(uintptr_t) info.info.win.hwnd;
+#endif
+#ifdef SDL_VIDEO_DRIVER_X11
+            window_id = info.info.x11.window;
+#endif
+            qemu_console_set_window_id(con, window_id);
         }
+#endif
     }
 
     /* Load a 32x32x4 image. White pixels are transparent. */

--UugvWAfsgieZRqgk--
