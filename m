Received: from eggs.gnu.org ([2001:4830:134:3::10]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70DM-0001p5-KX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70DK-00027a-NX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:34:28 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-5-vsementsov@virtuozzo.com>
	<08a610aa-9c78-1c83-5e48-b93080aac87b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cc4cd44f-5628-9a02-0b97-2bf46fa72d58@virtuozzo.com>
Date: Mon, 1 Oct 2018 18:33:57 +0300
MIME-Version: 1.0
In-Reply-To: <08a610aa-9c78-1c83-5e48-b93080aac87b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/7] qcow2: async scheme for qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

27.09.2018 21:35, Max Reitz wrote:
> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>> Start several async requests instead of read chunk by chunk.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 204 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 5e7f2ee318..a0df8d4e50 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1869,6 +1869,197 @@ out:
>>       return ret;
>>   }
>>   
>> +typedef struct Qcow2WorkerTask {
>> +    uint64_t file_cluster_offset;
>> +    uint64_t offset;
>> +    uint64_t bytes;
>> +    uint64_t bytes_done;
>> +} Qcow2WorkerTask;
> Why don't you make this a union of request-specific structs?

ok, will try

>
>> +
>> +typedef int (*Qcow2DoWorkFunc)(BlockDriverState *bs, QEMUIOVector *qiov,
>> +                               Qcow2WorkerTask *task);
>> +
>> +typedef struct Qcow2RWState {
>> +    BlockDriverState *bs;
>> +    QEMUIOVector *qiov;
>> +    uint64_t bytes;
> Maybe make it total_bytes so it doesn't conflict with the value in
> Qcow2WorkerTask?

ok

>
>> +    int ret;
>> +    bool waiting_one;
>> +    bool waiting_all;
>> +    bool finalize;
>> +    Coroutine *co;
>> +    QSIMPLEQ_HEAD(, Qcow2Worker) free_workers;
>> +    QSIMPLEQ_HEAD(, Qcow2Worker) busy_workers;
>> +    int online_workers;
>> +    Qcow2DoWorkFunc do_work_func;
>> +} Qcow2RWState;
>> +
>> +typedef struct Qcow2Worker {
>> +    Qcow2RWState *rws;
>> +    Coroutine *co;
>> +    Qcow2WorkerTask task;
>> +    bool busy;
>> +    QSIMPLEQ_ENTRY(Qcow2Worker) entry;
>> +} Qcow2Worker;
>> +#define QCOW2_MAX_WORKERS 64
> That's really a bit hidden here.  I think it should go into the header.
>
> Also I'm not quite sure about the number.  In other places we've always
> used 16.
>
> (With the encryption code always allocating a new bounce buffer, this
> can mean quite a bit of memory usage.)

No doubts.

>
>> +
>> +static coroutine_fn void qcow2_rw_worker(void *opaque);
>> +static Qcow2Worker *qcow2_new_worker(Qcow2RWState *rws)
>> +{
>> +    Qcow2Worker *w = g_new0(Qcow2Worker, 1);
>> +    w->rws = rws;
>> +    w->co = qemu_coroutine_create(qcow2_rw_worker, w);
>> +
>> +    return w;
>> +}
>> +
>> +static void qcow2_free_worker(Qcow2Worker *w)
>> +{
>> +    g_free(w);
>> +}
>> +
>> +static coroutine_fn void qcow2_rw_worker(void *opaque)
>> +{
>> +    Qcow2Worker *w = opaque;
>> +    Qcow2RWState *rws = w->rws;
>> +
>> +    rws->online_workers++;
>> +
>> +    while (!rws->finalize) {
>> +        int ret = rws->do_work_func(rws->bs, rws->qiov, &w->task);
>> +        if (ret < 0 && rws->ret == 0) {
>> +            rws->ret = ret;
>> +        }
>> +
>> +        if (rws->waiting_all || rws->ret < 0) {
>> +            break;
>> +        }
>> +
>> +        w->busy = false;
>> +        QSIMPLEQ_REMOVE(&rws->busy_workers, w, Qcow2Worker, entry);
>> +        QSIMPLEQ_INSERT_TAIL(&rws->free_workers, w, entry);
>> +        if (rws->waiting_one) {
>> +            rws->waiting_one = false;
>> +            /* we must unset it here, to prevent queuing rws->co in several
>> +             * workers (it may happen if other worker already waits us on mutex,
>> +             * so it will be entered after our yield and before rws->co enter)
>> +             *
>> +             * TODO: rethink this comment, as here (and in other places in the
>> +             * file) we moved from qemu_coroutine_add_next to aio_co_wake.
>> +             */
>> +            aio_co_wake(rws->co);
>> +        }
>> +
>> +        qemu_coroutine_yield();
>> +    }
>> +
>> +    if (w->busy) {
>> +        w->busy = false;
>> +        QSIMPLEQ_REMOVE(&rws->busy_workers, w, Qcow2Worker, entry);
>> +    }
>> +    qcow2_free_worker(w);
>> +    rws->online_workers--;
>> +
>> +    if (rws->waiting_all && rws->online_workers == 0) {
>> +        aio_co_wake(rws->co);
>> +    }
>> +}
>> +
>> +static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
>> +                                            uint64_t file_cluster_offset,
>> +                                            uint64_t offset,
>> +                                            uint64_t bytes,
>> +                                            uint64_t bytes_done)
> I'd propose just taking a const Qcow2WorkerTask * here.  (Makes even
> more sense if you make it a union.)

