Received: from eggs.gnu.org ([2001:4830:134:3::10]:37838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeev9-00082d-Dh
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeev4-0003ZY-G8
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:38:15 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeev4-0003ZG-BA
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:38:10 -0500
Received: by mail-qt0-x241.google.com with SMTP id z10so17983868qti.5
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 02:38:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180123033034.29493-1-f4bug@amsat.org>
	<20180123033034.29493-17-f4bug@amsat.org>
	<28028621-ae9a-b199-7f51-4cbe0162bc47@amsat.org>
Message-ID: <5e5c6a68-ca46-d7b7-a88e-bb87552a3602@amsat.org>
Date: Thu, 25 Jan 2018 07:37:59 -0300
MIME-Version: 1.0
In-Reply-To: <28028621-ae9a-b199-7f51-4cbe0162bc47@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/18] sdcard: add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>

On 01/25/2018 07:30 AM, Philippe Mathieu-Daudé wrote:
> On 01/23/2018 12:30 AM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sd.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 27176ba33e..b3b6859bc4 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -93,6 +93,7 @@ struct SDState {
>>      /* Configurable properties */
>>      BlockBackend *blk;
>>      bool spi;
>> +    uint8_t uhs_supported;
>>  
>>      uint32_t mode;    /* current card mode, one of SDCardModes */
>>      int32_t state;    /* current card state, one of SDCardStates */
>> @@ -289,6 +290,8 @@ static void sd_reset_ocr(SDState *sd)
>>  {
>>      /* All voltages OK */
>>      sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
>> +
>> +    sd->ocr = FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8, !!sd->uhs_supported);
> 
> This patch has to go after this series #17 "sdcard: implement the UHS-I
> SWITCH_FUNCTION entries (Spec v3)"

Also although the SD interface is working/tested, the MMC interface is
missing from this series, and UHS enabled MMC cards are not usable:

kernel: mmc0: SDHCI controller on PCI [0000:00:05.0] using ADMA
kernel: sd 0:0:0:0: Attached scsi generic sg0 type 0
kernel: mmc0: Skipping voltage switch
[mmc kthread looping]

> 
>>  }
>>  
>>  static void sd_ocr_powerup(void *opaque)
>> @@ -2107,6 +2110,7 @@ static Property sd_properties[] = {
>>       * board to ensure that ssi transfers only occur when the chip select
>>       * is asserted.  */
>>      DEFINE_PROP_BOOL("spi", SDState, spi, false),
>> +    DEFINE_PROP_UINT8("uhs", SDState, uhs_supported, UHS_NOT_SUPPORTED),
>>      DEFINE_PROP_END_OF_LIST()
>>  };
>>  
>>
