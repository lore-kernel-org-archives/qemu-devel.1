Received: from eggs.gnu.org ([2001:4830:134:3::10]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJHw0-0006dj-1o
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJHvz-0001UD-1a
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:50:48 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJHvy-0001Tp-T0
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:50:46 -0500
Received: by mail-ot0-x244.google.com with SMTP id t79so23913921ota.3
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 03:50:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171127104717.GD31757@n2100.armlinux.org.uk>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
	<E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
	<CACPK8XdvUtvKiX_uqTnnb8U-jKuhy4Kw+cda=OKvzabfaffjgQ@mail.gmail.com>
	<20171127094436.GB31757@n2100.armlinux.org.uk>
	<ff0993df-8c3f-e985-8b1c-641a8de7dc21@kaod.org>
	<20171127104717.GD31757@n2100.armlinux.org.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2017 12:50:24 +0100
Message-ID: <CAFEAcA_Bq1AtsGtv0gZLpcWwUrZ8b=OGGKmvz=EujJUkK9osOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley <joel@jms.id.au>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Shi <alex.shi@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 November 2017 at 11:47, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Nov 27, 2017 at 11:16:06AM +0100, C=C3=A9dric Le Goater wrote:
>> Additional QEMU logging gives us :
>>
>>   Ignoring attempt to switch CPSR_A flag from non-secure world with SCR.=
AW bit clear
>>   Ignoring attempt to switch CPSR_F flag from non-secure world with SCR.=
FW bit clear

> From what it sounds like, when you run the kernel without uboot, QEMU
> decides to run the kernel in the nonsecure world.  If it did the same
> with u-boot, u-boot would not be able to change the SCR register, so
> u-boot must run in the secure world if it's setting the AW and FW
> bits.

Yes, this seems like a QEMU bug. (Added qemu-devel to cc: accordingly).
We'll print this warning for a v7 CPU which has the Security Extensions
but not the Virtualization Extensions (which is the case where the
architecture mandates that NS not be able to change the CPSR.A and
F bits), but we shouldn't (in theory) get into that situation
because either:
 * we started the emulation by running a secure bootrom, which
   should have initialized SCR.AW/FW correctly before booting the
   NS kernel (I assume this is the "run from u-boot" setup)
 * we started the kernel directly from QEMU, in which case QEMU's
   internal "act like a bootloader" code should have done the
   setting of SCR.AW/FW.

Cedric's command line is the second of these types, so something's
gone wrong in our internal bootloader. The code in
hw/arm/boot.c:arm_write_secure_board_setup_dummy_smc() sets up
a little bit of guest code that runs in secure mode and sets
SCR.AW/FW. I suspect the romulus-bmc machine model isn't invoking
that code.

Most QEMU users shouldn't be affected by this because not
many board models default to enabling the security extensions
in the emulated CPU, and the highbank and raspi boards at least
do do this secure-mode setup I think.

thanks
-- PMM
