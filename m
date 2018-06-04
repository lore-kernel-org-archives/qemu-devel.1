Received: from eggs.gnu.org ([2001:4830:134:3::10]:36717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPj6C-0008TD-1c
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPj68-0008H0-Ub
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:36:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fPj68-0008Gu-Pg
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:36:08 -0400
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-4-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6ad93c95-8c14-6155-6f0f-6c2dcc46faa8@redhat.com>
Date: Mon, 4 Jun 2018 14:36:01 +0800
MIME-Version: 1.0
In-Reply-To: <20180603050546.6827-4-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 03/17] colo-compare: use notifier to
 notify packets comparing result
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
> It's a good idea to use notifier to notify COLO frame of
> inconsistent packets comparing.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 32 +++++++++++++++++++++++++-------
>   net/colo-compare.h |  2 ++
>   2 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 7ff3ae8904..05061cd1c4 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -29,6 +29,7 @@
>   #include "sysemu/iothread.h"
>   #include "net/colo-compare.h"
>   #include "migration/colo.h"
> +#include "migration/migration.h"
>  =20
>   #define TYPE_COLO_COMPARE "colo-compare"
>   #define COLO_COMPARE(obj) \
> @@ -37,6 +38,9 @@
>   static QTAILQ_HEAD(, CompareState) net_compares =3D
>          QTAILQ_HEAD_INITIALIZER(net_compares);
>  =20
> +static NotifierList colo_compare_notifiers =3D
> +    NOTIFIER_LIST_INITIALIZER(colo_compare_notifiers);
> +
>   #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>   #define MAX_QUEUE_SIZE 1024
>  =20
> @@ -561,8 +565,24 @@ static int colo_old_packet_check_one(Packet *pkt, =
int64_t *check_time)
>       }
>   }
>  =20
> +static void colo_compare_inconsistent_notify(void)
> +{

Not good at English but inconsistency sounds better here.

Thanks

> +    notifier_list_notify(&colo_compare_notifiers,
> +                migrate_get_current());
> +}
> +
> +void colo_compare_register_notifier(Notifier *notify)
> +{
> +    notifier_list_add(&colo_compare_notifiers, notify);
> +}
> +
> +void colo_compare_unregister_notifier(Notifier *notify)
> +{
> +    notifier_remove(notify);
> +}
> +
>   static int colo_old_packet_check_one_conn(Connection *conn,
> -                                          void *user_data)
> +                                           void *user_data)
>   {
>       GList *result =3D NULL;
>       int64_t check_time =3D REGULAR_PACKET_CHECK_MS;
> @@ -573,10 +593,7 @@ static int colo_old_packet_check_one_conn(Connecti=
on *conn,
>  =20
>       if (result) {
>           /* Do checkpoint will flush old packet */
> -        /*
> -         * TODO: Notify colo frame to do checkpoint.
> -         * colo_compare_inconsistent_notify();
> -         */
> +        colo_compare_inconsistent_notify();
>           return 0;
>       }
>  =20
> @@ -620,11 +637,12 @@ static void colo_compare_packet(CompareState *s, =
Connection *conn,
>               /*
>                * If one packet arrive late, the secondary_list or
>                * primary_list will be empty, so we can't compare it
> -             * until next comparison.
> +             * until next comparison. If the packets in the list are
> +             * timeout, it will trigger a checkpoint request.
>                */
>               trace_colo_compare_main("packet different");
>               g_queue_push_head(&conn->primary_list, pkt);
> -            /* TODO: colo_notify_checkpoint();*/
> +            colo_compare_inconsistent_notify();
>               break;
>           }
>       }
> diff --git a/net/colo-compare.h b/net/colo-compare.h
> index 1b1ce76aea..22ddd512e2 100644
> --- a/net/colo-compare.h
> +++ b/net/colo-compare.h
> @@ -18,5 +18,7 @@
>   #define QEMU_COLO_COMPARE_H
>  =20
>   void colo_notify_compares_event(void *opaque, int event, Error **errp=
);
> +void colo_compare_register_notifier(Notifier *notify);
> +void colo_compare_unregister_notifier(Notifier *notify);
>  =20
>   #endif /* QEMU_COLO_COMPARE_H */
