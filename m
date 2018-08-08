Received: from eggs.gnu.org ([2001:4830:134:3::10]:60710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fnP1B-0004P3-RN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fnP15-0004Sf-U3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:00:53 -0400
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-5-jsnow@redhat.com>
	<20180808034124.GB755222@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <ed93bdc3-0ed8-2840-026b-66fbc9580655@redhat.com>
Date: Wed, 8 Aug 2018 10:00:33 -0400
MIME-Version: 1.0
In-Reply-To: <20180808034124.GB755222@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/21] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>



On 08/07/2018 11:41 PM, Jeff Cody wrote:
> On Tue, Aug 07, 2018 at 12:33:32AM -0400, John Snow wrote:
>> Change the manual deferment to commit_complete into the implicit
>> callback to job_exit.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/commit.c | 19 +++++--------------
>>  1 file changed, 5 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 620666161b..5bed098d5f 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -68,19 +68,14 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
>>      return 0;
>>  }
>>  
>> -typedef struct {
>> -    int ret;
>> -} CommitCompleteData;
>> -
>> -static void commit_complete(Job *job, void *opaque)
>> +static void commit_exit(Job *job)
>>  {
>>      CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>>      BlockJob *bjob = &s->common;
>> -    CommitCompleteData *data = opaque;
>>      BlockDriverState *top = blk_bs(s->top);
>>      BlockDriverState *base = blk_bs(s->base);
>>      BlockDriverState *commit_top_bs = s->commit_top_bs;
>> -    int ret = data->ret;
>> +    int ret = job->ret;
>>      bool remove_commit_top_bs = false;
>>  
>>      /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
> 
> Since 'ret' is only assigned to 'job->ret' outside of this line, we could
> drop the local 'ret' and assign job->ret to the output of
> brdrv_drop_intermediate() in this code below:
> 
>     if (!job_is_cancelled(job) && ret == 0) {
>         /* success */
>         ret = bdrv_drop_intermediate(s->commit_top_bs, base,
>                                      s->backing_file_str);
>     }
> 
>> @@ -117,9 +112,6 @@ static void commit_complete(Job *job, void *opaque)
>>       * bdrv_set_backing_hd() to fail. */
>>      block_job_remove_all_bdrv(bjob);
>>  
>> -    job_completed(job, ret);
>> -    g_free(data);
>> -
>>      /* If bdrv_drop_intermediate() didn't already do that, remove the commit
>>       * filter driver from the backing chain. Do this as the final step so that
>>       * the 'consistent read' permission can be granted.  */
>> @@ -132,12 +124,12 @@ static void commit_complete(Job *job, void *opaque)
>>  
>>      bdrv_unref(commit_top_bs);
>>      bdrv_unref(top);
>> +    job->ret = ret;
> 
> We could then drop this line as well.
> 
> (This may fall under bike shedding, so I don't feel strongly about it):

You're right; though most of it gets blown out of the water in #16
anyway, so it doesn't stay a problem for long.

--js

> 
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> 

Thanks!

>>  }
>>  
>>  static void coroutine_fn commit_run(void *opaque)
>>  {
>>      CommitBlockJob *s = opaque;
>> -    CommitCompleteData *data;
>>      int64_t offset;
>>      uint64_t delay_ns = 0;
>>      int ret = 0;
>> @@ -210,9 +202,7 @@ static void coroutine_fn commit_run(void *opaque)
>>  out:
>>      qemu_vfree(buf);
>>  
>> -    data = g_malloc(sizeof(*data));
>> -    data->ret = ret;
>> -    job_defer_to_main_loop(&s->common.job, commit_complete, data);
>> +    s->common.job.ret = ret;
>>  }
>>  
>>  static const BlockJobDriver commit_job_driver = {
>> @@ -223,6 +213,7 @@ static const BlockJobDriver commit_job_driver = {
>>          .user_resume   = block_job_user_resume,
>>          .drain         = block_job_drain,
>>          .start         = commit_run,
>> +        .exit          = commit_exit,
>>      },
>>  };
>>  
>> -- 
>> 2.14.4
>>
