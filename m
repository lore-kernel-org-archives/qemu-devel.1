Received: from eggs.gnu.org ([2001:4830:134:3::10]:46380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrMK-0003VQ-Op
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrMH-0000CI-HS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:33:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVrMH-0000Ai-9F
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:33:37 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5468b372-eec3-1969-e927-236859a6b079@redhat.com>
Date: Fri, 14 Jul 2017 11:33:30 +0800
MIME-Version: 1.0
In-Reply-To: <1499925175-21218-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 3/4] net/colo-compare.c: Optimize
 unpredictable tcp options comparison
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B407=E6=9C=8813=E6=97=A5 13:52, Zhang Chen wrote:
> When network is busy, some tcp options(like sack) will unpredictable
> occur in primary side or secondary side. it will make packet size
> not same, but the two packet's payload is identical. colo just
> care about packet payload, so we skip the option field.

A question is, if SACK were not same, does it mean e.g some packet were=20
lost just for primary or secondary? If yes, we will be out of sync soon.=20
Is it really better to delay the checkpoint here?

Thanks

>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 34 +++++++++++++++++++++++++---------
>   1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 2caeb80..6406c4a 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -183,7 +183,10 @@ static int packet_enqueue(CompareState *s, int mod=
e)
>    * return:    0  means packet same
>    *            > 0 || < 0 means packet different
>    */
> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int =
offset)
> +static int colo_packet_compare_common(Packet *ppkt,
> +                                      Packet *spkt,
> +                                      int poffset,
> +                                      int soffset)
>   {
>       if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>           char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_d=
st[20];
> @@ -198,9 +201,10 @@ static int colo_packet_compare_common(Packet *ppkt=
, Packet *spkt, int offset)
>                                      sec_ip_src, sec_ip_dst);
>       }
>  =20
> -    if (ppkt->size =3D=3D spkt->size) {
> -        return memcmp(ppkt->data + offset, spkt->data + offset,
> -                      spkt->size - offset);
> +    if (ppkt->size =3D=3D spkt->size || poffset !=3D soffset) {
> +        return memcmp(ppkt->data + poffset,
> +                      spkt->data + soffset,
> +                      spkt->size - soffset);
>       } else {
>           trace_colo_compare_main("Net packet size are not the same");
>           return -1;
> @@ -263,12 +267,22 @@ static int colo_packet_compare_tcp(Packet *spkt, =
Packet *ppkt)
>        * so we just need skip this field.
>        */
>       if (ptcp->th_off > 5) {
> -        ptrdiff_t tcp_offset;
> -        tcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->data
> +        ptrdiff_t ptcp_offset, stcp_offset;
> +
> +        ptcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->data
>                        + (ptcp->th_off * 4);
> -        res =3D colo_packet_compare_common(ppkt, spkt, tcp_offset);
> +        stcp_offset =3D spkt->transport_header - (uint8_t *)spkt->data
> +                     + (stcp->th_off * 4);
> +
> +        /*
> +         * When network is busy, some tcp options(like sack) will unpr=
edictable
> +         * occur in primary side or secondary side. it will make packe=
t size
> +         * not same, but the two packet's payload is identical. colo j=
ust
> +         * care about packet payload, so we skip the option field.
> +         */
> +        res =3D colo_packet_compare_common(ppkt, spkt, ptcp_offset, st=
cp_offset);
>       } else if (ptcp->th_sum =3D=3D stcp->th_sum) {
> -        res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
> +        res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN, ETH_H=
LEN);
>       } else {
>           res =3D -1;
>       }
> @@ -328,6 +342,7 @@ static int colo_packet_compare_udp(Packet *spkt, Pa=
cket *ppkt)
>        * the ip payload here.
>        */
>       ret =3D colo_packet_compare_common(ppkt, spkt,
> +                                     network_header_length + ETH_HLEN,
>                                        network_header_length + ETH_HLEN=
);
>  =20
>       if (ret) {
> @@ -365,6 +380,7 @@ static int colo_packet_compare_icmp(Packet *spkt, P=
acket *ppkt)
>        * the ip payload here.
>        */
>       if (colo_packet_compare_common(ppkt, spkt,
> +                                   network_header_length + ETH_HLEN,
>                                      network_header_length + ETH_HLEN))=
 {
>           trace_colo_compare_icmp_miscompare("primary pkt size",
>                                              ppkt->size);
> @@ -402,7 +418,7 @@ static int colo_packet_compare_other(Packet *spkt, =
Packet *ppkt)
>                                      sec_ip_src, sec_ip_dst);
>       }
>  =20
> -    return colo_packet_compare_common(ppkt, spkt, 0);
> +    return colo_packet_compare_common(ppkt, spkt, 0, 0);
>   }
>  =20
>   static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time=
)
