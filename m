Received: from eggs.gnu.org ([2001:4830:134:3::10]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX2Cl-00070b-Dc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX2Cg-0006ZN-Nt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:20:39 -0400
Received: from [59.151.112.132] (port=13778 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX2Cg-0006XK-2B
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:20:34 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<174a3db3-6a14-edbb-641a-e93746c51861@redhat.com>
	<7ac18343-fc01-8029-2264-617fdde6d6b2@cn.fujitsu.com>
	<20170717085505.GD2106@work-vm>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <9acbc01a-e3a5-40ff-5059-bea5569680ba@cn.fujitsu.com>
Date: Mon, 17 Jul 2017 17:23:00 +0800
MIME-Version: 1.0
In-Reply-To: <20170717085505.GD2106@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V2 2/4] net/colo-compare.c: Compare the tcp
 packets that has the same sequence number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 07/17/2017 04:55 PM, Dr. David Alan Gilbert wrote:
> * Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
>>
>> On 07/14/2017 11:25 AM, Jason Wang wrote:
>>>
>>> On 2017年07月13日 13:52, Zhang Chen wrote:
>>>> If primary packet's sequence number not same with secondary packet's
>>>> sequence number, no need to compare the packet other field.
>>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>> ---
>>>>    net/colo-compare.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>>> index 0f8e198..2caeb80 100644
>>>> --- a/net/colo-compare.c
>>>> +++ b/net/colo-compare.c
>>>> @@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet
>>>> *spkt, Packet *ppkt)
>>>>        ptcp = (struct tcphdr *)ppkt->transport_header;
>>>>        stcp = (struct tcphdr *)spkt->transport_header;
>>>>    +    if ((ptcp->th_flags & TH_SYN) != TH_SYN &&
>>>> +        ptcp->th_seq != stcp->th_seq) {
>>>> +        trace_colo_compare_main("colo_packet_compare_tcp seq not
>>>> same");
>>>> +        return -1;
>>>> +    }
>>>> +
>>>>        /*
>>>>         * The 'identification' field in the IP header is *very* random
>>>>         * it almost never matches.  Fudge this by ignoring differences in
>>> Do we have any statistics numbers for this?
>> Rethink about this patch, I will remove it in next version and send a
>> independent
>> patch in the future.
>> Because in FTP get test, primary guest send lots of packet differ to
>> secondary guest's,
>> the packet payload are not same, but the total payload are same.
> Do you mean that the TCP stream is the same but the packet sizes are
> different due to different fragmentation?

Yes, like that:
We send this payload: "1234567890".

primary:
pkt1 payload:"123"
pkt2 payload:"4567890"

secondary:
pkt1 payload:"1234567890"


>
>> I think I have to buffer some packet's payload depend on sequence number for
>> comparison?
>> Any idea about this?
> The original COLO discussions ~2-3 years ago talked about performing TCP
> reassembly and comparing the TCP stream; not a simple task.
>
> But the version I worked with also had the rewrite of the sequence
> numbers on the secondary to cause them to match even with the same
> fragmentation - but that doesn't seem to be upstream yet.

In current qemu upstream we use filter-rewriter to rewrite the sequence
numbers on the secondary, but we can not avoid different fragmentation 
in two side.
Any comments about guarantee the primary side and the secondary side 
have the same fragmentation?

Thanks
Zhang Chen

>
> Dave
>
>> Thanks
>> Zhang Chen
>>
>>> Thanks
>>>
>>>
>>>
>> -- 
>> Thanks
>> Zhang Chen
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
> .
>

-- 
Thanks
Zhang Chen
