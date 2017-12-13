Received: from eggs.gnu.org ([2001:4830:134:3::10]:43098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePAy3-0004GI-B3
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePAy0-00052a-6H
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:37:15 -0500
References: <20171211234609.30497-1-jsnow@redhat.com>
	<20171212000824.GE20604@localhost.localdomain>
	<75812f29-9d2e-9a68-8eee-5b020c0990f6@redhat.com>
	<20171213104819.GG16782@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <abfb3ae8-9e40-7c01-6b2f-9fe42adf21c4@redhat.com>
Date: Wed, 13 Dec 2017 12:37:07 -0500
MIME-Version: 1.0
In-Reply-To: <20171213104819.GG16782@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: kick jobs on
 set-speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 12/13/2017 05:48 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 12, 2017 at 01:22:28PM -0500, John Snow wrote:
>>
>>
>> On 12/11/2017 07:08 PM, Jeff Cody wrote:
>>> On Mon, Dec 11, 2017 at 06:46:09PM -0500, John Snow wrote:
>>>> If users set an unreasonably low speed (like one byte per second), the
>>>> calculated delay may exceed many hours. While we like to punish users
>>>> for asking for stupid things, we do also like to allow users to correct
>>>> their wicked ways.
>>>>
>>>> When a user provides a new speed, kick the job to allow it to recalculate
>>>> its delay.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  blockjob.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/blockjob.c b/blockjob.c
>>>> index 715c2c2680..43f01ad190 100644
>>>> --- a/blockjob.c
>>>> +++ b/blockjob.c
>>>> @@ -483,6 +483,7 @@ static void block_job_completed_txn_success(BlockJob *job)
>>>>  void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>>>>  {
>>>>      Error *local_err = NULL;
>>>> +    int64_t old_speed = job->speed;
>>>>  
>>>>      if (!job->driver->set_speed) {
>>>>          error_setg(errp, QERR_UNSUPPORTED);
>>>> @@ -495,6 +496,10 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>>>>      }
>>>>  
>>>>      job->speed = speed;
>>>> +    /* Kick the job to recompute its delay */
>>>> +    if ((speed > old_speed) && timer_pending(&job->sleep_timer)) {
>>>
>>> job->sleep_timer is protected by block_job_mutex (via
>>> block_job_lock/unlock); is it safe for us to check it here outside the
>>> mutex?
>>>
>>
>> My hunch is that in this specific case that it is; but only because of
>> assumptions about holding the aio_context and the QEMU global mutex here.
>>
>>> But in any case, I think we could get rid of the timer_pending check, and
>>> just always kick the job if we have a speed increase.  block_job_enter()
>>> should do the right thing (mutex protected check on job->busy and
>>> job->sleep_timer).
>>>
>>
>> I could lock it for inarguable correctness; I just didn't want to kick a
>> job that didn't actually require any kicking to limit any potential
>> problems from that interaction.
>>
>> (I'm fond of the extra conditional because I feel like it makes the
>> intent of the kick explicit.)
>>
>> I can remove it.
> 
> Removing the conditional would introduce a bug.  block_job_enter() will
> unpause the job.
> 

It will almost certainly pause again immediately, but maybe not before
work is performed.
