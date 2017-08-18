Received: from eggs.gnu.org ([2001:4830:134:3::10]:41420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dikmv-00063p-SG
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dikms-0004Cq-MM
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:25 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dikms-0004Cd-Hp
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:22 -0400
Received: by mail-qk0-x242.google.com with SMTP id o124so5638176qke.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:10:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1503065708-28277-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<b199b6a5-9679-741b-9fcb-d69f7e8da7bc@amsat.org>
Message-ID: <c605a917-54bd-63ae-d743-4db847263dbf@amsat.org>
Date: Fri, 18 Aug 2017 14:10:19 -0300
MIME-Version: 1.0
In-Reply-To: <b199b6a5-9679-741b-9fcb-d69f7e8da7bc@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] pcnet: switch lnc_mchash() over to use
 net_crc32_le()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com

On 08/18/2017 01:59 PM, Philippe Mathieu-Daudé wrote:
> On 08/18/2017 11:15 AM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/net/pcnet.c |   16 +---------------
>>   1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
>> index 6544553..c050993 100644
>> --- a/hw/net/pcnet.c
>> +++ b/hw/net/pcnet.c
>> @@ -522,23 +522,9 @@ static inline void pcnet_rmd_store(PCNetState *s, 
>> struct pcnet_RMD *rmd,
>>              be16_to_cpu(hdr->ether_type));       \
>>   } while (0)
>> -#define MULTICAST_FILTER_LEN 8
>> -
>>   static inline uint32_t lnc_mchash(const uint8_t *ether_addr)
>>   {
>> -#define LNC_POLYNOMIAL          0xEDB88320UL
>> -    uint32_t crc = 0xFFFFFFFF;
>> -    int idx, bit;
>> -    uint8_t data;
>> -
>> -    for (idx = 0; idx < 6; idx++) {
>> -        for (data = *ether_addr++, bit = 0; bit < 
>> MULTICAST_FILTER_LEN; bit++) {
>> -            crc = (crc >> 1) ^ (((crc ^ data) & 1) ? LNC_POLYNOMIAL : 
>> 0);
>> -            data >>= 1;
>> -        }
>> -    }
>> -    return crc;
>> -#undef LNC_POLYNOMIAL
>> +    return net_crc32_le(ether_addr, 6);

with previous suggestion from patch 1/4:

        return mac_crc32_le(ether_addr);

> 
> using ETH_ALEN:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>>   }
>>   #define CRC(crc, ch)     (crc = (crc >> 8) ^ crctab[(crc ^ (ch)) & 
>> 0xff])
> 
