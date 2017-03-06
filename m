Received: from eggs.gnu.org ([2001:4830:134:3::10]:39488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpwT-00026H-EJ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpwS-0008WF-IO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:32:37 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckpwS-0008Vx-DF
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:32:36 -0500
Received: by mail-wm0-x22d.google.com with SMTP id n11so60022359wma.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 02:32:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1703042344460.63482@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<6b70a9dfe56c3a0dc8e874c45d70612aff7b8e3a.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA9FL-sshVzKewf+rCs6-5_c2Y86Qy0b=3DMog4MrVOpwA@mail.gmail.com>
	<alpine.BSF.2.20.1703030259350.33600@zero.eik.bme.hu>
	<CAFEAcA-PUcPaOPOXXhab1N=YAHja0xCf5yaZYm5m0p1=j6A=WA@mail.gmail.com>
	<alpine.BSF.2.20.1703032100430.14293@zero.eik.bme.hu>
	<CAFEAcA_KxS6J3Mzrc+ijg0LGdxZsk_FDd9xAExGROgWYn-3qyQ@mail.gmail.com>
	<alpine.BSF.2.20.1703042344460.63482@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 10:32:14 +0000
Message-ID: <CAFEAcA9euFa=fypaZaO5prpNQ6mdCmaSZgu3dofVgh2bYcSSxA@mail.gmail.com>
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

On 4 March 2017 at 22:58, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Sat, 4 Mar 2017, Peter Maydell wrote:
>> Right, but we should test the PCI-on-a-little-endian CPU
>> case, because right now your code has #ifdef TARGET_WORDS_BIGENDIAN
>> in it which means that the PCI device will behave differently
>> on big and little endian CPUs, and you have a case that you
>> haven't tested.
>
>
> I could not find an image to test this. I've tried removing the sysbus
> version from SH and add a PCI one instead but then Linux did not seem to
> find the card.

I was thinking about testing the PCI card on x86.

> I could not find any other OS images that would have this
> combination that is also known to work on any real hardware so I think if
> someone ever finds a problem with such combination then we can fix it when
> having a test case, since I could not figure out theoretically what should
> be the right way.
>
>> (At the moment with the set of cases you've tested the
>> sh embedded device ones will always be using the "not
>> TARGET_WORDS_BIGENDIAN" code and the PCI-on-PPC will
>> always use the "is TARGET_WORDS_BIGENDIAN" code. But
>> TARGET_WORDS_BIGENDIAN set/not set is orthogonal to
>> PCI-vs-embedded.)
>
>
> Why do you think that framebuffer endianness is dependent on PCI-vs-embedded
> as opposed to target endianness? The latter seems more plausible to me.

The PCI card should behave the same way whether you plug it
into a PPC system or an x86 system (since it's the same
hardware). So code in the handling of the PCI card that
looks at TARGET_WORDS_BIGENDIAN is suspicious.

thanks
-- PMM
