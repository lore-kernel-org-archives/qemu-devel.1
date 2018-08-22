Received: from eggs.gnu.org ([2001:4830:134:3::10]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsb5s-0004A2-H9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 17:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsb5r-0003Ww-G8
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 17:55:12 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-5-jsnow@redhat.com>
	<8290bf09-1525-a09b-5582-f20a70022025@redhat.com>
	<7009f691-12fb-d688-9edb-7196ee398386@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3c91a6b4-d698-e044-1e9b-201c362009df@redhat.com>
Date: Wed, 22 Aug 2018 17:55:02 -0400
MIME-Version: 1.0
In-Reply-To: <7009f691-12fb-d688-9edb-7196ee398386@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com



On 08/22/2018 07:58 AM, Max Reitz wrote:
> On 2018-08-17 21:18, John Snow wrote:
>>
>>
>> On 08/17/2018 03:04 PM, John Snow wrote:
>>> Change the manual deferment to commit_complete into the implicit
>>> callback to job_exit, renaming commit_complete to commit_exit.
>>>
>>> This conversion does change the timing of when job_completed is
>>> called to after the bdrv_replace_node and bdrv_unref calls, which
>>> could have implications for bjob->blk which will now be put down
>>> after this cleanup.
>>>
>>> Kevin highlights that we did not take any permissions for that backend
>>> at job creation time, so it is safe to reorder these operations.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  block/commit.c | 20 ++++----------------
>>>  1 file changed, 4 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/block/commit.c b/block/commit.c
>>> index 4a17bb73ec..93c3b6a39e 100644
>>> --- a/block/commit.c
>>> +++ b/block/commit.c
>>> @@ -68,19 +68,13 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
>>>      return 0;
>>>  }
>>>  
>>> -typedef struct {
>>> -    int ret;
>>> -} CommitCompleteData;
>>> -
>>> -static void commit_complete(Job *job, void *opaque)
>>> +static void commit_exit(Job *job)
>>>  {
>>>      CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>>>      BlockJob *bjob = &s->common;
>>> -    CommitCompleteData *data = opaque;
>>>      BlockDriverState *top = blk_bs(s->top);
>>>      BlockDriverState *base = blk_bs(s->base);
>>>      BlockDriverState *commit_top_bs = s->commit_top_bs;
>>> -    int ret = data->ret;
>>>      bool remove_commit_top_bs = false;
>>>  
>>>      /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
>>> @@ -93,8 +87,8 @@ static void commit_complete(Job *job, void *opaque)
>>>  
>>>      if (!job_is_cancelled(job) && ret == 0) {
>>
>> forgot to actually squash the change in here that replaces `ret` with
>> `job->ret`.
> 
> A better interface would be one function that is called when .run() was
> successful, and one that is called when it was not.  (They can still
> resolve into a single function in the job that is just called with a
> boolean that's either true or false, but accessing *job to find out
> whether .run() was successful or not seems kind of convoluted to me.)
> 
> Max
> 

Sorry, I need a better cover letter.

.exit() is going away, and either .prepare() or .abort() will be called
after .run(), so what you're asking for will be true, just not all at
once in this series.

--js
