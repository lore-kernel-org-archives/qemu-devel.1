Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAlxr-0001pk-R7
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAlxo-0003wB-Jf
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:10:03 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:31247)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAlxn-0003t6-UN
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:10:00 -0400
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
	<20181011090007.1103-2-maozhongyi@cmss.chinamobile.com>
	<682179e1-f851-8f1b-7ad3-b92b1c3d474b@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <ad8087ea-d756-9c7b-68cc-6c1ba2860cd5@cmss.chinamobile.com>
Date: Fri, 12 Oct 2018 09:09:50 +0800
MIME-Version: 1.0
In-Reply-To: <682179e1-f851-8f1b-7ad3-b92b1c3d474b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] wm8750: remove duplicate macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



On 10/11/18 6:39 PM, Philippe Mathieu-Daudé wrote:
> Hi Mao,
> 
> On 11/10/2018 11:00, Mao Zhongyi wrote:
>> The header file wm8750.h contains '#define TYPE_WM8750 "wm8750"'
>> macro, but '#define CODEC "wm8750"' macro is redefined in wm8750.c,
>> just remove the local CODEC macro and replace it with TYPE_WM8750.
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   hw/audio/wm8750.c | 18 ++++++++----------
>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
>> index f4aa838f62..4be3602079 100644
>> --- a/hw/audio/wm8750.c
>> +++ b/hw/audio/wm8750.c
>> @@ -15,8 +15,6 @@
>>   #define IN_PORT_N	3
>>   #define OUT_PORT_N	3
>>   
>> -#define CODEC		"wm8750"
>> -
>>   typedef struct {
>>       int adc;
>>       int adc_hz;
>> @@ -204,11 +202,11 @@ static void wm8750_set_format(WM8750State *s)
>>       in_fmt.fmt = AUD_FMT_S16;
>>   
>>       s->adc_voice[0] = AUD_open_in(&s->card, s->adc_voice[0],
>> -                    CODEC ".input1", s, wm8750_audio_in_cb, &in_fmt);
>> +                    TYPE_WM8750 ".input1", s, wm8750_audio_in_cb, &in_fmt);
> 
> I don't think this is correct. The TYPE_name could change, but the CODEC
> shouldn't change. Both definitions are different.

OK, I will remove this patch.

Thanks,
Mao

> 
> Regards,
> 
> Phil.
> 
>>       s->adc_voice[1] = AUD_open_in(&s->card, s->adc_voice[1],
>> -                    CODEC ".input2", s, wm8750_audio_in_cb, &in_fmt);
>> +                    TYPE_WM8750 ".input2", s, wm8750_audio_in_cb, &in_fmt);
>>       s->adc_voice[2] = AUD_open_in(&s->card, s->adc_voice[2],
>> -                    CODEC ".input3", s, wm8750_audio_in_cb, &in_fmt);
>> +                    TYPE_WM8750 ".input3", s, wm8750_audio_in_cb, &in_fmt);
>>   
>>       /* Setup output */
>>       out_fmt.endianness = 0;
>> @@ -217,12 +215,12 @@ static void wm8750_set_format(WM8750State *s)
>>       out_fmt.fmt = AUD_FMT_S16;
>>   
>>       s->dac_voice[0] = AUD_open_out(&s->card, s->dac_voice[0],
>> -                    CODEC ".speaker", s, wm8750_audio_out_cb, &out_fmt);
>> +                    TYPE_WM8750 ".speaker", s, wm8750_audio_out_cb, &out_fmt);
>>       s->dac_voice[1] = AUD_open_out(&s->card, s->dac_voice[1],
>> -                    CODEC ".headphone", s, wm8750_audio_out_cb, &out_fmt);
>> +                    TYPE_WM8750 ".headphone", s, wm8750_audio_out_cb, &out_fmt);
>>       /* MONOMIX is also in stereo for simplicity */
>>       s->dac_voice[2] = AUD_open_out(&s->card, s->dac_voice[2],
>> -                    CODEC ".monomix", s, wm8750_audio_out_cb, &out_fmt);
>> +                    TYPE_WM8750 ".monomix", s, wm8750_audio_out_cb, &out_fmt);
>>       /* no sense emulating OUT3 which is a mix of other outputs */
>>   
>>       wm8750_vol_update(s);
>> @@ -584,7 +582,7 @@ static int wm8750_post_load(void *opaque, int version_id)
>>   }
>>   
>>   static const VMStateDescription vmstate_wm8750 = {
>> -    .name = CODEC,
>> +    .name = TYPE_WM8750,
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>>       .pre_save = wm8750_pre_save,
>> @@ -621,7 +619,7 @@ static void wm8750_realize(DeviceState *dev, Error **errp)
>>   {
>>       WM8750State *s = WM8750(dev);
>>   
>> -    AUD_register_card(CODEC, &s->card);
>> +    AUD_register_card(TYPE_WM8750, &s->card);
>>       wm8750_reset(I2C_SLAVE(s));
>>   }
>>   
>>
> 
