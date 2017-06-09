Received: from eggs.gnu.org ([2001:4830:134:3::10]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJD5q-0001Ef-A5
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJD5m-00057O-5f
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJD5l-00057A-SO
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:08:18 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
Date: Fri, 9 Jun 2017 14:08:08 +0800
MIME-Version: 1.0
In-Reply-To: <1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 02/10] net/filter-mirror.c: Make filter
 mirror support vnet support.
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
> We add the vnet_hdr_support option for filter-mirror, default is disabl=
e.

s/disable/disabled/

> If you use virtio-net-pci net driver, please enable it.
> You can use it for example:
> -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0,=
vnet_hdr_support
>
> If have vnet_hdr_support flag,

If it has

>   we will change the send packet format from

s/send/sending/

> struct {int size; const uint8_t buf[];} to {int size; int vnet_hdr_len;=
 const uint8_t buf[];}.
> make other module(like colo-compare) know how to parse net packet corre=
ctly.

Please double check the commit logs, some have obvious grammar issues.

>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-mirror.c | 69 ++++++++++++++++++++++++++++++++++++++++++++=
+++++----
>   qemu-options.hx     |  5 ++--
>   2 files changed, 66 insertions(+), 8 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 72fa7c2..50aa81b 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -38,15 +38,17 @@ typedef struct MirrorState {
>       NetFilterState parent_obj;
>       char *indev;
>       char *outdev;
> +    bool vnet_hdr;
>       CharBackend chr_in;
>       CharBackend chr_out;
>       SocketReadState rs;
>   } MirrorState;
>  =20
> -static int filter_mirror_send(CharBackend *chr_out,
> +static int filter_mirror_send(MirrorState *s,
>                                 const struct iovec *iov,
>                                 int iovcnt)

This function were renamed to filter_send in your commit=20
e05dc4cf56d70225fc76225a3fd7df9f7b8ca5f9 ("net/filter-mirror.c: Rename=20
filter_mirror_send() and fix codestyle")

>   {
> +    NetFilterState *nf =3D NETFILTER(s);
>       int ret =3D 0;
>       ssize_t size =3D 0;
>       uint32_t len =3D 0;
> @@ -58,14 +60,43 @@ static int filter_mirror_send(CharBackend *chr_out,
>       }
>  =20
>       len =3D htonl(size);
> -    ret =3D qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len=
));
> +    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof=
(len));

This looks a independent change, please do it in another patch.

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
> +        /*
> +         * In anytime, nf->netdev and nf->netdev->peer both have a vne=
t_hdr_len,
> +         * Here we just find out which is we need. When filter set RX =
or TX
> +         * that the real vnet_hdr_len are different.
> +         */

Let's remove the comment and let code explain itself.

> +        if (nf->direction =3D=3D NET_FILTER_DIRECTION_RX ||
> +            nf->direction =3D=3D NET_FILTER_DIRECTION_ALL) {
> +            vnet_hdr_len =3D nf->netdev->vnet_hdr_len;

This can only work if e.g virtio-net set its own vnet_hdr_len. But looks=20
like it use guest_hdr_len instead.

And using NET_FILTER_DIRECTION_ALL looks suspicious. Maybe we should=20
accept sender from its caller and compare it with nf->netdev to get the=20
correct direction.

> +        } else if (nf->direction =3D=3D NET_FILTER_DIRECTION_TX) {
> +            vnet_hdr_len =3D nf->netdev->peer->vnet_hdr_len;

This looks wrong, TX means the packet were sent from netdev, we should=20
care nf->netdev's hdrlen.

> +        } else {
> +            return 0;
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
> @@ -141,7 +172,7 @@ static ssize_t filter_mirror_receive_iov(NetFilterS=
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
> @@ -164,7 +195,7 @@ static ssize_t filter_redirector_receive_iov(NetFil=
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
> @@ -308,6 +339,13 @@ static char *filter_mirror_get_outdev(Object *obj,=
 Error **errp)
>       return g_strdup(s->outdev);
>   }
>  =20
> +static bool filter_mirror_get_vnet_hdr(Object *obj, Error **errp)
> +{
> +    MirrorState *s =3D FILTER_MIRROR(obj);
> +
> +    return s->vnet_hdr;
> +}
> +
>   static void
>   filter_mirror_set_outdev(Object *obj, const char *value, Error **errp=
)
>   {
> @@ -322,6 +360,15 @@ filter_mirror_set_outdev(Object *obj, const char *=
value, Error **errp)
>       }
>   }
>  =20
> +static void filter_mirror_set_vnet_hdr(Object *obj,
> +                                       bool value,
> +                                       Error **errp)
> +{
> +    MirrorState *s =3D FILTER_MIRROR(obj);
> +
> +    s->vnet_hdr =3D value;
> +}
> +
>   static char *filter_redirector_get_outdev(Object *obj, Error **errp)
>   {
>       MirrorState *s =3D FILTER_REDIRECTOR(obj);
> @@ -340,8 +387,20 @@ filter_redirector_set_outdev(Object *obj, const ch=
ar *value, Error **errp)
>  =20
>   static void filter_mirror_init(Object *obj)
>   {
> +    MirrorState *s =3D FILTER_MIRROR(obj);
> +
>       object_property_add_str(obj, "outdev", filter_mirror_get_outdev,
>                               filter_mirror_set_outdev, NULL);
> +
> +    /*
> +     * The vnet_hdr is disabled by default, if you want to enable
> +     * this option, you must enable all the option on related modules
> +     * (like other filter or colo-compare).
> +     */

This comment makes sense for docs but is useless here, let code explain=20
itself.

Thanks

> +    s->vnet_hdr =3D false;
> +    object_property_add_bool(obj, "vnet_hdr_support",
> +                             filter_mirror_get_vnet_hdr,
> +                             filter_mirror_set_vnet_hdr, NULL);
>   }
>  =20
>   static void filter_redirector_init(Object *obj)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 70c0ded..5c09fae 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4024,10 +4024,9 @@ queue @var{all|rx|tx} is an option that can be a=
pplied to any netfilter.
>   @option{tx}: the filter is attached to the transmit queue of the netd=
ev,
>                where it will receive packets sent by the netdev.
>  =20
> -@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outd=
ev=3D@var{chardevid}[,queue=3D@var{all|rx|tx}]
> +@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outd=
ev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
>  =20
> -filter-mirror on netdev @var{netdevid},mirror net packet to chardev
> -@var{chardevid}
> +filter-mirror on netdev @var{netdevid},mirror net packet to chardev@va=
r{chardevid}, if have the vnet_hdr_support flag, filter-mirror will mirro=
r packet with vnet_hdr_len.
>  =20
>   @item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid}=
,indev=3D@var{chardevid},
>   outdev=3D@var{chardevid}[,queue=3D@var{all|rx|tx}]
