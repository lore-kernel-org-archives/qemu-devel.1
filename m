Received: from eggs.gnu.org ([2001:4830:134:3::10]:33943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70Pa-0002kk-2o
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g70PZ-0001Wu-3W
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:47:06 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-8-vsementsov@virtuozzo.com>
	<1c8299bf-0b31-82a7-c7c4-5069581f2d94@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <61700fb9-8416-48d0-4238-1ad64a619c28@virtuozzo.com>
Date: Mon, 1 Oct 2018 18:46:50 +0300
MIME-Version: 1.0
In-Reply-To: <1c8299bf-0b31-82a7-c7c4-5069581f2d94@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 7/7] qcow2: async scheme for
 qcow2_co_pwritev
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

28.09.2018 17:35, Max Reitz wrote:
> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>> Start several async requests instead of read chunk by chunk.
>>
>> Iotest 026 output is changed, as because of async io error path has
>> changed.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.c                      | 47 ++++++++++++++++++++++++++++++--------
>>   tests/qemu-iotests/026.out         | 18 ++++++++-------
>>   tests/qemu-iotests/026.out.nocache | 20 ++++++++--------
>>   3 files changed, 59 insertions(+), 26 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 88b3fb8080..c7501adfc6 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1874,6 +1874,7 @@ typedef struct Qcow2WorkerTask {
>>       uint64_t offset;
>>       uint64_t bytes;
>>       uint64_t bytes_done;
>> +    QCowL2Meta *l2meta;
>>   } Qcow2WorkerTask;
>>   
>>   typedef int (*Qcow2DoWorkFunc)(BlockDriverState *bs, QEMUIOVector *qiov,
>> @@ -1965,11 +1966,16 @@ static coroutine_fn void qcow2_rw_worker(void *opaque)
>>       }
>>   }
>>   
>> +/* qcow2_rws_add_task
>> +* l2meta - opaque pointer for do_work_func, so behavior depends on
>> +*          do_work_func, specified in qcow2_init_rws
>> +*/
> I think this would work better if Qcow2WorkerTask was indeed a union.
>
>>   static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
>>                                               uint64_t file_cluster_offset,
>>                                               uint64_t offset,
>>                                               uint64_t bytes,
>> -                                            uint64_t bytes_done)
>> +                                            uint64_t bytes_done,
>> +                                            QCowL2Meta *l2meta)
>>   {
>>       Qcow2Worker *w;
>>   
>> @@ -1980,7 +1986,8 @@ static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
>>               .file_cluster_offset = file_cluster_offset,
>>               .offset = offset,
>>               .bytes = bytes,
>> -            .bytes_done = bytes_done
>> +            .bytes_done = bytes_done,
>> +            .l2meta = l2meta
>>           };
>>           rws->ret = rws->do_work_func(rws->bs, rws->qiov, &task);
>>           return;
>> @@ -2006,6 +2013,7 @@ static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
>>       w->task.offset = offset;
>>       w->task.bytes = bytes;
>>       w->task.bytes_done = bytes_done;
>> +    w->task.l2meta = l2meta;
>>   
>>       qemu_coroutine_enter(w->co);
>>   }
>> @@ -2137,7 +2145,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
>>               qemu_co_mutex_unlock(&s->lock);
>>   
>>               qcow2_rws_add_task(&rws, cluster_offset, offset, cur_bytes,
>> -                               bytes_done);
>> +                               bytes_done, NULL);
>>               if (rws.ret < 0) {
>>                   ret = rws.ret;
>>                   goto fail_nolock;
>> @@ -2289,6 +2297,19 @@ fail:
>>       return ret;
>>   }
>>   
>> +static coroutine_fn int qcow2_co_do_pwritev_task(BlockDriverState *bs,
>> +                                                 QEMUIOVector *qiov,
>> +                                                 Qcow2WorkerTask *task)
>> +{
>> +    return qcow2_co_do_pwritev(bs,
>> +                               task->file_cluster_offset,
>> +                               task->offset,
>> +                               task->bytes,
>> +                               qiov,
>> +                               task->bytes_done,
>> +                               task->l2meta);
>> +}
>> +
>>   static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>                                            uint64_t bytes, QEMUIOVector *qiov,
>>                                            int flags)
>> @@ -2299,16 +2320,19 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>       uint64_t bytes_done = 0;
>>       uint8_t *cluster_data = NULL;
>>       QCowL2Meta *l2meta = NULL;
>> +    Qcow2RWState rws = {0};
>>   
>>       trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
>>   
>> +    qcow2_init_rws(&rws, bs, qiov, bytes, qcow2_co_do_pwritev_task);
>> +
>>       qemu_iovec_init(&hd_qiov, qiov->niov);
>>   
>>       s->cluster_cache_offset = -1; /* disable compressed cache */
>>   
>>       qemu_co_mutex_lock(&s->lock);
>>   
>> -    while (bytes != 0) {
>> +    while (bytes != 0 && rws.ret == 0) {
>>           int offset_in_cluster = offset_into_cluster(s, offset);
>>           unsigned int cur_bytes = MIN(bytes, INT_MAX); /* number of sectors in
>>                                                            current iteration */
>> @@ -2340,11 +2364,11 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
>>   
>>           qemu_co_mutex_unlock(&s->lock);
>>   
>> -
>> -        ret = qcow2_co_do_pwritev(bs, cluster_offset, offset, cur_bytes,
>> -                                  qiov, bytes_done, l2meta);
>> -        l2meta = NULL; /* l2meta is consumed by qcow2_co_do_pwritev() */
>> -        if (ret < 0) {
>> +        qcow2_rws_add_task(&rws, cluster_offset, offset, cur_bytes, bytes_done,
>> +                           l2meta);
>> +        l2meta = NULL; /* l2meta is consumed */
>> +        if (rws.ret < 0) {
>> +            ret = rws.ret;
>>               goto fail_nometa;
>>           }
>>   
>> @@ -2362,6 +2386,11 @@ fail:
>>   
>>       qemu_co_mutex_unlock(&s->lock);
>>   
>> +    qcow2_finalize_rws(&rws);
>> +    if (ret == 0) {
>> +        ret = rws.ret;
>> +    }
>> +
>>   fail_nometa:
> Shouldn't we finalize below the fail_nometa label?

yes you are right, it's a bug.

>
> (And as a minor thing, if the "ret = rws.ret" assignment was there as
> well, you could drop the same assignment before the "goto fail_nometa".)
>
> Max
>
>>   
>>       qemu_iovec_destroy(&hd_qiov);


-- 
Best regards,
Vladimir
