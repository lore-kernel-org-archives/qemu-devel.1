Received: from eggs.gnu.org ([2001:4830:134:3::10]:52933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAzb-0001if-43
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAza-0000xu-Bf
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:04:35 -0400
Received: from [59.151.112.132] (port=59691 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAzZ-0000x9-WF
	for qemu-devel@nongnu.org; Mon, 15 May 2017 04:04:34 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<f8b6d2cf-e683-ecc2-e8b4-f96ed3a23ac3@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <16d1f340-f889-f152-ce36-46f61eda51ab@cn.fujitsu.com>
Date: Mon, 15 May 2017 16:04:35 +0800
MIME-Version: 1.0
In-Reply-To: <f8b6d2cf-e683-ecc2-e8b4-f96ed3a23ac3@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 10/12] net/colo-compare.c: Add vnet
 packet's tcp/udp/icmp compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 05/15/2017 12:11 PM, Jason Wang wrote:
>
>
> On 2017年05月12日 09:41, Zhang Chen wrote:
>> COLO-Proxy just focus on packet payload, So we skip vnet header.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index cb0b04e..bf565f3 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -188,6 +188,8 @@ static int packet_enqueue(CompareState *s, int mode)
>>    */
>>   static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, 
>> int offset)
>>   {
>> +    int offset_all;
>> +
>>       if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>>           char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], 
>> sec_ip_dst[20];
>>   @@ -201,9 +203,12 @@ static int colo_packet_compare_common(Packet 
>> *ppkt, Packet *spkt, int offset)
>>                                      sec_ip_src, sec_ip_dst);
>>       }
>>   +    offset_all = ppkt->vnet_hdr_len + offset;
>
> How about just keep using offset by increasing it with vnet_hdr_len?

OK, I will fix it in next version.

Thanks
Zhang Chen

>
> Thanks
>
>> +
>>       if (ppkt->size == spkt->size) {
>> -        return memcmp(ppkt->data + offset, spkt->data + offset,
>> -                      spkt->size - offset);
>> +        return memcmp(ppkt->data + offset_all,
>> +                      spkt->data + offset_all,
>> +                      spkt->size - offset_all);
>>       } else {
>>           trace_colo_compare_main("Net packet size are not the same");
>>           return -1;
>> @@ -261,8 +266,9 @@ static int colo_packet_compare_tcp(Packet *spkt, 
>> Packet *ppkt)
>>        */
>>       if (ptcp->th_off > 5) {
>>           ptrdiff_t tcp_offset;
>> +
>>           tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>> -                     + (ptcp->th_off * 4);
>> +                     + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>>           res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
>>       } else if (ptcp->th_sum == stcp->th_sum) {
>>           res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>
>
>
> .
>

-- 
Thanks
Zhang Chen
