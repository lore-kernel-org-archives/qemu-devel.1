Received: from eggs.gnu.org ([2001:4830:134:3::10]:56944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDCW-0003Wj-6b
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDCS-0008Mz-QM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJDCS-0008Mr-HT
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:15:12 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5de38b64-e84a-930a-0c39-f084d00fc9c4@redhat.com>
Date: Fri, 9 Jun 2017 14:15:07 +0800
MIME-Version: 1.0
In-Reply-To: <1496829322-17099-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 04/10] net/net.c: Add vnet_hdr support
 in SocketReadState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 2017=E5=B9=B406=E6=9C=8807=E6=97=A5 17:55, Zhang Chen wrote:
> We add a flag to dicide whether net_fill_rstate() to read

s/dicide/decide/ and s/to/needs/

> the vnet_hdr_len or not.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> ---
>   include/net/net.h   |  6 +++++-
>   net/filter-mirror.c |  1 +
>   net/net.c           | 33 ++++++++++++++++++++++++++++++---
>   3 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 9a92c70..b2167ae 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -112,9 +112,13 @@ typedef struct NICState {
>   } NICState;
>  =20
>   struct SocketReadState {
> -    int state; /* 0 =3D getting length, 1 =3D getting data */
> +    /* 0 =3D getting length, 1 =3D getting vnet header length, 2 =3D g=
etting data */
> +    int state;
> +    /* This flag decide whether to read the vnet_hdr_len field */
> +    bool vnet_hdr;
>       uint32_t index;
>       uint32_t packet_len;
> +    uint32_t vnet_hdr_len;
>       uint8_t buf[NET_BUFSIZE];
>       SocketReadStateFinalize *finalize;
>   };
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 3413e82..4b03dda 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -267,6 +267,7 @@ static void filter_redirector_setup(NetFilterState =
*nf, Error **errp)
>       }
>  =20
>       net_socket_rs_init(&s->rs, redirector_rs_finalize);
> +    s->rs.vnet_hdr =3D s->vnet_hdr;

This looks like a follow up patch on top for this. And I would like to=20
reoder the series and make this patch as 02/10.

>  =20
>       if (s->indev) {
>           chr =3D qemu_chr_find(s->indev);
> diff --git a/net/net.c b/net/net.c
> index 4e7a305..b9b90c9 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1606,8 +1606,10 @@ void net_socket_rs_init(SocketReadState *rs,
>                           SocketReadStateFinalize *finalize)
>   {
>       rs->state =3D 0;
> +    rs->vnet_hdr =3D false;

Let's introduce a parameter for this function and let's caller set it=20
instead of manually toggling it like above.

>       rs->index =3D 0;
>       rs->packet_len =3D 0;
> +    rs->vnet_hdr_len =3D 0;
>       memset(rs->buf, 0, sizeof(rs->buf));
>       rs->finalize =3D finalize;
>   }
> @@ -1622,8 +1624,12 @@ int net_fill_rstate(SocketReadState *rs, const u=
int8_t *buf, int size)
>       unsigned int l;
>  =20
>       while (size > 0) {
> -        /* reassemble a packet from the network */
> -        switch (rs->state) { /* 0 =3D getting length, 1 =3D getting da=
ta */
> +        /* Reassemble a packet from the network.
> +         * 0 =3D getting length.
> +         * 1 =3D getting vnet header length.
> +         * 2 =3D getting data.
> +         */
> +        switch (rs->state) {
>           case 0:
>               l =3D 4 - rs->index;
>               if (l > size) {
> @@ -1637,10 +1643,31 @@ int net_fill_rstate(SocketReadState *rs, const =
uint8_t *buf, int size)
>                   /* got length */
>                   rs->packet_len =3D ntohl(*(uint32_t *)rs->buf);
>                   rs->index =3D 0;
> -                rs->state =3D 1;
> +                if (rs->vnet_hdr) {
> +                    rs->state =3D 1;
> +                } else {
> +                    rs->state =3D 2;
> +                    rs->vnet_hdr_len =3D 0;
> +                }
>               }
>               break;
>           case 1:
> +            l =3D 4 - rs->index;
> +            if (l > size) {
> +                l =3D size;
> +            }
> +            memcpy(rs->buf + rs->index, buf, l);
> +            buf +=3D l;
> +            size -=3D l;
> +            rs->index +=3D l;
> +            if (rs->index =3D=3D 4) {
> +                /* got vnet header length */
> +                rs->vnet_hdr_len =3D ntohl(*(uint32_t *)rs->buf);
> +                rs->index =3D 0;
> +                rs->state =3D 2;
> +            }
> +            break;
> +        case 2:
>               l =3D rs->packet_len - rs->index;
>               if (l > size) {
>                   l =3D size;
