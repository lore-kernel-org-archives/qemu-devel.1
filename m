Received: from eggs.gnu.org ([2001:4830:134:3::10]:59473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejY72-0005SL-U7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejY6z-0008PZ-LR
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:22:44 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejY6z-0008PR-GK
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:22:41 -0500
Received: by mail-qt0-x242.google.com with SMTP id i8so3773953qtj.9
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:22:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180123032135.28863-1-f4bug@amsat.org>
	<20180123032135.28863-11-f4bug@amsat.org>
	<CAKmqyKMds=ebER8+5t+HKOA4xDVE+-MGjSkWZXVMa06LGw7ggQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <810cad96-3bd6-3567-ba2f-4fbe0bde365b@amsat.org>
Date: Wed, 7 Feb 2018 19:22:36 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMds=ebER8+5t+HKOA4xDVE+-MGjSkWZXVMa06LGw7ggQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 10/12] sdcard: rename sd_set_$REG()
 functions called once as sd_reset_$REG()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Alistair,

On 01/31/2018 01:28 PM, Alistair Francis wrote:
> On Mon, Jan 22, 2018 at 7:21 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> All are only called once at reset.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I don't think this patch gets us anything, in the future someone might
> use the functions to set values and then this new name will be
> confusing. Can we drop this patch?

This is indeed the purpose of this patch, be explicit than these
functions are here to reset default values and not set anything (except
value at reset).

I personally prefer to use explicit self-documenting names to avoid such
confusions.

I'll drop it from this series and eventually reintroduce it in last part
where MMC functions do set values different than reset values.

> 
> Alistair
> 
>> ---
>>  hw/sd/sd.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index c46e9c2818..8b5022a7db 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -269,7 +269,7 @@ static uint16_t sd_crc16(void *message, size_t width)
>>      return shift_reg;
>>  }
>>
>> -static void sd_set_ocr(SDState *sd)
>> +static void sd_reset_ocr(SDState *sd)
>>  {
>>      /* All voltages OK, Standard Capacity SD Memory Card, not yet powered up */
>>      sd->ocr = 0x00ffff00;
>> @@ -285,7 +285,7 @@ static void sd_ocr_powerup(void *opaque)
>>      sd->ocr |= OCR_POWER_UP;
>>  }
>>
>> -static void sd_set_scr(SDState *sd)
>> +static void sd_reset_scr(SDState *sd)
>>  {
>>      sd->scr[0] = 0x00;         /* SCR Structure */
>>      sd->scr[1] = 0x2f;         /* SD Security Support */
>> @@ -304,7 +304,7 @@ static void sd_set_scr(SDState *sd)
>>  #define MDT_YR 2006
>>  #define MDT_MON        2
>>
>> -static void sd_set_cid(SDState *sd)
>> +static void sd_reset_cid(SDState *sd)
>>  {
>>      sd->cid[0] = MID;          /* Fake card manufacturer ID (MID) */
>>      sd->cid[1] = OID[0];       /* OEM/Application ID (OID) */
>> @@ -336,7 +336,7 @@ static const uint8_t sd_csd_rw_mask[16] = {
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
>>  };
>>
>> -static void sd_set_csd(SDState *sd, uint64_t size)
>> +static void sd_reset_csd(SDState *sd, uint64_t size)
>>  {
>>      uint32_t csize = (size >> (CMULT_SHIFT + HWBLOCK_SHIFT)) - 1;
>>      uint32_t sectsize = (1 << (SECTOR_SHIFT + 1)) - 1;
>> @@ -391,6 +391,11 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>>      }
>>  }
>>
>> +static void sd_reset_rca(SDState *sd)
>> +{
>> +    sd->rca = 0;
>> +}
>> +
>>  static void sd_set_rca(SDState *sd)
>>  {
>>      sd->rca += 0x4567;

Here is an example where set_rsa() is not the same than reset_rsa().

>> @@ -405,12 +410,12 @@ static void sd_set_rca(SDState *sd)
>>  #define CARD_STATUS_B  0x00c01e00
>>  #define CARD_STATUS_C  0xfd39a028
>>
>> -static void sd_set_cardstatus(SDState *sd)
>> +static void sd_reset_cardstatus(SDState *sd)
>>  {
>>      sd->card_status = 0x00000100;
>>  }
>>
>> -static void sd_set_sdstatus(SDState *sd)
>> +static void sd_reset_sdstatus(SDState *sd)
>>  {
>>      memset(sd->sd_status, 0, 64);
>>  }
>> @@ -494,13 +499,13 @@ static void sd_reset(DeviceState *dev)
>>      sect = sd_addr_to_wpnum(size) + 1;
>>
>>      sd->state = sd_idle_state;
>> -    sd->rca = 0x0000;
>> -    sd_set_ocr(sd);
>> -    sd_set_scr(sd);
>> -    sd_set_cid(sd);
>> -    sd_set_csd(sd, size);
>> -    sd_set_cardstatus(sd);
>> -    sd_set_sdstatus(sd);
>> +    sd_reset_rca(sd);
>> +    sd_reset_ocr(sd);
>> +    sd_reset_scr(sd);
>> +    sd_reset_cid(sd);
>> +    sd_reset_csd(sd, size);
>> +    sd_reset_cardstatus(sd);
>> +    sd_reset_sdstatus(sd);
>>
>>      g_free(sd->wp_groups);
>>      sd->wp_switch = sd->blk ? blk_is_read_only(sd->blk) : false;
>> --
>> 2.15.1
>>
>>
