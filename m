Received: from eggs.gnu.org ([2001:4830:134:3::10]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d0IRv-00006T-0A
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 22:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d0IRr-0006k3-Tp
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 22:00:59 -0400
Received: from [59.151.112.132] (port=18006 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d0IRr-0006ik-7l
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 22:00:55 -0400
References: <1492334677-14170-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1492334677-14170-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<3a4f5675-bcea-96f5-5dd2-a3d4355cbe7a@amsat.org>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <00c145b0-d02f-9316-e144-8fa86c4e35d7@cn.fujitsu.com>
Date: Tue, 18 Apr 2017 10:01:11 +0800
MIME-Version: 1.0
In-Reply-To: <3a4f5675-bcea-96f5-5dd2-a3d4355cbe7a@amsat.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] COLO-compare: Optimize tcp compare for
 option field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 04/17/2017 09:43 PM, Philippe Mathieu-Daudé wrote:
> Hi Zhang,
>
> On 04/16/2017 06:24 AM, Zhang Chen wrote:
>> In this patch we support packet that have tcp options field.
>> Add tcp options field check, If the packet have options
>> field we just skip it and compare tcp payload,
>> Avoid unnecessary checkpoint, optimize performance.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>  net/colo-compare.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index aada04e..881d6b2 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -228,6 +228,7 @@ static int colo_packet_compare_tcp(Packet *spkt, 
>> Packet *ppkt)
>>  {
>>      struct tcphdr *ptcp, *stcp;
>>      int res;
>> +    int tcp_offset = 0;
>
> No need to declare here, it can be restricted to the if {} body.

OK~

>
>>
>>      trace_colo_compare_main("compare tcp");
>>
>> @@ -248,7 +249,31 @@ static int colo_packet_compare_tcp(Packet *spkt, 
>> Packet *ppkt)
>>          spkt->ip->ip_sum = ppkt->ip->ip_sum;
>>      }
>>
>> -    if (ptcp->th_sum == stcp->th_sum) {
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
>> +     * so we just need skip this field.
>> +     */
>> +    if (ptcp->th_off > 5) {
>
> You can declare here.
>
> I'd rather declare tcp_offset as a ptrdiff_t.

I got your point, will fix it in next version.

Thanks
Zhang Chen

>
>> +        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>> +                     + (ptcp->th_off * 4);
>> +        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
>> +    } else if (ptcp->th_sum == stcp->th_sum) {
>>          res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>>      } else {
>>          res = -1;
>>
>
>
> .
>

-- 
Thanks
Zhang Chen