ok, I'll try this way

>
>> +{
>> +    Qcow2Worker *w;
>> +
>> +    assert(rws->co == qemu_coroutine_self());
>> +
>> +    if (bytes_done == 0 && bytes == rws->bytes) {
>> +        Qcow2WorkerTask task = {
>> +            .file_cluster_offset = file_cluster_offset,
>> +            .offset = offset,
>> +            .bytes = bytes,
>> +            .bytes_done = bytes_done
>> +        };
>> +        rws->ret = rws->do_work_func(rws->bs, rws->qiov, &task);
> (If so, you'd just pass the pointer along here)
>
>> +        return;
>> +    }
> I like this fast path, but I think it deserves a small comment.  (That
> is a fast path and bypasses the whole worker infrastructure.)
>
>> +
>> +    if (!QSIMPLEQ_EMPTY(&rws->free_workers)) {
>> +        w = QSIMPLEQ_FIRST(&rws->free_workers);
>> +        QSIMPLEQ_REMOVE_HEAD(&rws->free_workers, entry);
>> +    } else if (rws->online_workers < QCOW2_MAX_WORKERS) {
>> +        w = qcow2_new_worker(rws);
>> +    } else {
>> +        rws->waiting_one = true;
>> +        qemu_coroutine_yield();
>> +        assert(!rws->waiting_one); /* already unset by worker */
> Sometimes I hate coroutines.  OK.  So, how does the yield ensure that
> any worker is scheduled?  Doesn't yield just give control to the parent?

hm. I don't follow. All workers are busy - we sure, because there no 
free workers,
and we can't create one more, second condition isn't satisfied too.
So, we give control to the parent. And only worker can wake us up.

>
> Right now I think it would be clearer to me if you'd just wake all busy
> coroutines (looping over them) until one has settled.

but all workers are busy, we should not touch them (they may be yielded 
in io operation)..

>
> This would also save you the aio_co_wake() in the worker itself, as
> they'd just have to yield in all cases.
>
>> +
>> +        w = QSIMPLEQ_FIRST(&rws->free_workers);
>> +        QSIMPLEQ_REMOVE_HEAD(&rws->free_workers, entry);
>> +    }
>> +    w->busy = true;
>> +    QSIMPLEQ_INSERT_TAIL(&rws->busy_workers, w, entry);
>> +
>> +    w->task.file_cluster_offset = file_cluster_offset;
>> +    w->task.offset = offset;
>> +    w->task.bytes = bytes;
>> +    w->task.bytes_done = bytes_done;
> (And you'd copy it with w->task = *task here)
>
>> +
>> +    qemu_coroutine_enter(w->co);
>> +}
>> +
>> +static void qcow2_init_rws(Qcow2RWState *rws, BlockDriverState *bs,
>> +                           QEMUIOVector *qiov, uint64_t bytes,
>> +                           Qcow2DoWorkFunc do_work_func)
>> +{
>> +    memset(rws, 0, sizeof(*rws));
>> +    rws->bs = bs;
>> +    rws->qiov = qiov;
>> +    rws->bytes = bytes;
>> +    rws->co = qemu_coroutine_self();
>> +    rws->do_work_func = do_work_func;
> Maybe you'd like to use
>
> *rws = (Qcow2RWState) {
>      .bs = bs,
>      ...
> };
>
> Then you could save yourself the memset().

ok

>
>> +    QSIMPLEQ_INIT(&rws->free_workers);
>> +    QSIMPLEQ_INIT(&rws->busy_workers);
>> +}
>> +
>> +static void qcow2_finalize_rws(Qcow2RWState *rws)
>> +{
>> +    assert(rws->co == qemu_coroutine_self());
>> +
>> +    /* kill waiting workers */
>> +    rws->finalize = true;
>> +    while (!QSIMPLEQ_EMPTY(&rws->free_workers)) {
>> +        Qcow2Worker *w = QSIMPLEQ_FIRST(&rws->free_workers);
>> +        QSIMPLEQ_REMOVE_HEAD(&rws->free_workers, entry);
>> +        qemu_coroutine_enter(w->co);
>> +    }
>> +
>> +    /* wait others */
>> +    if (rws->online_workers > 0) {
>> +        rws->waiting_all = true;
>> +        qemu_coroutine_yield();
>> +        rws->waiting_all = false;
> Why don't you enter the busy workers here?  (And keep doing so until
> online_workers is 0.)  That way, you could save yourself the other
> aio_co_wake() in qcow2_rw_worker().

We shouldn't enter busy workers, as they may yielded on io operation. 
The operation should complete.

>
> (My problem with those aio_co_wake()s is that they make the control flow
> rather hard to follow, in my opinion.  I'd prefer it if only these
> "control" functions woke up the worker coroutines, and not have it also
> the other way round in some cases.)
>
>> +    }
>> +
>> +    assert(rws->online_workers == 0);
>> +    assert(QSIMPLEQ_EMPTY(&rws->free_workers));
>> +    assert(QSIMPLEQ_EMPTY(&rws->busy_workers));
>> +}
>> +
>> +static coroutine_fn int qcow2_co_preadv_normal_task(BlockDriverState *bs,
>> +                                                    QEMUIOVector *qiov,
>> +                                                    Qcow2WorkerTask *task)
>> +{
>> +    return qcow2_co_preadv_normal(bs,
>> +                                  task->file_cluster_offset,
>> +                                  task->offset,
>> +                                  task->bytes,
>> +                                  qiov,
>> +                                  task->bytes_done);
>> +}
>> +
>>   static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>                                           uint64_t bytes, QEMUIOVector *qiov,
>>                                           int flags)
>> @@ -1880,12 +2071,15 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>       uint64_t cluster_offset = 0;
>>       uint64_t bytes_done = 0;
>>       QEMUIOVector hd_qiov;
>> +    Qcow2RWState rws = {0};
>> +
>> +    qcow2_init_rws(&rws, bs, qiov, bytes, qcow2_co_preadv_normal_task);
> I think it's a bit of a shame to initialize all of this in case we're
> just going to go into the fast path anyway.  But off the top of my head
> I can't come up with a much better solution.
>
> (Apart from adding more fields to Qcow2WorkerTask, which, to be honest,
> wouldn't be much better.  Because then we initialize that bigger object
> on the stack somewhere, as opposed to the static Qcow2RWState, so we
> probably don't gain anything.)
>
> Max
>
>>   
>>       qemu_iovec_init(&hd_qiov, qiov->niov);
>>   
>>       qemu_co_mutex_lock(&s->lock);
>>   
>> -    while (bytes != 0) {
>> +    while (bytes != 0 && rws.ret == 0) {
>>   
>>           /* prepare next request */
>>           cur_bytes = MIN(bytes, INT_MAX);
>> @@ -1942,9 +2136,10 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>           case QCOW2_CLUSTER_NORMAL:
>>               qemu_co_mutex_unlock(&s->lock);
>>   
>> -            ret = qcow2_co_preadv_normal(bs, cluster_offset,
>> -                                         offset, cur_bytes, qiov, bytes_done);
>> -            if (ret < 0) {
>> +            qcow2_rws_add_task(&rws, cluster_offset, offset, cur_bytes,
>> +                               bytes_done);
>> +            if (rws.ret < 0) {
>> +                ret = rws.ret;
>>                   goto fail_nolock;
>>               }
>>   
>> @@ -1967,6 +2162,11 @@ fail:
>>       qemu_co_mutex_unlock(&s->lock);
>>   
>>   fail_nolock:
>> +    qcow2_finalize_rws(&rws);
>> +    if (ret == 0) {
>> +        ret = rws.ret;
>> +    }
>> +
>>       qemu_iovec_destroy(&hd_qiov);
>>   
>>       return ret;
>>
>


-- 
Best regards,
Vladimir
