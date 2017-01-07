Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cPxrg-0001sU-In
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 15:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cPxrf-0003SO-A1
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 15:45:24 -0500
References: <20170106184948.3422-1-mar.krzeminski@gmail.com>
	<20170106184948.3422-3-mar.krzeminski@gmail.com>
	<ab63d2bc-cbfd-7d3a-ca80-efc1e99a20bd@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <8b690e14-e45d-bbdf-4b30-c666ce442d97@gmail.com>
Date: Sat, 7 Jan 2017 21:45:10 +0100
MIME-Version: 1.0
In-Reply-To: <ab63d2bc-cbfd-7d3a-ca80-efc1e99a20bd@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block: m25p80: Introduce die erase
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, edgar.iglesias@xilinx.com
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org



W dniu 07.01.2017 o 20:57, Cédric Le Goater pisze:
> On 01/06/2017 07:49 PM, Marcin Krzeminski wrote:
>> Modern big flash nor devices consist from more than one die.
>> Some of them do not support chip erase and instead have die
>> erase command that can erase one die only. This commit adds
>> possibility to define number of dies in the chip and adds
>> support for die erase command. Nor flash model is not strict
>> thus option to disable chip eras was not added.
>>
>> Signed-off-by: Marcin Krzeminski <mar.krzeminski@gmail.com>
>> ---
>>   hw/block/m25p80.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index 6dff81b..b065ddc 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -73,6 +73,12 @@ typedef struct FlashPartInfo {
>>       uint32_t n_sectors;
>>       uint32_t page_size;
>>       uint16_t flags;
>> +    /*
>> +     * Big sized spi nor are often stacked devices, thus sometime
>> +     * replace chip erase with die erase.
>> +     * This field inform how many die is in the chip.
>> +     */
>> +    uint8_t die_cnt;
>>   } FlashPartInfo;
>>   
>>   /* adapted from linux */
>> @@ -90,7 +96,8 @@ typedef struct FlashPartInfo {
>>       .sector_size = (_sector_size),\
>>       .n_sectors = (_n_sectors),\
>>       .page_size = 256,\
>> -    .flags = (_flags),
>> +    .flags = (_flags),\
>> +    .die_cnt = 0
>>   
>>   #define INFO6(_part_name, _jedec_id, _ext_id, _sector_size, _n_sectors, _flags)\
>>       .part_name = _part_name,\
>> @@ -107,6 +114,24 @@ typedef struct FlashPartInfo {
>>       .n_sectors = (_n_sectors),\
>>       .page_size = 256,\
>>       .flags = (_flags),\
>> +    .die_cnt = 0
>> +
>> +#define INFO_STACKED(_part_name, _jedec_id, _ext_id, _sector_size, _n_sectors,\
>> +                    _flags, _die_cnt)\
>> +    .part_name = _part_name,\
>> +    .id = {\
>> +        ((_jedec_id) >> 16) & 0xff,\
>> +        ((_jedec_id) >> 8) & 0xff,\
>> +        (_jedec_id) & 0xff,\
>> +        ((_ext_id) >> 8) & 0xff,\
>> +        (_ext_id) & 0xff,\
>> +          },\
>> +    .id_len = (!(_jedec_id) ? 0 : (3 + ((_ext_id) ? 2 : 0))),\
>> +    .sector_size = (_sector_size),\
>> +    .n_sectors = (_n_sectors),\
>> +    .page_size = 256,\
>> +    .flags = (_flags),\
>> +    .die_cnt = _die_cnt
>>   
>>   #define JEDEC_NUMONYX 0x20
>>   #define JEDEC_WINBOND 0xEF
>> @@ -359,6 +384,8 @@ typedef enum {
>>   
>>       REVCR = 0x65,
>>       WEVCR = 0x61,
>> +
>> +    DIE_ERASE = 0xC4,
>>   } FlashCMD;
>>   
>>   typedef enum {
>> @@ -514,6 +541,17 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
>>       case BULK_ERASE:
>>           len = s->size;
>>           break;
>> +    case DIE_ERASE:
>> +        if (s->pi->die_cnt) {
>> +            len = s->size / s->pi->die_cnt;
>> +            offset = offset & (~(len - 1));
>> +            printf("Die erase len = 0x%X offset = 0x%X!\n", len, offset);
> do we need this printf ?
Ups, testing leftover. I will delete this in next version.
Thanks!
>
> Thanks,
>
> C.
>
>   
>> +        } else {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: die erase is not supported"
>> +                          " by device\n");
>> +            return;
>> +        }
>> +        break;
>>       default:
>>           abort();
>>       }
>> @@ -635,6 +673,7 @@ static void complete_collecting_data(Flash *s)
>>       case ERASE4_32K:
>>       case ERASE_SECTOR:
>>       case ERASE4_SECTOR:
>> +    case DIE_ERASE:
>>           flash_erase(s, s->cur_addr, s->cmd_in_progress);
>>           break;
>>       case WRSR:
>> @@ -881,6 +920,7 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>>       case PP:
>>       case PP4:
>>       case PP4_4:
>> +    case DIE_ERASE:
>>           s->needed_bytes = get_addr_length(s);
>>           s->pos = 0;
>>           s->len = 0;
>>
>
