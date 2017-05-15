Received: from eggs.gnu.org ([2001:4830:134:3::10]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7Et-00070y-FH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7Eq-0003cF-BS
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA7Eq-0003bk-3W
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:04:04 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c08c1b97-3035-b87f-fd5a-e5ab9646714c@redhat.com>
Date: Mon, 15 May 2017 12:03:56 +0800
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 06/12] net/colo-compare.c: Add new
 option to enable vnet support for colo-compare
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
> We add the vnet_hdr option for colo-compare, default is disable.
> If you use virtio-net-pci net driver, please enable it.
> You can use it for example:
> -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3D=
compare1,outdev=3Dcompare_out0,vnet_hdr=3Don
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/colo-compare.c | 34 +++++++++++++++++++++++++++++++++-
>   qemu-options.hx    |  3 ++-
>   2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 332f57e..99a6912 100644
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
> @@ -642,6 +643,28 @@ static void compare_set_outdev(Object *obj, const =
char *value, Error **errp)
>       s->outdev =3D g_strdup(value);
>   }
>  =20
> +static char *compare_get_vnet_hdr(Object *obj, Error **errp)
> +{
> +    CompareState *s =3D COLO_COMPARE(obj);
> +
> +    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
> +}
> +
> +static void compare_set_vnet_hdr(Object *obj,
> +                                 const char *value,
> +                                 Error **errp)
> +{
> +    CompareState *s =3D COLO_COMPARE(obj);
> +
> +    if (strcmp(value, "on") && strcmp(value, "off")) {
> +        error_setg(errp, "Invalid value for colo-compare vnet_hdr, "
> +                         "should be 'on' or 'off'");
> +        return;
> +    }
> +
> +    s->vnet_hdr =3D !strcmp(value, "on");
> +}
> +
>   static void compare_pri_rs_finalize(SocketReadState *pri_rs)
>   {
>       CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
> @@ -667,7 +690,6 @@ static void compare_sec_rs_finalize(SocketReadState=
 *sec_rs)
>       }
>   }
>  =20
> -

Unnecessary whitespace change.

>   /*
>    * Return 0 is success.
>    * Return 1 is failed.
> @@ -775,6 +797,8 @@ static void colo_compare_class_init(ObjectClass *oc=
, void *data)
>  =20
>   static void colo_compare_init(Object *obj)
>   {
> +    CompareState *s =3D COLO_COMPARE(obj);
> +
>       object_property_add_str(obj, "primary_in",
>                               compare_get_pri_indev, compare_set_pri_in=
dev,
>                               NULL);
> @@ -784,6 +808,14 @@ static void colo_compare_init(Object *obj)
>       object_property_add_str(obj, "outdev",
>                               compare_get_outdev, compare_set_outdev,
>                               NULL);
> +    /*
> +     * The vnet_hdr is disabled by default, if you want to enable
> +     * this option, you must enable all the option on related modules
> +     * (like other filter or colo-compare).
> +     */
> +    s->vnet_hdr =3D false;
> +    object_property_add_str(obj, "vnet_hdr", compare_get_vnet_hdr,
> +                            compare_set_vnet_hdr, NULL);
>   }
>  =20
>   static void colo_compare_finalize(Object *obj)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0f81c22..115b83f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4061,12 +4061,13 @@ The file format is libpcap, so it can be analyz=
ed with tools such as tcpdump
>   or Wireshark.
>  =20
>   @item -object colo-compare,id=3D@var{id},primary_in=3D@var{chardevid}=
,secondary_in=3D@var{chardevid},
> -outdev=3D@var{chardevid}
> +outdev=3D@var{chardevid},vnet_hdr=3D@var{on|off}
>  =20
>   Colo-compare gets packet from primary_in@var{chardevid} and secondary=
_in@var{chardevid}, than compare primary packet with
>   secondary packet. If the packets are same, we will output primary
>   packet to outdev@var{chardevid}, else we will notify colo-frame
>   do checkpoint and send primary packet to outdev@var{chardevid}.
> +if vnet_hdr =3D on, colo compare will send/recv packet with vnet_hdr_l=
en.
>  =20
>   we must use it with the help of filter-mirror and filter-redirector.
>  =20

Please squash this into its function implementation.

Thanks
