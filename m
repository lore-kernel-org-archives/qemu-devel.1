Received: from eggs.gnu.org ([2001:4830:134:3::10]:56641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck8zK-00088B-7p
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck8zI-0005J1-R0
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:40:42 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ck8zI-0005I8-Jo
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:40:40 -0500
Received: by mail-wm0-x229.google.com with SMTP id v186so33207195wmd.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 04:40:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1703032100430.14293@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<6b70a9dfe56c3a0dc8e874c45d70612aff7b8e3a.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA9FL-sshVzKewf+rCs6-5_c2Y86Qy0b=3DMog4MrVOpwA@mail.gmail.com>
	<alpine.BSF.2.20.1703030259350.33600@zero.eik.bme.hu>
	<CAFEAcA-PUcPaOPOXXhab1N=YAHja0xCf5yaZYm5m0p1=j6A=WA@mail.gmail.com>
	<alpine.BSF.2.20.1703032100430.14293@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 12:40:17 +0000
Message-ID: <CAFEAcA_KxS6J3Mzrc+ijg0LGdxZsk_FDd9xAExGROgWYn-3qyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 07/14] sm501: Fix device endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 3 March 2017 at 20:11, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 3 Mar 2017, Peter Maydell wrote:
>> So what cases have you tested? The Linux kernel seems to support:
>> * sh embedded device, little endian
>> * PCI card, little endian host
>> * PCI card, big endian host
>> and there are also
>> * 16 bit pixel format
>> * 32 bit pixel format
>>
>> which makes 6 different combinations.
>> (It's a shame there's no sh4 BE code to run on this.)
>
>
> As mentioned before I've used this image to test SH:
>
> https://people.debian.org/~aurel32/qemu/sh4/
>
> with video=800x600-16 kernel parameter where changing -16 to different bit
> depths (8, 32) reproduces the problem. On ppc I've tested with MorphOS which
> uses 16 bpp, Linux and U-boot which I think uses 8 bit. These run on real
> hardware so I think if they work the emulation should be OK.
>
> You've said before that PCI is likely always little endian and SH embedded
> is LE too so unless something uses the device in BE mode (which we don't
> emulate) setting it to little endian should be correct. For frame buffer
> endianness I can only go with what I've seen clients doing and my patch does
> what worked for the above on SH and PPC. I can't prove it's correct but
> works for the systems I've targeted and also fixes the SH case which seemed
> to be broken.

Right, but we should test the PCI-on-a-little-endian CPU
case, because right now your code has #ifdef TARGET_WORDS_BIGENDIAN
in it which means that the PCI device will behave differently
on big and little endian CPUs, and you have a case that you
haven't tested.

(At the moment with the set of cases you've tested the
sh embedded device ones will always be using the "not
TARGET_WORDS_BIGENDIAN" code and the PCI-on-PPC will
always use the "is TARGET_WORDS_BIGENDIAN" code. But
TARGET_WORDS_BIGENDIAN set/not set is orthogonal to
PCI-vs-embedded.)

thanks
-- PMM
