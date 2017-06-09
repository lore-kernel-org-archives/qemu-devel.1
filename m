Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJD7W-0001n2-J9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJD7S-0006Gf-Ey
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:10:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJD7S-0006GA-70
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:10:02 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <695b25fa-e86b-0e3d-1004-a55c6bef98f6@redhat.com>
Date: Fri, 9 Jun 2017 14:09:56 +0800
MIME-Version: 1.0
In-Reply-To: <1496829322-17099-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 03/10] net/filter-mirror.c: Add new
 option to enable vnet support for filter-redirector
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
> We add the vnet_hdr_support option for filter-redirector, default is di=
sable.

s/disable/disabled/

> If you use virtio-net-pci net driver, please enable it.
> Because colo-compare or other modules needs the vnet_hdr_len to parse
> packet, so we add this new option send the len to others.

s/so//

> You can use it for example:
> -object filter-redirector,id=3Dr0,netdev=3Dhn0,queue=3Dtx,outdev=3Dred0=
,vnet_hdr_support
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-mirror.c | 28 ++++++++++++++++++++++++++++
>   qemu-options.hx     |  6 +++---
>   2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 50aa81b..3413e82 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -376,6 +376,13 @@ static char *filter_redirector_get_outdev(Object *=
obj, Error **errp)
>       return g_strdup(s->outdev);
>   }
>  =20
> +static bool filter_redirector_get_vnet_hdr(Object *obj, Error **errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
> +    return s->vnet_hdr;
> +}
> +
>   static void
>   filter_redirector_set_outdev(Object *obj, const char *value, Error **=
errp)
>   {
> @@ -385,6 +392,15 @@ filter_redirector_set_outdev(Object *obj, const ch=
ar *value, Error **errp)
>       s->outdev =3D g_strdup(value);
>   }
>  =20
> +static void filter_redirector_set_vnet_hdr(Object *obj,
> +                                           bool value,
> +                                           Error **errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
> +    s->vnet_hdr =3D value;
> +}
> +
>   static void filter_mirror_init(Object *obj)
>   {
>       MirrorState *s =3D FILTER_MIRROR(obj);
> @@ -405,10 +421,22 @@ static void filter_mirror_init(Object *obj)
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

Let's remove the comment here.

> +    s->vnet_hdr =3D false;
> +    object_property_add_bool(obj, "vnet_hdr_support",
> +                             filter_redirector_get_vnet_hdr,
> +                             filter_redirector_set_vnet_hdr, NULL);
>   }
>  =20
>   static void filter_mirror_fini(Object *obj)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5c09fae..e78b942 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4028,11 +4028,11 @@ queue @var{all|rx|tx} is an option that can be =
applied to any netfilter.
>  =20
>   filter-mirror on netdev @var{netdevid},mirror net packet to chardev@v=
ar{chardevid}, if have the vnet_hdr_support flag, filter-mirror will mirr=
or packet with vnet_hdr_len.
>  =20
> -@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},=
indev=3D@var{chardevid},
> -outdev=3D@var{chardevid}[,queue=3D@var{all|rx|tx}]
> +@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},=
indev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[=
,vnet_hdr_support]
>  =20
>   filter-redirector on netdev @var{netdevid},redirect filter's net pack=
et to chardev
> -@var{chardevid},and redirect indev's packet to filter.
> +@var{chardevid},and redirect indev's packet to filter.if have the vnet=
_hdr_support flag,
> +filter-redirector will redirect packet with vnet_hdr_len.
>   Create a filter-redirector we need to differ outdev id from indev id,=
 id can not
>   be the same. we can just use indev or outdev, but at least one of ind=
ev or outdev
>   need to be specified.
