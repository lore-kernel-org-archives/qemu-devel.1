Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fi5YW-00054O-5d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 18:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fi5YT-0001b7-0R
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 18:13:20 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57825
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fi5YS-0001UX-OH
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 18:13:16 -0400
References: <201807230206.02284.randrianasulu@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <51adf87b-89f3-fa17-9685-e7ea863800be@ilande.co.uk>
Date: Tue, 24 Jul 2018 23:12:57 +0100
MIME-Version: 1.0
In-Reply-To: <201807230206.02284.randrianasulu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-ppc -M mac99 and -soundhw es1370
 doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>, qemu-devel@nongnu.org

On 23/07/18 00:06, Andrew Randrianasulu wrote:

> Hello!
> 
> Currently I'm trying pre-releases of qemu, for avoiding situation when release
> was too bugged (2.12, for my taste ..qemu-system-alpha was broken,
> qemu-system-x86_64 -M q35 was broken ..)
> 
> using
> qemu-system-ppc --version
> QEMU emulator version 2.12.91 (v3.0.0-rc1-17-g5b3ecd3d94-dirty)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
> 
> I can't start qemu-system-ppc with -M mac99 and -soundhw es1370:

I'm actually surprised that this could ever work at all, since -soundhw 
is a legacy PC option and certainly isn't included in regular testing of 
the PPC Mac machines.

The confusion comes from the fact that the mac99 machine has multiple 
PCI buses, and my guess is that recent fixes the 3.0 dev cycle could 
have broken an assumption in the old option code.

In theory you should be able to get the correct configuration with 
something like this:

./qemu-system-ppc -monitor stdio -device ES1370 -M mac99

But I'm afraid this configuration is effectively unsupported.

> qemu-system-ppc -monitor stdio -soundhw es1370 -vga std -M mac99
> QEMU 2.12.91 monitor - type 'help' for more information
> (qemu) qemu-system-ppc: PCI bus not available for es1370
> 
> qemu-system-ppc64 starts fine:
> emu-system-ppc64 -monitor stdio -soundhw es1370 -vga std -M mac99
> QEMU 2.12.91 monitor - type 'help' for more information
> (qemu) info pci
>    Bus  0, device  11, function 0:
>      Host bridge: PCI device 106b:004b
>        id ""
>    Bus  0, device  12, function 0:
>      Class 65280: PCI device 106b:0022
>        BAR0: 32 bit memory at 0x80000000 [0x8007ffff].
>        id ""
>    Bus  0, device  13, function 0:
>      USB controller: PCI device 106b:003f
>        IRQ 28.
>        BAR0: 32 bit memory at 0x80080000 [0x800800ff].
>        id ""
>    Bus  0, device  14, function 0:
>      VGA controller: PCI device 1234:1111
>        BAR0: 32 bit prefetchable memory at 0x81000000 [0x81ffffff].
>        BAR2: 32 bit memory at 0x82000000 [0x82000fff].
>        BAR6: 32 bit memory at 0x82010000 [0x8201ffff].
>        id ""
>    Bus  0, device  15, function 0:
>      Ethernet controller: PCI device 10ec:8029
>        IRQ 30.
>        BAR0: I/O at 0x1000 [0x10ff].
>        BAR6: 32 bit memory at 0x82040000 [0x8207ffff].
>        id ""
>    Bus  0, device  16, function 0:
>      Audio controller: PCI device 1274:5000
>        IRQ 27.
>        BAR0: I/O at 0x1100 [0x11ff].
>        id ""
> (qemu)
> 
> Note, I'm using 32-bit qemu build, configured like this:
> setarch
> i486 ./configure --prefix=/usr --disable-gtk --enable-virglrenderer --enable-sdl
> \ --with-sdlabi=2.0 --audio-drv-list=alsa,oss --host-cc=/opt/gcc49/bin/gcc
> \ --enable-opengl --extra-cflags="-I/usr/X11R7/include -O3 -march=i686
> \ -mtune=native -m32 -Wno-maybe-uninitialized -Wno-nested-externs
> \ -Wno-implicit-function-declaration" --disable-werror
> 
> for qemu-system-ppc -M mac99 'info pci' shows:
> 
> qemu-system-ppc -monitor stdio -vga std -M mac99
> QEMU 2.12.91 monitor - type 'help' for more information
> (qemu) info pci
>    Bus  0, device  11, function 0:
>      Host bridge: PCI device 106b:001f
>        id ""
>    Bus  0, device  12, function 0:
>      Class 65280: PCI device 106b:0022
>        BAR0: 32 bit memory at 0x80000000 [0x8007ffff].
>        id ""
>    Bus  0, device  13, function 0:
>      USB controller: PCI device 106b:003f
>        IRQ 28.
>        BAR0: 32 bit memory at 0x80080000 [0x800800ff].
>        id ""
>    Bus  0, device  14, function 0:
>      VGA controller: PCI device 1234:1111
>        BAR0: 32 bit prefetchable memory at 0x81000000 [0x81ffffff].
>        BAR2: 32 bit memory at 0x82000000 [0x82000fff].
>        BAR6: 32 bit memory at 0x82010000 [0x8201ffff].
>        id ""
>    Bus  0, device  15, function 0:
>      Ethernet controller: PCI device 10ec:8029
>        IRQ 30.
>        BAR0: I/O at 0x1000 [0x10ff].
>        BAR6: 32 bit memory at 0x82040000 [0x8207ffff].
>        id ""
>    Bus  0, device  14, function 0:
>      Host bridge: PCI device 106b:001e
>        id ""
>    Bus  0, device  11, function 0:
>      Host bridge: PCI device 106b:0020
>        id ""
> (qemu)
> 
> Last two devices seems strange .....
> 
> Also, mouse seems to be confused, try  finnix-ppc-110.iso (it enables gpm on
> startup, start like qemu-system-ppc -monitor stdio -M mac99 -cdrom
> ~/finnix-ppc-110.iso and try to move mouse inside qemu window. It feels like
> keyboard got some mouseclicks too? or mouse movement generates mouse button
> clicks, too) or http://cdimage.ubuntu.com/lubuntu/releases/16.04/release/ ->
> [   ]  lubuntu-16.04-desktop-powerpc.iso   (but you must wait for nearly 10 min
> until it finishes booting)

Is this a regression? Certainly it's not an image that is part of my 
regular test suite. And what is your host platform? Does a 64-bit build 
make any difference? What about using GTK and/or VNC instead of SDL? 
Does disabling the sound hardware change the responsiveness?


ATB,

Mark.
