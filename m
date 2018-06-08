Received: from eggs.gnu.org ([2001:4830:134:3::10]:40947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRGHD-0002fB-1f
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRGHB-00074C-B6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:13:55 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRGHA-000735-T2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:13:53 -0400
Received: by mail-ot0-x244.google.com with SMTP id d19-v6so9859798oti.8
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:13:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180607180641.874-8-f4bug@amsat.org>
References: <20180607180641.874-1-f4bug@amsat.org>
	<20180607180641.874-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Jun 2018 13:13:31 +0100
Message-ID: <CAFEAcA_9e6_=2doj0_uJCDEWiho0WqnAU6SXhdh--Yeb7m++nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/7] hw/sd/ssi-sd: Force cards
 connected in SPI mode to use Spec v1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 7 June 2018 at 19:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Due to physical restriction in SPI mode the maximum transfer
> speed is limited. All the extensions added after Spec v3 are
> simply not supported in SPI mode:

You say here that SPI mode doesn't support extensions added
"after spec v3"...

>   7.1 Introduction
>
>     The SPI mode consists of a secondary communication protocol
>     that is offered by Flash-based SD Memory Cards. This mode is
>     a subset of the SD Memory Card protocol, designed to communicate
>     with a SPI channel, commonly found in Motorola's (and lately a
>     few other vendors') microcontrollers. The interface is selected
>     during the first reset command after power up (CMD0) and cannot
>     be changed once the part is powered on.
>     The SPI standard defines the physical link only, and not the
>     complete data transfer protocol. The SD Memory Card SPI
>     implementation uses a subset of the SD Memory Card protocol and
>     command set. The advantage of the SPI mode is the capability of
>     using an off-the-shelf host, hence reducing the design-in effort
>     to minimum. The disadvantage is the loss of performance of the
>     SPI mode versus SD mode (e.g. Single data line and hardware CS
>     signal per card).
>     The commands and functions in SD mode defined after the Version
>     2.00 are not supported in SPI mode.

...but here quote the spec which says that commands defined after
version 2.00 are not supported in SPI mode...

and then the patch itself enforces spec 1.10, rather than 2.
So I'm confused.

> The card may respond to the
>     commands and functions even if the card is in SPI mode but host
>     should not use them in SPI mode.
>
> Some firmwares use the CMD8 in SPI mode to poll which Spec version
> the SD card supports.
>
>   7.2.1 Mode Selection and Initialization (SPI mode)
>
>     The SD Card is powered up in the SD mode. It will enter SPI mode
>     if the CS signal is asserted (negative) during the reception of
>     the reset command (CMD0). If the card recognizes that the SD mode
>     is required it will not respond to the command and remain in the
>     SD mode. If SPI mode is required, the card will switch to SPI and
>     respond with the SPI mode R1 response.
>     The only way to return to the SD mode is by entering the power
>     cycle. In SPI mode, the SD Card protocol state machine in SD mode
>     is not observed. All the SD Card commands supported in SPI mode
>     are always available. [...]
>     If the card indicates an illegal command, the card is legacy and
>     does not support CMD8. If the card supports CMD8 and can operate
>     on the supplied voltage, the response echoes back the supply
>     voltage and the check pattern that were set in the command
>     argument.
>
> The NuttX RTOS use it too:
>
>     /* Check for SDHC Version 2.x.  CMD 8 is reserved on SD version 1.0 a=
nd
>      * MMC.
>      */
>     finfo("Send CMD8\n");
>     result =3D mmcsd_sendcmd(slot, &g_cmd8, 0x1aa);
>     if (result =3D=3D MMCSD_SPIR1_IDLESTATE)
>       ...
>     /* Check for SDC version 1.x or MMC */
>     else
>       ...
>
> See https://bitbucket.org/nuttx/nuttx/src/nuttx-7.25/drivers/mmcsd/mmcsd_=
spi.c?mmcsd_spi.c-1645#mmcsd_spi.c-1645

This seems reasonable guest behaviour, and it's what the spec says
to do. Why do we need to enforce 1.10 to get things to work?

thanks
-- PMM
