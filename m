Received: from eggs.gnu.org ([2001:4830:134:3::10]:45255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJMgt-0007uU-1O
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJMgn-0007ss-Vn
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:55:31 -0500
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:51698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eJMgn-0007jd-Ha
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:55:25 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 56E30FE675
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 17:55:16 +0100 (CET)
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
	<E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
	<CACPK8XdvUtvKiX_uqTnnb8U-jKuhy4Kw+cda=OKvzabfaffjgQ@mail.gmail.com>
	<20171127094436.GB31757@n2100.armlinux.org.uk>
	<ff0993df-8c3f-e985-8b1c-641a8de7dc21@kaod.org>
	<20171127104717.GD31757@n2100.armlinux.org.uk>
	<CAFEAcA_Bq1AtsGtv0gZLpcWwUrZ8b=OGGKmvz=EujJUkK9osOQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <08ef70f9-c70a-ca2c-1084-3920de9fe98e@kaod.org>
Date: Mon, 27 Nov 2017 17:55:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Bq1AtsGtv0gZLpcWwUrZ8b=OGGKmvz=EujJUkK9osOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] ARM: BUG if jumping to usermode
 address in kernel mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Joel Stanley <joel@jms.id.au>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Shi <alex.shi@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, QEMU Developers <qemu-devel@nongnu.org>

On 11/27/2017 12:50 PM, Peter Maydell wrote:
> On 27 November 2017 at 11:47, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Mon, Nov 27, 2017 at 11:16:06AM +0100, C=C3=A9dric Le Goater wrote:
>>> Additional QEMU logging gives us :
>>>
>>>   Ignoring attempt to switch CPSR_A flag from non-secure world with S=
CR.AW bit clear
>>>   Ignoring attempt to switch CPSR_F flag from non-secure world with S=
CR.FW bit clear
>=20
>> From what it sounds like, when you run the kernel without uboot, QEMU
>> decides to run the kernel in the nonsecure world.  If it did the same
>> with u-boot, u-boot would not be able to change the SCR register, so
>> u-boot must run in the secure world if it's setting the AW and FW
>> bits.
>=20
> Yes, this seems like a QEMU bug. (Added qemu-devel to cc: accordingly).
> We'll print this warning for a v7 CPU which has the Security Extensions
> but not the Virtualization Extensions (which is the case where the
> architecture mandates that NS not be able to change the CPSR.A and
> F bits), but we shouldn't (in theory) get into that situation
> because either:
>  * we started the emulation by running a secure bootrom, which
>    should have initialized SCR.AW/FW correctly before booting the
>    NS kernel (I assume this is the "run from u-boot" setup)
>  * we started the kernel directly from QEMU, in which case QEMU's
>    internal "act like a bootloader" code should have done the
>    setting of SCR.AW/FW.
>=20
> Cedric's command line is the second of these types, so something's
> gone wrong in our internal bootloader. The code in
> hw/arm/boot.c:arm_write_secure_board_setup_dummy_smc() sets up
> a little bit of guest code that runs in secure mode and sets
> SCR.AW/FW. I suspect the romulus-bmc machine model isn't invoking
> that code.

Indeed, it is missing.=20

With a quick hack adding the extra secure boot loader, I could=20
boot the QEMU romulus-bmc machine (armv6 CPU) with 4.15-rc1 kernel.
All is fine. =20
 =20
But the code of the Aspeed machines also covers the ast2400 SoC=20
which uses an armv5 CPU. So it needs some rework. That will be for
QEMU 2.12 I suppose.

Thank,

C.


> Most QEMU users shouldn't be affected by this because not
> many board models default to enabling the security extensions
> in the emulated CPU, and the highbank and raspi boards at least
> do do this secure-mode setup I think.
>=20
> thanks
> -- PMM
>=20
