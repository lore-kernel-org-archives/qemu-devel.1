Received: from eggs.gnu.org ([2001:4830:134:3::10]:46543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZGQ-0004HI-1Z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZGM-0001Ar-PZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:16:54 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGZGM-0001Aj-Jm
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:16:50 -0400
Received: by mail-qt0-x243.google.com with SMTP id m5-v6so459415qti.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 17:16:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180509034658.26455-1-f4bug@amsat.org>
	<20180509034658.26455-5-f4bug@amsat.org>
	<CAKmqyKN71oTTVMiuqGnFL2wyiAEBRH+nGCvxj_UpK+6RxF1PLg@mail.gmail.com>
	<b30a766d-2c6e-8804-973c-8110bb6ac5d2@amsat.org>
	<CAKmqyKPnrF93GGY9YaqpjDLrnWPmEis8xt1SDm4GRhcvP2KTRQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <025447ec-d2af-4f92-9cc0-6f59877e617a@amsat.org>
Date: Wed, 9 May 2018 21:16:44 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPnrF93GGY9YaqpjDLrnWPmEis8xt1SDm4GRhcvP2KTRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/14] sdcard: Extract
 sd_frame48/136_calc_checksum()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 05/09/2018 08:04 PM, Alistair Francis wrote:
> On Wed, May 9, 2018 at 12:15 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Hi Alistair,
>>
>> On 05/09/2018 03:00 PM, Alistair Francis wrote:
>>> On Tue, May 8, 2018 at 8:46 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> It will help when moving this around for qtesting in the next commit.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  hw/sd/sd.c | 21 ++++++++++++++++++---
>>>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>> index 27a70896cd..06607115a7 100644
>>>> --- a/hw/sd/sd.c
>>>> +++ b/hw/sd/sd.c
>>>> @@ -273,6 +273,21 @@ static uint16_t sd_crc16(const void *message, size_t width)
>>>>      return shift_reg;
>>>>  }
>>>>
>>>> +enum {
>>>> +    F48_CONTENT_LENGTH  = 1 /* command */ + 4 /* argument */,
>>>> +    F136_CONTENT_LENGTH = 15,
>>>> +};
>>>> +
>>>> +static uint8_t sd_frame48_calc_checksum(const void *content)
>>>> +{
>>>> +    return sd_crc7(content, F48_CONTENT_LENGTH);
>>>> +}
>>>> +
>>>> +static uint8_t sd_frame136_calc_checksum(const void *content)
>>>> +{
>>>> +    return (sd_crc7(content, F136_CONTENT_LENGTH) << 1) | 1;
>>>> +}
>>>> +
>>>>  #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
>>>>
>>>>  FIELD(OCR, VDD_VOLTAGE_WINDOW,          0, 24)
>>>> @@ -352,7 +367,7 @@ static void sd_set_cid(SDState *sd)
>>>>      sd->cid[13] = 0x00 |       /* Manufacture date (MDT) */
>>>>          ((MDT_YR - 2000) / 10);
>>>>      sd->cid[14] = ((MDT_YR % 10) << 4) | MDT_MON;
>>>> -    sd->cid[15] = (sd_crc7(sd->cid, 15) << 1) | 1;
>>>> +    sd->cid[15] = sd_frame136_calc_checksum(sd->cid);
>>>>  }
>>>>
>>>>  #define HWBLOCK_SHIFT  9                       /* 512 bytes */
>>>> @@ -416,7 +431,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>>>>          sd->csd[13] = 0x40;
>>>>          sd->csd[14] = 0x00;
>>>>      }
>>>> -    sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
>>>> +    sd->csd[15] = sd_frame136_calc_checksum(sd->csd);
>>>>  }
>>>>
>>>>  static void sd_set_rca(SDState *sd)
>>>> @@ -491,7 +506,7 @@ static int sd_req_crc_validate(SDRequest *req)
>>>>      buffer[0] = 0x40 | req->cmd;
>>>>      stl_be_p(&buffer[1], req->arg);
>>>>      return 0;
>>>> -    return sd_crc7(buffer, 5) != req->crc;     /* TODO */
>>>> +    return sd_frame48_calc_checksum(buffer) != req->crc; /* TODO */
>>>
>>> This 5 has changed to a 15. Is that on purpose? It should be mentioned
>>> in the commit message if it is.
>>
>> I just extracted this function:
>>
>>   static uint8_t sd_frame48_calc_checksum(const void *content)
>>   {
>>       return sd_crc7(content, F48_CONTENT_LENGTH);
>>   }
>>
>> Having:
>>
>>   enum {
>>       F48_CONTENT_LENGTH  = 1 /* command */ + 4 /* argument */,
>>
>> So F48_CONTENT_LENGTH = 5 as previous.
> 
> Ah, I missed the '+ 4 '. I just stopped reading at the comment.

This way looked clearer to me, but it might not be...
Would this be clearer?

   F48_CONTENT_LENGTH  = 1 + 4 /* command + argument */,

> 
> Looks good then:
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for your review time :)

> 
> Alistair
> 
>>
>> This function is later verified with tests from patch 12 of this series.
>>
>>>
>>> Alistair
>>>
>>>>  }
>>>>
>>>>  static void sd_response_r1_make(SDState *sd, uint8_t *response)
>>>> --
>>>> 2.17.0
>>>>
>>>>
