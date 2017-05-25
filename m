Received: from eggs.gnu.org ([2001:4830:134:3::10]:50328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDlyn-0000ec-Uo
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDlyj-0004gX-Bn
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dDlyj-0004gN-1x
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:10:33 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <118320f3-67cf-bb46-8ae7-6de552cc15bf@redhat.com>
Date: Thu, 25 May 2017 14:10:25 +0800
MIME-Version: 1.0
In-Reply-To: <1495549241-23380-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5 3/9] net/filter-mirror.c: Add new option
 to enable vnet support for filter-redirector
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
> We add the vnet_hdr option for filter-redirector, default is disable.
> If you use virtio-net-pci net driver, please enable it.
> Because colo-compare or other modules needs the vnet_hdr_len to parse
> packet, so we add this new option send the len to others.
> You can use it for example:
> -object filter-redirector,id=3Dr0,netdev=3Dhn0,queue=3Dtx,outdev=3Dred0=
,vnet_hdr=3Don
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-mirror.c | 33 +++++++++++++++++++++++++++++++++
>   qemu-options.hx     |  6 +++---
>   2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 8df0be6..6c8579f 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -381,6 +381,13 @@ static char *filter_redirector_get_outdev(Object *=
obj, Error **errp)
>       return g_strdup(s->outdev);
>   }
>  =20
> +static char *filter_redirector_get_vnet_hdr(Object *obj, Error **errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
> +    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
> +}
> +
>   static void
>   filter_redirector_set_outdev(Object *obj, const char *value, Error **=
errp)
>   {
> @@ -390,6 +397,21 @@ filter_redirector_set_outdev(Object *obj, const ch=
ar *value, Error **errp)
>       s->outdev =3D g_strdup(value);
>   }
>  =20
> +static void filter_redirector_set_vnet_hdr(Object *obj,
> +                                           const char *value,
> +                                           Error **errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
> +    if (strcmp(value, "on") && strcmp(value, "off")) {
> +        error_setg(errp, "Invalid value for filter-redirector vnet_hdr=
, "
> +                         "should be 'on' or 'off'");
> +        return;
> +    }
> +
> +    s->vnet_hdr =3D !strcmp(value, "on");
> +}
> +
>   static void filter_mirror_init(Object *obj)
>   {
>       MirrorState *s =3D FILTER_MIRROR(obj);
> @@ -409,10 +431,21 @@ static void filter_mirror_init(Object *obj)
>  =20
>   static void filter_redirector_init(Object *obj)
>   {
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
>       object_property_add_str(obj, "indev", filter_redirector_get_indev=
,
>                               filter_redirector_set_indev, NULL);
>       object_property_add_str(obj, "outdev", filter_redirector_get_outd=
ev,
>                               filter_redirector_set_outdev, NULL);
> +
> +    /*
> +     * The vnet_hdr is disabled by default, if you want to enable
> +     * this option, you must enable all the option on related modules
> +     * (like other filter or colo-compare).
> +     */
> +    s->vnet_hdr =3D false;
> +    object_property_add_str(obj, "vnet_hdr", filter_redirector_get_vne=
t_hdr,
> +                            filter_redirector_set_vnet_hdr, NULL);

Why not using object_property_add_bool()?

Thanks

>   }
>  =20
>   static void filter_mirror_fini(Object *obj)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 81fb96b..a3c4688 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4028,11 +4028,11 @@ queue @var{all|rx|tx} is an option that can be =
applied to any netfilter.
>  =20
>   filter-mirror on netdev @var{netdevid},mirror net packet to chardev@v=
ar{chardevid}, if vnet_hdr =3D on, filter-mirror will mirror packet with =
vnet_hdr_len.
>  =20
> -@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},=
indev=3D@var{chardevid},
> -outdev=3D@var{chardevid}[,queue=3D@var{all|rx|tx}]
> +@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},=
indev=3D@var{chardevid},outdev=3D@var{chardevid},vnet_hdr=3D@var{on|off}[=
,queue=3D@var{all|rx|tx}]
>  =20
>   filter-redirector on netdev @var{netdevid},redirect filter's net pack=
et to chardev
> -@var{chardevid},and redirect indev's packet to filter.
> +@var{chardevid},and redirect indev's packet to filter.if vnet_hdr =3D =
on,
> +filter-redirector will redirect packet with vnet_hdr_len.
>   Create a filter-redirector we need to differ outdev id from indev id,=
 id can not
>   be the same. we can just use indev or outdev, but at least one of ind=
ev or outdev
>   need to be specified.
