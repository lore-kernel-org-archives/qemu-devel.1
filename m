Received: from eggs.gnu.org ([2001:4830:134:3::10]:35480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjtXr-0007CL-Dw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjtXn-0003CR-EH
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 15:11:19 -0500
Date: Fri, 3 Mar 2017 21:11:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-PUcPaOPOXXhab1N=YAHja0xCf5yaZYm5m0p1=j6A=WA@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703032100430.14293@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<6b70a9dfe56c3a0dc8e874c45d70612aff7b8e3a.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA9FL-sshVzKewf+rCs6-5_c2Y86Qy0b=3DMog4MrVOpwA@mail.gmail.com>
	<alpine.BSF.2.20.1703030259350.33600@zero.eik.bme.hu>
	<CAFEAcA-PUcPaOPOXXhab1N=YAHja0xCf5yaZYm5m0p1=j6A=WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 07/14] sm501: Fix device endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 3 Mar 2017, Peter Maydell wrote:
> On 3 March 2017 at 02:15, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Maybe it's not correct but works for everything I could test better than the
>> original code (which was broken even for the SH images one can find) so I
>> think we could just go with this until someone complains and provides a test
>> case. I've given up on trying to understand it because I don't really know
>> this device and SH so I could only go by the images I could find and they
>> seem to like it this way.
>
> So what cases have you tested? The Linux kernel seems to support:
> * sh embedded device, little endian
> * PCI card, little endian host
> * PCI card, big endian host
> and there are also
> * 16 bit pixel format
> * 32 bit pixel format
>
> which makes 6 different combinations.
> (It's a shame there's no sh4 BE code to run on this.)

As mentioned before I've used this image to test SH:

https://people.debian.org/~aurel32/qemu/sh4/

with video=800x600-16 kernel parameter where changing -16 to different bit 
depths (8, 32) reproduces the problem. On ppc I've tested with MorphOS 
which uses 16 bpp, Linux and U-boot which I think uses 8 bit. These run on 
real hardware so I think if they work the emulation should be OK.

You've said before that PCI is likely always little endian and SH embedded 
is LE too so unless something uses the device in BE mode (which we don't 
emulate) setting it to little endian should be correct. For frame buffer 
endianness I can only go with what I've seen clients doing and my patch 
does what worked for the above on SH and PPC. I can't prove it's correct 
but works for the systems I've targeted and also fixes the SH case which 
seemed to be broken.

>>> Looking at how the SWAP_FB_ENDIAN flag gets set:
>>> * for the r2d board it is set always
>>> * for PCI devices, it is set only if big-endian
>>>
>>> I suspect that what we actually have here is something
>>> like:
>>> * for the PCI device it's always little endian (and the
>>>   code ought not to need to depend on TARGET_WORDS_BIGENDIAN)
>>> * sysbus device may be more complicated
>>>
>>> Also I note there's an SM501_ENDIAN_CONTROL register on the
>>> device, which presumably if written changes the behaviour.
>
>> I've seen this but it's not emulated so it can be ignored for now. The spec
>> also says that default is little endian so for regs at least
>> DEVICE_LITTLE_ENDIAN should be OK.
>
> Yes, that makes sense. So we should be modelling this as an "always
> little endian device".
>
> The changes you have to the memory region ops achieve this for
> the registers implemented in this device itself. It looks like
> SYSBUS_OHCI is already always little endian. You also need to
> change the argument to the serial_mm_init() call to pass
> DEVICE_LITTLE_ENDIAN.

OK, will do that.
