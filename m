Received: from eggs.gnu.org ([2001:4830:134:3::10]:37208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cib1X-0006Bn-IQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cib1U-0003Cb-Cc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:12:35 -0500
Received: from [59.151.112.132] (port=45949 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cib1T-0003Bz-As
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:12:32 -0500
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1488259090-30034-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<958bdddd-003c-c785-e7e6-f700f1d87bc0@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <64fa3338-3771-4f19-7882-8a028aac87a4@cn.fujitsu.com>
Date: Tue, 28 Feb 2017 14:11:32 +0800
MIME-Version: 1.0
In-Reply-To: <958bdddd-003c-c785-e7e6-f700f1d87bc0@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2 2/3] COLO-compare: Optimize
 compare_common and compare_tcp
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



On 02/28/2017 01:47 PM, Jason Wang wrote:
>
>
> On 2017年02月28日 13:18, Zhang Chen wrote:
>> Add offset args for colo_packet_compare_common, optimize
>> colo_packet_compare_icmp() and colo_packet_compare_udp()
>> just compare the IP payload. Before compare all tcp packet,
>> we compare tcp checksum firstly, this function can get
>> better performance.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 42 ++++++++++++++++++++++++++++--------------
>>   1 file changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 602a758..61fcdf2 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -180,7 +180,7 @@ static int packet_enqueue(CompareState *s, int mode)
>>    * return:    0  means packet same
>>    *            > 0 || < 0 means packet different
>>    */
>> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
>> +static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, 
>> int offset)
>>   {
>>       trace_colo_compare_ip_info(ppkt->size, 
>> inet_ntoa(ppkt->ip->ip_src),
>> inet_ntoa(ppkt->ip->ip_dst), spkt->size,
>> @@ -188,7 +188,8 @@ static int colo_packet_compare_common(Packet 
>> *ppkt, Packet *spkt)
>> inet_ntoa(spkt->ip->ip_dst));
>>         if (ppkt->size == spkt->size) {
>> -        return memcmp(ppkt->data, spkt->data, spkt->size);
>> +        return memcmp(ppkt->data + offset, spkt->data + offset,
>> +                      spkt->size - offset);
>>       } else {
>>           trace_colo_compare_main("Net packet size are not the same");
>>           return -1;
>> @@ -207,13 +208,6 @@ static int colo_packet_compare_tcp(Packet *spkt, 
>> Packet *ppkt)
>>         trace_colo_compare_main("compare tcp");
>>   -    if (ppkt->size != spkt->size) {
>> -        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>> -            trace_colo_compare_main("pkt size not same");
>> -        }
>> -        return -1;
>> -    }
>> -
>>       ptcp = (struct tcphdr *)ppkt->transport_header;
>>       stcp = (struct tcphdr *)spkt->transport_header;
>>   @@ -231,8 +225,11 @@ static int colo_packet_compare_tcp(Packet 
>> *spkt, Packet *ppkt)
>>           spkt->ip->ip_sum = ppkt->ip->ip_sum;
>>       }
>>   -    res = memcmp(ppkt->data + ETH_HLEN, spkt->data + ETH_HLEN,
>> -                (spkt->size - ETH_HLEN));
>> +    if (ptcp->th_sum == stcp->th_sum) {
>> +        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>> +    } else {
>> +        res = -1;
>> +    }
>>         if (res != 0 && 
>> trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>> trace_colo_compare_pkt_info_src(inet_ntoa(ppkt->ip->ip_src),
>> @@ -263,10 +260,18 @@ static int colo_packet_compare_tcp(Packet 
>> *spkt, Packet *ppkt)
>>   static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>>   {
>>       int ret;
>> +    int network_length = ppkt->ip->ip_hl * 4;
>
> network_header_length looks better.

OK, I will rename it.

>
>>         trace_colo_compare_main("compare udp");
>>   -    ret = colo_packet_compare_common(ppkt, spkt);
>> +    /*
>> +     * Because of ppkt and spkt are both in the same connection,
>> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
>> +     * same with spkt. In addition, IP header's Identification is a 
>> random
>> +     * field, we can handle it in IP fragmentation function later.
>> +     * So we just compare the ip payload here.
>> +     */
>
> I'm afraid there're some other fields were ignored e.g TOS,TTL, and 
> options. We'd better explain this in the comment too.

OK, How about this?

+    /*
+     * Because of ppkt and spkt are both in the same connection,
+     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
+     * same with spkt. In addition, IP header's Identification is a random
+     * field, we can handle it in IP fragmentation function later.
+     * So we just compare the ip payload here. we ignored all IP header
+     * include other field like TOS,TTL,IP Checksum.
+     */

Thanks
Zhang Chen


>
>> +    ret = colo_packet_compare_common(ppkt, spkt, network_length + 
>> ETH_HLEN);
>>         if (ret) {
>>           trace_colo_compare_udp_miscompare("primary pkt size", 
>> ppkt->size);
>> @@ -284,9 +289,18 @@ static int colo_packet_compare_udp(Packet *spkt, 
>> Packet *ppkt)
>>    */
>>   static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>>   {
>> +    int network_length = ppkt->ip->ip_hl * 4;
>> +
>>       trace_colo_compare_main("compare icmp");
>>   -    if (colo_packet_compare_common(ppkt, spkt)) {
>> +    /*
>> +     * Because of ppkt and spkt are both in the same connection,
>> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
>> +     * same with spkt. In addition, IP header's Identification is a 
>> random
>> +     * field, we can handle it in IP fragmentation function later.
>> +     * So we just compare the ip payload here.
>> +     */
>> +    if (colo_packet_compare_common(ppkt, spkt, network_length + 
>> ETH_HLEN)) {
>>           trace_colo_compare_icmp_miscompare("primary pkt size",
>>                                              ppkt->size);
>>           qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
>> @@ -312,7 +326,7 @@ static int colo_packet_compare_other(Packet 
>> *spkt, Packet *ppkt)
>> inet_ntoa(ppkt->ip->ip_dst), spkt->size,
>> inet_ntoa(spkt->ip->ip_src),
>> inet_ntoa(spkt->ip->ip_dst));
>> -    return colo_packet_compare_common(ppkt, spkt);
>> +    return colo_packet_compare_common(ppkt, spkt, 0);
>>   }
>>     static int colo_old_packet_check_one(Packet *pkt, int64_t 
>> *check_time)
>
>
>
> .
>

-- 
Thanks
Zhang Chen
