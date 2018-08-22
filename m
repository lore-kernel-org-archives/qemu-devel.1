Received: from eggs.gnu.org ([2001:4830:134:3::10]:49145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsck7-0005mC-17
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 19:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsck6-0001d2-9M
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 19:40:50 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-7-jsnow@redhat.com>
	<ce27055e-4a00-348b-9234-05a5e0e0af13@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5a08f2fa-ccdb-3219-0ff8-65e38d7c06eb@redhat.com>
Date: Wed, 22 Aug 2018 19:40:41 -0400
MIME-Version: 1.0
In-Reply-To: <ce27055e-4a00-348b-9234-05a5e0e0af13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] jobs: utilize job_exit shim
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



On 08/22/2018 08:20 AM, Max Reitz wrote:
> On 2018-08-17 21:04, John Snow wrote:
>> Utilize the job_exit shim by not calling job_defer_to_main_loop, and
>> where applicable, converting the deferred callback into the job_exit
>> callback.
>>
>> This converts backup, stream, create, and the unit tests all at once.
>> None of these jobs undergo and order of operations changes, so it should
>> be a mechanical change.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/backup.c            | 16 ----------------
>>  block/create.c            | 14 +++-----------
>>  block/stream.c            | 22 +++++++---------------
>>  tests/test-bdrv-drain.c   |  6 ------
>>  tests/test-blockjob-txn.c | 11 ++---------
>>  tests/test-blockjob.c     | 10 ++++------
>>  6 files changed, 16 insertions(+), 63 deletions(-)
> 
> [...]
> 
>> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
>> index 82cedee78b..ef29f35e44 100644
>> --- a/tests/test-blockjob-txn.c
>> +++ b/tests/test-blockjob-txn.c
>> @@ -24,17 +24,11 @@ typedef struct {
>>      int *result;
>>  } TestBlockJob;
>>  
>> -static void test_block_job_complete(Job *job, void *opaque)
>> +static void test_block_job_exit(Job *job)
>>  {
>>      BlockJob *bjob = container_of(job, BlockJob, job);
>>      BlockDriverState *bs = blk_bs(bjob->blk);
>> -    int rc = (intptr_t)opaque;
>>  
>> -    if (job_is_cancelled(job)) {
>> -        rc = -ECANCELED;
>> -    }
>> -
>> -    job_completed(job, rc);
>>      bdrv_unref(bs);
>>  }
> 
> That is a change in the order of operations, actually.  It's OK though
> because the BDS is still owned by the block job's BlockBackend.
> 
> (So I'd give an R-b, but I'm still unsure about the .exit() interface.)
> 
> Max
> 

Good eye; it does change the order of operations here, but like the
preceding two patches it should be safe for the same reasons.

I'll just update the commit message to keep things easier.
