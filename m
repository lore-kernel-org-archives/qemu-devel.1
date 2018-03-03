Received: from eggs.gnu.org ([2001:4830:134:3::10]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5cQ-0002UK-C5
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 06:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5cL-0006M9-Ek
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 06:46:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:55569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1es5cL-0006KS-7r
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 06:46:21 -0500
Received: by mail-wm0-x242.google.com with SMTP id q83so7668357wme.5
	for <qemu-devel@nongnu.org>; Sat, 03 Mar 2018 03:46:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215221325.7611-1-f4bug@amsat.org>
	<20180215221325.7611-20-f4bug@amsat.org>
	<CAFEAcA-fFV+JVWvqQCPfhFK5J-=Ad6c2mubqZAmg5Ce5VwANMQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0515e0c9-151b-7b87-f4fe-b110d59eee9c@amsat.org>
Date: Sat, 3 Mar 2018 08:46:14 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fFV+JVWvqQCPfhFK5J-=Ad6c2mubqZAmg5Ce5VwANMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 19/20] sdcard: add a 'uhs' property,
 update the OCR register ACCEPT_SWITCH_1V8 bit
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

On 02/22/2018 11:25 AM, Peter Maydell wrote:
> On 15 February 2018 at 22:13, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/sd/sd.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index ada96f5574..b9429b06ca 100644
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
>> @@ -292,6 +293,8 @@ static void sd_set_ocr(SDState *sd)
>>  {
>>      /* All voltages OK */
>>      sd->ocr = R_OCR_VDD_VOLTAGE_WIN_HI_MASK;
>> +
>> +    sd->ocr = FIELD_DP32(sd->ocr, OCR, ACCEPT_SWITCH_1V8, !!sd->uhs_supported);
>>  }
>>
>>  static void sd_ocr_powerup(void *opaque)
>> @@ -2189,6 +2192,7 @@ static Property sd_properties[] = {
>>       * board to ensure that ssi transfers only occur when the chip select
>>       * is asserted.  */
>>      DEFINE_PROP_BOOL("spi", SDState, spi, false),
>> +    DEFINE_PROP_UINT8("uhs", SDState, uhs_supported, UHS_NOT_SUPPORTED),
>>      DEFINE_PROP_END_OF_LIST()
>>  };
> 
> The field name and the use of the value suggest that this is just
> a boolean flag, so why define it as a PROP_UINT8 rather than PROP_BOOL ?

Here is the full enum:

typedef enum  {
    UHS_NOT_SUPPORTED   = 0,
    UHS_I               = 1,
    UHS_II              = 2,    /* currently not supported */
    UHS_III             = 3,    /* currently not supported */
} sd_uhs_mode_t;

I'll rename it "uhs_mode" to reflect this is not a boolean.

Some controllers modeled support UHS-II, I guess we'll need to implement
it at some point during the year.

Regards,

Phil.
