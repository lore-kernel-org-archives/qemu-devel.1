Received: from eggs.gnu.org ([2001:4830:134:3::10]:36326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPj2I-0007CE-J1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fPj2D-0006zt-QC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:32:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fPj2D-0006zj-K8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:32:05 -0400
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-3-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ef50f2c-2b48-2951-1bf4-cdc596f1dc88@redhat.com>
Date: Mon, 4 Jun 2018 14:31:57 +0800
MIME-Version: 1.0
In-Reply-To: <20180603050546.6827-3-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 02/17] colo-compare: implement the
 process of checkpoint
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
> While do checkpoint, we need to flush all the unhandled packets,
> By using the filter notifier mechanism, we can easily to notify
> every compare object to do this process, which runs inside
> of compare threads as a coroutine.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   include/migration/colo.h |  6 ++++
>   net/colo-compare.c       | 76 +++++++++++++++++++++++++++++++++++++++=
+
>   net/colo-compare.h       | 22 ++++++++++++
>   3 files changed, 104 insertions(+)
>   create mode 100644 net/colo-compare.h
>
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index 2fe48ad353..fefb2fcf4c 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -16,6 +16,12 @@
>   #include "qemu-common.h"
>   #include "qapi/qapi-types-migration.h"
>  =20
> +enum colo_event {
> +    COLO_EVENT_NONE,
> +    COLO_EVENT_CHECKPOINT,
> +    COLO_EVENT_FAILOVER,
> +};
> +
>   void colo_info_init(void);
>  =20
>   void migrate_start_colo_process(MigrationState *s);
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 23b2d2c4cc..7ff3ae8904 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -27,11 +27,16 @@
>   #include "qemu/sockets.h"
>   #include "net/colo.h"
>   #include "sysemu/iothread.h"
> +#include "net/colo-compare.h"
> +#include "migration/colo.h"
>  =20
>   #define TYPE_COLO_COMPARE "colo-compare"
>   #define COLO_COMPARE(obj) \
>       OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE)
>  =20
> +static QTAILQ_HEAD(, CompareState) net_compares =3D
> +       QTAILQ_HEAD_INITIALIZER(net_compares);
> +
>   #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>   #define MAX_QUEUE_SIZE 1024
>  =20
> @@ -41,6 +46,10 @@
>   /* TODO: Should be configurable */
>   #define REGULAR_PACKET_CHECK_MS 3000
>  =20
> +static QemuMutex event_mtx;
> +static QemuCond event_complete_cond;
> +static int event_unhandled_count;
> +
>   /*
>    *  + CompareState ++
>    *  |               |
> @@ -87,6 +96,11 @@ typedef struct CompareState {
>       IOThread *iothread;
>       GMainContext *worker_context;
>       QEMUTimer *packet_check_timer;
> +
> +    QEMUBH *event_bh;
> +    enum colo_event event;
> +
> +    QTAILQ_ENTRY(CompareState) next;
>   } CompareState;
>  =20
>   typedef struct CompareClass {
> @@ -736,6 +750,25 @@ static void check_old_packet_regular(void *opaque)
>                   REGULAR_PACKET_CHECK_MS);
>   }
>  =20
> +/* Public API, Used for COLO frame to notify compare event */
> +void colo_notify_compares_event(void *opaque, int event, Error **errp)
> +{
> +    CompareState *s;
> +
> +    qemu_mutex_lock(&event_mtx);
> +    QTAILQ_FOREACH(s, &net_compares, next) {
> +        s->event =3D event;
> +        qemu_bh_schedule(s->event_bh);
> +        event_unhandled_count++;
> +    }
> +    /* Wait all compare threads to finish handling this event */
> +    while (event_unhandled_count > 0) {
> +        qemu_cond_wait(&event_complete_cond, &event_mtx);
> +    }
> +
> +    qemu_mutex_unlock(&event_mtx);
> +}
> +
>   static void colo_compare_timer_init(CompareState *s)
>   {
>       AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> @@ -756,6 +789,28 @@ static void colo_compare_timer_del(CompareState *s=
)
>       }
>    }
>  =20
> +static void colo_flush_packets(void *opaque, void *user_data);
> +
> +static void colo_compare_handle_event(void *opaque)
> +{
> +    CompareState *s =3D opaque;
> +
> +    switch (s->event) {
> +    case COLO_EVENT_CHECKPOINT:
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +        break;
> +    case COLO_EVENT_FAILOVER:
> +        break;
> +    default:
> +        break;
> +    }
> +    qemu_mutex_lock(&event_mtx);

Isn't this a deadlock? Since colo_notify_compares_event() won't release=20
event_mtx until event_unhandled_count reaches zero.

> +    assert(event_unhandled_count > 0);
> +    event_unhandled_count--;
> +    qemu_cond_broadcast(&event_complete_cond);
> +    qemu_mutex_unlock(&event_mtx);
> +}
> +
>   static void colo_compare_iothread(CompareState *s)
>   {
>       object_ref(OBJECT(s->iothread));
> @@ -769,6 +824,7 @@ static void colo_compare_iothread(CompareState *s)
>                                s, s->worker_context, true);
>  =20
>       colo_compare_timer_init(s);
> +    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
>   }
>  =20
>   static char *compare_get_pri_indev(Object *obj, Error **errp)
> @@ -926,8 +982,13 @@ static void colo_compare_complete(UserCreatable *u=
c, Error **errp)
>       net_socket_rs_init(&s->pri_rs, compare_pri_rs_finalize, s->vnet_h=
dr);
>       net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize, s->vnet_h=
dr);
>  =20
> +    QTAILQ_INSERT_TAIL(&net_compares, s, next);
> +
>       g_queue_init(&s->conn_list);
>  =20
> +    qemu_mutex_init(&event_mtx);
> +    qemu_cond_init(&event_complete_cond);
> +
>       s->connection_track_table =3D g_hash_table_new_full(connection_ke=
y_hash,
>                                                         connection_key_=
equal,
>                                                         g_free,
> @@ -990,6 +1051,7 @@ static void colo_compare_init(Object *obj)
>   static void colo_compare_finalize(Object *obj)
>   {
>       CompareState *s =3D COLO_COMPARE(obj);
> +    CompareState *tmp =3D NULL;
>  =20
>       qemu_chr_fe_deinit(&s->chr_pri_in, false);
>       qemu_chr_fe_deinit(&s->chr_sec_in, false);
> @@ -997,6 +1059,16 @@ static void colo_compare_finalize(Object *obj)
>       if (s->iothread) {
>           colo_compare_timer_del(s);
>       }
> +
> +    qemu_bh_delete(s->event_bh);
> +
> +    QTAILQ_FOREACH(tmp, &net_compares, next) {
> +        if (!strcmp(tmp->outdev, s->outdev)) {

This looks not elegant, can we compare by address or just use QLIST?

Thanks

> +            QTAILQ_REMOVE(&net_compares, s, next);
> +            break;
> +        }
> +    }
> +
>       /* Release all unhandled packets after compare thead exited */
>       g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>  =20
> @@ -1009,6 +1081,10 @@ static void colo_compare_finalize(Object *obj)
>       if (s->iothread) {
>           object_unref(OBJECT(s->iothread));
>       }
> +
> +    qemu_mutex_destroy(&event_mtx);
> +    qemu_cond_destroy(&event_complete_cond);
> +
>       g_free(s->pri_indev);
>       g_free(s->sec_indev);
>       g_free(s->outdev);
> diff --git a/net/colo-compare.h b/net/colo-compare.h
> new file mode 100644
> index 0000000000..1b1ce76aea
> --- /dev/null
> +++ b/net/colo-compare.h
> @@ -0,0 +1,22 @@
> +/*
> + * COarse-grain LOck-stepping Virtual Machines for Non-stop Service (C=
OLO)
> + * (a.k.a. Fault Tolerance or Continuous Replication)
> + *
> + * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
> + * Copyright (c) 2017 FUJITSU LIMITED
> + * Copyright (c) 2017 Intel Corporation
> + *
> + * Authors:
> + *    zhanghailiang <zhang.zhanghailiang@huawei.com>
> + *    Zhang Chen <zhangckid@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_COLO_COMPARE_H
> +#define QEMU_COLO_COMPARE_H
> +
> +void colo_notify_compares_event(void *opaque, int event, Error **errp)=
;
> +
> +#endif /* QEMU_COLO_COMPARE_H */
