Received: from eggs.gnu.org ([209.51.188.92]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1WVr-0002iI-Ci
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1WVq-0003Ey-Gk
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:23:11 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:27461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1WVq-0003EL-96
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:23:10 -0500
Date: Wed, 6 Mar 2019 14:22:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903061321.58890.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903061409050.30260@zero.eik.bme.hu>
References: <201903061321.58890.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, 6 Mar 2019, Andrew Randrianasulu wrote:
> I was compiling those pmons for last two days, and I happy to say most of my hackery was
> unnecessary.

Thanks. Just a few quick notes.

> After this , I run resulted pmon like this
> (using Zoltan's patch for ati-vga device on top of current qemu):
>
> mips64el-softmmu/qemu-system-mips64el -M fulong2e -cpu Loongson-2E -m 1G 
> -bios /dev/shm/pmon-my/pmon/zloader.2edev/pmon.bin -device 
> ati-vga,model=rv100 -hda /dev/shm/LONGSOON_disk -cdrom 
> /dev/shm/debian-8.0.0-mipsel-xfce-CD-1.iso -display sdl,gl=on

I think you don't need -cpu option as board will set that anyway and 
probably does not work with anything else. Also -m 1G is useless as memory 
is currently fixed at 256 MB (see comment in mips_fulong2e.c:298) due to 
me not knowing where to map highmem on mips in general or this board in 
particular. If that's fixed and the line with the comment is removed you 
may be able to use more than 256 MB RAM but not yet.

> it can see both disk and CD, but sadly I was unable to find any working kernel?!
>
> vmlinux-2e just hangs early, and vmlinux-3.16.0-4-loongson-2e extracted from debian pkg
> hangs a litle latter in boot process. Tried without -m option, and with 2F CPU.
> I mean even with just -kernel, no bios involved.

This could be some missing or buggy emulation. Maybe if you can get some 
debug logs from kernel that could tell what it's doing. Usually at least 
-d unimp,guest_errors options are recommended for debugging but if nothing 
is printed then it's harder to find out what's causing the hang.

> Also, while I was able to compile-in uhci support, adding usb-kbd device freezes pmon. And newly-added
> EHCI support apparently limited to only some CPUs/boards :/ At least I was unable to compile pmon in
> this config and with mod_usb_ehci.

No idea about that but the default ps2 kbd and mouse that's set up by the 
board should work so maybe it's not important and you should not need usb 
for kbd.

Regards,
BALATON Zoltan
