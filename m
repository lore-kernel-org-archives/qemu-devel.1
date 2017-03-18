Received: from eggs.gnu.org ([2001:4830:134:3::10]:42762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpMko-0005PF-ND
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 18:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpMkn-0001Dw-Hf
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 18:23:18 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpMkn-0001Dj-9y
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 18:23:17 -0400
Received: by mail-wm0-x22c.google.com with SMTP id u132so38769960wmg.0
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 15:23:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <741795585.70221.1489871707491@communicator.strato.de>
References: <5909E3D6-85D8-4B21-9442-CCD312A4717B@inbox.ru>
	<741795585.70221.1489871707491@communicator.strato.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 22:22:55 +0000
Message-ID: <CAFEAcA-82Hx102VSxxsxD_20RSRCG6BWWtvtxpY4vhWnQTFo-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Strange behaviour in network device initialization.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Bommert <marc@brightwise.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 March 2017 at 21:15, Marc Bommert <marc@brightwise.de> wrote:
> I ran into some behaviour I don't understand and which may be a qemu problem but which may also be my fault, since I haven't investigated much on QOM so far.
> I am currently writing a NIC sysbus device based on the structure of hw/net/smc91c111.c
>
> qemu is invoked as:
>
>   $ qemu-system-arm -M mymachine -m 8 -kernel kernel.elf -nographic -net nic,id=myid -netdev tap,ifname=tap0,id=myid,script=no,downscript=no -device mydevice,netdev=myid
>
>
> The initialization structure is a little special here. A "legacy helper" initialization function is called from the board module mymachine.c:
>
>    for(n = 0; n < nb_nics; n++) {
>         nd = &nd_table[n];
>
>         if (!nd->model || strcmp(nd->model, "mydevice") == 0) {
>             mydevice_init(nd, MYDEVICE_BASE, pic[17]);
>             break;
>         } else {
>         /* We don't know this NIC model */
>         }
>     }


> Now, the actual problem is that mydevice_init1() is called twice and
> the device state is also instantiated twice.

This is expected, because you're creating two devices.
Device 1 is the one that's created by calling
mydevice_init() here in the board code.
Device 2 is created because you say "-device mydevice"
on the command line.

smc91c111 is an "embedded" device which is memory mapped
into a particular address in the memory space and directly
wired up to an interrupt line. (QEMU calls these "sysbus
devices".) These can't be sensibly created from the command
line because there's no way to specify how to wire them
up and where they live in memory.

Conversely, the -device command line option is for
devices which go in pluggable buses, like PCI and
ISA devices. The -device option says "create one
of these and plug it into some available bus of
the right type"; it creates devices in addition to
any that the board creates itself.

The slightly odd thing is that -device mydevice
doesn't fail for you -- if you try that for smc91c111 it
will complain:
 "Device smc91c111 cannot be dynamically instantiated"
to let you know that the command line option is wrong.

PS: smc91c111 is not a very good model to copy,
because that device code is very old, and doesn't
necessarily follow current QEMU coding practices.
Looking at a device that's been added to QEMU
more recently may be a better idea.

thanks
-- PMM
