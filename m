Received: from eggs.gnu.org ([2001:4830:134:3::10]:48242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cvPUg-0000iB-Gr
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1cvPUd-0005qk-Bl
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:31:38 -0400
Date: Tue, 4 Apr 2017 16:31:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170404143121.GA6421@kozik-book>
References: <20170318192509.15499-1-krzk@kernel.org>
	<CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
	<20170404134402.GA4196@kozik-book>
	<CAFEAcA9UGEVVUfL3--goP4mVU+ezegWPcoka41XM8d_E2yyJkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9UGEVVUfL3--goP4mVU+ezegWPcoka41XM8d_E2yyJkQ@mail.gmail.com>
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

On Tue, Apr 04, 2017 at 03:05:09PM +0100, Peter Maydell wrote:
> On 4 April 2017 at 14:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Tue, Apr 04, 2017 at 01:09:08PM +0100, Peter Maydell wrote:
> >> On 18 March 2017 at 19:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> > Add emulation for Exynos4210 Pseudo Random Number Generator which could
> >> > work on fixed seeds or with seeds provided by True Random Number
> >> > Generator block inside the SoC.
> >> >
> >> > Implement only the fixed seeds part of it in polling mode (no
> >> > interrupts).  Simple testing:
> >> >     # echo "exynos" > /sys/class/misc/hw_random/rng_current
> >> >     # dd if=/dev/hwrng of=/dev/null bs=1 count=16
> >> >
> >> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> >
> >> > ---
> >> >
> >> > Changes since v1:
> >> > 1. Use GRand-like functions to fix build on MingW32 (this adds also
> >> >    finalize).
> >> > 2. Add DPRINTF macro.
> >> > 3. Use HWADDR_PRIx and family for printing values.
> >>
> >> Is there a data sheet that describes this RNG? I had a quick google
> >> but couldn't find anything in the 4210 manual you can get from Samsung.
> >
> > Official and public datasheet - I never heard about it... AFAIK, Samsung
> > never released any datasheet... But recently I found a copy of
> > Exynos4412 datasheet published on FriendlyArm website:
> > http://wiki.friendlyarm.com/wiki/index.php/NanoPC-T1
> > (at the bottom in "Resources").
> >
> > Some blocks in Exynos4412, including the RNG, are the same as in
> > Exynos4210. However, you should not expect too much data about the RNG
> > in the datasheet...
> >
> >> In particular I'm not sure we want to use GRand here.
> >
> > Now, I am not sure neither. :)
> 
> The last RNG we added was hw/misc/bcm2835_rng.c, which uses
> qcrypto_random_bytes() to get cryptographically-random bytes
> from the host. On the other hand it sounds like this Exynos
> hardware is a PRNG without true-random input...

Yes, I think that is the case. The PRNG block looks the same on all
Exynos SoCs. At least from datasheet perspective and registers.
The difference came with Exynos5420 with introducing another block -
True RNG - which could be chained to PRNG as seed. However the PRNG
stays the same (according to datasheet).

Unfortunately I could not verify too much of this because on Exynos5420
apparently the PRNG block is locked by SecureMonitor.

At some point I will probably get back to Exynos5420 (and True RNG) but
till then, the choice of GRand repeatable random sequences makes some
sense to me.

The remaining issue with this QEMU patch, brought to light during
discussions on LKML, is that it does not accept multiple seeds. From
what I understood, a good PRNG should be able to consume more seeds
at one pass (into same registers) thus. In other words these cases
should produce different results:
1. Seed(a), random
2. Seed(b), Seed(a), random

As of now, I think GRand will not allow this.

The hardware on Exynos4412 behaves like this plus it generates random
numbers even for the same seed after reboot (which could mean that it
was seeded by bootloader or Secure OS).

Best regards,
Krzysztof
