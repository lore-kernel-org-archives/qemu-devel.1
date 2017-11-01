Received: from eggs.gnu.org ([2001:4830:134:3::10]:59161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9zqn-0006IF-Fx
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9zqm-0006Xt-39
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:43:01 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:43508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e9zql-0006X9-QK
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:43:00 -0400
Received: by mail-pg0-x235.google.com with SMTP id s75so3110551pgs.0
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 13:42:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86790113-ff54-95e1-451f-0c3f27002910@gmail.com>
References: <20171101071652.19375-1-frasse.iglesias@gmail.com>
	<20171101071652.19375-2-frasse.iglesias@gmail.com>
	<86790113-ff54-95e1-451f-0c3f27002910@gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Wed, 1 Nov 2017 21:42:57 +0100
Message-ID: <CAAYMZQt8i8dXuWUO=uggSnBgrrJ3AsrCXisAU2osOt_qGER+Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 01/13] m25p80: Add support for
 continuous read out of RDSR and READ_FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>
Cc: qemu-devel@nongnu.org, edgari@xilinx.com, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>, Peter Maydell <peter.maydell@linaro.org>

On 1 November 2017 at 20:20, mar.krzeminski <mar.krzeminski@gmail.com>
wrote:

> Hi Francisco,
>
> W dniu 01.11.2017 o 08:16, Francisco Iglesias pisze:
>
> Add support for continuous read out of the RDSR and READ_FSR status
>> registers until the chip select is deasserted. This feature is supported
>> by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
>> Windbond, SST, Gigadevice, Eon and Macronix.
>>
>> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>> ---
>>   hw/block/m25p80.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index a2438b9..721ae1a 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -423,6 +423,7 @@ typedef struct Flash {
>>       uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
>>       uint32_t len;
>>       uint32_t pos;
>> +    bool data_read_loop;
>>       uint8_t needed_bytes;
>>       uint8_t cmd_in_progress;
>>       uint32_t cur_addr;
>> @@ -983,6 +984,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>           }
>>           s->pos = 0;
>>           s->len = 1;
>> +        s->data_read_loop = true;
>>           s->state = STATE_READING_DATA;
>>           break;
>>   @@ -993,6 +995,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>           }
>>           s->pos = 0;
>>           s->len = 1;
>> +        s->data_read_loop = true;
>>           s->state = STATE_READING_DATA;
>>           break;
>>   @@ -1133,6 +1136,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>>           s->pos = 0;
>>           s->state = STATE_IDLE;
>>           flash_sync_dirty(s, -1);
>> +        s->data_read_loop = false;
>>       }
>>         DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
>> @@ -1198,7 +1202,9 @@ static uint32_t m25p80_transfer8(SSISlave *ss,
>> uint32_t tx)
>>           s->pos++;
>>           if (s->pos == s->len) {
>>               s->pos = 0;
>> -            s->state = STATE_IDLE;
>> +            if (!s->data_read_loop) {
>> +                s->state = STATE_IDLE;
>> +            }
>>           }
>>           break;
>>   @@ -1279,6 +1285,7 @@ static const VMStateDescription vmstate_m25p80 = {
>>           VMSTATE_UINT8_ARRAY(data, Flash, M25P80_INTERNAL_DATA_BUFFER_SZ
>> ),
>>           VMSTATE_UINT32(len, Flash),
>>           VMSTATE_UINT32(pos, Flash),
>> +        VMSTATE_BOOL(data_read_loop, Flash),
>>
> This is not so simple I am afraid. Sorry I have not mentioned that in
> previous review.
> Beside adding the field, you need to take care of VMSTATE (migration).
> Documentation is here:
> https://github.com/qemu/qemu/blob/master/docs/devel/migration.txt
>
> My suggestion would be to bump version and just set false to
> data_read_loopwhen importing
> older states - in fact it should be false by default, so do nothing?
> Since I am away from Qemu for a while, and there are some new features
> (subsections),
> could be that different solution is preferred.
> Maybe Peter can help.
>

Regards,
> Marcin


Hi Marcin,

I'll dive into the documentation (thank you for pinpointing!), code and
comeback with a new patch trying to correct this! (If Peter knows this
should be done in a certain way i'll will of course never turn down help)

Thank you once again Marcin!

Best regards,
Francisco Iglesias




>
>           VMSTATE_UINT8(needed_bytes, Flash),
>>           VMSTATE_UINT8(cmd_in_progress, Flash),
>>           VMSTATE_UINT32(cur_addr, Flash),
>>
>
>
