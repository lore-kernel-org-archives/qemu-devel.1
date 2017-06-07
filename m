Received: from eggs.gnu.org ([2001:4830:134:3::10]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWQV-0002Rf-JI
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWQQ-0000OO-Sg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIWQQ-0000O9-Jz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:34:46 -0400
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
	<1496659493-1105-3-git-send-email-wang.yong155@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <586d53fb-aed0-aa25-64d9-a2761a382efa@redhat.com>
Date: Wed, 7 Jun 2017 16:34:36 +0800
MIME-Version: 1.0
In-Reply-To: <1496659493-1105-3-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2 02/04] colo-compare: Process pactkets in
 the IOThread of the primary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yong Wang <wang.yong155@zte.com.cn>, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn



On 2017=E5=B9=B406=E6=9C=8805=E6=97=A5 18:44, Yong Wang wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> Process pactkets in the IOThread which arrived over the socket.
> we use qio_channel_set_aio_fd_handler to set the handlers on the
> IOThread AioContext.then the packets from the primary and the secondary
> are processed in the IOThread.
> Finally remove the colo-compare thread using the IOThread instead.
>
> Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
> ---
>   net/colo-compare.c | 133 ++++++++++++++++++++++++++++++++++++--------=
---------
>   net/colo.h         |   1 +
>   2 files changed, 91 insertions(+), 43 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index b0942a4..e3af791 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -29,6 +29,7 @@
>   #include "qemu/sockets.h"
>   #include "qapi-visit.h"
>   #include "net/colo.h"
> +#include "io/channel.h"
>   #include "sysemu/iothread.h"
>  =20
>   #define TYPE_COLO_COMPARE "colo-compare"
> @@ -82,11 +83,6 @@ typedef struct CompareState {
>       GQueue conn_list;
>       /* hashtable to save connection */
>       GHashTable *connection_track_table;
> -    /* compare thread, a thread for each NIC */
> -    QemuThread thread;
> -
> -    GMainContext *worker_context;
> -    GMainLoop *compare_loop;
>  =20
>       /*compare iothread*/
>       IOThread *iothread;
> @@ -95,6 +91,14 @@ typedef struct CompareState {
>       QEMUTimer *packet_check_timer;
>   } CompareState;
>  =20
> +typedef struct {
> +    Chardev parent;
> +    QIOChannel *ioc; /*I/O channel */

We probably don't want to manipulate char backend's internal io channel.=20
All need here is to access the frontend API (char-fe.c) I believe, and=20
hide the internal implementation.

> +} CompareChardev;
> +
> +#define COMPARE_CHARDEV(obj)                                     \
> +    OBJECT_CHECK(CompareChardev, (obj), TYPE_CHARDEV_SOCKET)
> +
>   typedef struct CompareClass {
>       ObjectClass parent_class;
>   } CompareClass;
> @@ -107,6 +111,12 @@ enum {
>   static int compare_chr_send(CharBackend *out,
>                               const uint8_t *buf,
>                               uint32_t size);
> +static void compare_chr_set_aio_fd_handlers(CharBackend *b,
> +                                    AioContext *ctx,
> +                                    IOCanReadHandler *fd_can_read,
> +                                    IOReadHandler *fd_read,
> +                                    IOEventHandler *fd_event,
> +                                    void *opaque);
>  =20
>   static gint seq_sorter(Packet *a, Packet *b, gpointer data)
>   {
> @@ -534,6 +544,30 @@ err:
>       return ret < 0 ? ret : -EIO;
>   }
>  =20
> +static void compare_chr_read(void *opaque)
> +{
> +    Chardev *chr =3D opaque;
> +    uint8_t buf[CHR_READ_BUF_LEN];
> +    int len, size;
> +    int max_size;
> +
> +    max_size =3D qemu_chr_be_can_write(chr);
> +    if (max_size <=3D 0) {
> +        return;
> +    }
> +
> +    len =3D sizeof(buf);
> +    if (len > max_size) {
> +        len =3D max_size;
> +    }
> +    size =3D CHARDEV_GET_CLASS(chr)->chr_sync_read(chr, (void *)buf, l=
en);
> +    if (size =3D=3D 0) {
> +        return;
> +    } else if (size > 0) {
> +        qemu_chr_be_write(chr, buf, size);
> +    }
> +}
> +
>   static int compare_chr_can_read(void *opaque)
>   {
>       return COMPARE_READ_LEN_MAX;
> @@ -550,8 +584,8 @@ static void compare_pri_chr_in(void *opaque, const =
uint8_t *buf, int size)
>  =20
>       ret =3D net_fill_rstate(&s->pri_rs, buf, size);
>       if (ret =3D=3D -1) {
> -        qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL,
> -                                 NULL, NULL, true);
> +        compare_chr_set_aio_fd_handlers(&s->chr_pri_in, s->ctx,
> +                                    NULL, NULL, NULL, NULL);
>           error_report("colo-compare primary_in error");
>       }
>   }
> @@ -567,8 +601,8 @@ static void compare_sec_chr_in(void *opaque, const =
uint8_t *buf, int size)
>  =20
>       ret =3D net_fill_rstate(&s->sec_rs, buf, size);
>       if (ret =3D=3D -1) {
> -        qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL,
> -                                 NULL, NULL, true);
> +        compare_chr_set_aio_fd_handlers(&s->chr_sec_in, s->ctx,
> +                                    NULL, NULL, NULL, NULL);
>           error_report("colo-compare secondary_in error");
>       }
>   }
> @@ -605,34 +639,57 @@ static void colo_compare_timer_del(CompareState *=
s)
>       }
>   }
>  =20
> -static void *colo_compare_thread(void *opaque)
> -{
> -    CompareState *s =3D opaque;
> -
> -    s->worker_context =3D g_main_context_new();
> -
> -    qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
> -                          compare_pri_chr_in, NULL, s, s->worker_conte=
xt, true);
> -    qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
> -                          compare_sec_chr_in, NULL, s, s->worker_conte=
xt, true);
> -
> -    s->compare_loop =3D g_main_loop_new(s->worker_context, FALSE);
> -
> -    g_main_loop_run(s->compare_loop);
> -
> -    g_main_loop_unref(s->compare_loop);
> -    g_main_context_unref(s->worker_context);
> -    return NULL;
> -}
>  =20
>   static void colo_compare_iothread(CompareState *s)
>   {
>       object_ref(OBJECT(s->iothread));
>       s->ctx =3D iothread_get_aio_context(s->iothread);
>  =20
> +    compare_chr_set_aio_fd_handlers(&s->chr_pri_in, s->ctx,
> +                    compare_chr_can_read,
> +                    compare_pri_chr_in,
> +                    NULL,
> +                    s);
> +    compare_chr_set_aio_fd_handlers(&s->chr_sec_in, s->ctx,
> +                    compare_chr_can_read,
> +                    compare_sec_chr_in,
> +                    NULL,
> +                    s);
> +
>       colo_compare_timer_init(s);
>   }
>  =20
> +static void compare_chr_set_aio_fd_handlers(CharBackend *b,
> +                                    AioContext *ctx,
> +                                    IOCanReadHandler *fd_can_read,
> +                                    IOReadHandler *fd_read,
> +                                    IOEventHandler *fd_event,
> +                                    void *opaque)
> +{
> +    CompareChardev *s;
> +
> +    if (!b->chr) {
> +        return;
> +    }
> +    s =3D COMPARE_CHARDEV(b->chr);
> +    if (!s->ioc) {
> +        return;
> +    }

So this is hacky, you can refer how vhost-user validate udp socket char=20
backend.

> +
> +    b->chr_can_read =3D fd_can_read;
> +    b->chr_read =3D fd_read;
> +    b->chr_event =3D fd_event;
> +    b->opaque =3D opaque;
> +    remove_fd_in_watch(b->chr);
> +
> +    if (b->chr_read) {
> +        qio_channel_set_aio_fd_handler(s->ioc, ctx,
> +                                compare_chr_read, NULL, b->chr);
> +    } else {
> +        qio_channel_set_aio_fd_handler(s->ioc, ctx, NULL, NULL, NULL);

So instead of doing such hack, how about passing a AioContext * instead=20
of GMainContext * to qemu_chr_fe_set_handlers?

Thanks

> +    }
> +}
> +
>   static char *compare_get_pri_indev(Object *obj, Error **errp)
>   {
>       CompareState *s =3D COLO_COMPARE(obj);
> @@ -736,8 +793,6 @@ static void colo_compare_complete(UserCreatable *uc=
, Error **errp)
>   {
>       CompareState *s =3D COLO_COMPARE(uc);
>       Chardev *chr;
> -    char thread_name[64];
> -    static int compare_id;
>  =20
>       if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread)=
 {
>           error_setg(errp, "colo compare needs 'primary_in' ,"
> @@ -776,12 +831,6 @@ static void colo_compare_complete(UserCreatable *u=
c, Error **errp)
>                                                         g_free,
>                                                         connection_dest=
roy);
>  =20
> -    sprintf(thread_name, "colo-compare %d", compare_id);
> -    qemu_thread_create(&s->thread, thread_name,
> -                       colo_compare_thread, s,
> -                       QEMU_THREAD_JOINABLE);
> -    compare_id++;
> -
>       colo_compare_iothread(s);
>  =20
>       return;
> @@ -834,16 +883,14 @@ static void colo_compare_finalize(Object *obj)
>   {
>       CompareState *s =3D COLO_COMPARE(obj);
>  =20
> -    qemu_chr_fe_set_handlers(&s->chr_pri_in, NULL, NULL, NULL, NULL,
> -                             s->worker_context, true);
> -    qemu_chr_fe_set_handlers(&s->chr_sec_in, NULL, NULL, NULL, NULL,
> -                             s->worker_context, true);
> +    compare_chr_set_aio_fd_handlers(&s->chr_pri_in, s->ctx,
> +                                    NULL, NULL, NULL, NULL);
> +    compare_chr_set_aio_fd_handlers(&s->chr_sec_in, s->ctx,
> +                                    NULL, NULL, NULL, NULL);
> +
>       qemu_chr_fe_deinit(&s->chr_out);
>       colo_compare_timer_del(s);
>  =20
> -    g_main_loop_quit(s->compare_loop);
> -    qemu_thread_join(&s->thread);
> -
>       /* Release all unhandled packets after compare thead exited */
>       g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>  =20
> diff --git a/net/colo.h b/net/colo.h
> index 7c524f3..936dea1 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -84,5 +84,6 @@ Connection *connection_get(GHashTable *connection_tra=
ck_table,
>   void connection_hashtable_reset(GHashTable *connection_track_table);
>   Packet *packet_new(const void *data, int size);
>   void packet_destroy(void *opaque, void *user_data);
> +void remove_fd_in_watch(Chardev *chr);
>  =20
>   #endif /* QEMU_COLO_PROXY_H */
