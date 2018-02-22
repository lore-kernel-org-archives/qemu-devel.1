Received: from eggs.gnu.org ([2001:4830:134:3::10]:57760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoqTb-0006Cw-9A
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoqTa-0002z2-5T
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:59:55 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoqTZ-0002yk-U0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:59:54 -0500
Received: by mail-oi0-x242.google.com with SMTP id u6so3609251oiv.9
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 04:59:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215220540.6556-9-f4bug@amsat.org>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-9-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 12:59:32 +0000
Message-ID: <CAFEAcA-x+t_PNFmMRQBwRQddo9QH=sDWQDiib5TQ8Lb2UU+Rmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/11] sdcard: display command name when
 tracing CMD/ACMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 15 February 2018 at 22:05, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> put the function in sdmmc-common.c since we will reuse it in hw/sd/core.c
>

As a general note, your commit messages are generally a bit
shorter than I'd prefer. This is to some extent a personal
style question, but if you're writing lots of patches where
the only commit message is the subject-line summary then I
think that it's worth being a bit more descriptive.
Also, the "body" part of the commit message should really
be able to stand alone as a description, rather than relying
on the subject line to make sense.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdmmc-internal.h |  3 +++
>  hw/sd/sd.c             | 13 +++++----
>  hw/sd/sdmmc-common.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/sd/Makefile.objs    |  2 +-
>  hw/sd/trace-events     |  8 +++---
>  5 files changed, 88 insertions(+), 10 deletions(-)
>  create mode 100644 hw/sd/sdmmc-common.c
>
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index 0e96cb0081..02b730089b 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -12,4 +12,7 @@
>
>  #define SDMMC_CMD_MAX 64
>
> +const char *sd_cmd_name(uint8_t cmd);
> +const char *sd_acmd_name(uint8_t cmd);

Can we have doc comments for new function prototypes in header files,
please?


> diff --git a/hw/sd/sdmmc-common.c b/hw/sd/sdmmc-common.c
> new file mode 100644
> index 0000000000..1d0198b1ad
> --- /dev/null
> +++ b/hw/sd/sdmmc-common.c
> @@ -0,0 +1,72 @@
> +/*
> + * SD/MMC cards common helpers
> + *
> + * Copyright (c) 2018  Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later

Ooh, a SPDX identifier. The project doesn't actually use these
at the moment, but it doesn't hurt to have one here I guess.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "sdmmc-internal.h"
> +
> +const char *sd_cmd_name(uint8_t cmd)
> +{
> +    static const char *cmd_abbrev[SDMMC_CMD_MAX] =3D {
> +         [0]    =3D "GO_IDLE_STATE",
> +         [2]    =3D "ALL_SEND_CID",            [3]    =3D "SEND_RELATIVE=
_ADDR",
> +         [4]    =3D "SET_DSR",                 [5]    =3D "IO_SEND_OP_CO=
ND",
> +         [6]    =3D "SWITCH_FUNC",             [7]    =3D "SELECT/DESELE=
CT_CARD",
> +         [8]    =3D "SEND_IF_COND",            [9]    =3D "SEND_CSD",
> +        [10]    =3D "SEND_CID",               [11]    =3D "VOLTAGE_SWITC=
H",
> +        [12]    =3D "STOP_TRANSMISSION",      [13]    =3D "SEND_STATUS",
> +                                            [15]    =3D "GO_INACTIVE_STA=
TE",
> +        [16]    =3D "SET_BLOCKLEN",           [17]    =3D "READ_SINGLE_B=
LOCK",
> +        [18]    =3D "READ_MULTIPLE_BLOCK",    [19]    =3D "SEND_TUNING_B=
LOCK",
> +        [20]    =3D "SPEED_CLASS_CONTROL",    [21]    =3D "DPS_spec",
> +                                            [23]    =3D "SET_BLOCK_COUNT=
",
> +        [24]    =3D "WRITE_BLOCK",            [25]    =3D "WRITE_MULTIPL=
E_BLOCK",
> +        [26]    =3D "MANUF_RSVD",             [27]    =3D "PROGRAM_CSD",
> +        [28]    =3D "SET_WRITE_PROT",         [29]    =3D "CLR_WRITE_PRO=
T",
> +        [30]    =3D "SEND_WRITE_PROT",
> +        [32]    =3D "ERASE_WR_BLK_START",     [33]    =3D "ERASE_WR_BLK_=
END",
> +        [34]    =3D "SW_FUNC_RSVD",           [35]    =3D "SW_FUNC_RSVD"=
,
> +        [36]    =3D "SW_FUNC_RSVD",           [37]    =3D "SW_FUNC_RSVD"=
,
> +        [38]    =3D "ERASE",
> +        [40]    =3D "DPS_spec",
> +        [42]    =3D "LOCK_UNLOCK",            [43]    =3D "Q_MANAGEMENT"=
,
> +        [44]    =3D "Q_TASK_INFO_A",          [45]    =3D "Q_TASK_INFO_B=
",
> +        [46]    =3D "Q_RD_TASK",              [47]    =3D "Q_WR_TASK",
> +        [48]    =3D "READ_EXTR_SINGLE",       [49]    =3D "WRITE_EXTR_SI=
NGLE",
> +        [50]    =3D "SW_FUNC_RSVD", /* FIXME */

What's this FIXME for? We should either fix whatever it is, or if
that's not practical the comment needs to describe the problem
so that a future reader of the code knows what it means and might
be able to fix it.

> +        [52]    =3D "IO_RW_DIRECT",           [53]    =3D "IO_RW_EXTENDE=
D",
> +        [54]    =3D "SDIO_RSVD",              [55]    =3D "APP_CMD",
> +        [56]    =3D "GEN_CMD",                [57]    =3D "SW_FUNC_RSVD"=
,
> +        [58]    =3D "READ_EXTR_MULTI",        [59]    =3D "WRITE_EXTR_MU=
LTI",
> +        [60]    =3D "MANUF_RSVD",             [61]    =3D "MANUF_RSVD",
> +        [62]    =3D "MANUF_RSVD",             [63]    =3D "MANUF_RSVD",
> +    };
> +    return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
> +}
> +
> +const char *sd_acmd_name(uint8_t cmd)
> +{
> +    static const char *acmd_abbrev[SDMMC_CMD_MAX] =3D {
> +         [6] =3D "SET_BUS_WIDTH",
> +        [13] =3D "SD_STATUS",
> +        [14] =3D "DPS_spec",                  [15] =3D "DPS_spec",
> +        [16] =3D "DPS_spec",
> +        [18] =3D "SECU_spec",
> +        [22] =3D "SEND_NUM_WR_BLOCKS",        [23] =3D "SET_WR_BLK_ERASE=
_COUNT",
> +        [41] =3D "SD_SEND_OP_COND",
> +        [42] =3D "SET_CLR_CARD_DETECT",
> +        [51] =3D "SEND_SCR",
> +        [52] =3D "SECU_spec",                 [53] =3D "SECU_spec",
> +        [54] =3D "SECU_spec",
> +        [56] =3D "SECU_spec",                 [57] =3D "SECU_spec",
> +        [58] =3D "SECU_spec",                 [59] =3D "SECU_spec",
> +    };
> +
> +    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
> +}

thanks
-- PMM
