Received: from eggs.gnu.org ([2001:4830:134:3::10]:36320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euJMc-0006tg-DX
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euJMZ-0000b6-4m
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:18 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euJMY-0000ap-QP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:51:15 -0500
Received: by mail-wr0-x241.google.com with SMTP id v111so9286631wrb.3
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 06:51:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215220540.6556-1-f4bug@amsat.org>
	<20180215220540.6556-9-f4bug@amsat.org>
	<CAFEAcA-x+t_PNFmMRQBwRQddo9QH=sDWQDiib5TQ8Lb2UU+Rmg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ecaca3be-a9e1-51b7-9e02-402417cc8183@amsat.org>
Date: Fri, 9 Mar 2018 15:51:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-x+t_PNFmMRQBwRQddo9QH=sDWQDiib5TQ8Lb2UU+Rmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

Hi Peter,

On 02/22/2018 01:59 PM, Peter Maydell wrote:
> On 15 February 2018 at 22:05, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> put the function in sdmmc-common.c since we will reuse it in hw/sd/core.c
>>
> 
> As a general note, your commit messages are generally a bit
> shorter than I'd prefer. This is to some extent a personal
> style question, but if you're writing lots of patches where
> the only commit message is the subject-line summary then I
> think that it's worth being a bit more descriptive.

Got it, I'll try to be a bit more verbose. As you noticed this is not
natural for me ;) It took me time to understand what is obvious for
someone focused weeks in the same code, is not for a reviewer context
switching from an unrelated topic, and for a limited time.

> Also, the "body" part of the commit message should really
> be able to stand alone as a description, rather than relying
> on the subject line to make sense.

This one is easy to fix :)

> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sdmmc-internal.h |  3 +++
>>  hw/sd/sd.c             | 13 +++++----
>>  hw/sd/sdmmc-common.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/sd/Makefile.objs    |  2 +-
>>  hw/sd/trace-events     |  8 +++---
>>  5 files changed, 88 insertions(+), 10 deletions(-)
>>  create mode 100644 hw/sd/sdmmc-common.c
>>
>> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
>> index 0e96cb0081..02b730089b 100644
>> --- a/hw/sd/sdmmc-internal.h
>> +++ b/hw/sd/sdmmc-internal.h
>> @@ -12,4 +12,7 @@
>>
>>  #define SDMMC_CMD_MAX 64
>>
>> +const char *sd_cmd_name(uint8_t cmd);
>> +const char *sd_acmd_name(uint8_t cmd);
> 
> Can we have doc comments for new function prototypes in header files,
> please?

Yes :|

> 
> 
>> diff --git a/hw/sd/sdmmc-common.c b/hw/sd/sdmmc-common.c
>> new file mode 100644
>> index 0000000000..1d0198b1ad
>> --- /dev/null
>> +++ b/hw/sd/sdmmc-common.c
>> @@ -0,0 +1,72 @@
>> +/*
>> + * SD/MMC cards common helpers
>> + *
>> + * Copyright (c) 2018  Philippe Mathieu-Daudé <f4bug@amsat.org>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
> 
> Ooh, a SPDX identifier. The project doesn't actually use these
> at the moment, but it doesn't hurt to have one here I guess.
> 
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "sdmmc-internal.h"
>> +
>> +const char *sd_cmd_name(uint8_t cmd)
>> +{
>> +    static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
>> +         [0]    = "GO_IDLE_STATE",
>> +         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
>> +         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
>> +         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
>> +         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
>> +        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
>> +        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
>> +                                            [15]    = "GO_INACTIVE_STATE",
>> +        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
>> +        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
>> +        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
>> +                                            [23]    = "SET_BLOCK_COUNT",
>> +        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
>> +        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
>> +        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
>> +        [30]    = "SEND_WRITE_PROT",
>> +        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
>> +        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
>> +        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
>> +        [38]    = "ERASE",
>> +        [40]    = "DPS_spec",
>> +        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
>> +        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
>> +        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
>> +        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
>> +        [50]    = "SW_FUNC_RSVD", /* FIXME */
> 
> What's this FIXME for? We should either fix whatever it is, or if
> that's not practical the comment needs to describe the problem
> so that a future reader of the code knows what it means and might
> be able to fix it.

Oops, I forgot to search for the CMD51 correct name.
Apparently some future Video extension, so I'll just remove the FIXME.

> 
>> +        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
>> +        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
>> +        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
>> +        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
>> +        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
>> +        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
>> +    };
>> +    return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
>> +}
>> +
>> +const char *sd_acmd_name(uint8_t cmd)
>> +{
>> +    static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
>> +         [6] = "SET_BUS_WIDTH",
>> +        [13] = "SD_STATUS",
>> +        [14] = "DPS_spec",                  [15] = "DPS_spec",
>> +        [16] = "DPS_spec",
>> +        [18] = "SECU_spec",
>> +        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
>> +        [41] = "SD_SEND_OP_COND",
>> +        [42] = "SET_CLR_CARD_DETECT",
>> +        [51] = "SEND_SCR",
>> +        [52] = "SECU_spec",                 [53] = "SECU_spec",
>> +        [54] = "SECU_spec",
>> +        [56] = "SECU_spec",                 [57] = "SECU_spec",
>> +        [58] = "SECU_spec",                 [59] = "SECU_spec",
>> +    };
>> +
>> +    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
>> +}
> 
> thanks
> -- PMM
> 
