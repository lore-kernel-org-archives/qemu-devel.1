Received: from eggs.gnu.org ([208.118.235.92]:38029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egcjQ-0000dv-JI
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egcin-0003id-Sg
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:42:16 -0500
From: John Snow <jsnow@redhat.com>
References: <20180130083532.GA31511@localhost>
	<7514e956-3896-62bc-999f-79717c9b9996@redhat.com>
Message-ID: <60e57a9f-ff79-e3ca-8492-d49214bf8ac6@redhat.com>
Date: Tue, 30 Jan 2018 15:39:21 -0500
MIME-Version: 1.0
In-Reply-To: <7514e956-3896-62bc-999f-79717c9b9996@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/mirror: change the semantic of
 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliang.opensource@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Liang Li <liliangleo@didichuxing.com>, Huaitong Han <huanhuaitong@didichuxing.com>



On 01/30/2018 03:18 PM, John Snow wrote:
> 
> 
> On 01/30/2018 03:38 AM, Liang Li wrote:
>> When doing drive mirror to a low speed shared storage, if there was heavy
>> BLK IO write workload in VM after the 'ready' event, drive mirror block job
>> can't be canceled immediately, it would keep running until the heavy BLK IO
>> workload stopped in the VM.
>>
>> Because libvirt depends on block-job-cancel for block live migration, the
>> current block-job-cancel has the semantic to make sure data is in sync after
>> the 'ready' event.  This semantic can't meet some requirement, for example,
>> people may use drive mirror for realtime backup while need the ability of
>> block live migration. If drive mirror can't not be cancelled immediately,
>> it means block live migration need to wait, because libvirt make use drive
>> mirror to implement block live migration and only one drive mirror block
>> job is allowed at the same time for a give block dev.
>>
>> We need a new interface for 'force cancel', which could quit block job
>> immediately if don't care about whether data is in sync or not.
>>
>> 'force' is not used by libvirt currently, to make things simple, change
>> it's semantic slightly, hope it will not break some use case which need its
>> original semantic.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Jeff Cody <jcody@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
>> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
>> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
>> ---
>>  block/mirror.c            |  9 +++------
>>  blockdev.c                |  4 ++--
>>  blockjob.c                | 11 ++++++-----
>>  hmp-commands.hx           |  3 ++-
>>  include/block/blockjob.h  |  9 ++++++++-
>>  qapi/block-core.json      |  6 ++++--
>>  tests/test-blockjob-txn.c |  8 ++++----
>>  7 files changed, 29 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index c9badc1..c22dff9 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -869,11 +869,8 @@ static void coroutine_fn mirror_run(void *opaque)
>>  
>>          ret = 0;
>>          trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>> -        if (!s->synced) {
>> -            block_job_sleep_ns(&s->common, delay_ns);
>> -            if (block_job_is_cancelled(&s->common)) {
>> -                break;
>> -            }
>> +        if (block_job_is_cancelled(&s->common) && s->common.force) {
>> +            break;
> 
> what's the justification for removing the sleep in the case that
> !s->synced && !block_job_is_cancelled(...) ?
> 
>>          } else if (!should_complete) {
>>              delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
>>              block_job_sleep_ns(&s->common, delay_ns);
>> @@ -887,7 +884,7 @@ immediate_exit:
>>           * or it was cancelled prematurely so that we do not guarantee that
>>           * the target is a copy of the source.
>>           */
>> -        assert(ret < 0 || (!s->synced && block_job_is_cancelled(&s->common)));
>> +        assert(ret < 0 || block_job_is_cancelled(&s->common));
> 
> This assertion gets weaker in the case where force isn't provided, is
> that desired?
> 
>>          assert(need_drain);
>>          mirror_wait_for_all_io(s);
>>      }
>> diff --git a/blockdev.c b/blockdev.c
>> index 8e977ee..039f156 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -145,7 +145,7 @@ void blockdev_mark_auto_del(BlockBackend *blk)
>>          aio_context_acquire(aio_context);
>>  
>>          if (bs->job) {
>> -            block_job_cancel(bs->job);
>> +            block_job_cancel(bs->job, false);
>>          }
>>  
>>          aio_context_release(aio_context);
>> @@ -3802,7 +3802,7 @@ void qmp_block_job_cancel(const char *device,
>>      }
>>  
>>      trace_qmp_block_job_cancel(job);
>> -    block_job_cancel(job);
>> +    block_job_cancel(job, force);
>>  out:
>>      aio_context_release(aio_context);
>>  }
>> diff --git a/blockjob.c b/blockjob.c
>> index f5cea84..0aacb50 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -365,7 +365,7 @@ static void block_job_completed_single(BlockJob *job)
>>      block_job_unref(job);
>>  }
>>  
>> -static void block_job_cancel_async(BlockJob *job)
>> +static void block_job_cancel_async(BlockJob *job, bool force)
>>  {
>>      if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
>>          block_job_iostatus_reset(job);
>> @@ -376,6 +376,7 @@ static void block_job_cancel_async(BlockJob *job)
>>          job->pause_count--;
>>      }
>>      job->cancelled = true;
>> +    job->force = force;
>>  }
>>  
> 
> I suppose this is okay; we're setting a permanent property of the job as
> part of a limited operation.
> 
> Granted, the job should disappear afterwards, so it should never
> conflict, but it made me wonder for a moment.
> 
> What happens if we cancel with force = true and then immediately cancel
> again with force = false? What happens? Can it cause issues?
> 
>>  static int block_job_finish_sync(BlockJob *job,
>> @@ -437,7 +438,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
>>       * on the caller, so leave it. */
>>      QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
>>          if (other_job != job) {
>> -            block_job_cancel_async(other_job);
>> +            block_job_cancel_async(other_job, true);
> 
> What's the rationale for deciding that transactional cancellations are
> always force=true?
> 
> Granted, this doesn't matter currently because mirror isn't a
> transactional job, but that makes the decision all the more curious.
> 
>>          }
>>      }
>>      while (!QLIST_EMPTY(&txn->jobs)) {
>> @@ -542,10 +543,10 @@ void block_job_user_resume(BlockJob *job)
>>      }
>>  }
>>  
>> -void block_job_cancel(BlockJob *job)
>> +void block_job_cancel(BlockJob *job, bool force)
>>  {
>>      if (block_job_started(job)) {
>> -        block_job_cancel_async(job);
>> +        block_job_cancel_async(job, force);
>>          block_job_enter(job);
>>      } else {
>>          block_job_completed(job, -ECANCELED);
>> @@ -557,7 +558,7 @@ void block_job_cancel(BlockJob *job)
>>   * function pointer casts there. */
>>  static void block_job_cancel_err(BlockJob *job, Error **errp)
>>  {
>> -    block_job_cancel(job);
>> +    block_job_cancel(job, false);
>>  }
>>  
>>  int block_job_cancel_sync(BlockJob *job)
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 15620c9..c8bb414 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -106,7 +106,8 @@ ETEXI
>>          .args_type  = "force:-f,device:B",
>>          .params     = "[-f] device",
>>          .help       = "stop an active background block operation (use -f"
>> -                      "\n\t\t\t if the operation is currently paused)",
>> +                      "\n\t\t\t if you want to abort the operation immediately"
>> +                      "\n\t\t\t instead of keep running until data is in sync )",
>>          .cmd        = hmp_block_job_cancel,
>>      },
>>  
>> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
>> index 00403d9..4a96c42 100644
>> --- a/include/block/blockjob.h
>> +++ b/include/block/blockjob.h
>> @@ -63,6 +63,12 @@ typedef struct BlockJob {
>>      bool cancelled;
>>  
>>      /**
>> +     * Set to true if the job should be abort immediately without waiting
>> +     * for data is in sync.
>> +     */
>> +    bool force;
>> +
>> +    /**
>>       * Counter for pause request. If non-zero, the block job is either paused,
>>       * or if busy == true will pause itself as soon as possible.
>>       */
>> @@ -218,10 +224,11 @@ void block_job_start(BlockJob *job);
>>  /**
>>   * block_job_cancel:
>>   * @job: The job to be canceled.
>> + * @force: Quit a job without waiting data is in sync.
>>   *
>>   * Asynchronously cancel the specified job.
>>   */
>> -void block_job_cancel(BlockJob *job);
>> +void block_job_cancel(BlockJob *job, bool force);
>>  
>>  /**
>>   * block_job_complete:
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 8225308..7c4dbfe 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2098,8 +2098,10 @@
>>  #          the name of the parameter), but since QEMU 2.7 it can have
>>  #          other values.
>>  #
>> -# @force: whether to allow cancellation of a paused job (default
>> -#         false).  Since 1.3.
>> +# @force: #optional whether to allow cancellation a job without waiting data is
>> +#         in sync, please not that since 2.12 it's semantic is not exactly the
>> +#         same as before, from 1.3 to 2.11 it means whether to allow cancellation
>> +#         of a paused job (default false).  Since 1.3.
>>  #
>>  # Returns: Nothing on success
>>  #          If no background operation is active on this device, DeviceNotActive
>> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
>> index 3591c96..53daadb 100644
>> --- a/tests/test-blockjob-txn.c
>> +++ b/tests/test-blockjob-txn.c
>> @@ -125,7 +125,7 @@ static void test_single_job(int expected)
>>      block_job_start(job);
>>  
>>      if (expected == -ECANCELED) {
>> -        block_job_cancel(job);
>> +        block_job_cancel(job, false);
>>      }
>>  
>>      while (result == -EINPROGRESS) {
>> @@ -173,10 +173,10 @@ static void test_pair_jobs(int expected1, int expected2)
>>      block_job_txn_unref(txn);
>>  
>>      if (expected1 == -ECANCELED) {
>> -        block_job_cancel(job1);
>> +        block_job_cancel(job1, false);
>>      }
>>      if (expected2 == -ECANCELED) {
>> -        block_job_cancel(job2);
>> +        block_job_cancel(job2, false);
>>      }
>>  
>>      while (result1 == -EINPROGRESS || result2 == -EINPROGRESS) {
>> @@ -231,7 +231,7 @@ static void test_pair_jobs_fail_cancel_race(void)
>>      block_job_start(job1);
>>      block_job_start(job2);
>>  
>> -    block_job_cancel(job1);
>> +    block_job_cancel(job1, false);
>>  
>>      /* Now make job2 finish before the main loop kicks jobs.  This simulates
>>       * the race between a pending kick and another job completing.
>>
> 
> --js
> 

This patch also causes an interesting regression in iotest 185:

185 1s ... - output mismatch (see 185.out.bad)
--- /home/bos/jhuston/src/qemu/tests/qemu-iotests/185.out	2017-12-21
16:15:50.879455552 -0500
+++ /home/bos/jhuston/src/qemu/bin/git/tests/qemu-iotests/185.out.bad
2018-01-30 15:38:47.936925014 -0500
@@ -28,16 +28,18 @@
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len":
4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304,
"offset": 4194304, "speed": 65536, "type": "commit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len":
4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}

 === Start mirror job and exit qemu ===

 {"return": {}}
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864
cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304,
"offset": 4194304, "speed": 65536, "type": "mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len":
4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len":
4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
