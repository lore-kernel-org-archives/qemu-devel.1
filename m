Received: from eggs.gnu.org ([2001:4830:134:3::10]:39809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckIdV-0004UY-7N
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 17:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckIdS-0005zX-5J
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 17:58:49 -0500
Date: Sat, 4 Mar 2017 23:58:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_KxS6J3Mzrc+ijg0LGdxZsk_FDd9xAExGROgWYn-3qyQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703042344460.63482@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<6b70a9dfe56c3a0dc8e874c45d70612aff7b8e3a.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA9FL-sshVzKewf+rCs6-5_c2Y86Qy0b=3DMog4MrVOpwA@mail.gmail.com>
	<alpine.BSF.2.20.1703030259350.33600@zero.eik.bme.hu>
	<CAFEAcA-PUcPaOPOXXhab1N=YAHja0xCf5yaZYm5m0p1=j6A=WA@mail.gmail.com>
	<alpine.BSF.2.20.1703032100430.14293@zero.eik.bme.hu>
	<CAFEAcA_KxS6J3Mzrc+ijg0LGdxZsk_FDd9xAExGROgWYn-3qyQ@mail.gmail.com>
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

On Sat, 4 Mar 2017, Peter Maydell wrote:
> On 3 March 2017 at 20:11, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Fri, 3 Mar 2017, Peter Maydell wrote:
>>> So what cases have you tested? The Linux kernel seems to support:
>>> * sh embedded device, little endian
>>> * PCI card, little endian host
>>> * PCI card, big endian host
>>> and there are also
>>> * 16 bit pixel format
>>> * 32 bit pixel format
>>>
>>> which makes 6 different combinations.
>>> (It's a shame there's no sh4 BE code to run on this.)
>>
>>
>> As mentioned before I've used this image to test SH:
>>
>> https://people.debian.org/~aurel32/qemu/sh4/
>>
>> with video=800x600-16 kernel parameter where changing -16 to different bit
>> depths (8, 32) reproduces the problem. On ppc I've tested with MorphOS which
>> uses 16 bpp, Linux and U-boot which I think uses 8 bit. These run on real
>> hardware so I think if they work the emulation should be OK.
>>
>> You've said before that PCI is likely always little endian and SH embedded
>> is LE too so unless something uses the device in BE mode (which we don't
>> emulate) setting it to little endian should be correct. For frame buffer
>> endianness I can only go with what I've seen clients doing and my patch does
>> what worked for the above on SH and PPC. I can't prove it's correct but
>> works for the systems I've targeted and also fixes the SH case which seemed
>> to be broken.
>
> Right, but we should test the PCI-on-a-little-endian CPU
> case, because right now your code has #ifdef TARGET_WORDS_BIGENDIAN
> in it which means that the PCI device will behave differently
> on big and little endian CPUs, and you have a case that you
> haven't tested.

I could not find an image to test this. I've tried removing the sysbus 
version from SH and add a PCI one instead but then Linux did not seem to 
find the card. I could not find any other OS images that would have this 
combination that is also known to work on any real hardware so I think if 
someone ever finds a problem with such combination then we can fix it when 
having a test case, since I could not figure out theoretically what should 
be the right way.

> (At the moment with the set of cases you've tested the
> sh embedded device ones will always be using the "not
> TARGET_WORDS_BIGENDIAN" code and the PCI-on-PPC will
> always use the "is TARGET_WORDS_BIGENDIAN" code. But
> TARGET_WORDS_BIGENDIAN set/not set is orthogonal to
> PCI-vs-embedded.)

Why do you think that framebuffer endianness is dependent on 
PCI-vs-embedded as opposed to target endianness? The latter seems more 
plausible to me. The TARGET_WORDS_BIGENDIAN was already there for 32 bit 
case. My patch only adds it to the 16 bit too and fixing the bytes for 
both (which seemed to be already wrong even on SH). So I think previously 
it was broken, my patch fixes it to be better (or at most broken in a
different way) so I don't think it's worse than before thus, an 
improvement.

> thanks
> -- PMM
>
>
