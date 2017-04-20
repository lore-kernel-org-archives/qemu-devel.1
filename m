Received: from eggs.gnu.org ([2001:4830:134:3::10]:42574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d15oa-0007wd-8J
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d15oX-00077c-2E
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d15oW-00077V-Pd
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:43:36 -0400
References: <1492482020-29745-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1492482020-29745-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <77fcaf8a-4352-feca-358e-379ff4006d18@redhat.com>
Date: Thu, 20 Apr 2017 14:43:27 +0800
MIME-Version: 1.0
In-Reply-To: <1492482020-29745-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 10:20, Zhang Chen wrote:
> In this patch we support packet that have tcp options field.
> Add tcp options field check, If the packet have options
> field we just skip it and compare tcp payload,
> Avoid unnecessary checkpoint, optimize performance.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index aada04e..049f6f8 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -248,7 +248,32 @@ static int colo_packet_compare_tcp(Packet *spkt, P=
acket *ppkt)
>           spkt->ip->ip_sum =3D ppkt->ip->ip_sum;
>       }
>  =20
> -    if (ptcp->th_sum =3D=3D stcp->th_sum) {
> +    /*
> +     * Check tcp header length for tcp option field.
> +     * th_off > 5 means this tcp packet have options field.
> +     * The tcp options maybe always different.
> +     * for example:
> +     * From RFC 7323.
> +     * TCP Timestamps option (TSopt):
> +     * Kind: 8
> +     *
> +     * Length: 10 bytes
> +     *
> +     *    +-------+-------+---------------------+---------------------=
+
> +     *    |Kind=3D8 |  10   |   TS Value (TSval)  |TS Echo Reply (TSec=
r)|
> +     *    +-------+-------+---------------------+---------------------=
+
> +     *       1       1              4                     4
> +     *
> +     * In this case the primary guest's timestamp always different wit=
h
> +     * the secondary guest's timestamp. COLO just focus on payload,
> +     * so we just need skip this field.h

Probably a good explanation why we can skip this kind of header. But it=20
does not explain why we can skip all the rest?

Thanks

> +     */
> +    if (ptcp->th_off > 5) {
> +        ptrdiff_t tcp_offset;
> +        tcp_offset =3D ppkt->transport_header - (uint8_t *)ppkt->data
> +                     + (ptcp->th_off * 4);
> +        res =3D colo_packet_compare_common(ppkt, spkt, tcp_offset);
> +    } else if (ptcp->th_sum =3D=3D stcp->th_sum) {
>           res =3D colo_packet_compare_common(ppkt, spkt, ETH_HLEN);
>       } else {
>           res =3D -1;
