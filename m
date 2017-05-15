Received: from eggs.gnu.org ([2001:4830:134:3::10]:33675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA6gf-00085k-Nt
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA6gc-0000aC-IK
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA6gc-0000ZO-8v
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:28:42 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <86fb06ff-fe11-17db-7abd-5327d7bd69a9@redhat.com>
Date: Mon, 15 May 2017 11:28:34 +0800
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 03/12] net/filter-mirror.c: Make
 filter_mirror_send support vnet support.
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
> In this patch, if vnet_hdr=3Don we change the send packet format from
> struct {int size; const uint8_t buf[];} to {int size; int vnet_hdr_len;=
 const uint8_t buf[];}.
> make other module(like colo-compare) know how to parse net packet corre=
ctly.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-mirror.c | 35 ++++++++++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 3766414..64323fc 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -44,10 +44,11 @@ typedef struct MirrorState {
>       SocketReadState rs;
>   } MirrorState;
>  =20
> -static int filter_mirror_send(CharBackend *chr_out,
> +static int filter_mirror_send(MirrorState *s,
>                                 const struct iovec *iov,
>                                 int iovcnt)
>   {
> +    NetFilterState *nf =3D NETFILTER(s);
>       int ret =3D 0;
>       ssize_t size =3D 0;
>       uint32_t len =3D 0;
> @@ -59,14 +60,38 @@ static int filter_mirror_send(CharBackend *chr_out,
>       }
>  =20
>       len =3D htonl(size);
> -    ret =3D qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len=
));
> +    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));
>       if (ret !=3D sizeof(len)) {
>           goto err;
>       }
>  =20
> +    if (s->vnet_hdr) {
> +        /*
> +         * If vnet_hdr =3D on, we send vnet header len to make other
> +         * module(like colo-compare) know how to parse net
> +         * packet correctly.
> +         */
> +        ssize_t vnet_hdr_len;
> +
> +        if (nf->netdev->using_vnet_hdr) {
> +            vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
> +        } else if (nf->netdev->peer->using_vnet_hdr) {
> +            vnet_hdr_len =3D nf->netdev->peer->vnet_hdr_len;

Still questionable here, may need a comment to explain.

> +        } else {
> +            error_report("filter get vnet_hdr_len failed");

Why need error here, could we just use zero?

Thanks

> +            goto err;
> +        }
> +
> +        len =3D htonl(vnet_hdr_len);
> +        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, si=
zeof(len));
> +        if (ret !=3D sizeof(len)) {
> +            goto err;
> +        }
> +    }
> +
>       buf =3D g_malloc(size);
>       iov_to_buf(iov, iovcnt, 0, buf, size);
> -    ret =3D qemu_chr_fe_write_all(chr_out, (uint8_t *)buf, size);
> +    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
>       g_free(buf);
>       if (ret !=3D size) {
>           goto err;
> @@ -142,7 +167,7 @@ static ssize_t filter_mirror_receive_iov(NetFilterS=
tate *nf,
>       MirrorState *s =3D FILTER_MIRROR(nf);
>       int ret;
>  =20
> -    ret =3D filter_mirror_send(&s->chr_out, iov, iovcnt);
> +    ret =3D filter_mirror_send(s, iov, iovcnt);
>       if (ret) {
>           error_report("filter_mirror_send failed(%s)", strerror(-ret))=
;
>       }
> @@ -165,7 +190,7 @@ static ssize_t filter_redirector_receive_iov(NetFil=
terState *nf,
>       int ret;
>  =20
>       if (qemu_chr_fe_get_driver(&s->chr_out)) {
> -        ret =3D filter_mirror_send(&s->chr_out, iov, iovcnt);
> +        ret =3D filter_mirror_send(s, iov, iovcnt);
>           if (ret) {
>               error_report("filter_mirror_send failed(%s)", strerror(-r=
et));
>           }
