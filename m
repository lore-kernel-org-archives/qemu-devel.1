Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxb2z-0002cI-7p
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxb2y-0005k9-3A
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:16:05 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxb2x-0005jv-Sw
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:16:04 -0400
Received: by mail-wr0-x234.google.com with SMTP id o21so122832634wrb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 08:16:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170404143121.GA6421@kozik-book>
References: <20170318192509.15499-1-krzk@kernel.org>
	<CAFEAcA8WGoa=DYXRH4MHfnHmUR_5-xERdmcuqrsk=bmS7GBCmg@mail.gmail.com>
	<20170404134402.GA4196@kozik-book>
	<CAFEAcA9UGEVVUfL3--goP4mVU+ezegWPcoka41XM8d_E2yyJkQ@mail.gmail.com>
	<20170404143121.GA6421@kozik-book>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 16:15:42 +0100
Message-ID: <CAFEAcA_DaW_DdcYweHPGpJrMNMP+Sd-Bw6W_OM7tCF5cMyh4aQ@mail.gmail.com>
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 4 April 2017 at 15:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, Apr 04, 2017 at 03:05:09PM +0100, Peter Maydell wrote:
>> On 4 April 2017 at 14:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > On Tue, Apr 04, 2017 at 01:09:08PM +0100, Peter Maydell wrote:
>> >> Is there a data sheet that describes this RNG? I had a quick google
>> >> but couldn't find anything in the 4210 manual you can get from Samsung.
>> >
>> > Official and public datasheet - I never heard about it... AFAIK, Samsung
>> > never released any datasheet... But recently I found a copy of
>> > Exynos4412 datasheet published on FriendlyArm website:
>> > http://wiki.friendlyarm.com/wiki/index.php/NanoPC-T1
>> > (at the bottom in "Resources").
>> >
>> > Some blocks in Exynos4412, including the RNG, are the same as in
>> > Exynos4210. However, you should not expect too much data about the RNG
>> > in the datasheet...
>> >
>> >> In particular I'm not sure we want to use GRand here.
>> >
>> > Now, I am not sure neither. :)
>>
>> The last RNG we added was hw/misc/bcm2835_rng.c, which uses
>> qcrypto_random_bytes() to get cryptographically-random bytes
>> from the host. On the other hand it sounds like this Exynos
>> hardware is a PRNG without true-random input...
>
> Yes, I think that is the case. The PRNG block looks the same on all
> Exynos SoCs. At least from datasheet perspective and registers.
> The difference came with Exynos5420 with introducing another block -
> True RNG - which could be chained to PRNG as seed. However the PRNG
> stays the same (according to datasheet).
>
> Unfortunately I could not verify too much of this because on Exynos5420
> apparently the PRNG block is locked by SecureMonitor.
>
> At some point I will probably get back to Exynos5420 (and True RNG) but
> till then, the choice of GRand repeatable random sequences makes some
> sense to me.

I was talking to Dan on IRC and his suggestion was that we should just
use qcrypto_random_bytes() for everything. On the other hand I'm
not totally sure that's the right approach.

I think my core issue here is that we really don't understand what
the hardware is doing or what the properties of its randomness
actually are. To me that says "Linux should not trust this thing
at all and shouldn't use it" which in turn makes implementing a
model in QEMU less important :-)

thanks
-- PMM
