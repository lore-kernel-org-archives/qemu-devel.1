Received: from eggs.gnu.org ([2001:4830:134:3::10]:52421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDmAI-0005Bp-Ii
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDmAE-0000nC-KC
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dDmAE-0000mR-Au
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:22:26 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9f0e7f5e-7da7-4d78-95d9-be544b1bd28e@redhat.com>
Date: Thu, 25 May 2017 14:22:20 +0800
MIME-Version: 1.0
In-Reply-To: <1495549241-23380-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5 6/9] net/colo-compare.c: Make
 colo-compare support vnet_hdr_len
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



On 2017=E5=B9=B405=E6=9C=8823=E6=97=A5 22:20, Zhang Chen wrote:
> We add the vnet_hdr option for colo-compare, default is disable.
> If you use virtio-net-pci net driver, please enable it.
> You can use it for example:
> -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3D=
compare1,outdev=3Dcompare_out0,vnet_hdr=3Don

This is not accurate since virtio-net-pci is not the only card that uses=20
vnet_hdr. E1000E is another one.

>
> COLO-compare can get vnet header length from filter,
> Add vnet_hdr_len to struct packet and output packet with
> the vnet_hdr_len.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 76 +++++++++++++++++++++++++++++++++++++++++++++=
++-------
>   qemu-options.hx    |  4 +--
>   2 files changed, 69 insertions(+), 11 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index bf0b856..f89b380 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -73,6 +73,7 @@ typedef struct CompareState {
>       CharBackend chr_out;
>       SocketReadState pri_rs;
>       SocketReadState sec_rs;
> +    bool vnet_hdr;
>  =20
>       /* connection list: the connections belonged to this NIC could be=
 found
>        * in this list.
> @@ -97,9 +98,10 @@ enum {
>       SECONDARY_IN,
>   };
>  =20
> -static int compare_chr_send(CharBackend *out,
> +static int compare_chr_send(CompareState *s,
>                               const uint8_t *buf,
> -                            uint32_t size);
> +                            uint32_t size,
> +                            uint32_t vnet_hdr_len);
>  =20
>   static gint seq_sorter(Packet *a, Packet *b, gpointer data)
>   {
> @@ -472,7 +474,10 @@ static void colo_compare_connection(void *opaque, =
void *user_data)
>           }
>  =20
>           if (result) {
> -            ret =3D compare_chr_send(&s->chr_out, pkt->data, pkt->size=
);
> +            ret =3D compare_chr_send(s,
> +                                   pkt->data,
> +                                   pkt->size,
> +                                   pkt->vnet_hdr_len);

Why not check vnet_hdr support here?  And don't we need strip vnet_hdr=20
here? (Since the redirector on destination does not do this)

>               if (ret < 0) {
>                   error_report("colo_send_primary_packet failed");
>               }
> @@ -493,9 +498,10 @@ static void colo_compare_connection(void *opaque, =
void *user_data)
>       }
>   }
>  =20
> -static int compare_chr_send(CharBackend *out,
> +static int compare_chr_send(CompareState *s,
>                               const uint8_t *buf,
> -                            uint32_t size)
> +                            uint32_t size,
> +                            uint32_t vnet_hdr_len)
>   {
>       int ret =3D 0;
>       uint32_t len =3D htonl(size);
> @@ -504,12 +510,24 @@ static int compare_chr_send(CharBackend *out,
>           return 0;
>       }
>  =20
> -    ret =3D qemu_chr_fe_write_all(out, (uint8_t *)&len, sizeof(len));
> +    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));
>       if (ret !=3D sizeof(len)) {
>           goto err;
>       }
>  =20
> -    ret =3D qemu_chr_fe_write_all(out, (uint8_t *)buf, size);
> +    if (s->vnet_hdr) {
> +        /*
> +         * We send vnet header len make other module(like filter-redir=
ector)
> +         * know how to parse net packet correctly.
> +         */

But redirector does not strip the vnet header, does this really work?

Thanks
