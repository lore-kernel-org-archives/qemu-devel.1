Received: from eggs.gnu.org ([2001:4830:134:3::10]:48434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEwkb-0002Yh-1v
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 06:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEwkW-0007Ch-Ea
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 06:20:33 -0500
Received: from [59.151.112.132] (port=38250 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEwkV-0007BQ-86
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 06:20:28 -0500
References: <1481183802-31153-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161208100744.GF10780@stefanha-x1.localdomain>
	<528af51a-3dcb-8dcb-58e7-451588133946@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <4f4ac75b-d52b-affe-2863-8b53e4d92d67@cn.fujitsu.com>
Date: Thu, 8 Dec 2016 19:20:19 +0800
MIME-Version: 1.0
In-Reply-To: <528af51a-3dcb-8dcb-58e7-451588133946@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] block/qapi: Optimize the query
 function of the blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, kwolf@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com



At 12/08/2016 07:17 PM, Dou Liyang wrote:
>
>
> At 12/08/2016 06:07 PM, Stefan Hajnoczi wrote:
>> On Thu, Dec 08, 2016 at 03:56:42PM +0800, Dou Liyang wrote:
>>
>> The commit message says "optimize" but I think the purpose of this patch
>> is to refactor qmp_query_blockstats() to make it easier to read?  Just
>> checking if you expect a change in performance.
>>
> Yes, I expect.
> It not just for readability. also for enhancing the performance.
>
> And I did a simple test:
>
> +    int64_t start_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      stats_list = qmp_query_blockstats(false, false, NULL);
> +    int64_t end_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +    monitor_printf(mon, " start_time=%" PRId64
> +                        " end_time=%" PRId64
> +                        " takes_time=%" PRId64
> +                        "\n",
> +                        start_time,
> +                        end_time,
> +                        (end_time -start_time));
>
> Then, use "info blockstats" 10 times and get the averages and
> distributions of the values:
>
> --default: use blk--
> before that patch: 1 disk : 3695ns  | 500 disks : 658156ns
>
> after that patch:  1 disk : 3290ns  | 500 disks : 651000ns
>
> --query_node: use BDS--
>
> before that patch: 1 disk : 2567ns  | 500 disks : 610947ns
>
> after that patch:  1 disk : 3290ns  | 500 disks : 597085ns


  before that patch: 1 disk : 3290ns  | 500 disks : 610947ns

  after that patch:  1 disk : 2567ns  | 500 disks : 597085ns


>
> And actually, For the qmp_query_blockstats(), I hope it could be O(1) by
> adding a parameter or something else. However, as you said, it was a
> reasonable short-term workaround.
> I am also confused whether it is necessary to do in the longer term ?
>
> whatever it is, I guess this patch may be helpful.
>
>> Usually when I see "optimize" I think improving performance.  When I see
>> "refactor" I think improving the structure of the code.
>>
>
> I see.
>
>>> In the query function named qmp_query_blockstats, for each block/node,
>>> the process is as shown below:
>>> the 0 func determines which the lookup queue will be used by the 1 func,
>>> then gets the next object by the 1 func and calls the 2. The 2 func
>>> calls
>>> the 3 and 4 func. There are some judgement and work that is useless and
>>> repetitive.
>>>
>>> +--------------+      +---------------------+
>>>  | 1            |      | 4.                  |
>>>  |next_query_bds|      |bdrv_query_bds_stats +---+
>>>  |              |      |                     |   |
>>>  +--------^-----+      +-------------^-------+   |
>>>           |                          |           |
>>> +---------+----------+      +--------+-------+   |
>>> | 0.                 |      | 2.             |   |
>>> |qmp_query_blockstats+------>bdrv_query_stats<----
>>> |                    |      |                |
>>> +--------------------+      +--------+-------+
>>>                                      |
>>>                        +-------------v-------+
>>>                        | 3.                  |
>>>                        |bdrv_query_blk_stats |
>>>                        |                     |
>>>                        +---------------------+
>>>
>>> So, we think its logic is complex, and its readability is low.
>>> There is no need to do so. Just let the function do its own thing.
>>>
>>> Now, we optimize them make sure that:
>>> 1. the func named bdrv_query_bds_stats do the work for the BDS.
>>> 2. the func named bdrv_query_blk_stats do the work for the Blocks.
>>> 3. the query func just call what the want actually in need.
>>>                                     +--------------+
>>>                                     |              |
>>>                            +--------v-----------+  |
>>>                        +--->  3.                |  |
>>> +-------------------+  |   |bdrv_query_bds_stats+--+
>>> | 1.                +--+   |                    |
>>> |                   +      +--------------------+
>>> |qmp_query_blockstats--+
>>> |                   |  |
>>> +-------------------+  |   +--------------------+
>>>                        |   | 2.                 |
>>>                        +--->                    |
>>>                            |bdrv_query_blk_stats|
>>>                            |                    |
>>>                            +--------------------+
>>>
>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>> ---
>>>  block/qapi.c | 106
>>> +++++++++++++++++++++++++++++------------------------------
>>>  1 file changed, 53 insertions(+), 53 deletions(-)
>>
>> It's not immediately obvious that this change improves code readability.
>> 53 insertions vs 53 deletions does not suggest a simplification.  I
>> guess it depends whether you prefer helper functions or open coding.
>>
>
> oops, I have not found that is the same! :)
> I will try to improve.
>
> Thanks,
>
>  Liyang
>
>
>> I'll leave the review of this patch to the maintainers of block/qapi.c.
>>
>>>
>>> diff --git a/block/qapi.c b/block/qapi.c
>>> index a62e862..090452b 100644
>>> --- a/block/qapi.c
>>> +++ b/block/qapi.c
>>> @@ -357,14 +357,14 @@ static void bdrv_query_info(BlockBackend *blk,
>>> BlockInfo **p_info,
>>>      qapi_free_BlockInfo(info);
>>>  }
>>>
>>> -static BlockStats *bdrv_query_stats(BlockBackend *blk,
>>> -                                    const BlockDriverState *bs,
>>> -                                    bool query_backing);
>>> -
>>> -static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend
>>> *blk)
>>> +static BlockStats *bdrv_query_blk_stats(BlockStats *s, BlockBackend
>>> *blk)
>>>  {
>>>      BlockAcctStats *stats = blk_get_stats(blk);
>>>      BlockAcctTimedStats *ts = NULL;
>>> +    BlockDeviceStats *ds = s->stats;
>>> +
>>> +    s->has_device = true;
>>> +    s->device = g_strdup(blk_name(blk));
>>>
>>>      ds->rd_bytes = stats->nr_bytes[BLOCK_ACCT_READ];
>>>      ds->wr_bytes = stats->nr_bytes[BLOCK_ACCT_WRITE];
>>> @@ -426,11 +426,24 @@ static void
>>> bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
>>>          dev_stats->avg_wr_queue_depth =
>>>              block_acct_queue_depth(ts, BLOCK_ACCT_WRITE);
>>>      }
>>> +
>>> +    return s;
>>>  }
>>>
>>> -static void bdrv_query_bds_stats(BlockStats *s, const
>>> BlockDriverState *bs,
>>> +static BlockStats *bdrv_query_bds_stats(BlockStats *s,
>>> +                                 const BlockDriverState *bs,
>>>                                   bool query_backing)
>>>  {
>>> +
>>> +    if (!s) {
>>> +        s = g_malloc0(sizeof(*s));
>>> +        s->stats = g_malloc0(sizeof(*s->stats));
>>> +    }
>>> +
>>> +    if (!bs) {
>>> +        return s;
>>> +    }
>>> +
>>>      if (bdrv_get_node_name(bs)[0]) {
>>>          s->has_node_name = true;
>>>          s->node_name = g_strdup(bdrv_get_node_name(bs));
>>> @@ -440,32 +453,12 @@ static void bdrv_query_bds_stats(BlockStats *s,
>>> const BlockDriverState *bs,
>>>
>>>      if (bs->file) {
>>>          s->has_parent = true;
>>> -        s->parent = bdrv_query_stats(NULL, bs->file->bs,
>>> query_backing);
>>> +        s->parent = bdrv_query_bds_stats(NULL, bs->file->bs,
>>> query_backing);
>>>      }
>>>
>>>      if (query_backing && bs->backing) {
>>>          s->has_backing = true;
>>> -        s->backing = bdrv_query_stats(NULL, bs->backing->bs,
>>> query_backing);
>>> -    }
>>> -
>>> -}
>>> -
>>> -static BlockStats *bdrv_query_stats(BlockBackend *blk,
>>> -                                    const BlockDriverState *bs,
>>> -                                    bool query_backing)
>>> -{
>>> -    BlockStats *s;
>>> -
>>> -    s = g_malloc0(sizeof(*s));
>>> -    s->stats = g_malloc0(sizeof(*s->stats));
>>> -
>>> -    if (blk) {
>>> -        s->has_device = true;
>>> -        s->device = g_strdup(blk_name(blk));
>>> -        bdrv_query_blk_stats(s->stats, blk);
>>> -    }
>>> -    if (bs) {
>>> -        bdrv_query_bds_stats(s, bs, query_backing);
>>> +        s->backing = bdrv_query_bds_stats(NULL, bs->backing->bs,
>>> query_backing);
>>>      }
>>>
>>>      return s;
>>> @@ -494,42 +487,49 @@ BlockInfoList *qmp_query_block(Error **errp)
>>>      return head;
>>>  }
>>>
>>> -static bool next_query_bds(BlockBackend **blk, BlockDriverState **bs,
>>> -                           bool query_nodes)
>>> -{
>>> -    if (query_nodes) {
>>> -        *bs = bdrv_next_node(*bs);
>>> -        return !!*bs;
>>> -    }
>>> -
>>> -    *blk = blk_next(*blk);
>>> -    *bs = *blk ? blk_bs(*blk) : NULL;
>>> -
>>> -    return !!*blk;
>>> -}
>>> -
>>>  BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
>>>                                       bool query_nodes,
>>>                                       Error **errp)
>>>  {
>>>      BlockStatsList *head = NULL, **p_next = &head;
>>> -    BlockBackend *blk = NULL;
>>> +    BlockBackend *blk;
>>>      BlockDriverState *bs = NULL;
>>>
>>>      /* Just to be safe if query_nodes is not always initialized */
>>> -    query_nodes = has_query_nodes && query_nodes;
>>> +    if (has_query_nodes && query_nodes) {
>>> +        while ((bs = bdrv_next_node(bs))) {
>>> +            BlockStatsList *info = g_malloc0(sizeof(*info));
>>> +            AioContext *ctx = bdrv_get_aio_context(bs);
>>> +            BlockStats *s;
>>>
>>> -    while (next_query_bds(&blk, &bs, query_nodes)) {
>>> -        BlockStatsList *info = g_malloc0(sizeof(*info));
>>> -        AioContext *ctx = blk ? blk_get_aio_context(blk)
>>> -                              : bdrv_get_aio_context(bs);
>>> +            s = g_malloc0(sizeof(*s));
>>> +            s->stats = g_malloc0(sizeof(*s->stats));
>>>
>>> -        aio_context_acquire(ctx);
>>> -        info->value = bdrv_query_stats(blk, bs, !query_nodes);
>>> -        aio_context_release(ctx);
>>> +            aio_context_acquire(ctx);
>>> +            info->value = bdrv_query_bds_stats(s, bs, false);
>>> +            aio_context_release(ctx);
>>>
>>> -        *p_next = info;
>>> -        p_next = &info->next;
>>> +            *p_next = info;
>>> +             p_next = &info->next;
>>> +        }
>>> +    } else {
>>> +        for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
>>> +            BlockStatsList *info = g_malloc0(sizeof(*info));
>>> +            AioContext *ctx = blk_get_aio_context(blk);
>>> +            BlockStats *s;
>>> +
>>> +            s = g_malloc0(sizeof(*s));
>>> +            s->stats = g_malloc0(sizeof(*s->stats));
>>> +            bs = blk_bs(blk);
>>> +
>>> +            aio_context_acquire(ctx);
>>> +            s = bdrv_query_blk_stats(s, blk);
>>> +            info->value = bdrv_query_bds_stats(s, bs, true);
>>> +            aio_context_release(ctx);
>>> +
>>> +            *p_next = info;
>>> +            p_next = &info->next;
>>> +        }
>>>      }
>>>
>>>      return head;
>>> --
>>> 2.5.5
>>>
>>>
>>>
