Received: from eggs.gnu.org ([2001:4830:134:3::10]:33415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA6f6-0007Eb-5c
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA6f3-0007zU-05
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:27:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA6f2-0007zL-NX
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:27:04 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a9e278bc-2131-3ed2-d8ab-e5e32c2b4df5@redhat.com>
Date: Mon, 15 May 2017 11:26:58 +0800
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 02/12] net/filter-mirror.c: Add new
 option to enable vnet support for filter-mirror
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
> We add the vnet_hdr option for filter-mirror, default is disable.
> If you use virtio-net-pci net driver, please enable it.
> You can use it for example:
> -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0,=
vnet_hdr=3Don
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-mirror.c | 34 ++++++++++++++++++++++++++++++++++
>   qemu-options.hx     |  5 +++--
>   2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 72fa7c2..3766414 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -38,6 +38,7 @@ typedef struct MirrorState {
>       NetFilterState parent_obj;
>       char *indev;
>       char *outdev;
> +    bool vnet_hdr;
>       CharBackend chr_in;
>       CharBackend chr_out;
>       SocketReadState rs;
> @@ -308,6 +309,13 @@ static char *filter_mirror_get_outdev(Object *obj,=
 Error **errp)
>       return g_strdup(s->outdev);
>   }
>  =20
> +static char *filter_mirror_get_vnet_hdr(Object *obj, Error **errp)
> +{
> +    MirrorState *s =3D FILTER_MIRROR(obj);
> +
> +    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
> +}
> +
>   static void
>   filter_mirror_set_outdev(Object *obj, const char *value, Error **errp=
)
>   {
> @@ -322,6 +330,21 @@ filter_mirror_set_outdev(Object *obj, const char *=
value, Error **errp)
>       }
>   }
>  =20
> +static void filter_mirror_set_vnet_hdr(Object *obj,
> +                                       const char *value,
> +                                       Error **errp)
> +{
> +    MirrorState *s =3D FILTER_MIRROR(obj);
> +
> +    if (strcmp(value, "on") && strcmp(value, "off")) {
> +        error_setg(errp, "Invalid value for filter-mirror vnet_hdr, "
> +                         "should be 'on' or 'off'");
> +        return;
> +    }
> +
> +    s->vnet_hdr =3D !strcmp(value, "on");
> +}
> +
>   static char *filter_redirector_get_outdev(Object *obj, Error **errp)
>   {
>       MirrorState *s =3D FILTER_REDIRECTOR(obj);
> @@ -340,8 +363,19 @@ filter_redirector_set_outdev(Object *obj, const ch=
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
> +    s->vnet_hdr =3D false;
> +    object_property_add_str(obj, "vnet_hdr", filter_mirror_get_vnet_hd=
r,
> +                             filter_mirror_set_vnet_hdr, NULL);
>   }

We'd better squash this into patch 3 and even after the changes for=20
net_fill_rstate().

>  =20
>   static void filter_redirector_init(Object *obj)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 70c0ded..1e08481 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4024,10 +4024,11 @@ queue @var{all|rx|tx} is an option that can be =
applied to any netfilter.
>   @option{tx}: the filter is attached to the transmit queue of the netd=
ev,
>                where it will receive packets sent by the netdev.
>  =20
> -@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outd=
ev=3D@var{chardevid}[,queue=3D@var{all|rx|tx}]
> +@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outd=
ev=3D@var{chardevid},vnet_hdr=3D@var{on|off}[,queue=3D@var{all|rx|tx}]
>  =20
>   filter-mirror on netdev @var{netdevid},mirror net packet to chardev
> -@var{chardevid}
> +@var{chardevid}, if vnet_hdr =3D on, filter-mirror will mirror packet
> +with vnet_hdr_len.

As pointed by Eric, we'd better keep the long line here.

Thanks

>  =20
>   @item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid}=
,indev=3D@var{chardevid},
>   outdev=3D@var{chardevid}[,queue=3D@var{all|rx|tx}]
