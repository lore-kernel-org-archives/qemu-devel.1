Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1frxUh-0005S2-FM
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1frxMx-0003Gd-V2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:30:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1frxMx-0003GT-Pi
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:30:11 -0400
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-17-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2bd91af8-f11f-ff55-8a02-9bee3361d7ff@redhat.com>
Date: Tue, 21 Aug 2018 11:30:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180811205924.4113-17-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 16/20] filter: Add handle_event method
 for NetFilterClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
> Filter needs to process the event of checkpoint/failover or
> other event passed by COLO frame.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   include/net/filter.h |  5 +++++
>   net/filter.c         | 17 +++++++++++++++++
>   net/net.c            | 28 ++++++++++++++++++++++++++++
>   3 files changed, 50 insertions(+)
>
> diff --git a/include/net/filter.h b/include/net/filter.h
> index 435acd6f82..49da666ac0 100644
> --- a/include/net/filter.h
> +++ b/include/net/filter.h
> @@ -38,6 +38,8 @@ typedef ssize_t (FilterReceiveIOV)(NetFilterState *nc=
,
>  =20
>   typedef void (FilterStatusChanged) (NetFilterState *nf, Error **errp)=
;
>  =20
> +typedef void (FilterHandleEvent) (NetFilterState *nf, int event, Error=
 **errp);
> +
>   typedef struct NetFilterClass {
>       ObjectClass parent_class;
>  =20
> @@ -45,6 +47,7 @@ typedef struct NetFilterClass {
>       FilterSetup *setup;
>       FilterCleanup *cleanup;
>       FilterStatusChanged *status_changed;
> +    FilterHandleEvent *handle_event;
>       /* mandatory */
>       FilterReceiveIOV *receive_iov;
>   } NetFilterClass;
> @@ -77,4 +80,6 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *s=
ender,
>                                       int iovcnt,
>                                       void *opaque);
>  =20
> +void colo_notify_filters_event(int event, Error **errp);
> +
>   #endif /* QEMU_NET_FILTER_H */
> diff --git a/net/filter.c b/net/filter.c
> index 2fd7d7d663..0f17eba143 100644
> --- a/net/filter.c
> +++ b/net/filter.c
> @@ -17,6 +17,8 @@
>   #include "net/vhost_net.h"
>   #include "qom/object_interfaces.h"
>   #include "qemu/iov.h"
> +#include "net/colo.h"
> +#include "migration/colo.h"
>  =20
>   static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
>   {
> @@ -245,11 +247,26 @@ static void netfilter_finalize(Object *obj)
>       g_free(nf->netdev_id);
>   }
>  =20
> +static void dummy_handle_event(NetFilterState *nf, int event, Error **=
errp)
> +{

It's in fact not a "dummy" handler, Maybe it's better to rename it as=20
"default".

> +    switch (event) {
> +    case COLO_EVENT_CHECKPOINT:
> +        break;
> +    case COLO_EVENT_FAILOVER:
> +        object_property_set_str(OBJECT(nf), "off", "status", errp);

I think filter is a generic infrastructure, so it's better not have COLO=20
specific things like this. You can either add a generic name or have a=20
dedicated helper to just disable all net filters.

> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
>   static void netfilter_class_init(ObjectClass *oc, void *data)
>   {
>       UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    NetFilterClass *nfc =3D NETFILTER_CLASS(oc);
>  =20
>       ucc->complete =3D netfilter_complete;
> +    nfc->handle_event =3D dummy_handle_event;
>   }
>  =20
>   static const TypeInfo netfilter_info =3D {
> diff --git a/net/net.c b/net/net.c
> index a77ea88fff..b4f6a2efb2 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1331,6 +1331,34 @@ void hmp_info_network(Monitor *mon, const QDict =
*qdict)
>       }
>   }
>  =20
> +void colo_notify_filters_event(int event, Error **errp)
> +{
> +    NetClientState *nc, *peer;
> +    NetClientDriver type;
> +    NetFilterState *nf;
> +    NetFilterClass *nfc =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    QTAILQ_FOREACH(nc, &net_clients, next) {
> +        peer =3D nc->peer;
> +        type =3D nc->info->type;
> +        if (!peer || type !=3D NET_CLIENT_DRIVER_TAP) {
> +            continue;
> +        }

The check the TAP is redundant with previous patch.

> +        QTAILQ_FOREACH(nf, &nc->filters, next) {
> +            nfc =3D  NETFILTER_GET_CLASS(OBJECT(nf));
> +            if (!nfc->handle_event) {

Looks like this won't happen.

Thanks

> +                continue;
> +            }
> +            nfc->handle_event(nf, event, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +        }
> +    }
> +}
> +
>   void qmp_set_link(const char *name, bool up, Error **errp)
>   {
>       NetClientState *ncs[MAX_QUEUE_NUM];
