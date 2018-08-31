Received: from eggs.gnu.org ([2001:4830:134:3::10]:58208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0m-00022i-QH
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrn8-0003vl-MU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:21:23 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-6-jsnow@redhat.com>
	<95d4818c-0116-270a-0353-3dc6789e0a45@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5fa4a2ea-f76e-13c6-f309-26bf14ca8ec1@redhat.com>
Date: Fri, 31 Aug 2018 18:21:16 -0400
MIME-Version: 1.0
In-Reply-To: <95d4818c-0116-270a-0353-3dc6789e0a45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/13] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jtc@redhat.com



On 08/27/2018 08:47 AM, Max Reitz wrote:
> On 2018-08-24 00:22, John Snow wrote:
>> For purposes of minimum code movement, refactor the mirror_exit
>> callback to use the post-finalization callbacks in a trivial way.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 837279e979..f5b504406d 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -79,6 +79,7 @@ typedef struct MirrorBlockJob {
>>      int max_iov;
>>      bool initial_zeroing_ongoing;
>>      int in_active_write_counter;
>> +    bool prepared;
>>  } MirrorBlockJob;
>>  
>>  typedef struct MirrorBDSOpaque {
>> @@ -607,7 +608,7 @@ static void mirror_wait_for_all_io(MirrorBlockJob *s)
>>      }
>>  }
>>  
>> -static void mirror_exit(Job *job)
>> +static int mirror_exit_common(Job *job)
>>  {
>>      MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
>>      BlockJob *bjob = &s->common;
>> @@ -619,6 +620,11 @@ static void mirror_exit(Job *job)
>>      Error *local_err = NULL;
>>      int ret = job->ret;
>>  
>> +    if (s->prepared) {
>> +        return ret;
> 
> I'd prefer "return 0".  We only get here from mirror_abort(), and
> mirror_abort() cannot fail, so this function should not report failure then.
> 
> Also, the error has already been reported (as evidenced by the fact that
> job->ret < 0), so there is no need to report it again.  The function is
> supposed to be a no-op on its second call, and it was successful in
> doing so.
> 

If that makes you happiest.

That looks meaner than I meant it, but I still really want to write it,
because that makes *me* happiest.

>> +    }
>> +    s->prepared = true;
>> +
>>      bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
>>  
>>      /* Make sure that the source BDS doesn't go away before we called
>> @@ -711,7 +717,17 @@ static void mirror_exit(Job *job)
>>      bdrv_unref(mirror_top_bs);
>>      bdrv_unref(src);
>>  
>> -    job->ret = ret;
>> +    return ret;
>> +}
>> +
>> +static int mirror_prepare(Job *job)
>> +{
>> +    return mirror_exit_common(job);
>> +}
>> +
>> +static void mirror_abort(Job *job)
>> +{
>> +    mirror_exit_common(job);
> 
> Hm.  If we cannot assert that this always returns 0 (given that job->ret
> is negative before, which it is here), then something is off.

Yeah, this is one of the reasons I didn't more aggressively refactor
this code. I wasn't sure what to do with the concept of something that
can fail during abort.r

It already _can_ happen, so I opted for: "OK, fine, let it. No change in
behavior."

That said, of course it'd be better if that wasn't true...

> 
> The first thing obviously is the "return ret" you add in this patch, but
> that's easy to get rid off.
> 
> The second thing is the ret = -EPERM in the "if (s->backing_mode ==
> MIRROR_SOURCE_BACKING_CHAIN)" path.  Now the first question is, can we
> skip that on error?
> 
> The answer is "nobody would notice, but not really?".  First, we
> probably usually want a working target node for mirror even on failure.
> Now, this backing_mode here is used only for drive-mirror, so usually
> when that job fails, the target just goes aways (and it wouldn't matter
> what backing chain it had).
> 
> But you can give the target a node-name and then at least theoretically
> reference it while the job is running.  Then the backing chain after
> failure would matter.
> 

In the case of failure should we even attempt to install a different
backing chain after the failed operation? I'd think no, right?

> Though OTOH, we do not share CONSISTENT_READ on the target, so if you do
> that, it's not like we ever promised you you'd get the right backing
> chain at any point...  (And not sharing CONSISTENT_READ means that you
> really cannot attach the node to anything while the job is running.)
> 
> So we could just not attach the target backing chain if job->ret < 0.

Ah, like you suggest here.

> At least we could ignore errors.   But it'd need an explanation (namely
> "We didn't share CONSISTENT_READ, so we can ignore errors here").
> 
> 
> The second idea would be: We only need a valid target when the job was
> actually completed.  Looking it up unveils that cancelling a mirror
> (post-READY) does not make it abort; job->ret is still 0.  So I suppose
> when we ever get to mirror_abort() without mirror_prepare() having been
> called before, that is not a point where the target needs to be made
> consistent.  So that also means we can just ignore the error then.

This sounds like a solid justification to me!

It looks nicer to have all of the things that can fail under the if (ret
== 0) check anyway, because it moves us just a pinch closer to removing
that out into a proper .prepare, but there's still quite a few calls
before that stanza.

> 
> 
> All in all, I would say that if we are in .abort() (job->ret < 0), it
> should ignore this specific error (i.e. not overwrite @ret, which is
> already negative), because
> 
> (1) The target never shared CONSISTENT_READ anyway, so if there are
> other parents already, they won't be surprised that the backing chain is
> still missing; and if there are no other parents, it doesn't matter what
> we do because the target is going to bdrv_delete()'d after the job anyway.
> (2) While we can make an effort to get a half-consistent target even
> when the job has failed, chances are that it will be inconsistent
> anyway.  Also, nobody expects mirror to leave behind a consistent target
> when failing.  (Note: Post-READY cancel (to complete) does not count as
> failure.)
> 
> 
> The basic chance looks good, but I'd really like a working assertion
> here that mirror_exit_common() has returned 0.
> 
> Max
> 

OK, you got it. I'd like to try another stab at actually splitting this
function apart, but I might wait until after this series.

Skipping the backing chain reinstallation on failure doesn't bother any
existing iotest, so we can debate about if it's safe or not on that
patch in the next version.

>>  }
>>  
>>  static void mirror_throttle(MirrorBlockJob *s)
>> @@ -1132,7 +1148,8 @@ static const BlockJobDriver mirror_job_driver = {
>>          .user_resume            = block_job_user_resume,
>>          .drain                  = block_job_drain,
>>          .run                    = mirror_run,
>> -        .exit                   = mirror_exit,
>> +        .prepare                = mirror_prepare,
>> +        .abort                  = mirror_abort,
>>          .pause                  = mirror_pause,
>>          .complete               = mirror_complete,
>>      },
>> @@ -1149,7 +1166,8 @@ static const BlockJobDriver commit_active_job_driver = {
>>          .user_resume            = block_job_user_resume,
>>          .drain                  = block_job_drain,
>>          .run                    = mirror_run,
>> -        .exit                   = mirror_exit,
>> +        .prepare                = mirror_prepare,
>> +        .abort                  = mirror_abort,
>>          .pause                  = mirror_pause,
>>          .complete               = mirror_complete,
>>      },
>>
> 
> 

Thank you!

--John
