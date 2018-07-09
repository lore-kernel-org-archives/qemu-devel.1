Received: from eggs.gnu.org ([2001:4830:134:3::10]:35357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcVte-0006fA-KP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcVtd-0007iX-P5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:08:06 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcVtd-0007iI-JB
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:08:05 -0400
Received: by mail-oi0-x241.google.com with SMTP id c6-v6so35767424oiy.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 06:08:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706162155.8432-2-f4bug@amsat.org>
References: <20180706162155.8432-1-f4bug@amsat.org>
	<20180706162155.8432-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 14:07:44 +0100
Message-ID: <CAFEAcA8zeJYCD_1fee==nCYo8tWk61wzQoiR_KEA8CZ_GzyBaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/1] hw/sd/omap_mmc: Split
 'pseudo-reset' from 'power-on-reset'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrzej Zaborowski <balrogg@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 6 July 2018 at 17:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> DeviceClass::reset models a "cold power-on" reset which can
> also be use to powercycle a device; but there is no "hot reset"
> (a.k.a. soft-reset) method available.
>
> The OMAP MMC Power-Up Control bit is not designed to powercycle
> a card, but to disable it without powering it off (pseudo-reset):
>
>   Multimedia Card (MMC/SD/SDIO) Interface [SPRU765A]
>
>   MMC_CON[11] Power-Up Control (POW)
>   This bit must be set to 1 before any valid transaction to either
>   MMC/SD or SPI memory cards.
>   When 1, the card is considered powered-up and the controller core
>   is enabled.
>   When 0, the card is considered powered-down (system dependent),
>   and the controller core logic is in pseudo-reset state. This is,
>   the MMC_STAT flags and the FIFO pointers are reset, any access to
>   MMC_DATA[DATA] has no effect, a write into the MMC.CMD register
>   is ignored, and a setting of MMC_SPI[STR] to 1 is ignored.

This text says that the card "is considered powered-down (system
dependent)", so it's not entirely invalid to reset the card here.
Still, if the guests get confused by it I guess that the n8x0
systems didn't do that, and certainly resetting the other parts
of the controller state is wrong.

Strictly I guess we should also check the enable flag for the other
things this text calls out:
 * accesses to MMC_DATA[DATA]
 * writes to MMC.CMD (we already do this)
 * setting MMC_SPI[STR] to 1 (we don't emulate MMC_SPI)

but we should probably consider that a separate bug. (And the
n8x0 boards are pretty much unmaintained currently, so I don't
care very much whether we fix it or not. I don't have any working
test images -- I have one of uncertain vintage which seems to
be flaky when it gets to the mmc card init, but I think it
makes a bit more progress with this patch now.)

Applied to target-arm.next, thanks.

thanks
-- PMM
