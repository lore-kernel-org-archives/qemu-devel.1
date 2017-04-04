Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cvOl6-00038n-VW
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cvOl5-000830-U1
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:44:33 -0400
Date: Tue, 4 Apr 2017 15:44:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170404134402.GA4196@kozik-book>
References: <20170318192509.15499-1-krzk@kernel.org>
	<CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc: Add Exynos4210 Pseudo Random
 Number Generator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Apr 04, 2017 at 01:09:08PM +0100, Peter Maydell wrote:
> On 18 March 2017 at 19:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Add emulation for Exynos4210 Pseudo Random Number Generator which could
> > work on fixed seeds or with seeds provided by True Random Number
> > Generator block inside the SoC.
> >
> > Implement only the fixed seeds part of it in polling mode (no
> > interrupts).  Simple testing:
> >     # echo "exynos" > /sys/class/misc/hw_random/rng_current
> >     # dd if=/dev/hwrng of=/dev/null bs=1 count=16
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Use GRand-like functions to fix build on MingW32 (this adds also
> >    finalize).
> > 2. Add DPRINTF macro.
> > 3. Use HWADDR_PRIx and family for printing values.
> 
> Is there a data sheet that describes this RNG? I had a quick google
> but couldn't find anything in the 4210 manual you can get from Samsung.

Official and public datasheet - I never heard about it... AFAIK, Samsung
never released any datasheet... But recently I found a copy of
Exynos4412 datasheet published on FriendlyArm website:
http://wiki.friendlyarm.com/wiki/index.php/NanoPC-T1
(at the bottom in "Resources").

Some blocks in Exynos4412, including the RNG, are the same as in
Exynos4210. However, you should not expect too much data about the RNG
in the datasheet...

> In particular I'm not sure we want to use GRand here.

Now, I am not sure neither. :) Let me describe the background:

Recently I started also improving the Linux kernel driver for RNG module
which ended in writing a new driver followed by discussions
from which I learnt a lot. See [1][2][3]

The datasheet is not saying too much how the RNG module works inside...
so it is all a guessing. I must admit that I wrote the QEMU RNG part mostly
looking at behavior of kernel driver and combining the knowledge with
information obtained from datasheet. Thus I used GRand to have
repeatable sequences for same seed.

During the discussions about new kernel driver, I found that this RNG
module (at least on Exynos4412 board) requires seeding but it is not
following the Pseudo RNG behavior - seeding with the same value produces
different results. This means that GRand would not be needed here.

The new driver (not merged yet) took this into account and it behaves
differently than previous one. Most notably it tries to be a better pseudo
random number generator in terms of randomness.

I did not test the new kernel driver with this QEMU RNG driver because
it uses different user-space API and I still did not configure full
Linux box in QEMU (mounting root, having some distro in the image). I am
booting the QEMU kernel to initramfs with some toolset included.

[1] https://www.spinics.net/lists/kernel/msg2474154.html
[2] https://www.spinics.net/lists/arm-kernel/msg571653.html
[3] https://www.spinics.net/lists/arm-kernel/msg571516.html


Best regards,
Krzysztof
