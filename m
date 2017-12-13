Received: from eggs.gnu.org ([2001:4830:134:3::10]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eP28m-0005Ld-M5
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eP28l-0004s7-3W
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:11:44 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eP28k-0004rg-PZ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:11:43 -0500
Received: by mail-wm0-x230.google.com with SMTP id f140so3233441wmd.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 00:11:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <781f34e2-622c-858a-d6e8-77860ed3f36a@cn.fujitsu.com>
References: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<b6d0276b6310888ce85e96277826e8e1ae1ba541.1512552817.git.maozy.fnst@cn.fujitsu.com>
	<CAK3tnvJ-nFhdN8qdO1WqBxp5stX_Rrh1F5eM5_NC_7uOsGow4Q@mail.gmail.com>
	<781f34e2-622c-858a-d6e8-77860ed3f36a@cn.fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 13 Dec 2017 08:11:41 +0000
Message-ID: <CAK3tnvL18vuczgmZuCO2FONVK6+LAnOSpy6DRLhnWcL-6N7z6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] colo: remove the incorrect if
 conditions in colo_compare_packet_tcp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

On Wed, Dec 13, 2017 at 5:32 AM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
wrote:

> Hi, Chen
>
> On 12/12/2017 11:19 PM, Zhang Chen wrote:
>
>> This patch should be moved behind the patch with payload comparition.
>>
>
> Well, it is not impossible, but I think it is better to be here. Because
> it is
> the correct logic to firstly ensure that there are no missing cases by
> fixing
> the small nits in the original tcp comparison then consider whether or no=
t
> to
> rebuild it. It's two things. The payload comparison patch belongs to the
> latter,
> So this patch should be placed in front of it.


Rethink about this patch, combine this to the next patch is better in logic=
.



>
>
> People needs look your changes to understand why we need this patch.
>>
>
> Actually, in colo_packet_compare_tcp() the if condition (ptcp->th_off > 5=
)
> is
> not reasonable, it make the packets with =E2=80=98ptcp->th_off =3D=3D 5=
=E2=80=99 lose the
> chance of
> comparison even if the same payload.
>
> Since colo is focus on the payload we only need to get the length of
> packet header
> rather than care about whether the packet carries option fields. So this
> is the
> meaning of this patch.
>

No, this is reasonable.
  if  (ptcp->th_off > 5) means primary side have more TCP option in this
moment,
At this time secondary side have a big probability without the
option(ptcp->th_off !=3D stcp->th_off ) like SACK option.
So, the old way in here can handle some different pkt size situation about
TCP options.
I remember in my test, here can optimize the performance in some case very
huge.


Thanks
Zhang Chen



>
> Thanks,
> Mao
>
>
>> Thanks
>> Zhang Chen
>>
>>
>> On Wed, Dec 6, 2017 at 9:57 AM, Mao Zhongyi <maozy.fnst@cn.fujitsu.com
>> <mailto:maozy.fnst@cn.fujitsu.com>> wrote:
>>
>>     The th_off field specifies the size of the TCP header, if th_off > 5=
,
>>     it only means this tcp packet have options field. Regardless of
>> whether
>>     the packet carries option fields, it doesn't effect us to obtain the
>>     length of the header use a general method. So there is no need to ad=
d
>>     the limiting conditions(if (th_off > 5)). In addtion, here we just
>> focus
>>     on the payload, don't care about the option field. So removed the
>>     'if (th_off > 5)' and 'if (ptcp->th_sum =3D=3D stcp->th_sum)' condit=
ions
>>     together.
>>
>>     Cc: Zhang Chen <zhangckid@gmail.com <mailto:zhangckid@gmail.com>>
>>     Cc: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:
>> lizhijian@cn.fujitsu.com>>
>>     Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
>>
>>     Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com <mailto:
>> maozy.fnst@cn.fujitsu.com>>
>>     Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com <mailto:
>> lizhijian@cn.fujitsu.com>>
>>
>>     ---
>>      net/colo-compare.c | 31 ++++++++++++-------------------
>>      1 file changed, 12 insertions(+), 19 deletions(-)
>>
>>     diff --git a/net/colo-compare.c b/net/colo-compare.c
>>     index 1ce195f..0afb5f0 100644
>>     --- a/net/colo-compare.c
>>     +++ b/net/colo-compare.c
>>     @@ -271,26 +271,19 @@ static int colo_packet_compare_tcp(Packet
>> *spkt, Packet *ppkt)
>>           * the secondary guest's timestamp. COLO just focus on payload,
>>           * so we just need skip this field.
>>           */
>>     -    if (ptcp->th_off > 5) {
>>     -        ptrdiff_t ptcp_offset, stcp_offset;
>>     +    ptrdiff_t ptcp_offset, stcp_offset;
>>
>>     -        ptcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->d=
ata
>>     -                      + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>>     -        stcp_offset =3D spkt->transport_header - (uint8_t *)spkt->d=
ata
>>     -                      + (stcp->th_off * 4) - spkt->vnet_hdr_len;
>>     -
>>     -        /*
>>     -         * When network is busy, some tcp options(like sack) will
>> unpredictable
>>     -         * occur in primary side or secondary side. it will make
>> packet size
>>     -         * not same, but the two packet's payload is identical. col=
o
>> just
>>     -         * care about packet payload, so we skip the option field.
>>     -         */
>>     -        res =3D colo_packet_compare_common(ppkt, spkt, ptcp_offset,
>> stcp_offset);
>>     -    } else if (ptcp->th_sum =3D=3D stcp->th_sum) {
>>     -        res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN,
>> ETH_HLEN);
>>     -    } else {
>>     -        res =3D -1;
>>     -    }
>>     +    ptcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->data
>>     +                  + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>>     +    stcp_offset =3D spkt->transport_header - (uint8_t *)spkt->data
>>     +                  + (stcp->th_off * 4) - spkt->vnet_hdr_len;
>>     +    /*
>>     +     * When network is busy, some tcp options(like sack) will
>> unpredictable
>>     +     * occur in primary side or secondary side. it will make packet
>> size
>>     +     * not same, but the two packet's payload is identical. colo ju=
st
>>     +     * care about packet payload, so we skip the option field.
>>     +     */
>>     +    res =3D colo_packet_compare_common(ppkt, spkt, ptcp_offset,
>> stcp_offset);
>>
>>          if (res !=3D 0 &&
>>              trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPAR=
E))
>> {
>>     --
>>     2.9.4
>>
>>
>>
>>
>>
>
>
