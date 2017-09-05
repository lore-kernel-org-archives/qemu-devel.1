Received: from eggs.gnu.org ([2001:4830:134:3::10]:54832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7EK-0000z9-P2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7EF-0007Ep-SG
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:21:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38772
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7EF-00079A-0m
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:20:55 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
References: <1504505688-32455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1504505688-32455-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<6e950754-7be8-1e9e-1fb8-3fffbdff44e2@cn.fujitsu.com>
Message-ID: <0045d465-8e1e-448c-a634-9b85372c14e3@cn.fujitsu.com>
Date: Tue, 5 Sep 2017 14:22:19 +0800
MIME-Version: 1.0
In-Reply-To: <6e950754-7be8-1e9e-1fb8-3fffbdff44e2@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5 1/3] net/colo-compare.c: Optimize
 unpredictable tcp options comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>



On 09/05/2017 10:11 AM, Dou Liyang wrote:
> Hi Chen,
>
> At 09/04/2017 02:14 PM, Zhang Chen wrote:
>> When network is busy, some tcp options(like sack) will unpredictable
>> occur in primary side or secondary side. it will make packet size
>> not same, but the two packet's payload is identical. colo just
>> care about packet payload, so we skip the option field.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>  net/colo-compare.c | 40 ++++++++++++++++++++++++++++------------
>>  1 file changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index ca67c68..18a9ebf 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -186,7 +186,10 @@ static int packet_enqueue(CompareState *s, int 
>> mode)
>>   * return:    0  means packet same
>>   *            > 0 || < 0 means packet different
>>   */
>> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, 
>> int offset)
>> +static int colo_packet_compare_common(Packet *ppkt,
>> +                                      Packet *spkt,
>> +                                      int poffset,
>> +                                      int soffset)
>>  {
>>      if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], 
>> sec_ip_dst[20];
>> @@ -201,12 +204,14 @@ static int colo_packet_compare_common(Packet 
>> *ppkt, Packet *spkt, int offset)
>>                                     sec_ip_src, sec_ip_dst);
>>      }
>>
>> -    offset = ppkt->vnet_hdr_len + offset;
>> +    poffset = ppkt->vnet_hdr_len + poffset;
>> +    soffset = ppkt->vnet_hdr_len + soffset;
>>
>> -    if (ppkt->size == spkt->size) {
>> -        return memcmp(ppkt->data + offset,
>> -                      spkt->data + offset,
>> -                      spkt->size - offset);
>> +    if (ppkt->size == spkt->size ||
>> +        ppkt->size - poffset == spkt->size - soffset) {
>
> This logic has a problem:
>
> ppkt->data
>    |-----------|---------rangeP---------|
>                |                    \   |
>            poffset                 ppkt->size
>                  \    equal range     \
> spkt->data        \                    \
>    |---------------|------rangeS--------|
>                    |                    |
>                 soffset            spkt->size
>
> See the above picture, (ppkt->size == spkt->size) is true,
> if  [soffset, spkt->size] == [poffset, poffset+(spkt->size- soffset) is
> also ture, the code will return 0, but actually, they are not equal.
>
> Please use following code instead,
>
> if (ppkt->size - poffset == spkt->size - soffset)
>
> I am a new boy in COLO, let's see what we actually want to compare,
> If I am wrong, please correct me. :-)
>
> ppkt->data
>    |-----------|---------rangeP---------|
>                |                        |
>            poffset                 ppkt->size
>
> spkt->data
>    |----|----------rangeS---------|
>         |                         |
>      soffset                 spkt->size
>
> The data in rangeP and rangeS is what we want to compare.
> So, we just need care about the rangeX's size and head pointer,
> not the whole size.

Yes, I have already considered this rare situation, but for packet 
comparing efficiency
I ignored it. As you know, every packet will be compared in COLO FT, 
most of packet
have the same offset, in this time use pkt->size is ok. the other packet 
with different
offset always have a different pkt->size. But we need cover all 
situation firstly,
I will update the V6 later.

Thanks
Zhang Chen

>
>
> Thanks,
>     dou.
> .
>

-- 
Thanks
Zhang Chen
