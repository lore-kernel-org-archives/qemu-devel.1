Received: from eggs.gnu.org ([2001:4830:134:3::10]:34193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d1Ptg-0000go-KW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 00:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d1Ptc-0001Eg-1f
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 00:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d1Ptb-0001EV-Ob
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 00:10:11 -0400
References: <1492482020-29745-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1492482020-29745-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<77fcaf8a-4352-feca-358e-379ff4006d18@redhat.com>
	<67940fb7-9a96-255a-e316-a0ade3bb0397@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c0bdd81e-4519-ca2e-19f5-5c7413bb80a8@redhat.com>
Date: Fri, 21 Apr 2017 12:10:04 +0800
MIME-Version: 1.0
In-Reply-To: <67940fb7-9a96-255a-e316-a0ade3bb0397@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B404=E6=9C=8821=E6=97=A5 11:48, Zhang Chen wrote:
>
>
> On 04/20/2017 02:43 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 10:20, Zhang Chen wrote:
>>> In this patch we support packet that have tcp options field.
>>> Add tcp options field check, If the packet have options
>>> field we just skip it and compare tcp payload,
>>> Avoid unnecessary checkpoint, optimize performance.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> ---
>>>   net/colo-compare.c | 27 ++++++++++++++++++++++++++-
>>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index aada04e..049f6f8 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -248,7 +248,32 @@ static int colo_packet_compare_tcp(Packet=20
>>> *spkt, Packet *ppkt)
>>>           spkt->ip->ip_sum =3D ppkt->ip->ip_sum;
>>>       }
>>>   -    if (ptcp->th_sum =3D=3D stcp->th_sum) {
>>> +    /*
>>> +     * Check tcp header length for tcp option field.
>>> +     * th_off > 5 means this tcp packet have options field.
>>> +     * The tcp options maybe always different.
>>> +     * for example:
>>> +     * From RFC 7323.
>>> +     * TCP Timestamps option (TSopt):
>>> +     * Kind: 8
>>> +     *
>>> +     * Length: 10 bytes
>>> +     *
>>> +     * +-------+-------+---------------------+---------------------+
>>> +     *    |Kind=3D8 |  10   |   TS Value (TSval)  |TS Echo Reply=20
>>> (TSecr)|
>>> +     * +-------+-------+---------------------+---------------------+
>>> +     *       1       1              4                     4
>>> +     *
>>> +     * In this case the primary guest's timestamp always different=20
>>> with
>>> +     * the secondary guest's timestamp. COLO just focus on payload,
>>> +     * so we just need skip this field.h
>>
>> Probably a good explanation why we can skip this kind of header. But=20
>> it does not explain why we can skip all the rest?
>
> I found tcp options have many kind number to express different meaning,
> Here I just give an example for the different options situation,
> and this field not the COLO-proxy focus on, COLO just concern the=20
> payload.
> Maybe we will optimize in the feature. Currently we want to make COLO=20
> full-function
> running in qemu upstream.

I see, but the questions are:

- If we see packets with different options (except for the case you=20
explain above), does it mean primary and secondary run out of sync?
- What will happen if we compare and ask for synchronization if we find=20
options are not exactly the same?

Thanks

>
> Thanks
> Zhang Chen
>
>>
>> Thanks
>>
>>> +     */
>>> +    if (ptcp->th_off > 5) {
>>> +        ptrdiff_t tcp_offset;
>>> +        tcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->dat=
a
>>> +                     + (ptcp->th_off * 4);
>>> +        res =3D colo_packet_compare_common(ppkt, spkt, tcp_offset);
>>> +    } else if (ptcp->th_sum =3D=3D stcp->th_sum) {
>>>           res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>>>       } else {
>>>           res =3D -1;
>>
>>
>>
>> .
>>
>
