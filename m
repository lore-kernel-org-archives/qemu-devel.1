Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dpnNc-0008K2-4p
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dpnNY-0007Qh-Sm
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:21:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32089
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dpnNY-0007Ph-2Z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 23:21:20 -0400
References: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
	<1503991359-3353-3-git-send-email-wang.yong155@zte.com.cn>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <ef26ee5f-af16-46ec-8f9a-57155d04c302@cn.fujitsu.com>
Date: Thu, 7 Sep 2017 11:22:56 +0800
MIME-Version: 1.0
In-Reply-To: <1503991359-3353-3-git-send-email-wang.yong155@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCHv5 02/03] colo-compare: Use IOThread to
 Check old packet regularly and Process pactkets of the primary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>, pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org



On 08/29/2017 03:22 PM, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
>
> Remove the task which check old packet in the comparing thread,
> then use IOthread context timer to handle it.
>
> Process pactkets in the IOThread which arrived over the socket.
> we use iothread_get_g_main_context to create a new g_main_loop in
> the IOThread.then the packets from the primary and the secondary
> are processed in the IOThread.
>
> Finally remove the colo-compare thread using the IOThread instead.
>
> Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>

Reviewed-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>

Hi~ Jason.
Have any comments to this series?

Thanks
Zhang Chen

> ---
>   net/colo-compare.c | 83 +++++++++++++++++++++++++++++-------------------------
>   1 file changed, 45 insertions(+), 38 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 5fe8e3f..b2a2a13 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -29,6 +29,7 @@
>   #include "qemu/sockets.h"
>   #include "qapi-visit.h"
>   #include "net/colo.h"
> +#include "sysemu/iothread.h"
>   
>   #define TYPE_COLO_COMPARE "colo-compare"
>   #define COLO_COMPARE(obj) \
> @@ -82,11 +83,10 @@ typedef struct CompareState {
>       GQueue conn_list;
>       /* hashtable to save connection */
>       GHashTable *connection_track_table;
> -    /* compare thread, a thread for each NIC */
> -    QemuThread thread;
>   
> +    IOThread *iothread;
>       GMainContext *worker_context;
> -    GMainLoop *compare_loop;
> +    QEMUTimer *packet_check_timer;
>   } CompareState;
>   
>   typedef struct CompareClass {
> @@ -597,22 +597,40 @@ static void compare_sec_chr_in(void *opaque, const uint8_t *buf, int size)
>    * Check old packet regularly so it can watch for any packets
>    * that the secondary hasn't produced equivalents of.
>    */
> -static gboolean check_old_packet_regular(void *opaque)
> +static void check_old_packet_regular(void *opaque)
>   {
>       CompareState *s = opaque;
>   
>       /* if have old packet we will notify checkpoint */
>       colo_old_packet_check(s);
> +    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                REGULAR_PACKET_CHECK_MS);
> +}
> +
> +static void colo_compare_timer_init(CompareState *s)
> +{
> +    AioContext *ctx = iothread_get_aio_context(s->iothread);
>   
> -    return TRUE;
> +    s->packet_check_timer = aio_timer_new(ctx, QEMU_CLOCK_VIRTUAL,
> +                                SCALE_MS, check_old_packet_regular,
> +                                s);
> +    timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                    REGULAR_PACKET_CHECK_MS);
>   }
>   
> -static void *colo_compare_thread(void *opaque)
> +static void colo_compare_timer_del(CompareState *s)
>   {
> -    CompareState *s = opaque;
> -    GSource *timeout_source;
> +    if (s->packet_check_timer) {
> +        timer_del(s->packet_check_timer);
> +        timer_free(s->packet_check_timer);
> +        s->packet_check_timer = NULL;
> +    }
> + }
>   
> -    s->worker_context = g_main_context_new();
> +static void colo_compare_iothread(CompareState *s)
> +{
> +    object_ref(OBJECT(s->iothread));
> +    s->worker_context = iothread_get_g_main_context(s->iothread);
>   
>       qemu_chr_fe_set_handlers(&s->chr_pri_in, compare_chr_can_read,
>                                compare_pri_chr_in, NULL, NULL,
> @@ -621,20 +639,7 @@ static void *colo_compare_thread(void *opaque)
>                                compare_sec_chr_in, NULL, NULL,
>                                s, s->worker_context, true);
>   
> -    s->compare_loop = g_main_loop_new(s->worker_context, FALSE);
> -
> -    /* To kick any packets that the secondary doesn't match */
> -    timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
> -    g_source_set_callback(timeout_source,
> -                          (GSourceFunc)check_old_packet_regular, s, NULL);
> -    g_source_attach(timeout_source, s->worker_context);
> -
> -    g_main_loop_run(s->compare_loop);
> -
> -    g_source_unref(timeout_source);
> -    g_main_loop_unref(s->compare_loop);
> -    g_main_context_unref(s->worker_context);
> -    return NULL;
> +    colo_compare_timer_init(s);
>   }
>   
>   static char *compare_get_pri_indev(Object *obj, Error **errp)
> @@ -759,12 +764,10 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
>   {
>       CompareState *s = COLO_COMPARE(uc);
>       Chardev *chr;
> -    char thread_name[64];
> -    static int compare_id;
>   
> -    if (!s->pri_indev || !s->sec_indev || !s->outdev) {
> +    if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread) {
>           error_setg(errp, "colo compare needs 'primary_in' ,"
> -                   "'secondary_in','outdev' property set");
> +                   "'secondary_in','outdev','iothread' property set");
>           return;
>       } else if (!strcmp(s->pri_indev, s->outdev) ||
>                  !strcmp(s->sec_indev, s->outdev) ||
> @@ -799,12 +802,7 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
>                                                         g_free,
>                                                         connection_destroy);
>   
> -    sprintf(thread_name, "colo-compare %d", compare_id);
> -    qemu_thread_create(&s->thread, thread_name,
> -                       colo_compare_thread, s,
> -                       QEMU_THREAD_JOINABLE);
> -    compare_id++;
> -
> +    colo_compare_iothread(s);
>       return;
>   }
>   
> @@ -848,6 +846,10 @@ static void colo_compare_init(Object *obj)
>       object_property_add_str(obj, "outdev",
>                               compare_get_outdev, compare_set_outdev,
>                               NULL);
> +    object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
> +                            (Object **)&s->iothread,
> +                            object_property_allow_set_link,
> +                            OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
>   
>       s->vnet_hdr = false;
>       object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
> @@ -861,16 +863,21 @@ static void colo_compare_finalize(Object *obj)
>       qemu_chr_fe_deinit(&s->chr_pri_in, false);
>       qemu_chr_fe_deinit(&s->chr_sec_in, false);
>       qemu_chr_fe_deinit(&s->chr_out, false);
> -
> -    g_main_loop_quit(s->compare_loop);
> -    qemu_thread_join(&s->thread);
> -
> +    if (s->iothread) {
> +        colo_compare_timer_del(s);
> +    }
>       /* Release all unhandled packets after compare thead exited */
>       g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>   
>       g_queue_clear(&s->conn_list);
>   
> -    g_hash_table_destroy(s->connection_track_table);
> +    if (s->connection_track_table) {
> +        g_hash_table_destroy(s->connection_track_table);
> +    }
> +
> +    if (s->iothread) {
> +        object_unref(OBJECT(s->iothread));
> +    }
>       g_free(s->pri_indev);
>       g_free(s->sec_indev);
>       g_free(s->outdev);

-- 
Thanks
Zhang Chen
