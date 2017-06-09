Received: from eggs.gnu.org ([2001:4830:134:3::10]:58282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDIF-0005Yl-FG
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dJDIC-0002AX-5B
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dJDIB-0002AB-SW
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:21:08 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-10-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c734e384-a0fe-0b08-2221-3d7a5842cb50@redhat.com>
Date: Fri, 9 Jun 2017 14:20:58 +0800
MIME-Version: 1.0
In-Reply-To: <1496829322-17099-10-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 09/10] net/filter-rewriter.c: Make
 filter-rewriter support vnet_hdr_len
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
> We add the vnet_hdr_support option for filter-rewriter, default is disa=
ble.
> If you use virtio-net-pci net driver, please enable it.
> You can use it for example:
> -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall,vnet_hdr_sup=
port
>
> We get the vnet_hdr_len from NetClientState that make us
> parse net packet correctly.
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> ---
>   net/filter-rewriter.c | 51 ++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>   qemu-options.hx       |  4 ++--
>   2 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 63256c7..8eaf0e8 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -17,6 +17,7 @@
>   #include "qemu-common.h"
>   #include "qapi/error.h"
>   #include "qapi/qmp/qerror.h"
> +#include "qemu/error-report.h"
>   #include "qapi-visit.h"
>   #include "qom/object.h"
>   #include "qemu/main-loop.h"
> @@ -33,6 +34,7 @@ typedef struct RewriterState {
>       NetQueue *incoming_queue;
>       /* hashtable to save connection */
>       GHashTable *connection_track_table;
> +    bool vnet_hdr;
>   } RewriterState;
>  =20
>   static void filter_rewriter_flush(NetFilterState *nf)
> @@ -155,10 +157,25 @@ static ssize_t colo_rewriter_receive_iov(NetFilte=
rState *nf,
>       ConnectionKey key;
>       Packet *pkt;
>       ssize_t size =3D iov_size(iov, iovcnt);
> +    ssize_t vnet_hdr_len =3D 0;
>       char *buf =3D g_malloc0(size);
>  =20
>       iov_to_buf(iov, iovcnt, 0, buf, size);
> -    pkt =3D packet_new(buf, size, 0);
> +
> +    if (s->vnet_hdr) {
> +        if (nf->direction =3D=3D NET_FILTER_DIRECTION_RX ||
> +            nf->direction =3D=3D NET_FILTER_DIRECTION_ALL) {
> +            vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
> +        } else if (nf->direction =3D=3D NET_FILTER_DIRECTION_TX) {
> +            vnet_hdr_len =3D nf->netdev->peer->vnet_hdr_len;
> +        } else {
> +            error_report("filter-rewriter get vnet_hdr_len failed");
> +            /* When error occurred we drop the packet  */
> +            return 1;
> +        }
> +    }

Similar issue as patch 02, and we can probably use a helper to avoid=20
duplicating codes.

Thanks

> +
> +    pkt =3D packet_new(buf, size, vnet_hdr_len);
>       g_free(buf);
>  =20
>       /*
> @@ -237,6 +254,37 @@ static void colo_rewriter_setup(NetFilterState *nf=
, Error **errp)
>       s->incoming_queue =3D qemu_new_net_queue(qemu_netfilter_pass_to_n=
ext, nf);
>   }
>  =20
> +static bool filter_rewriter_get_vnet_hdr(Object *obj, Error **errp)
> +{
> +    RewriterState *s =3D FILTER_COLO_REWRITER(obj);
> +
> +    return s->vnet_hdr;
> +}
> +
> +static void filter_rewriter_set_vnet_hdr(Object *obj,
> +                                         bool value,
> +                                         Error **errp)
> +{
> +    RewriterState *s =3D FILTER_COLO_REWRITER(obj);
> +
> +    s->vnet_hdr =3D value;
> +}
> +
> +static void filter_rewriter_init(Object *obj)
> +{
> +    RewriterState *s =3D FILTER_COLO_REWRITER(obj);
> +
> +    /*
> +     * The vnet_hdr is disabled by default, if you want to enable
> +     * this option, you must enable all the option on related modules
> +     * (like other filter or colo-compare).
> +     */
> +    s->vnet_hdr =3D false;
> +    object_property_add_bool(obj, "vnet_hdr_support",
> +                             filter_rewriter_get_vnet_hdr,
> +                             filter_rewriter_set_vnet_hdr, NULL);
> +}
> +
>   static void colo_rewriter_class_init(ObjectClass *oc, void *data)
>   {
>       NetFilterClass *nfc =3D NETFILTER_CLASS(oc);
> @@ -250,6 +298,7 @@ static const TypeInfo colo_rewriter_info =3D {
>       .name =3D TYPE_FILTER_REWRITER,
>       .parent =3D TYPE_NETFILTER,
>       .class_init =3D colo_rewriter_class_init,
> +    .instance_init =3D filter_rewriter_init,
>       .instance_size =3D sizeof(RewriterState),
>   };
>  =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fbfd604..8655842 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4037,12 +4037,12 @@ Create a filter-redirector we need to differ ou=
tdev id from indev id, id can not
>   be the same. we can just use indev or outdev, but at least one of ind=
ev or outdev
>   need to be specified.
>  =20
> -@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},re=
writer-mode=3D@var{mode}[,queue=3D@var{all|rx|tx}]
> +@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},re=
writer-mode=3D@var{mode},queue=3D@var{all|rx|tx},[vnet_hdr_support]
>  =20
>   Filter-rewriter is a part of COLO project.It will rewrite tcp packet =
to
>   secondary from primary to keep secondary tcp connection,and rewrite
>   tcp packet to primary from secondary make tcp packet can be handled b=
y
> -client.
> +client.if have the vnet_hdr_support flag, we can parse packet with vne=
t header.
>  =20
>   usage:
>   colo secondary:
