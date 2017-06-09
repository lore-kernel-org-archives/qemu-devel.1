Received: from eggs.gnu.org ([2001:4830:134:3::10]:57367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDEU-0004cy-2C
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDEQ-0000c0-OM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:17:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJDEQ-0000bP-HS
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:17:14 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-9-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b90ff24c-a011-556a-98fd-a5dd81bfe1ca@redhat.com>
Date: Fri, 9 Jun 2017 14:17:09 +0800
MIME-Version: 1.0
In-Reply-To: <1496829322-17099-9-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 08/10] net/colo-compare.c: Add vnet
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



On 2017=E5=B9=B406=E6=9C=8807=E6=97=A5 17:55, Zhang Chen wrote:
> COLO-Proxy just focus on packet payload, So we skip vnet header.

s/So/so/

>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index e33cf7e..ad1c3d5 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -201,8 +201,11 @@ static int colo_packet_compare_common(Packet *ppkt=
, Packet *spkt, int offset)
>                                      sec_ip_src, sec_ip_dst);
>       }
>  =20
> +    offset =3D ppkt->vnet_hdr_len + offset;
> +
>       if (ppkt->size =3D=3D spkt->size) {
> -        return memcmp(ppkt->data + offset, spkt->data + offset,
> +        return memcmp(ppkt->data + offset,
> +                      spkt->data + offset,
>                         spkt->size - offset);
>       } else {
>           trace_colo_compare_main("Net packet size are not the same");
> @@ -261,8 +264,9 @@ static int colo_packet_compare_tcp(Packet *spkt, Pa=
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
