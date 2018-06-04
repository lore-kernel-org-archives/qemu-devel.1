Received: from eggs.gnu.org ([2001:4830:134:3::10]:48046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPk8n-00066j-Bx
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPk8k-0000OO-7f
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:42:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fPk8k-0000O9-1B
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 03:42:54 -0400
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-16-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3714d91c-04a2-fdd7-5399-e50a1ba3fc68@redhat.com>
Date: Mon, 4 Jun 2018 15:42:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180603050546.6827-16-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 15/17] filter-rewriter: handle
 checkpoint and failover event
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



On 2018=E5=B9=B406=E6=9C=8803=E6=97=A5 13:05, Zhang Chen wrote:
> After one round of checkpoint, the states between PVM and SVM
> become consistent, so it is unnecessary to adjust the sequence
> of net packets for old connections, besides, while failover
> happens, filter-rewriter needs to check if it still needs to
> adjust sequence of net packets.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   migration/colo.c      | 13 +++++++++++++
>   net/filter-rewriter.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 442471e088..0bff21d9e5 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -31,6 +31,7 @@
>   #include "qapi/qapi-events-migration.h"
>   #include "qapi/qmp/qerror.h"
>   #include "sysemu/cpus.h"
> +#include "net/filter.h"
>  =20
>   static bool vmstate_loading;
>   static Notifier packets_compare_notifier;
> @@ -82,6 +83,11 @@ static void secondary_vm_do_failover(void)
>       if (local_err) {
>           error_report_err(local_err);
>       }
> +    /* Notify all filters of all NIC to do checkpoint */
> +    colo_notify_filters_event(COLO_EVENT_FAILOVER, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>  =20
>       if (!autostart) {
>           error_report("\"-S\" qemu option will be ignored in secondary=
 side");
> @@ -800,6 +806,13 @@ void *colo_process_incoming_thread(void *opaque)
>               goto out;
>           }
>  =20
> +        /* Notify all filters of all NIC to do checkpoint */
> +        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
> +        if (local_err) {
> +            qemu_mutex_unlock_iothread();
> +            goto out;
> +        }
> +

I think the above should belong to another patch.

>           vmstate_loading =3D false;
>           vm_start();
>           trace_colo_vm_state_change("stop", "run");
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 0909a9a8af..f3c306cc89 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -20,6 +20,8 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/iov.h"
>   #include "net/checksum.h"
> +#include "net/colo.h"
> +#include "migration/colo.h"
>  =20
>   #define FILTER_COLO_REWRITER(obj) \
>       OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
> @@ -277,6 +279,43 @@ static ssize_t colo_rewriter_receive_iov(NetFilter=
State *nf,
>       return 0;
>   }
>  =20
> +static void reset_seq_offset(gpointer key, gpointer value, gpointer us=
er_data)
> +{
> +    Connection *conn =3D (Connection *)value;
> +
> +    conn->offset =3D 0;
> +}
> +
> +static gboolean offset_is_nonzero(gpointer key,
> +                                  gpointer value,
> +                                  gpointer user_data)
> +{
> +    Connection *conn =3D (Connection *)value;
> +
> +    return conn->offset ? true : false;
> +}
> +
> +static void colo_rewriter_handle_event(NetFilterState *nf, int event,
> +                                       Error **errp)
> +{
> +    RewriterState *rs =3D FILTER_COLO_REWRITER(nf);
> +
> +    switch (event) {
> +    case COLO_EVENT_CHECKPOINT:
> +        g_hash_table_foreach(rs->connection_track_table,
> +                            reset_seq_offset, NULL);
> +        break;
> +    case COLO_EVENT_FAILOVER:
> +        if (!g_hash_table_find(rs->connection_track_table,
> +                              offset_is_nonzero, NULL)) {
> +            object_property_set_str(OBJECT(nf), "off", "status", errp)=
;
> +        }

I may miss something but I think rewriter should not be turned off even=20
after failover?

Thanks

> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
>   static void colo_rewriter_cleanup(NetFilterState *nf)
>   {
>       RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> @@ -332,6 +371,7 @@ static void colo_rewriter_class_init(ObjectClass *o=
c, void *data)
>       nfc->setup =3D colo_rewriter_setup;
>       nfc->cleanup =3D colo_rewriter_cleanup;
>       nfc->receive_iov =3D colo_rewriter_receive_iov;
> +    nfc->handle_event =3D colo_rewriter_handle_event;
>   }
>  =20
>   static const TypeInfo colo_rewriter_info =3D {
