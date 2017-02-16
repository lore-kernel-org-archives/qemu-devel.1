Received: from eggs.gnu.org ([2001:4830:134:3::10]:43294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceBma-0005Bc-3h
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceBmW-0005FY-VX
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:26:56 -0500
Received: from [59.151.112.132] (port=5119 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceBmW-0005FD-JD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:26:52 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487147657-166092-4-git-send-email-zhang.zhanghailiang@huawei.com>
Message-ID: <4867fec3-cf63-8148-90ef-35e4da958c89@cn.fujitsu.com>
Date: Thu, 16 Feb 2017 10:27:05 +0800
MIME-Version: 1.0
In-Reply-To: <1487147657-166092-4-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] colo-compare: release all unhandled
 packets in finalize function
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
> We should release all unhandled packets before finalize colo compare.
> Besides, we need to free connection_track_table, or there will be
> a memory leak bug.
>
> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>
> ---
>   net/colo-compare.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a16e2d5..809bad3 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -676,6 +676,23 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
>       return;
>   }
>   

This function in my patch "colo-compare and filter-rewriter work with 
colo-frame "
Named 'colo_flush_connection', I think use 'flush' instead of 'release' 
is better,

Thanks
Zhang Chen


> +static void colo_release_packets(void *opaque, void *user_data)
> +{
> +    CompareState *s = user_data;
> +    Connection *conn = opaque;
> +    Packet *pkt = NULL;
> +
> +    while (!g_queue_is_empty(&conn->primary_list)) {
> +        pkt = g_queue_pop_head(&conn->primary_list);
> +        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
> +        packet_destroy(pkt, NULL);
> +    }
> +    while (!g_queue_is_empty(&conn->secondary_list)) {
> +        pkt = g_queue_pop_head(&conn->secondary_list);
> +        packet_destroy(pkt, NULL);
> +    }
> +}
> +
>   static void colo_compare_class_init(ObjectClass *oc, void *data)
>   {
>       UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> @@ -707,9 +724,12 @@ static void colo_compare_finalize(Object *obj)
>       g_main_loop_quit(s->compare_loop);
>       qemu_thread_join(&s->thread);
>   
> +    /* Release all unhandled packets after compare thead exited */
> +    g_queue_foreach(&s->conn_list, colo_release_packets, s);
>   
>       g_queue_free(&s->conn_list);
>   
> +    g_hash_table_destroy(s->connection_track_table);
>       g_free(s->pri_indev);
>       g_free(s->sec_indev);
>       g_free(s->outdev);

-- 
Thanks
Zhang Chen
