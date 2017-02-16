Received: from eggs.gnu.org ([2001:4830:134:3::10]:45986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceC4s-0008Ik-4n
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceC4p-0003Wn-2Z
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:45:50 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:4510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceC4o-0003VO-5O
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:45:46 -0500
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487147657-166092-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<ce15349b-facb-aed4-4352-1c57890a7f68@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58A51234.4060203@huawei.com>
Date: Thu, 16 Feb 2017 10:45:08 +0800
MIME-Version: 1.0
In-Reply-To: <ce15349b-facb-aed4-4352-1c57890a7f68@cn.fujitsu.com>
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com

On 2017/2/16 10:25, Zhang Chen wrote:
>
>
> On 02/15/2017 04:34 PM, zhanghailiang wrote:
>> We should call g_main_loop_quit() to notify colo compare thread to
>> exit, Or it will run in g_main_loop_run() forever.
>>
>> Besides, the finalizing process can't happen in context of colo thread,
>> it is reasonable to remove the 'if (qemu_thread_is_self(&s->thread))'
>> branch.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>    net/colo-compare.c | 19 +++++++++----------
>>    1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index fdde788..a16e2d5 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -83,6 +83,8 @@ typedef struct CompareState {
>>        GHashTable *connection_track_table;
>>        /* compare thread, a thread for each NIC */
>>        QemuThread thread;
>> +
>> +    GMainLoop *compare_loop;
>>    } CompareState;
>>
>>    typedef struct CompareClass {
>> @@ -496,7 +498,6 @@ static gboolean check_old_packet_regular(void *opaque)
>>    static void *colo_compare_thread(void *opaque)
>>    {
>>        GMainContext *worker_context;
>> -    GMainLoop *compare_loop;
>>        CompareState *s = opaque;
>>        GSource *timeout_source;
>>
>> @@ -507,7 +508,7 @@ static void *colo_compare_thread(void *opaque)
>>        qemu_chr_fe_set_handlers(&s->chr_sec_in, compare_chr_can_read,
>>                                 compare_sec_chr_in, NULL, s, worker_context, true);
>>
>> -    compare_loop = g_main_loop_new(worker_context, FALSE);
>> +    s->compare_loop = g_main_loop_new(worker_context, FALSE);
>>
>>        /* To kick any packets that the secondary doesn't match */
>>        timeout_source = g_timeout_source_new(REGULAR_PACKET_CHECK_MS);
>> @@ -515,10 +516,10 @@ static void *colo_compare_thread(void *opaque)
>>                              (GSourceFunc)check_old_packet_regular, s, NULL);
>>        g_source_attach(timeout_source, worker_context);
>>
>> -    g_main_loop_run(compare_loop);
>> +    g_main_loop_run(s->compare_loop);
>>
>>        g_source_unref(timeout_source);
>> -    g_main_loop_unref(compare_loop);
>> +    g_main_loop_unref(s->compare_loop);
>>        g_main_context_unref(worker_context);
>>        return NULL;
>>    }
>> @@ -703,13 +704,11 @@ static void colo_compare_finalize(Object *obj)
>>        qemu_chr_fe_deinit(&s->chr_sec_in);
>>        qemu_chr_fe_deinit(&s->chr_out);
>>
>> -    g_queue_free(&s->conn_list);
>> +    g_main_loop_quit(s->compare_loop);
>> +    qemu_thread_join(&s->thread);
>>
>> -    if (qemu_thread_is_self(&s->thread)) {
>> -        /* compare connection */
>> -        g_queue_foreach(&s->conn_list, colo_compare_connection, s);
>> -        qemu_thread_join(&s->thread);
>> -    }
>
> Before free the 's->conn_list', you should flush all queued primary packets
> and release all queued secondary packets here, so combine this patch
> with 3/5 patch as
> one patch is a better choose.
>

Make sense, will fix it in next version, thanks.

> Thanks
> Zhang Chen
>
>> +
>> +    g_queue_free(&s->conn_list);
>>
>>        g_free(s->pri_indev);
>>        g_free(s->sec_indev);
>
