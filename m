Received: from eggs.gnu.org ([2001:4830:134:3::10]:58307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRkin-0004Hv-Ez
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRkik-0002A3-CW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:07:37 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=33966 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRkik-00029Y-6n
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 14:07:34 -0500
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<1483967385-12891-6-git-send-email-kraxel@redhat.com>
	<a277b56c-3bb9-dcb1-eafc-0844cd77b8eb@weilnetz.de>
	<1484236609.5151.16.camel@redhat.com>
	<20170112170539.GS2832@var.bordeaux.inria.fr>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ac52618f-a5c1-3b4b-3d07-2bdbb6fb1372@weilnetz.de>
Date: Thu, 12 Jan 2017 20:07:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170112170539.GS2832@var.bordeaux.inria.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 05/11] sdl2: set window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/12/17 18:05, Samuel Thibault wrote:
> Hello,
>
> Gerd Hoffmann, on Thu 12 Jan 2017 16:56:49 +0100, wrote:
>> On Do, 2017-01-12 at 16:10 +0100, Stefan Weil wrote:
>>> This commit breaks builds for Windows. See below for details.
>>
>>> Windows does not use X11. gcc fails:
>>>
>>>   CC      ui/sdl2.o
>>> /qemu/ui/sdl2.c: In function =91sdl_display_init=92:
>>> /qemu/ui/sdl2.c:821:54: error: =91union <anonymous>=92 has no member =
named =91x11=92
>>>              qemu_console_set_window_id(con, info.info.x11.window);
>>
>> Oops.
>
> Oops, sorry, it seems to have been overlooked indeed.  Can you easily
> test the attached patch?
>
> Samuel
>

It does not compile. I fixed it and simplified the code a little bit
(see below, please fix line wrap which my mailer enforced). That code
compiles. I did not run tests.

Stefan


diff --git a/ui/sdl2.c b/ui/sdl2.c
index 9a79b17b92..91fb111aa5 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -817,9 +817,15 @@ void sdl_display_init(DisplayState *ds, int=20
full_screen, int no_frame)
          sdl2_console[i].dcl.con =3D con;
          register_displaychangelistener(&sdl2_console[i].dcl);

+#if defined(SDL_VIDEO_DRIVER_WINDOWS) || defined(SDL_VIDEO_DRIVER_X11)
          if (SDL_GetWindowWMInfo(sdl2_console[i].real_window, &info)) {
+#if defined(SDL_VIDEO_DRIVER_WINDOWS)
+            qemu_console_set_window_id(con,=20
(uintptr_t)info.info.win.window);
+#elif defined(SDL_VIDEO_DRIVER_X11)
              qemu_console_set_window_id(con, info.info.x11.window);
+#endif
          }
+#endif
      }

      /* Load a 32x32x4 image. White pixels are transparent. */
