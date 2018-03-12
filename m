Received: from eggs.gnu.org ([2001:4830:134:3::10]:37333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evMdK-0005PP-6f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evMdH-0003an-0f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:32:54 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evMdG-0003ZW-Mm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:32:50 -0400
Received: by mail-wm0-x241.google.com with SMTP id z81so16124639wmb.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 05:32:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91f6b906-f5b8-48f5-7a4e-474e360d02fd@amsat.org>
Date: Mon, 12 Mar 2018 13:32:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 03/09/2018 06:03 PM, Peter Maydell wrote:
> On 9 March 2018 at 15:36, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>>  from qemu/xilinx tag xilinx-v2015.2]
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> This should ideally have a Signed-off-by: from somebody @xilinx.com as
> well as you, then.
> 
>> ---
>>  hw/sd/sd.c         | 148 +++++++++++++++++++++++++++++++++++++++++++++--------
>>  hw/sd/trace-events |   1 +
>>  2 files changed, 127 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 235e0518d6..b907d62aef 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -124,6 +124,7 @@ struct SDState {
>>      bool enable;
>>      uint8_t dat_lines;
>>      bool cmd_line;
>> +    bool uhs_enabled;
>>  };
>>
>>  static const char *sd_state_name(enum SDCardStates state)
>> @@ -563,6 +564,7 @@ static void sd_reset(DeviceState *dev)
>>      sd->expecting_acmd = false;
>>      sd->dat_lines = 0xf;
>>      sd->cmd_line = true;
>> +    sd->uhs_enabled = false;
>>      sd->multi_blk_cnt = 0;
>>  }
>>
>> @@ -761,30 +763,132 @@ static uint32_t sd_wpbits(SDState *sd, uint64_t addr)
>>      return ret;
>>  }
>>
>> +/* Function Group */
>> +enum {
>> +    SD_FG_MIN               = 1,
>> +    SD_FG_ACCESS_MODE       = 1,
>> +    SD_FG_COMMAND_SYSTEM    = 2,
>> +    SD_FG_DRIVER_STRENGTH   = 3,
>> +    SD_FG_CURRENT_LIMIT     = 4,
>> +    SD_FG_RSVD_5            = 5,
>> +    SD_FG_RSVD_6            = 6,
>> +    SD_FG_COUNT
>> +};
> 
> Since the minimum isn't 0, this means SD_FG_COUNT isn't
> actually the count of the number of FGs. I think having
>     SD_FG_MAX = 6,
> 
> would make the loops below clearer, since they become
>   for (fn_grp = SD_FG_MAX; fn_grp >= SD_FG_MIN; fn_grp--) {
> 
>> +
>> +/* Function name */
>> +#define SD_FN_COUNT 16
>> +
>> +static const char *sd_fn_grp_name[SD_FG_COUNT] = {
>> +    [SD_FG_ACCESS_MODE]     = "ACCESS_MODE",
>> +    [SD_FG_COMMAND_SYSTEM]  = "COMMAND_SYSTEM",
>> +    [SD_FG_DRIVER_STRENGTH] = "DRIVER_STRENGTH",
>> +    [SD_FG_CURRENT_LIMIT]   = "CURRENT_LIMIT",
>> +    [SD_FG_RSVD_5]          = "RSVD5",
>> +    [SD_FG_RSVD_6]          = "RSVD6",
>> +};
>> +
>> +typedef struct sd_fn_support {
>> +    const char *name;
>> +    bool uhs_only;
>> +    bool unimp;
>> +} sd_fn_support;
>> +
>> +static const sd_fn_support *sd_fn_support_defs[SD_FG_COUNT] = {
>> +    [SD_FG_ACCESS_MODE] = (sd_fn_support [SD_FN_COUNT]) {
>> +        [0] = { .name = "default/SDR12" },
>> +        [1] = { .name = "high-speed/SDR25" },
>> +        [2] = { .name = "SDR50",    .uhs_only = true },
>> +        [3] = { .name = "SDR104",   .uhs_only = true },
>> +        [4] = { .name = "DDR50",    .uhs_only = true },
>> +    },
>> +    [SD_FG_COMMAND_SYSTEM] = (sd_fn_support [SD_FN_COUNT]) {
>> +        [0] = { .name = "default" },
>> +        [1] = { .name = "For eC" },
>> +        [3] = { .name = "OTP",      .unimp = true },
>> +        [4] = { .name = "ASSD",     .unimp = true },
>> +    },
>> +    [SD_FG_DRIVER_STRENGTH] = (sd_fn_support [SD_FN_COUNT]) {
>> +        [0] = { .name = "default/Type B" },
>> +        [1] = { .name = "Type A",   .uhs_only = true },
>> +        [2] = { .name = "Type C",   .uhs_only = true },
>> +        [3] = { .name = "Type D",   .uhs_only = true },
>> +    },
>> +    [SD_FG_CURRENT_LIMIT] = (sd_fn_support [SD_FN_COUNT]) {
>> +        [0] = { .name = "default/200mA" },
>> +        [1] = { .name = "400mA",    .uhs_only = true },
>> +        [2] = { .name = "600mA",    .uhs_only = true },
>> +        [3] = { .name = "800mA",    .uhs_only = true },
>> +    },
>> +    [SD_FG_RSVD_5] = (sd_fn_support [SD_FN_COUNT]) {
>> +        [0] = { .name = "default" },
>> +    },
>> +    [SD_FG_RSVD_6] = (sd_fn_support [SD_FN_COUNT]) {
>> +        [0] = { .name = "default" },
>> +    },
>> +};
>> +
>> +#define SD_FN_NO_INFLUENCE          (1 << 15)
>> +
>>  static void sd_function_switch(SDState *sd, uint32_t arg)
>>  {
>> -    int i, mode, new_func;
>> -    mode = !!(arg & 0x80000000);
>> -
>> -    sd->data[0] = 0x00;                /* Maximum current consumption */
>> -    sd->data[1] = 0x01;
>> -    sd->data[2] = 0x80;                /* Supported group 6 functions */
>> -    sd->data[3] = 0x01;
>> -    sd->data[4] = 0x80;                /* Supported group 5 functions */
>> -    sd->data[5] = 0x01;
>> -    sd->data[6] = 0x80;                /* Supported group 4 functions */
>> -    sd->data[7] = 0x01;
>> -    sd->data[8] = 0x80;                /* Supported group 3 functions */
>> -    sd->data[9] = 0x01;
>> -    sd->data[10] = 0x80;       /* Supported group 2 functions */
>> -    sd->data[11] = 0x43;
>> -    sd->data[12] = 0x80;       /* Supported group 1 functions */
>> -    sd->data[13] = 0x03;
>> -    for (i = 0; i < 6; i ++) {
>> -        new_func = (arg >> (i * 4)) & 0x0f;
>> -        if (mode && new_func != 0x0f)
>> -            sd->function_group[i] = new_func;
>> -        sd->data[14 + (i >> 1)] = new_func << ((i * 4) & 4);
>> +    int fn_grp, new_func, i;
>> +    uint8_t *data_p;
>> +    bool mode = extract32(arg, 31, 1);  /* 0: check only, 1: do switch */
>> +
>> +    stw_be_p(sd->data + 0, 0x0001);     /* Maximum current consumption */
> 
> Previously we were writing 0x00, 0x01 to the first 2 bytes of data;
> now we will write 0x01, 0x00. Are you sure that's right ? I guess
> it's the difference between claiming 1mA and 256mA.
> (I can't make any sense of the table in the spec so I have no idea.)

Good catch. I'm not sure which default value we want here, I doubt 256
mA matches the card used, but the hw tests pass so I'll keep it.
We might change it to a property later.

> 
> Also the spec says that if the guest selects an invalid function then
> this value should be 0.
> 
>> +
>> +    data_p = &sd->data[2];
>> +    for (fn_grp = SD_FG_COUNT - 1; fn_grp >= SD_FG_MIN; fn_grp--) {
>> +        uint16_t supported_fns = SD_FN_NO_INFLUENCE;
>> +        for (i = 0; i < SD_FN_COUNT; ++i) {
>> +            const sd_fn_support *def = &sd_fn_support_defs[fn_grp][i];
>> +
>> +            if (def->name && !def->unimp &&
>> +                    !(def->uhs_only && !sd->uhs_enabled)) {
>> +                supported_fns |= 1 << i;
>> +            }
>> +        }
>> +        stw_be_p(data_p, supported_fns);
>> +        data_p += 2;
>> +    }
>> +
>> +    assert(data_p == &sd->data[14]);
>> +    for (fn_grp = SD_FG_COUNT - 1; fn_grp >= SD_FG_MIN; fn_grp--) {
>> +        new_func = (arg >> ((fn_grp - 1) * 4)) & 0x0f;
>> +        if (new_func == 0xf) {
> 
> /* Guest requested no influence, so this function group stays the same */
> 
>> +            new_func = sd->function_group[fn_grp - 1];
>> +        } else {
>> +            const sd_fn_support *def = &sd_fn_support_defs[fn_grp][new_func];
>> +            if (mode) {
>> +                if (!def->name) {
>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>> +                                  "Function %d not a valid for "
> 
> "not valid for"
> 
>> +                                  "function group %d\n",
>> +                                  new_func, fn_grp);
>> +                    new_func = 0xf;
>> +                } else if (def->unimp) {
>> +                    qemu_log_mask(LOG_UNIMP,
>> +                                  "Function %s (fn grp %d) not implemented\n",
>> +                                  def->name, fn_grp);
>> +                    new_func = 0xf;
>> +                } else if (def->uhs_only && !sd->uhs_enabled) {
>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>> +                                  "Function %s (fn grp %d) only "
>> +                                  "valid in UHS mode\n",
>> +                                  def->name, fn_grp);
>> +                    new_func = 0xf;
>> +                } else {
>> +                    sd->function_group[fn_grp - 1] = new_func;
> 
> I think the spec says that if the guest makes an invalid selection
> for one function in the group then we must ignore all the set values,
> not just the one that was wrong, so we need to check everything
> first before we start writing the new values back.

Yes, we missed that.

> 
>> +                }
>> +            }
>> +            trace_sdcard_function_select(def->name, sd_fn_grp_name[fn_grp],
>> +                                         mode);
>> +        }
>> +        if (!(fn_grp & 0x1)) { /* evens go in high nibble */
>> +            *data_p = new_func << 4;
>> +        } else { /* odds go in low nibble */
>> +            *(data_p++) |= new_func;
>> +        }
>>      }
>>      memset(&sd->data[17], 0, 47);
>>      stw_be_p(sd->data + 65, sd_crc16(sd->data, 64));
>> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
>> index 2059ace61f..c106541a47 100644
>> --- a/hw/sd/trace-events
>> +++ b/hw/sd/trace-events
>> @@ -42,6 +42,7 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
>>  sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
>>  sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
>>  sdcard_set_voltage(uint16_t millivolts) "%u mV"
>> +sdcard_function_select(const char *fn_name, const char *grp_name, bool do_switch) "Function %s (group: %s, sw: %u)"
>>
>>  # hw/sd/milkymist-memcard.c
>>  milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>> --
>> 2.16.2
>>
> 
> thanks
> -- PMM
> 
