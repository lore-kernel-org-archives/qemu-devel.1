Received: from eggs.gnu.org ([2001:4830:134:3::10]:48028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1rFV-0002T5-OS
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1rFU-00070X-SN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:54:53 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:46718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1rFU-0006zx-MN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:54:52 -0400
Received: by mail-wm0-x233.google.com with SMTP id m72so3472773wmc.1
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 02:54:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f3871f0a-7df2-a5e0-1770-8df04bb76750@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<CAFEAcA9-dmTD3v1YU7Wr5EcA53z=c_WxS0K1+1zbw16q=vj-vQ@mail.gmail.com>
	<f3871f0a-7df2-a5e0-1770-8df04bb76750@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 10:54:30 +0100
Message-ID: <CAFEAcA-kJ-qEoo-2ZWaH0XPv-cJA4O3wZAW=FwmM5nUU4-mVBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] aspeed: add support for the
 witherspoon-bmc board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 10 October 2017 at 10:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/06/2017 05:10 PM, Peter Maydell wrote:
>>> +    mc->ignore_memory_transaction_failures =3D true;
>>
>> Please don't set this flag for new board models, it is only
>> for our legacy existing ones. Instead implement any devices
>> that you need for guest code to boot (stub them out with
>> create_unimplemented_device() if you like).
>
> I have dug into this a little more and it seems that it is
> required for the Aspeed bootloader (a modified u-boot) which
> uses static variables in early init phases. So legacy firmwares
> won't work in QEMU but will on real HW.
>
> It's fine with me but what is the goal of the approach ? Force
> SoC providers into fixing their FW when they use QEMU ?

The goal is to model hardware correctly. Hardware gives
aborts if you touch a physical address with no device there,
and so QEMU's model should do the same. If you have guest
code that touches a physical address and blows up because
of an abort (but doesn't when run on h/w) then either:
 * it is trying to probe a device that exists in real h/w:
   you need to provide a stub implementation in QEMU
 * the SoC's bus fabric really doesn't pass aborts back
   to the CPU; I think this is unlikely, but you can model
   it at the SoC level with a suitable default memory region

The purpose of the flag is purely for existing board models,
where it is impossible to enable the correct (abort)
behaviour without possibly breaking guest code images that
work for people using released QEMU code. On a new board
model we don't have that problem and we can get it right
from the start. If we don't get it right from the start
then we will never have a chance to fix it in future.

Our mismodelling of this (not turning accesses to invalid
addresses into CPU aborts) meant that in the past it was
possible to be lazy when implementing a board model and
just not model half the hardware at all. Now it isn't,
but I don't think that adding a set of calls to
create_unimplemented_device() is a significant imposition.

thanks
-- PMM
