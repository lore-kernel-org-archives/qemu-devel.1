Received: from eggs.gnu.org ([2001:4830:134:3::10]:60204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er8SL-00035j-AT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er8SK-0003ay-AB
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:36:05 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-12-jsnow@redhat.com>
	<20180228155337.GE4855@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <d88d1e84-bd70-e060-c3c6-29bcf419fd1a@redhat.com>
Date: Wed, 28 Feb 2018 15:35:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180228155337.GE4855@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 11/21] blockjobs: add block_job_dismiss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 02/28/2018 10:53 AM, Kevin Wolf wrote:
> Am 24.02.2018 um 00:51 hat John Snow geschrieben:
>> For jobs that have reached their CONCLUDED state, prior to having their
>> last reference put down (meaning jobs that have completed successfully,
>> unsuccessfully, or have been canceled), allow the user to dismiss the
>> job's lingering status report via block-job-dismiss.
>>
>> This gives management APIs the chance to conclusively determine if a job
>> failed or succeeded, even if the event broadcast was missed.
>>
>> Note that jobs do not yet linger in any such state, they are freed
>> immediately upon reaching this previously-unnamed state. such a state is
>> added immediately in the next commit.
>>
>> Verbs:
>> Dismiss: operates on CONCLUDED jobs only.
> 
> You want to insert an empty line here.
> 

Don't tell me what I want.

(Seriously though, what the heck is wrong with my script? When I go to
edit this commend message there *IS* a newline here. This has been
happening a bit lately and I haven't really had the chance to catch it
happening in action yet... sorry.)

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/trace-events       |  1 +
>>  blockdev.c               | 14 ++++++++++++++
>>  blockjob.c               | 34 ++++++++++++++++++++++++++++++++--
>>  include/block/blockjob.h |  9 +++++++++
>>  qapi/block-core.json     | 24 +++++++++++++++++++++++-
>>  5 files changed, 79 insertions(+), 3 deletions(-)
> 
>> @@ -841,6 +865,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>>          block_job_txn_add_job(txn, job);
>>      }
>>  
>> +    /* For the expanded job control STM, grab an extra
>> +     * reference for finalize() to put down */
> 
> Do you mean dismiss()?
> 

Sure. We'll say yes.

>> +    block_job_ref(job);
>>      return job;
>>  }
>>  
>> @@ -859,6 +886,9 @@ void block_job_pause_all(void)
>>  
>>  void block_job_early_fail(BlockJob *job)
>>  {
>> +    /* One for creation, one for finalize() */
> 
> And here?
> 

Sure. We'll say yes again.

>> +    assert(job->status == BLOCK_JOB_STATUS_CREATED);
>> +    block_job_unref(job);
>>      block_job_unref(job);
>>  }
> 
> Kevin
> 
