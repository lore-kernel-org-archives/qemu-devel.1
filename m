Received: from eggs.gnu.org ([2001:4830:134:3::10]:40586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7M7-0000Hy-Vu
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7M4-000686-Sf
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA7M4-00067h-Jc
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:11:32 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f8b6d2cf-e683-ecc2-e8b4-f96ed3a23ac3@redhat.com>
Date: Mon, 15 May 2017 12:11:24 +0800
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-11-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 10/12] net/colo-compare.c: Add vnet
 packet's tcp/udp/icmp compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B405=E6=9C=8812=E6=97=A5 09:41, Zhang Chen wrote:
> COLO-Proxy just focus on packet payload, So we skip vnet header.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index cb0b04e..bf565f3 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -188,6 +188,8 @@ static int packet_enqueue(CompareState *s, int mode=
)
>    */
>   static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int=
 offset)
>   {
> +    int offset_all;
> +
>       if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
>           char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_d=
st[20];
>  =20
> @@ -201,9 +203,12 @@ static int colo_packet_compare_common(Packet *ppkt=
, Packet *spkt, int offset)
>                                      sec_ip_src, sec_ip_dst);
>       }
>  =20
> +    offset_all =3D ppkt->vnet_hdr_len + offset;

How about just keep using offset by increasing it with vnet_hdr_len?

Thanks

> +
>       if (ppkt->size =3D=3D spkt->size) {
> -        return memcmp(ppkt->data + offset, spkt->data + offset,
> -                      spkt->size - offset);
> +        return memcmp(ppkt->data + offset_all,
> +                      spkt->data + offset_all,
> +                      spkt->size - offset_all);
>       } else {
>           trace_colo_compare_main("Net packet size are not the same");
>           return -1;
> @@ -261,8 +266,9 @@ static int colo_packet_compare_tcp(Packet *spkt, Pa=
cket *ppkt)
>        */
>       if (ptcp->th_off > 5) {
>           ptrdiff_t tcp_offset;
> +
>           tcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->data
> -                     + (ptcp->th_off * 4);
> +                     + (ptcp->th_off * 4) - ppkt->vnet_hdr_len;
>           res =3D colo_packet_compare_common(ppkt, spkt, tcp_offset);
>       } else if (ptcp->th_sum =3D=3D stcp->th_sum) {
>           res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
