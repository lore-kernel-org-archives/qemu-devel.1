Received: from eggs.gnu.org ([2001:4830:134:3::10]:51892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cFiiC-00074o-Lp
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cFii9-0004OM-G7
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:33:16 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=59748 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cFii9-0004O2-6a
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:33:13 -0500
References: <bd061de5-5cf6-035c-ce1c-acda671f0463@ilande.co.uk>
	<5ef0624b-25d7-4d8d-efe4-3a51d5d212b7@weilnetz.de>
	<CABLmASGthfWrCCxmy+xfrMHzg-3vHkmirsOcQECQWh87BqmyxQ@mail.gmail.com>
	<c16121e5-4822-42b2-ec78-7347ab9cc63f@weilnetz.de>
	<CABLmASGw9httdKD1qEjxod=K4mWemt+OBKzWHL8XHSjoxuv-Yg@mail.gmail.com>
	<e9e2b4a7-991b-4713-a282-1ca27b11c022@ilande.co.uk>
	<2e61d0c2-5c16-de77-8fef-e824974e4a6f@weilnetz.de>
	<CABLmASEZw7wxfU-4gsmGkK4ObXgxiO4VFuttZagwDM60xET8Hg@mail.gmail.com>
	<CABLmASH45_ahx5c6RnvkOFcwqOb5x9t8gEm-S0Dfzs93i5C8KQ@mail.gmail.com>
	<f46fac8a-683c-08a4-5ef8-7668b91b13e0@weilnetz.de>
	<CABLmASG9hrA1go5qROhBLKk3-oR6mzFSp4wmAMz+sjr7kteing@mail.gmail.com>
	<4a68532a-aaaf-fe18-be1a-8bbd36ffd339@weilnetz.de>
	<CABLmASFXDgZ=RMzX=Py+3zLrZzMU4nRNKTTdXuHSMmsVJoXhUw@mail.gmail.com>
	<CABLmASHp8fUsui6Am4=_QpbnZmKr5_4Z=xpnxRbDBTWcTiM5sQ@mail.gmail.com>
	<1971f7f3-a69f-faa5-b7e5-350ad58b652f@weilnetz.de>
	<CABLmASFw_GYyhUBHagQ0ah8cEU4VJD9HM885dKUa9BYiJB7xDw@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <9e21bec4-4308-667f-253f-951cccc6d73d@weilnetz.de>
Date: Sat, 10 Dec 2016 15:33:08 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASFw_GYyhUBHagQ0ah8cEU4VJD9HM885dKUa9BYiJB7xDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU for Windows - UI status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>

This is a status summary for UI support in QEMU for Windows.

Available user interfaces
-------------------------

* curses
* SDL 1.2
* SDL 2.0
* GTK without VTE
* VNC

Status curses
-------------

It is supported, but I don't have any test results as I nearly
never use it. It does not support graphics, so its use is very
limited.

Status SDL 1.2
--------------

I dropped using SDL 1.2 for QEMU 2.8, so I have no new test results.
With QEMU 2.7 SDL 1.2 works, but the redirection of STDOUT and STDERR
to files confuses users ("crash without any message") and does not
work because of missing rights for typical installations.

Status SDL 2.0
--------------

I started testing with SDL 2.0 today. A default build for Windows
is not usable, because QEMU terminates immediately with an error
message: "Fatal Error: Out of memory - aborting" (even if running
without -sdl).

This is caused by main being mapped to SDL_main and probably a
mismatch between QEMU (compiled with TCHAR = 1 byte) and SDL2
(compiled with TCHAR = 2 bytes). It can be fixed by defining
SDL_MAIN_HANDLED before including SDL.h and undefining main.

Fixing main is not sufficient: booting the 386 BIOS is extremely
slow, obviously with threads waiting for each other, maybe deadlocks.
Keyboard and mouse input seems to help a little bit.

Status GTK without VTE
----------------------

There is no VTE for Windows, and I see no chance to port the VTE code
for that platform.

Without VTE, QEMU's monitor window does not have a history. Scrolling
in lengthy output (help command) is not possible. This can be
reproduced on Linux, too, by disabling VTE support.

In addition, I got this report from Howard (cc'ed):

> These are the issues I encountered with qemu-system-ppc.exe in the GTK gui:
> -Mouse tracking is not exact.The mouse in guest Mac OS/Mac OSX is
> faster than the host mouse.
> -Input grab allows the mouse to travel outside the guest window.
> -Double click speed is set so fast it is almost impossible to achieve
> a double click.
> -It requires constant moving of the mouse to achieve boot times
> comparable to SDL, otherwise boot is extremely slow.

AFAIK tablet mode should give better (good?) results, but I don't
think it will fix the deadlock issues which slow down operations.

I know that there are keyboard issues with GTK (even on Linux)
when using a non English keybords (Umlauts, AltGr key on
German keyboard).

Status VNC
----------

I use it rarely, but it seems to work. The VNC code still needs
surprisingly many commits. Maybe code stability could be improved
by removing most of the code in QEMU and replacing it by libvnc.

Summary
-------

Most QEMU user interfaces have problems on Windows.

It looks as if the old SDL 1.2 is still a good option for Windows.
VNC might be another good choice.

Comments and fixes are welcome. For 2.8, I documented the SDL 2 problem,
but I won't send last minute fixes.

Regards
Stefan
