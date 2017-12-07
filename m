Received: from eggs.gnu.org ([2001:4830:134:3::10]:50327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eMoZU-0005rR-V2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eMoZR-0008Sv-Qz
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:18:08 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43371
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eMoZR-0008SD-Jw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:18:05 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-6-mark.cave-ayland@ilande.co.uk>
	<8ad8cb9d-9328-5fd2-be8c-99082dfe3fc7@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b497300f-c3b8-cc1b-e980-2a6888b0e104@ilande.co.uk>
Date: Thu, 7 Dec 2017 05:17:57 +0000
MIME-Version: 1.0
In-Reply-To: <8ad8cb9d-9328-5fd2-be8c-99082dfe3fc7@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 5/5] sunhme: switch sunhme_receive() over
 to use net_crc32_le()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

On 06/12/17 03:34, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 12/05/2017 05:17 AM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/net/sunhme.c | 25 +------------------------
>>   1 file changed, 1 insertion(+), 24 deletions(-)
>>
>> diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
>> index b1efa1b88d..df66e2630c 100644
>> --- a/hw/net/sunhme.c
>> +++ b/hw/net/sunhme.c
>> @@ -698,29 +698,6 @@ static inline void sunhme_set_rx_ring_nr(SunHMEState *s, int i)
>>       s->erxregs[HME_ERXI_RING >> 2] = ring;
>>   }
>>   
>> -#define POLYNOMIAL_LE 0xedb88320
>> -static uint32_t sunhme_crc32_le(const uint8_t *p, int len)
>> -{
>> -    uint32_t crc;
>> -    int carry, i, j;
>> -    uint8_t b;
>> -
>> -    crc = 0xffffffff;
>> -    for (i = 0; i < len; i++) {
>> -        b = *p++;
>> -        for (j = 0; j < 8; j++) {
>> -            carry = (crc & 0x1) ^ (b & 0x01);
>> -            crc >>= 1;
>> -            b >>= 1;
>> -            if (carry) {
>> -                crc = crc ^ POLYNOMIAL_LE;
>> -            }
>> -        }
>> -    }
>> -
>> -    return crc;
>> -}
>> -
>>   #define MIN_BUF_SIZE 60
>>   
>>   static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
>> @@ -761,7 +738,7 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
>>               trace_sunhme_rx_filter_bcast_match();
>>           } else if (s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_HENABLE) {
>>               /* Didn't match local address, check hash filter */
>> -            int mcast_idx = sunhme_crc32_le(buf, 6) >> 26;
> 
> This could be:
> 
>                 int mcast_idx = compute_mcast_idx_le(buf);
> 
> With:
> 
> unsigned compute_mcast_idx_le(const uint8_t *ep)
> {
>      return net_crc32(ep, ETH_ALEN) >> 26;
> }

It looks like Stefan is suggesting in his comments that the inline 
approach is better, so I'll try to keep that style for the moment.

I do like the use of ETH_ALEN though so I'll add that in to the next 
version.

> Anyway:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
>> +            int mcast_idx = net_crc32_le(buf, 6) >> 26;
>>               if (!(s->macregs[(HME_MACI_HASHTAB0 >> 2) - (mcast_idx >> 4)] &
>>                       (1 << (mcast_idx & 0xf)))) {
>>                   /* Didn't match hash filter */
>>

ATB,

Mark.
