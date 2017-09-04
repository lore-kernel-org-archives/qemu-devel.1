Received: from eggs.gnu.org ([2001:4830:134:3::10]:58984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dogZn-0000WW-Qj
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 21:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dogYj-0003f8-Jr
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 21:53:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34291
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dogYi-0003aK-I2
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 21:52:17 -0400
References: <1503305719-2512-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1503305719-2512-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<17975998-de91-6c9c-6e37-04cf46dd6254@cn.fujitsu.com>
	<b96e1ef6-046d-f790-8ea3-14bb46b57f2d@gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f9722faf-4d55-fb74-3ad4-16e9fd68f43e@cn.fujitsu.com>
Date: Mon, 4 Sep 2017 09:52:06 +0800
MIME-Version: 1.0
In-Reply-To: <b96e1ef6-046d-f790-8ea3-14bb46b57f2d@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 1/3] net/colo-compare.c: Optimize
 unpredictable tcp options comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com
Cc: jasowang@redhat.com, =?UTF-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= <lizhijian@cn.fujitsu.com>

Hi Chen,

At 09/02/2017 12:02 AM, Zhang Chen wrote:
>
>
> On 09/01/2017 05:35 PM, Dou Liyang wrote:
>> Hi chen,
>>
>> At 08/21/2017 04:55 PM, Zhang Chen wrote:
>>> When network is busy, some tcp options(like sack) will unpredictable
>>> occur in primary side or secondary side. it will make packet size
>>> not same, but the two packet's payload is identical. colo just
>>> care about packet payload, so we skip the option field.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> ---
>>>  net/colo-compare.c | 39 +++++++++++++++++++++++++++------------
>>>  1 file changed, 27 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index ca67c68..f6bda41 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -186,7 +186,10 @@ static int packet_enqueue(CompareState *s, int
>>> mode)
>>>   * return:    0  means packet same
>>>   *            > 0 || < 0 means packet different
>>>   */
>>> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt,
>>> int offset)
>>> +static int colo_packet_compare_common(Packet *ppkt,
>>> +                                      Packet *spkt,
>>> +                                      int poffset,
>>> +                                      int soffset)
>>>  {
>>>      if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>>>          char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20],
>>> sec_ip_dst[20];
>>> @@ -201,12 +204,13 @@ static int colo_packet_compare_common(Packet
>>> *ppkt, Packet *spkt, int offset)
>>>                                     sec_ip_src, sec_ip_dst);
>>>      }
>>>
>>> -    offset = ppkt->vnet_hdr_len + offset;
>>> +    poffset = ppkt->vnet_hdr_len + poffset;
>>> +    soffset = ppkt->vnet_hdr_len + soffset;
>>>
>>> -    if (ppkt->size == spkt->size) {
>>> -        return memcmp(ppkt->data + offset,
>>> -                      spkt->data + offset,
>>> -                      spkt->size - offset);
>>> +    if (ppkt->size == spkt->size || poffset != soffset) {
>>> +        return memcmp(ppkt->data + poffset,
>>> +                      spkt->data + soffset,
>>> +                      spkt->size - soffset);
>>
>> Here maybe a mistake,
>>
>> I guess you should make sure
>>
>> (ppkt->size - poffset) == (spkt->size - soffset) is true in case of
>> (poffset != soffset) at the same time.
>>
>> Because, if sack make the header not equal, it is also possible that
>> the data is not equal at the same time.
>
> Good catch! In rare situation will miss a different packet, I will fix
> it in next version.
>

Thank you very much!

>>
>>>      } else {
>>>          trace_colo_compare_main("Net packet size are not the same");
>>>          return -1;
>>> @@ -263,13 +267,22 @@ static int colo_packet_compare_tcp(Packet
>>> *spkt, Packet *ppkt)
>>>       * so we just need skip this field.
>>>       */
>>>      if (ptcp->th_off > 5) {
>>> -        ptrdiff_t tcp_offset;
>>> +        ptrdiff_t ptcp_offset, stcp_offset;
>>>
>>> -        tcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>>> -                     + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>>> -        res = colo_packet_compare_common(ppkt, spkt, tcp_offset);
>>> +        ptcp_offset = ppkt->transport_header - (uint8_t *)ppkt->data
>>> +                      + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>>> +        stcp_offset = spkt->transport_header - (uint8_t *)spkt->data
>>> +                      + (stcp->th_off * 4) - spkt->vnet_hdr_len;
>>> +
>>> +        /*
>>> +         * When network is busy, some tcp options(like sack) will
>>> unpredictable
>>> +         * occur in primary side or secondary side. it will make
>>> packet size
>>> +         * not same, but the two packet's payload is identical. colo
>>> just
>>> +         * care about packet payload, so we skip the option field.
>>> +         */
>>> +        res = colo_packet_compare_common(ppkt, spkt, ptcp_offset,
>>> stcp_offset);
>>
>> we add a new parameter in xxx_common() just for xxx_tcp().
>> In my opinion, it seems not good.
>>
>> Can we split the tcp related code out from xxx_common, and make the
>> xxx_common function just do like what its name says.
>
> We introduce this parameter for all protocol, just tcp is the first user.
> We should have the ability of compare all kinds of packet.
> Maybe we must use different offset for other protocol except tcp in the
> future.
>

Got it,

Thanks,
	dou.

> Thanks
> Zhang Chen
>
>>
>>
>>>      } else if (ptcp->th_sum == stcp->th_sum) {
>>> -        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>>> +        res = colo_packet_compare_common(ppkt, spkt, ETH_HLEN,
>>> ETH_HLEN);
>>>      } else {
>>>          res = -1;
>>>      }
>>> @@ -329,6 +342,7 @@ static int colo_packet_compare_udp(Packet *spkt,
>>> Packet *ppkt)
>>>       * the ip payload here.
>>>       */
>>>      ret = colo_packet_compare_common(ppkt, spkt,
>>> +                                     network_header_length + ETH_HLEN,
>>>                                       network_header_length + ETH_HLEN);
>>
>> ditto
>>
>>>
>>>      if (ret) {
>>> @@ -366,6 +380,7 @@ static int colo_packet_compare_icmp(Packet *spkt,
>>> Packet *ppkt)
>>>       * the ip payload here.
>>>       */
>>>      if (colo_packet_compare_common(ppkt, spkt,
>>> +                                   network_header_length + ETH_HLEN,
>>>                                     network_header_length + ETH_HLEN)) {
>>
>> ditto
>>
>>> trace_colo_compare_icmp_miscompare("primary pkt size",
>>>                                             ppkt->size);
>>> @@ -403,7 +418,7 @@ static int colo_packet_compare_other(Packet
>>> *spkt, Packet *ppkt)
>>>                                     sec_ip_src, sec_ip_dst);
>>>      }
>>>
>>> -    return colo_packet_compare_common(ppkt, spkt, 0);
>>> +    return colo_packet_compare_common(ppkt, spkt, 0, 0);
>>
>> ditto
>>
>> Thanks,
>>     dou.
>>
>>>  }
>>>
>>>  static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
>>>
>>
>>
>>
>
