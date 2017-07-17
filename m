Received: from eggs.gnu.org ([2001:4830:134:3::10]:50399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX0b9-0006bM-0Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX0b4-0000uV-FS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:37:43 -0400
Received: from [59.151.112.132] (port=36823 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX0b4-0000t2-2L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:37:38 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<174a3db3-6a14-edbb-641a-e93746c51861@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <7ac18343-fc01-8029-2264-617fdde6d6b2@cn.fujitsu.com>
Date: Mon, 17 Jul 2017 15:39:58 +0800
MIME-Version: 1.0
In-Reply-To: <174a3db3-6a14-edbb-641a-e93746c51861@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 07/14/2017 11:25 AM, Jason Wang wrote:
>
>
> On 2017年07月13日 13:52, Zhang Chen wrote:
>> If primary packet's sequence number not same with secondary packet's
>> sequence number, no need to compare the packet other field.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 0f8e198..2caeb80 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -222,6 +222,12 @@ static int colo_packet_compare_tcp(Packet *spkt, 
>> Packet *ppkt)
>>       ptcp = (struct tcphdr *)ppkt->transport_header;
>>       stcp = (struct tcphdr *)spkt->transport_header;
>>   +    if ((ptcp->th_flags & TH_SYN) != TH_SYN &&
>> +        ptcp->th_seq != stcp->th_seq) {
>> +        trace_colo_compare_main("colo_packet_compare_tcp seq not 
>> same");
>> +        return -1;
>> +    }
>> +
>>       /*
>>        * The 'identification' field in the IP header is *very* random
>>        * it almost never matches.  Fudge this by ignoring differences in
>
> Do we have any statistics numbers for this?

Rethink about this patch, I will remove it in next version and send a 
independent
patch in the future.
Because in FTP get test, primary guest send lots of packet differ to 
secondary guest's,
the packet payload are not same, but the total payload are same.
I think I have to buffer some packet's payload depend on sequence number 
for comparison?
Any idea about this?

Thanks
Zhang Chen

>
> Thanks
>
>
>

-- 
Thanks
Zhang Chen
