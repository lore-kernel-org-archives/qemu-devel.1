Received: from eggs.gnu.org ([2001:4830:134:3::10]:57248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d1PXw-0004E2-Ba
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d1PXs-00018W-FV
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:47:48 -0400
Received: from [59.151.112.132] (port=63474 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d1PXs-00017R-2d
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:47:44 -0400
References: <1492482020-29745-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1492482020-29745-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<77fcaf8a-4352-feca-358e-379ff4006d18@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <67940fb7-9a96-255a-e316-a0ade3bb0397@cn.fujitsu.com>
Date: Fri, 21 Apr 2017 11:48:01 +0800
MIME-Version: 1.0
In-Reply-To: <77fcaf8a-4352-feca-358e-379ff4006d18@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2 1/2] COLO-compare: Optimize tcp compare
 for option field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 04/20/2017 02:43 PM, Jason Wang wrote:
>
>
> On 2017年04月18日 10:20, Zhang Chen wrote:
>> In this patch we support packet that have tcp options field.
>> Add tcp options field check, If the packet have options
>> field we just skip it and compare tcp payload,
>> Avoid unnecessary checkpoint, optimize performance.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index aada04e..049f6f8 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -248,7 +248,32 @@ static int colo_packet_compare_tcp(Packet *spkt, 
>> Packet *ppkt)
>>           spkt->ip->ip_sum = ppkt->ip->ip_sum;
>>       }
>>   -    if (ptcp->th_sum == stcp->th_sum) {
>> +    /*
>> +     * Check tcp header length for tcp option field.
>> +     * th_off > 5 means this tcp packet have options field.
>> +     * The tcp options maybe always different.
>> +     * for example:
>> +     * From RFC 7323.
>> +     * TCP Timestamps option (TSopt):
>> +     * Kind: 8
>> +     *
>> +     * Length: 10 bytes
>> +     *
>> +     * +-------+-------+---------------------+---------------------+
>> +     *    |Kind=8 |  10   |   TS Value (TSval)  |TS Echo Reply (TSecr)|
>> +     * +-------+-------+---------------------+---------------------+
>> +     *       1       1              4                     4
>> +     *
>> +     * In this case the primary guest's timestamp always different with
>> +     * the secondary guest's timestamp. COLO just focus on payload,
>> +     * so we just need skip this field.h
>
> Probably a good explanation why we can skip this kind of header. But 
> it does not explain why we can skip all the rest?

I found tcp options have many kind number to express different meaning,
Here I just give an example for the different options situation,
and this field not the COLO-proxy focus on, COLO just concern the payload.
Maybe we will optimize in the feature. Currently we want to make COLO 
full-function
running in qemu upstream.

Thanks
Zhang Chen

>
> Thanks
>
>> +     */
>> +    if (ptcp->th_off > 5) {
>> +        ptrdiff_t tcp_offset;
>> +        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>> +                     + (ptcp->th_off * 4);
>> +        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
>> +    } else if (ptcp->th_sum == stcp->th_sum) {
>>           res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>>       } else {
>>           res = -1;
>
>
>
> .
>

-- 
Thanks
Zhang Chen
