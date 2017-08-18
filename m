Received: from eggs.gnu.org ([2001:4830:134:3::10]:40645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dikjU-0003go-N2
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dikjR-0002ij-Il
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:06:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dikjR-0002ia-D8
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:06:49 -0400
Received: by mail-qk0-x241.google.com with SMTP id x77so9255040qka.4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:06:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1503065708-28277-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<66172cef-cd84-4d0f-dee3-fdfa7b4144eb@amsat.org>
Message-ID: <035ce9db-73d0-9bb6-8aa8-4e0b1a2dd383@amsat.org>
Date: Fri, 18 Aug 2017 14:06:46 -0300
MIME-Version: 1.0
In-Reply-To: <66172cef-cd84-4d0f-dee3-fdfa7b4144eb@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] net: move CRC32 calculation from
 compute_mcast_idx() into its own net_crc32() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, jasowang@redhat.com

On 08/18/2017 01:51 PM, Philippe Mathieu-Daudé wrote:
> On 08/18/2017 11:15 AM, Mark Cave-Ayland wrote:
>> Separate out the standard ethernet CRC32 calculation into a new 
>> net_crc32()
>> function, renaming the constant POLYNOMIAL to POLYNOMIAL_BE to make it 
>> clear
>> that this is a big-endian CRC32 calculation.
>>
>> Then remove the existing implementation from compute_mcast_idx() and 
>> call the
>> new function in its place.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   include/net/net.h |    3 ++-
>>   net/net.c         |   16 +++++++++++-----
>>   2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 1c55a93..586098c 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -227,7 +227,8 @@ NetClientState *net_hub_port_find(int hub_id);
>>   void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
>> -#define POLYNOMIAL 0x04c11db6
>> +#define POLYNOMIAL_BE 0x04c11db6
>> +uint32_t net_crc32(const uint8_t *p, int len);
>>   unsigned compute_mcast_idx(const uint8_t *ep);
>>   #define vmstate_offset_macaddr(_state, _field)                       \
>> diff --git a/net/net.c b/net/net.c
>> index 0e28099..a856907 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1568,25 +1568,31 @@ int net_client_parse(QemuOptsList *opts_list, 
>> const char *optarg)
>>   /* From FreeBSD */
>>   /* XXX: optimize */
>> -unsigned compute_mcast_idx(const uint8_t *ep)
>> +uint32_t net_crc32(const uint8_t *p, int len)
> 
> imho there is no point in using signed length.
> 
>>   {
>>       uint32_t crc;
>>       int carry, i, j;
>>       uint8_t b;
>>       crc = 0xffffffff;
>> -    for (i = 0; i < 6; i++) {
>> -        b = *ep++;
>> +    for (i = 0; i < len; i++) {
>> +        b = *p++;
>>           for (j = 0; j < 8; j++) {
>>               carry = ((crc & 0x80000000L) ? 1 : 0) ^ (b & 0x01);
>>               crc <<= 1;
>>               b >>= 1;
>>               if (carry) {
>> -                crc = ((crc ^ POLYNOMIAL) | carry);
>> +                crc = ((crc ^ POLYNOMIAL_BE) | carry);
>>               }
>>           }
>>       }
>> -    return crc >> 26;
>> +
>> +    return crc;
>> +}
>> +
>> +unsigned compute_mcast_idx(const uint8_t *ep)
>> +{
>> +    return net_crc32(ep, 6) >> 26;
> 
> while here let's use ETH_ALEN
>

reading the next patches, what do you think about:

static inline uint32_t mac_crc32_be(const uint8_t *p)
{
     return net_crc32_be(ep, ETH_ALEN);
}

unsigned compute_mcast_idx(const uint8_t *ep)
{
     return mac_crc32_be(p) >> 26;
}

>>   }
>>   QemuOptsList qemu_netdev_opts = {
>>
> with "uint32_t net_crc32(const uint8_t *p, size_t len);":
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
