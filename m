Received: from eggs.gnu.org ([2001:4830:134:3::10]:60611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciadI-0006eD-TI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciadE-000136-CH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:47:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ciadE-000130-3l
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:47:28 -0500
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1488259090-30034-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <958bdddd-003c-c785-e7e6-f700f1d87bc0@redhat.com>
Date: Tue, 28 Feb 2017 13:47:19 +0800
MIME-Version: 1.0
In-Reply-To: <1488259090-30034-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B402=E6=9C=8828=E6=97=A5 13:18, Zhang Chen wrote:
> Add offset args for colo_packet_compare_common, optimize
> colo_packet_compare_icmp() and colo_packet_compare_udp()
> just compare the IP payload. Before compare all tcp packet,
> we compare tcp checksum firstly, this function can get
> better performance.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 42 ++++++++++++++++++++++++++++--------------
>   1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 602a758..61fcdf2 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -180,7 +180,7 @@ static int packet_enqueue(CompareState *s, int mode=
)
>    * return:    0  means packet same
>    *            > 0 || < 0 means packet different
>    */
> -static int colo_packet_compare_common(Packet *ppkt, Packet *spkt)
> +static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int =
offset)
>   {
>       trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src=
),
>                                  inet_ntoa(ppkt->ip->ip_dst), spkt->siz=
e,
> @@ -188,7 +188,8 @@ static int colo_packet_compare_common(Packet *ppkt,=
 Packet *spkt)
>                                  inet_ntoa(spkt->ip->ip_dst));
>  =20
>       if (ppkt->size =3D=3D spkt->size) {
> -        return memcmp(ppkt->data, spkt->data, spkt->size);
> +        return memcmp(ppkt->data + offset, spkt->data + offset,
> +                      spkt->size - offset);
>       } else {
>           trace_colo_compare_main("Net packet size are not the same");
>           return -1;
> @@ -207,13 +208,6 @@ static int colo_packet_compare_tcp(Packet *spkt, P=
acket *ppkt)
>  =20
>       trace_colo_compare_main("compare tcp");
>  =20
> -    if (ppkt->size !=3D spkt->size) {
> -        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> -            trace_colo_compare_main("pkt size not same");
> -        }
> -        return -1;
> -    }
> -
>       ptcp =3D (struct tcphdr *)ppkt->transport_header;
>       stcp =3D (struct tcphdr *)spkt->transport_header;
>  =20
> @@ -231,8 +225,11 @@ static int colo_packet_compare_tcp(Packet *spkt, P=
acket *ppkt)
>           spkt->ip->ip_sum =3D ppkt->ip->ip_sum;
>       }
>  =20
> -    res =3D memcmp(ppkt->data + ETH_HLEN, spkt->data + ETH_HLEN,
> -                (spkt->size - ETH_HLEN));
> +    if (ptcp->th_sum =3D=3D stcp->th_sum) {
> +        res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
> +    } else {
> +        res =3D -1;
> +    }
>  =20
>       if (res !=3D 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOM=
PARE)) {
>           trace_colo_compare_pkt_info_src(inet_ntoa(ppkt->ip->ip_src),
> @@ -263,10 +260,18 @@ static int colo_packet_compare_tcp(Packet *spkt, =
Packet *ppkt)
>   static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
>   {
>       int ret;
> +    int network_length =3D ppkt->ip->ip_hl * 4;

network_header_length looks better.

>  =20
>       trace_colo_compare_main("compare udp");
>  =20
> -    ret =3D colo_packet_compare_common(ppkt, spkt);
> +    /*
> +     * Because of ppkt and spkt are both in the same connection,
> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
> +     * same with spkt. In addition, IP header's Identification is a ra=
ndom
> +     * field, we can handle it in IP fragmentation function later.
> +     * So we just compare the ip payload here.
> +     */

I'm afraid there're some other fields were ignored e.g TOS,TTL, and=20
options. We'd better explain this in the comment too.

> +    ret =3D colo_packet_compare_common(ppkt, spkt, network_length + ET=
H_HLEN);
>  =20
>       if (ret) {
>           trace_colo_compare_udp_miscompare("primary pkt size", ppkt->s=
ize);
> @@ -284,9 +289,18 @@ static int colo_packet_compare_udp(Packet *spkt, P=
acket *ppkt)
>    */
>   static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
>   {
> +    int network_length =3D ppkt->ip->ip_hl * 4;
> +
>       trace_colo_compare_main("compare icmp");
>  =20
> -    if (colo_packet_compare_common(ppkt, spkt)) {
> +    /*
> +     * Because of ppkt and spkt are both in the same connection,
> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
> +     * same with spkt. In addition, IP header's Identification is a ra=
ndom
> +     * field, we can handle it in IP fragmentation function later.
> +     * So we just compare the ip payload here.
> +     */
> +    if (colo_packet_compare_common(ppkt, spkt, network_length + ETH_HL=
EN)) {
>           trace_colo_compare_icmp_miscompare("primary pkt size",
>                                              ppkt->size);
>           qemu_hexdump((char *)ppkt->data, stderr, "colo-compare",
> @@ -312,7 +326,7 @@ static int colo_packet_compare_other(Packet *spkt, =
Packet *ppkt)
>                                  inet_ntoa(ppkt->ip->ip_dst), spkt->siz=
e,
>                                  inet_ntoa(spkt->ip->ip_src),
>                                  inet_ntoa(spkt->ip->ip_dst));
> -    return colo_packet_compare_common(ppkt, spkt);
> +    return colo_packet_compare_common(ppkt, spkt, 0);
>   }
>  =20
>   static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time=
)
