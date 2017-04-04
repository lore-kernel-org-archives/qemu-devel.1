Received: from eggs.gnu.org ([2001:4830:134:3::10]:39076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvP5Q-0001dP-Fi
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvP5P-00023Q-Ag
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:05:32 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvP5P-00022X-4G
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 10:05:31 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k6so212043431wre.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 07:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170404134402.GA4196@kozik-book>
References: <20170318192509.15499-1-krzk@kernel.org>
	<CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
	<20170404134402.GA4196@kozik-book>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 15:05:09 +0100
Message-ID: <CAFEAcA9UGEVVUfL3--goP4mVU+ezegWPcoka41XM8d_E2yyJkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 April 2017 at 14:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Apr 04, 2017 at 01:09:08PM +0100, Peter Maydell wrote:
>> On 18 March 2017 at 19:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > Add emulation for Exynos4210 Pseudo Random Number Generator which could
>> > work on fixed seeds or with seeds provided by True Random Number
>> > Generator block inside the SoC.
>> >
>> > Implement only the fixed seeds part of it in polling mode (no
>> > interrupts).  Simple testing:
>> >     # echo "exynos" > /sys/class/misc/hw_random/rng_current
>> >     # dd if=/dev/hwrng of=/dev/null bs=1 count=16
>> >
>> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >
>> > ---
>> >
>> > Changes since v1:
>> > 1. Use GRand-like functions to fix build on MingW32 (this adds also
>> >    finalize).
>> > 2. Add DPRINTF macro.
>> > 3. Use HWADDR_PRIx and family for printing values.
>>
>> Is there a data sheet that describes this RNG? I had a quick google
>> but couldn't find anything in the 4210 manual you can get from Samsung.
>
> Official and public datasheet - I never heard about it... AFAIK, Samsung
> never released any datasheet... But recently I found a copy of
> Exynos4412 datasheet published on FriendlyArm website:
> http://wiki.friendlyarm.com/wiki/index.php/NanoPC-T1
> (at the bottom in "Resources").
>
> Some blocks in Exynos4412, including the RNG, are the same as in
> Exynos4210. However, you should not expect too much data about the RNG
> in the datasheet...
>
>> In particular I'm not sure we want to use GRand here.
>
> Now, I am not sure neither. :)

The last RNG we added was hw/misc/bcm2835_rng.c, which uses
qcrypto_random_bytes() to get cryptographically-random bytes
from the host. On the other hand it sounds like this Exynos
hardware is a PRNG without true-random input...

> During the discussions about new kernel driver, I found that this RNG
> module (at least on Exynos4412 board) requires seeding but it is not
> following the Pseudo RNG behavior - seeding with the same value produces
> different results. This means that GRand would not be needed here.

That's rather odd. You're right that the datasheet is hopelessly
uninformative about what's actually going on.

thanks
-- PMM
