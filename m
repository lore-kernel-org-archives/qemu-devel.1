Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7SpV-0004Sb-Hp
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7SpU-0001Z2-F4
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:03:13 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:48274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e7SpU-0001YI-6J
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 17:03:12 -0400
Received: by mail-pf0-x243.google.com with SMTP id b79so858963pfk.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 14:03:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e8ac6787-38cb-c1e9-4ca4-6a5887887bd8@gmail.com>
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
	<20171024195139.28179-3-frasse.iglesias@gmail.com>
	<e8ac6787-38cb-c1e9-4ca4-6a5887887bd8@gmail.com>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Wed, 25 Oct 2017 23:03:09 +0200
Message-ID: <CAAYMZQvLOqQRhz4BgndHSNg+fBi=XOK3m41T5XTQCYBsYBscUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 02/13] m25p80: Add support for SST READ
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
Cc: qemu-devel@nongnu.org, edgari@xilinx.com, alistai@xilinx.com, Francisco Iglesias <francisco.iglesias@feimtech.se>

Good day Marcin,

Thank you for your excellent review comments! I will correct the patches in
the next version of the patch series (v4).

Best regards,
Francisco Iglesias


On 25 October 2017 at 20:12, mar.krzeminski <mar.krzeminski@gmail.com>
wrote:

>
>
> W dniu 24.10.2017 o 21:51, Francisco Iglesias pisze:
>
> Add support for SST READ ID 0x90/0xAB commands for reading out the flash
>> manufacuter ID and device ID.
>>
>> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>> ---
>>   hw/block/m25p80.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 2971519..c85e8fa 100644
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
>> @@ -1018,6 +1023,21 @@ static void decode_new_cmd(Flash *s, uint32_t
>> value)
>>           s->state = STATE_READING_DATA;
>>           break;
>>   +    case RDID_90:
>> +    case RDID_AB:
>> +        DB_PRINT_L(0, "populated manf/dev ID\n");
>> +        if (get_man(s) == MAN_SST) {
>> +            s->data[0] = s->pi->id[0];
>> +            s->data[1] = s->pi->id[2];
>> +            s->pos = 0;
>> +            s->len = 2;
>> +            s->data_read_loop = true;
>> +            s->state = STATE_READING_DATA;
>>
> I am not sure about this. I am looking at SST25WF080 datasheet, and it
> seem that those commands
> also expect address, and based on that returns manufacturer id or device
> id.
>
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n",
>> value);
>> +        }
>> +        break;
>> +
>>       case BULK_ERASE:
>>           if (s->write_enable) {
>>               DB_PRINT_L(0, "chip erase\n");
>>
> Regard,
> Marcin
>
