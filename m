Received: from eggs.gnu.org ([2001:4830:134:3::10]:42962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceBko-0003cs-B8
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceBkl-0004hP-5n
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:25:06 -0500
Received: from [59.151.112.132] (port=34692 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceBkk-0004fc-Fp
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:25:03 -0500
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487147657-166092-3-git-send-email-zhang.zhanghailiang@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <ce15349b-facb-aed4-4352-1c57890a7f68@cn.fujitsu.com>
Date: Thu, 16 Feb 2017 10:25:12 +0800
MIME-Version: 1.0
In-Reply-To: <1487147657-166092-3-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] colo-compare: kick compare thread to
 exit while finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com



On 02/15/2017 04:34 PM, zhanghailiang wrote:
> We should call g_main_loop_quit() to notify colo compare thread to
> exit, Or it will run in g_main_loop_run() forever.
>
> Besides, the finalizing process can't happen in context of colo thread,
> it is reasonable to remove the 'if (qemu_thread_is_self(&s->thread))'
> branch.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index fdde788..a16e2d5 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -83,6 +83,8 @@ typedef struct CompareState {
>       GHashTable *connection_track_table;
>       /* compare thread, a thread for each NIC */
>       QemuThread thread;
> +
> +    GMainLoop *compare_loop;
>   } CompareState;
>   
>   typedef struct CompareClass {
> @@ -496,7 +498,6 @@ static gboolean check_old_packet_regular(void *opaque)
>   static void *colo_compare_thread(void *opaque)
>   {
>       GMainContext *worker_context;
> -    GMainLoop *compare_loop;
>       CompareState *s = opaque;
>       GSource *timeout_source;
>   
> @@ -507,7 +508,7 @@ static void *colo_compare_thread(void *opaque)
>       qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
>                                compare_sec_chr_in, NULL, s, worker_context, true);
>   
> -    compare_loop = g_main_loop_new(worker_context, FALSE);
> +    s->compare_loop = g_main_loop_new(worker_context, FALSE);
>   
>       /* To kick any packets that the secondary doesn't match */
>       timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
> @@ -515,10 +516,10 @@ static void *colo_compare_thread(void *opaque)
>                             (GSourceFunc)check_old_packet_regular, s, NULL);
>       g_source_attach(timeout_source, worker_context);
>   
> -    g_main_loop_run(compare_loop);
> +    g_main_loop_run(s->compare_loop);
>   
>       g_source_unref(timeout_source);
> -    g_main_loop_unref(compare_loop);
> +    g_main_loop_unref(s->compare_loop);
>       g_main_context_unref(worker_context);
>       return NULL;
>   }
> @@ -703,13 +704,11 @@ static void colo_compare_finalize(Object *obj)
>       qemu_chr_fe_deinit(&s->chr_sec_in);
>       qemu_chr_fe_deinit(&s->chr_out);
>   
> -    g_queue_free(&s->conn_list);
> +    g_main_loop_quit(s->compare_loop);
> +    qemu_thread_join(&s->thread);
>   
> -    if (qemu_thread_is_self(&s->thread)) {
> -        /* compare connection */
> -        g_queue_foreach(&s->conn_list, colo_compare_connection, s);
> -        qemu_thread_join(&s->thread);
> -    }

Before free the 's->conn_list', you should flush all queued primary packets
and release all queued secondary packets here, so combine this patch 
with 3/5 patch as
one patch is a better choose.

Thanks
Zhang Chen

> +
> +    g_queue_free(&s->conn_list);
>   
>       g_free(s->pri_indev);
>       g_free(s->sec_indev);

-- 
Thanks
Zhang Chen
