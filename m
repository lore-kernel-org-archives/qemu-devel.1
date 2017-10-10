Received: from eggs.gnu.org ([2001:4830:134:3::10]:55152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1uTF-0001nl-QZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1uTA-00035J-Qm
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:21:17 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:53961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1uTA-00033k-KH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:21:12 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 902075A3EC
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:21:09 +0200 (CEST)
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-2-clg@kaod.org>
	<CAFEAcA9-dmTD3v1YU7Wr5EcA53z=c_WxS0K1+1zbw16q=vj-vQ@mail.gmail.com>
	<f3871f0a-7df2-a5e0-1770-8df04bb76750@kaod.org>
	<CAFEAcA-kJ-qEoo-2ZWaH0XPv-cJA4O3wZAW=FwmM5nUU4-mVBg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <900ffff3-3667-7e17-bf38-7c6a520ed838@kaod.org>
Date: Tue, 10 Oct 2017 15:21:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-kJ-qEoo-2ZWaH0XPv-cJA4O3wZAW=FwmM5nUU4-mVBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 10/10/2017 11:54 AM, Peter Maydell wrote:
> On 10 October 2017 at 10:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> On 10/06/2017 05:10 PM, Peter Maydell wrote:
>>>> +    mc->ignore_memory_transaction_failures =3D true;
>>>
>>> Please don't set this flag for new board models, it is only
>>> for our legacy existing ones. Instead implement any devices
>>> that you need for guest code to boot (stub them out with
>>> create_unimplemented_device() if you like).
>>
>> I have dug into this a little more and it seems that it is
>> required for the Aspeed bootloader (a modified u-boot) which
>> uses static variables in early init phases. So legacy firmwares
>> won't work in QEMU but will on real HW.
>>
>> It's fine with me but what is the goal of the approach ? Force
>> SoC providers into fixing their FW when they use QEMU ?
>=20
> The goal is to model hardware correctly. Hardware gives
> aborts if you touch a physical address with no device there,
> and so QEMU's model should do the same. If you have guest
> code that touches a physical address and blows up because
> of an abort (but doesn't when run on h/w) then either:
>  * it is trying to probe a device that exists in real h/w:
>    you need to provide a stub implementation in QEMU
>  * the SoC's bus fabric really doesn't pass aborts back
>    to the CPU; I think this is unlikely, but you can model
>    it at the SoC level with a suitable default memory region

well, that is case it seems.=20

Anyhow, I found the required fixes in u-boot, so I will go with=20
ignore_memory_transaction_failures=3Dfalse with this new machine.

Thanks,

C.=20
=20
> The purpose of the flag is purely for existing board models,
> where it is impossible to enable the correct (abort)
> behaviour without possibly breaking guest code images that
> work for people using released QEMU code. On a new board
> model we don't have that problem and we can get it right
> from the start. If we don't get it right from the start
> then we will never have a chance to fix it in future.
>=20
> Our mismodelling of this (not turning accesses to invalid
> addresses into CPU aborts) meant that in the past it was
> possible to be lazy when implementing a board model and
> just not model half the hardware at all. Now it isn't,
> but I don't think that adding a set of calls to
> create_unimplemented_device() is a significant imposition.
>=20
> thanks
> -- PMM
>=20
