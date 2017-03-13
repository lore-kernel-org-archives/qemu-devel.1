Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJ8k-0005gr-30
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnJ8g-00058o-Uq
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnJ8g-00058G-Lj
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:07:26 -0400
References: <1489045207-27706-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8d8d77a6-7616-98de-247c-3084c88e3fcf@redhat.com>
Date: Mon, 13 Mar 2017 14:07:21 +0800
MIME-Version: 1.0
In-Reply-To: <1489045207-27706-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] COLO-compare: Fix trace_event print bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 15:40, Zhang Chen wrote:
> Because of inet_ntoa() return a statically allocated buffer,
> subsequent calls will overwrite, So we fix this bug.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 33 +++++++++++++++++++++++++--------
>   1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 282727b..54e6d40 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -182,10 +182,18 @@ static int packet_enqueue(CompareState *s, int mo=
de)
>    */
>   static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int=
 offset)
>   {
> -    trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src)=
,
> -                               inet_ntoa(ppkt->ip->ip_dst), spkt->size=
,
> -                               inet_ntoa(spkt->ip->ip_src),
> -                               inet_ntoa(spkt->ip->ip_dst));
> +    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> +        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_ds=
t[20];
> +
> +        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> +        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
> +        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
> +        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
> +
> +        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
> +                                   pri_ip_dst, spkt->size,
> +                                   sec_ip_src, sec_ip_dst);
> +    }
>  =20
>       if (ppkt->size =3D=3D spkt->size) {
>           return memcmp(ppkt->data + offset, spkt->data + offset,
> @@ -336,10 +344,19 @@ static int colo_packet_compare_icmp(Packet *spkt,=
 Packet *ppkt)
>   static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
>   {
>       trace_colo_compare_main("compare other");
> -    trace_colo_compare_ip_info(ppkt->size, inet_ntoa(ppkt->ip->ip_src)=
,
> -                               inet_ntoa(ppkt->ip->ip_dst), spkt->size=
,
> -                               inet_ntoa(spkt->ip->ip_src),
> -                               inet_ntoa(spkt->ip->ip_dst));
> +    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
> +        char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_ds=
t[20];
> +
> +        strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
> +        strcpy(pri_ip_dst, inet_ntoa(ppkt->ip->ip_dst));
> +        strcpy(sec_ip_src, inet_ntoa(spkt->ip->ip_src));
> +        strcpy(sec_ip_dst, inet_ntoa(spkt->ip->ip_dst));
> +
> +        trace_colo_compare_ip_info(ppkt->size, pri_ip_src,
> +                                   pri_ip_dst, spkt->size,
> +                                   sec_ip_src, sec_ip_dst);
> +    }
> +
>       return colo_packet_compare_common(ppkt, spkt, 0);
>   }
>  =20

Applied, thanks.
