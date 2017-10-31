Received: from eggs.gnu.org ([2001:4830:134:3::10]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9Uh9-0004DZ-GN
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e9Uh8-0000mK-4z
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:59 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:48429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e9Uh7-0000lM-SP
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:58 -0400
Received: by mail-pg0-x233.google.com with SMTP id v78so14395276pgb.5
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 04:26:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a5d353da-2ec3-7563-cbab-f7399d0ccbf7@gmail.com>
References: <20171029101343.15544-1-frasse.iglesias@gmail.com>
	<20171029101343.15544-2-frasse.iglesias@gmail.com>
	<a5d353da-2ec3-7563-cbab-f7399d0ccbf7@gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Tue, 31 Oct 2017 12:26:55 +0100
Message-ID: <CAAYMZQtB_vQW1oTJYj627EOFeVynG-WYroVQrBubKNeKekdupg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/13] m25p80: Add support for
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
Cc: qemu-devel@nongnu.org, edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se

Hi Marcin,

Huge thank you once again for reviewing and your time! I'll update above i
next version of the patch series. I'll remove the Acks so the patch can be
revisited (if it is ok for you that keep it just let me know and I'll do
so!).

Best regards,
Francisco Iglesias


On 29 Oct 2017 16:08, "mar.krzeminski" <mar.krzeminski@gmail.com> wrote:

>
>
> W dniu 29.10.2017 o 11:13, Francisco Iglesias pisze:
>
>> Add support for continuous read out of the RDSR and READ_FSR status
>> registers until the chip select is deasserted. This feature is supported
>> by amongst others 1 or more flashtypes manufactured by Numonyx (Micron),
>> Windbond, SST, Gigadevice, Eon and Macronix.
>>
>> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>> Acked-by: Marcin Krzemi=C5=84ski <mar.krzeminski@gmail.com>
>> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>   hw/block/m25p80.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index a2438b9..2971519 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -423,6 +423,7 @@ typedef struct Flash {
>>       uint8_t data[M25P80_INTERNAL_DATA_BUFFER_SZ];
>>       uint32_t len;
>>       uint32_t pos;
>> +    bool data_read_loop;
>>
> I am sorry I have not seen this first time - data_read_loop should goes t=
o
> vmstate_m25p80.
>
>       uint8_t needed_bytes;
>>       uint8_t cmd_in_progress;
>>       uint32_t cur_addr;
>> @@ -983,6 +984,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>           }
>>           s->pos =3D 0;
>>           s->len =3D 1;
>> +        s->data_read_loop =3D true;
>>           s->state =3D STATE_READING_DATA;
>>           break;
>>   @@ -993,6 +995,7 @@ static void decode_new_cmd(Flash *s, uint32_t valu=
e)
>>           }
>>           s->pos =3D 0;
>>           s->len =3D 1;
>> +        s->data_read_loop =3D true;
>>           s->state =3D STATE_READING_DATA;
>>           break;
>>   @@ -1133,6 +1136,7 @@ static int m25p80_cs(SSISlave *ss, bool select)
>>           s->pos =3D 0;
>>           s->state =3D STATE_IDLE;
>>           flash_sync_dirty(s, -1);
>> +        s->data_read_loop =3D false;
>>       }
>>         DB_PRINT_L(0, "%sselect\n", select ? "de" : "");
>> @@ -1198,7 +1202,9 @@ static uint32_t m25p80_transfer8(SSISlave *ss,
>> uint32_t tx)
>>           s->pos++;
>>           if (s->pos =3D=3D s->len) {
>>               s->pos =3D 0;
>> -            s->state =3D STATE_IDLE;
>> +            if (!s->data_read_loop) {
>> +                s->state =3D STATE_IDLE;
>> +            }
>>           }
>>           break;
>>
>>
>
>
