Received: from eggs.gnu.org ([2001:4830:134:3::10]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5QkY-0000hN-4r
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5QkT-0007ra-Lz
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d5QkT-0007r3-DL
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:53:21 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7bde3681-280c-764a-71df-f4a1cc4b7011@redhat.com>
Date: Tue, 2 May 2017 13:53:13 +0800
MIME-Version: 1.0
In-Reply-To: <1493372840-24551-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 05/10] net/net.c: Add vnet header length
 to SocketReadState
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



On 2017=E5=B9=B404=E6=9C=8828=E6=97=A5 17:47, Zhang Chen wrote:
> Address Jason Wang's comments add vnet header length to SocketReadState=
.

Instead of saying this, you can add "Suggested-by: Jason Wang=20
<jasowang@redhat.com>" above your sign-off.

> So we change net_fill_rstate() to read
> struct  {int size; int vnet_hdr_len; const uint8_t buf[];}.

This makes me thinking about the backward compatibility. I think we'd=20
better try to keep it as much as possible. E.g how about pack=20
vnet_hdr_len into higher bits of size?

Thanks

>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   include/net/net.h |  4 +++-
>   net/net.c         | 24 ++++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 402d913..865cb98 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -115,9 +115,11 @@ typedef struct NICState {
>   } NICState;
>  =20
>   struct SocketReadState {
> -    int state; /* 0 =3D getting length, 1 =3D getting data */
> +    /* 0 =3D getting length, 1 =3D getting vnet header length, 2 =3D g=
etting data */
> +    int state;
>       uint32_t index;
>       uint32_t packet_len;
> +    uint32_t vnet_hdr_len;
>       uint8_t buf[NET_BUFSIZE];
>       SocketReadStateFinalize *finalize;
>   };
> diff --git a/net/net.c b/net/net.c
> index f69260f..5a6b5ac 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1639,8 +1639,12 @@ int net_fill_rstate(SocketReadState *rs, const u=
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
> @@ -1658,6 +1662,22 @@ int net_fill_rstate(SocketReadState *rs, const u=
int8_t *buf, int size)
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
