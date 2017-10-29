Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8utJ-00023W-Ld
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 17:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e8utI-0008Am-1K
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 17:13:09 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:43713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e8utH-0008A2-OT
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 17:13:07 -0400
Received: by mail-pf0-x234.google.com with SMTP id a8so9266190pfc.0
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 14:13:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8759fbe7-c75e-e05a-a5b2-0306b2841a5d@gmail.com>
References: <20171029101343.15544-1-frasse.iglesias@gmail.com>
	<20171029101343.15544-3-frasse.iglesias@gmail.com>
	<8759fbe7-c75e-e05a-a5b2-0306b2841a5d@gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Sun, 29 Oct 2017 22:13:06 +0100
Message-ID: <CAAYMZQuY5fxNe53CHArBrt9sLPg6TTfcK3Cu_yk-gOOQ0FgLEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 02/13] m25p80: Add support for SST READ
 ID 0x90/0xAB commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>
Cc: qemu-devel@nongnu.org, edgari@xilinx.com, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 29 October 2017 at 16:21, mar.krzeminski <mar.krzeminski@gmail.com>
wrote:

>
>
> W dniu 29.10.2017 o 11:13, Francisco Iglesias pisze:
>
> Add support for SST READ ID 0x90/0xAB commands for reading out the flash
>> manufacuter ID and device ID.
>>
>> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>   hw/block/m25p80.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 2971519..7a5c137 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -355,6 +355,8 @@ typedef enum {
>>       DPP = 0xa2,
>>       QPP = 0x32,
>>       QPP_4 = 0x34,
>> +    RDID_90 = 0x90,
>> +    RDID_AB = 0xab,
>>         ERASE_4K = 0x20,
>>       ERASE4_4K = 0x21,
>> @@ -405,6 +407,7 @@ typedef enum {
>>       MAN_MACRONIX,
>>       MAN_NUMONYX,
>>       MAN_WINBOND,
>> +    MAN_SST,
>>       MAN_GENERIC,
>>   } Manufacturer;
>>   @@ -476,6 +479,8 @@ static inline Manufacturer get_man(Flash *s)
>>           return MAN_SPANSION;
>>       case 0xC2:
>>           return MAN_MACRONIX;
>> +    case 0xBF:
>> +        return MAN_SST;
>>       default:
>>           return MAN_GENERIC;
>>       }
>> @@ -711,6 +716,22 @@ static void complete_collecting_data(Flash *s)
>>       case WEVCR:
>>           s->enh_volatile_cfg = s->data[0];
>>           break;
>> +    case RDID_90:
>> +    case RDID_AB:
>> +        if (get_man(s) == MAN_SST && s->cur_addr <= 1) {
>> +            if (s->cur_addr) {
>> +                s->data[0] = s->pi->id[2];
>> +                s->data[1] = s->pi->id[0];
>> +            } else {
>> +                s->data[0] = s->pi->id[0];
>> +                s->data[1] = s->pi->id[2];
>> +            }
>> +            s->pos = 0;
>> +            s->len = 2;
>> +            s->data_read_loop = true;
>> +            s->state = STATE_READING_DATA;
>>
> Do you know how the real HW will behave?
> When you get two bytes, it will send them once again or will wait for
> address?
>

Dear Marcin,

First of all thank you vey much for reviewing again! About your question
above, I have not tested it on HW but the SST flash datasheets for the
supported flashes in m25p80 state that "The manufacturer's and device ID
output stream is continuous until terminated by a low to high transition on
CE#.". Also in the diagram for the command in the datasheets it can be seen
that no address is needed (two continuous man/dev ids are read). This is
the reason to why data_read_loop is set to true above. Do you find this ok?



> +        }
>> +        break;
>>       default:
>>           break;
>>       }
>> @@ -926,6 +947,8 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>       case PP4:
>>       case PP4_4:
>>       case DIE_ERASE:
>> +    case RDID_90:
>> +    case RDID_AB:
>>           s->needed_bytes = get_addr_length(s);
>>
> If I understand correctly, for above commands allowed address length is 3
> bytes,
> but get_add_length can return 4. To avoid strange error I suggest to add
> case entry for them
> in get_addr_length.
>

About your suggestion above, I actually thought of this while creating the
patch but since I could not find support for 4 byte addresses in any of the
SST datasheets (and then no support for EN_4BYTE_ADDR (0xB7)), I could only
see get_addr_length to return 3 for these SST commands (and then the extra
cases shouldn't be needed), which is one of the reasons to why I decided to
add the commands to the above switch case. Do you find it ok to keep the
code as it is or would you like me to add the cases?

Best regards,
Francisco Iglesias


>
>           s->pos = 0;
>>           s->len = 0;
>>
> Regards,
> Marcin
>
>
