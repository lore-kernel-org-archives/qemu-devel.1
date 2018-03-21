Received: from eggs.gnu.org ([2001:4830:134:3::10]:57312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eyhUw-00011u-Aw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eyhUr-0005Ax-4G
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:26:02 -0400
Date: Wed, 21 Mar 2018 18:25:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Hello,

On Wed, 21 Mar 2018, Gerd Hoffmann wrote:
> On Tue, Mar 20, 2018 at 11:43:08PM +0100, BALATON Zoltan wrote:
>> 1. Scrollback does not work. With SDL1.2 it is possible to scroll the
>> monitor (and maybe other output windows as well, I'm not sure about that)
>> with Ctrl+PgUp/PgDn but this does not work with SDL2. Without this the small
>> monitor window is not really usable.
>
> Fixed (patches on the list).

Thanks, this seems to work:
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

>> 2. With at least qemu-system-ppc the serial and parallel output are not
>> accessible (Ctrl+Alt+3 opens an empty window and Ctrl+Alt+4 does nothing)
>
> Doesn't reproduce.  Ctrl-Alt-3 open serial for me, which shows some
> openbios output.  Ctrl-Alt-4 shows parallel.  powermac (default machine
> type).
>
> Tried ppc64 too.  pseries (also default machine type).  Seems there is
> no parallel port.  Serial works fine though (shows SLOF output).
>
>> while the serial output seems to be behind the monitor output in the window
>> opening with Ctrl+Alt+2 and flashes when I type in this window. (This
>> doesn't seem to happen with qemu-system-x86_64, maybe that's why it was not
>> catched.)
>
> Doesn't reproduce too.  It's also not clear why x86_64 should behave
> different that ppc.  There is no arch-specific code ui/, so there should
> be no difference, exept for hardware like paralle ports which are not
> supported by all machine types.
>
> Any chance you have tested an old ppc binary?

Not likely because I did make distclean and a clean build before testing 
to avoid any possible mismatch. It still does not work for me though. 
While trying to reproduce it now with qemu-system-i386 I got this 
segfault just by pressing Ctrl+Alt+[234] a few times:

Program received signal SIGSEGV, Segmentation fault.
0x0000555555c1da56 in handle_keydown (ev=0x7fffffffdc70) at ui/sdl2.c:335
335	    if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
(gdb) bt
#0  0x0000555555c1da56 in handle_keydown (ev=0x7fffffffdc70) at ui/sdl2.c:335
#1  0x0000555555c1e3ae in sdl2_poll_events (scon=0x555558114730)
     at ui/sdl2.c:605
#2  0x0000555555c1f280 in sdl2_2d_refresh (dcl=0x555558114730)
     at ui/sdl2-2d.c:129
#3  0x0000555555bf2154 in dpy_refresh (s=0x555557734850) at ui/console.c:1629
#4  0x0000555555bee45b in gui_update (opaque=0x555557734850)
     at ui/console.c:203
#5  0x0000555555d4c4b3 in timerlist_run_timers (timer_list=0x555556c06ad0)
     at util/qemu-timer.c:536
#6  0x0000555555d4c4fb in qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME)
     at util/qemu-timer.c:547
#7  0x0000555555d4c90b in qemu_clock_run_all_timers () at util/qemu-timer.c:674
#8  0x0000555555d4d0b2 in main_loop_wait (nonblocking=0)
     at util/main-loop.c:528
#9  0x000055555599af8a in main_loop () at vl.c:1943
#10 0x00005555559a2bc2 in main (argc=1, argv=0x7fffffffe148,
     envp=0x7fffffffe158) at vl.c:4729
(gdb) p scon
$1 = (struct sdl2_console *) 0x0
(gdb) p *ev
$3 = {type = 768, common = {type = 768, timestamp = 10771}, window = {
     type = 768, timestamp = 10771, windowID = 0, event = 1 '\001',
     padding1 = 0 '\000', padding2 = 0 '\000', padding3 = 0 '\000',
     data1 = 224, data2 = 1073742048}, key = {type = 768, timestamp = 10771,
     windowID = 0, state = 1 '\001', repeat = 0 '\000', padding2 = 0 '\000',
     padding3 = 0 '\000', keysym = {scancode = SDL_SCANCODE_LCTRL,
       sym = 1073742048, mod = 0, unused = 0}}, edit = {type = 768,
     timestamp = 10771, windowID = 0,
     text = "\001\000\000\000\340\000\000\000\340\000\000@", '\000' <repeats 19 times>,
     start = 0, length = 16}, text = {type = 768, timestamp = 10771,
     windowID = 0,
     text = "\001\000\000\000\340\000\000\000\340\000\000@", '\000' <repeats 19 times>},
     motion = {type = 768, timestamp = 10771, windowID = 0, which = 1,
     state = 224, x = 1073742048, y = 0, xrel = 0, yrel = 0}, button = {
     type = 768, timestamp = 10771, windowID = 0, which = 1,
     button = 224 '\340', state = 0 '\000', clicks = 0 '\000',
     padding1 = 0 '\000', x = 1073742048, y = 0}, wheel = {type = 768,
     timestamp = 10771, windowID = 0, which = 1, x = 224, y = 1073742048},
   jaxis = {type = 768, timestamp = 10771, which = 0, axis = 1 '\001',
     padding1 = 0 '\000', padding2 = 0 '\000', padding3 = 0 '\000',
     value = 224, padding4 = 0}, jball = {type = 768, timestamp = 10771,
     which = 0, ball = 1 '\001', padding1 = 0 '\000', padding2 = 0 '\000',
     padding3 = 0 '\000', xrel = 224, yrel = 0}, jhat = {type = 768,
     timestamp = 10771, which = 0, hat = 1 '\001', value = 0 '\000',
     padding1 = 0 '\000', padding2 = 0 '\000'}, jbutton = {type = 768,
     timestamp = 10771, which = 0, button = 1 '\001', state = 0 '\000',
     padding1 = 0 '\000', padding2 = 0 '\000'}, jdevice = {type = 768,
     timestamp = 10771, which = 0}, caxis = {type = 768, timestamp = 10771,
     which = 0, axis = 1 '\001', padding1 = 0 '\000', padding2 = 0 '\000',
     padding3 = 0 '\000', value = 224, padding4 = 0}, cbutton = {type = 768,
     timestamp = 10771, which = 0, button = 1 '\001', state = 0 '\000',
     padding1 = 0 '\000', padding2 = 0 '\000'}, cdevice = {type = 768,
     timestamp = 10771, which = 0}, quit = {type = 768, timestamp = 10771},
   user = {type = 768, timestamp = 10771, windowID = 0, code = 1,
     data1 = 0x400000e0000000e0, data2 = 0x0}, syswm = {type = 768,
     timestamp = 10771, msg = 0x100000000}, tfinger = {type = 768,
     timestamp = 10771, touchId = 4294967296, fingerId = 4611686980500062432,
     x = 0, y = 0, dx = 0, dy = 0, pressure = 0}, mgesture = {type = 768,
     timestamp = 10771, touchId = 4294967296, dTheta = 3.13890856e-43,
     dDist = 2.00005341, x = 0, y = 0, numFingers = 0, padding = 0},
   dgesture = {type = 768, timestamp = 10771, touchId = 4294967296,
     gestureId = 4611686980500062432, numFingers = 0, error = 0, x = 0, y = 0},
   drop = {type = 768, timestamp = 10771,
     file = 0x100000000 <error: Cannot access memory at address 0x100000000>},
   padding = 
"\000\003\000\000\023*\000\000\000\000\000\000\001\000\000\000\340\000\000\000\340\000\000@", 
'\000' <repeats 24 times>, "\020\000\000\000\000\000\000"}

Not sure if this is related to these patches, I haven't tried to bisect. 
Also my SDL2 version is a bit old, it's still 2.0.3 in case that matters 
but QEMU compiles with it so I also expect it to work at least as good as 
it used to with SDL1.2.

Regards,
BALATON Zoltan
