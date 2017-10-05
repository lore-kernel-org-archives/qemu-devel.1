Received: from eggs.gnu.org ([2001:4830:134:3::10]:54961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e0AiC-00051R-0N
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e0Ai9-0002R5-6R
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 14:17:31 -0400
References: <20171004015205.20724-1-jsnow@redhat.com>
	<20171004182732.GE9801@localhost.localdomain>
	<7fd66217-8eda-8de2-f34f-148f69f9df4d@redhat.com>
	<20171005113818.GA4416@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <9ea53caa-6dc2-368a-8648-83db0431ac47@redhat.com>
Date: Thu, 5 Oct 2017 14:17:14 -0400
MIME-Version: 1.0
In-Reply-To: <20171005113818.GA4416@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] blockjobs: add explicit job reaping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Nikolay: You mentioned a while ago that you had issues with incremental
backup's eventual return status being unknown. Can you please elaborate
for me why this is a problem?

I assume due to the long running of a backup job it's entirely possible
to imagine losing connection to QEMU and missing the event depending on
how long the interruption is.

Backup operations are expensive, so we need some definite way to catch
this return status.

Please let me know if you have any feedback to this thread.

On 10/05/2017 07:38 AM, Kevin Wolf wrote:
> Am 05.10.2017 um 03:46 hat John Snow geschrieben:
>> On 10/04/2017 02:27 PM, Kevin Wolf wrote:
>>> Am 04.10.2017 um 03:52 hat John Snow geschrieben:>>>> For jobs that complete when a monitor isn't looking, there's no way to
>>>> tell what the job's final return code was. We need to allow jobs to
>>>> remain in the list until queried for reliable management.
>>>
>>> Just a short summary of what I discussed with John on IRC:
>>>
>>> Another important reason why we want to have an explicit end of block
>>> jobs is that job completion often makes changes to the graph. For a
>>> management tool that manages the block graph on a node level, it is a
>>> big problem if graph changes can happen at any point that can lead to
>>> bad race conditions. Giving the management tool control over the end of
>>> the block job makes it aware that graph changes happen.
>>>
>>> This means that compared to this RFC series, we need to move the waiting
>>> earlier in the process:
>>>
>>> 1. Block job is done and calls block_job_completed()
>>> 2. Wait for other block jobs in the same job transaction to complete
>>> 3. Send a (new) QMP event to the management tool to notify it that the
>>>    job is ready to be reaped
>>
>> Oh, I suppose to distinguish it from "COMPLETED" in that sense, because
>> it isn't actually COMPLETED anymore under your vision, so it requires a
>> new event in this proposal.
>>
>> This becomes a bit messy, bumping up against both "READY" and a
>> transactional pre-completed state semantically. Uhhhh, for lack of a
>> better word in the timeframe I'd like to complete this email in, let's
>> call this new theoretical state "PENDING"?
>>
>> So presently, a job goes through the following life cycle:
>>
>> 1. CREATED --> RUNNING
>> 2. RUNNING <--> PAUSED
>> 3. RUNNING --> (READY | COMPLETED | CANCELED)
>> 4. READY --> (COMPLETED | CANCELED)
>> 5. (COMPLETED | CANCELED) --> NULL
>>
>> Where we emit an event upon entering "READY", "COMPLETED" or "CANCELED".
> 
> Roughly yes, but it's not quite true because you can still pause and
> unpause ready jobs. So READY and PAUSED are kind of orthogonal.
> 

But you cannot block-job-complete a running job, so I included it here
so we could keep the concept of the ready-to-complete state in mind.

>> My patchset here effectively adds a new optional terminal state:
>>
>> 5. (COMPLETED | CANCELED) --> (NULL | FINISHED)
>> 6. FINISHED --> NULL
>>
>> Where the last transition from FINISHED to NULL is performed via
>> block-job-reap, but notably we get to re-use the events for COMPLETED |
>> CANCELED to indicate the availability of this operation to be performed.
>>
>> What happens in the case of transactionally managed jobs presently is
>> that jobs get stuck as they enter the COMPLETED|CANCELED state. If you
>> were to query them they behave as if they're RUNNING. There's no
>> discrete state that exists for this presently.
>>
>> You can cancel these as normal, but I'm not sure if you can pause them,
>> actually. (Note to self, test that.) I think they have almost exactly
>> like any RUNNING job would.
> 
> Except that they don't do any work any more. This is an mportant
> difference for a mirror job which would normally keep copying new writes
> until it sends the COMPLETED event. So when libvirt restarts and it sees
> a "RUNNING" mirror job, it can't decide whether it is still copying
> things or has already completed.
> 
> Looks like this is another reason why we want a separate state here.

Yes, I realized as I was writing it that we have no real way to tell
that a job is simply pending completion.

> 
>> What you're proposing here is the formalization of the pre-completion
>> state ("PENDING") and that in this state, a job outside of a transaction
>> can exist until it is manually told to finally, once and for all,
>> actually finish its business. We can use this as a hook to perform and
>> last graph changes so they will not come as a surprise to the management
>> application. Maybe this operation should be called "Finalize". Again,
>> for lack of a better term in the timeframe, I'll refer to it as such for
>> now.
> 
> "finalize" doesn't sound too bad.
> 

Though taken altogether, the set of names we've accumulated is a little
ridiculous.

>> I think importantly this actually distinguishes it from "reap" in that
>> the commit phase can still fail, so we can't let the job follow that
>> auto transition back to the NULL state.
> 
> Let me see if I understand correctly: We want to make sure that the
> management tool sees the final return value for the job. We have already
> decided that events aren't enough for this because the management tool
> could be restarted while we send the event, so the information is lost.
> Having it as a return value of block-job-reap isn't enough either
> because it could be lost the same way. We need a separate phase where
> libvirt can query the return value and from which we don't automatically
> transition away.
> 
> I'm afraid that you are right.

There may be some wiggle room in asserting that some block-job-finalize
command should return the final status in its return value, but it's
clearly more flexible to not mandate this.

However, for existing QMP commands today there's no way to tell if a
command succeeded or failed if you somehow lose the synchronous reply,
so maybe this is actually OK ...

> 
>> That means that we'd need both a block-job-finalize AND a
>> block-job-reap to accomplish both of the following goals:
>>
>> (1) Allow the management application to control graph changes [libvirt]
>> (2) Prevent auto transitions to NULL state for asynchronous clients [A
>> requirement mentioned by Virtuozzo]
> 
> Okay, your (2) is another case that forbids auto-transitions to NULL.
> What I described above is why it's relevant for libvirt, too.
> 
>> It looks like this, overall:
>>
>> 1. CREATED --> RUNNING
>> 2. RUNNING <--> PAUSED
>> 3. RUNNING --> PENDING
>> 	via: auto transition
>> 	event: BLOCK_JOB_PENDING
>> 4. PENDING --> (COMPLETED | CANCELED)
>> 	via: block-job-finalize
>> 	event: (COMPLETED | ERROR)
>> 5. (COMPLETED | CANCELED) --> (NULL | FINISHED)
>> 	via: auto transition
>> 	event: none
>> 6. FINISHED --> NULL
>> 	via: block-job-reap
>> 	event: none
> 
> Looks reasonable. A bit verbose with two new commands, but given the
> requirements that's probably unavoidable.
> 

Unless I can avoid the actual reap action at the end by returning the
return code synchronously.

>> "Hey, wait, where did the ready state go?"
>>
>> Good question, I'm not sure how it fits in to something like "PENDING"
>> which is, I think NEARLY equivalent to a proposed pending->finalized
>> transition. Is it meaningful to have a job go from
>> running->ready->pending or running->pending->ready? I actually doubt it is.
> 
> I think it is, but only the former. If we leave the PAUSED state aside
> for a moment (as I said above, it's orthogonal) and look at the details,
> mirror works like this:
> 
> 1.  CREATED --> RUNNING
> 2a. RUNNING --> READY | CANCELLED
>         via: auto transition (when bulk copy is finished) / block-job-cancel
>         event: BLOCK_JOB_READY
> 2b. READY --> READY (COMPLETING) | READY (CANCELLING)
>         via: block-job-complete / block-job-cancel
>         event: none
> 3.  READY (CANCELLING) --> CANCELLED
>         via: auto transition (after draining in-flight mirror requests)
>         event: BLOCK_JOB_CANCELLED
>     or
>     READY (COMPLETING) --> COMPLETED
>         via: auto transition (when images are in sync)
>         event: BLOCK_JOB_COMPLETED
> 
> In the new model, we transition to PENDING in step 3 instead.
> 
>> The only difference really is that not all jobs use the READY -->
>> COMPLETE transition.
> 
> The really important difference is that in 2b you have a state that is
> exited via auto transition.
> 
> PENDING is a state that is exited synchronously with block-job-finalize
> (and having this defined point in time where graph changes occur etc. is
> the whole point of the state), whereas READY is a state where
> block-job-complete/cancel can request that it be left at the next
> opportunity, but the exact point in time is unpredictable - it doesn't
> happen during the execution of the QMP command anyway.
> 
> This is a fundamental difference that doesn't allow to treat READY and
> PENDING the same.
> 

I think you're right. That transition from READY isn't as synchronous as
I was making it out to be. Tch.

>> We could implement it into those jobs if the job is
>> created with some kind of boolean, like
>>
>> auto-complete: true/false
>>
>> where this defaults to true, the legacy behavior.
>>
>> For "mirror" we would just omit allowing people to set this setting
>> (auto-complete is effectively always off) because it is requisite and
>> essential to the operation of the job.
> 
> auto-complete=true would basically call block-job-finalize internally?
> 
> You can't conflate it with block-job-complete because READY and PENDING
> have to stay separate, but it would make sense as auto-finalize.
> 

I was conflating it. Or, at least trying to.

>> "OK, maybe that could work; what about transactions?"
>>
>> Transactions have to be a bit of their own case, I think.
>>
>> Essentially jobs that transactionally complete already hang around in
>> pending until all jobs complete, so they can do so together.
>>
>> What we don't really want is to force users to have to dig into the jobs
>> manually and complete each one individually. (I think...?) or have to
>> deal with the managerial nightmare of having some autocomplete, some
>> that don't, etc.
> 
> I'm not sure about that. Don't users already have to send
> block-job-complete to each job individually? Not doing the same for
> block-job-finalize would be kind of inconsistent.
> 

Yes, but that's only theoretical since we don't have support for any of
those kind of jobs in transactions yet, either!

In my head here I was thinking about a transaction-wide finalize to
replace "complete," but you're pointing out I can't mix the two.

That said, there's no reason we couldn't *make* that kind of completion
a transaction-wide, event, but... maybe that's too messy. Maybe
everything should just be left individual...

> I also think that it would be good if a separately started block job
> behaves like a transaction that contains a single job so that we don't
> get different models for the two cases.
> 
>> What I propose for transactions is:
>>
>> 1) Add a new property for transactions also named "auto-complete"
>> 2) If the property is set to false, Jobs in this transaction will have
>> their auto-complete values forcibly set to false
>> 3) Once all jobs in the transaction are set to pending, emit an event
>> ("TRANSACTION_READY", for instance)
>> 4) Allow the transaction to be manually committed.
> 
> This requires that we introduce names for transactions and let them
> be managed explicily by the user. Keeping things at the individual jobs
> certainly makes the interface simpler.
> 

True..

> I can't rule out that we won't want to make transactions explicitly
> managed objects in the future for some reason, but that will probably be
> something separate from the problem we're trying to solve now.
> 
>> The alternative is to leave it on a per-job basis and just stipulate
>> that any bizarre or inconvenient configurations are the fault of the
>> caller. Leaving transactions completely untouched should theoretically
>> work.
> 
> Should be a lot easier. To integrate it into you state machine above:
> 
> 3.  READY (COMPLETING) | READY (CANCELLING) --> DONE
>         via: auto transition (block_job_completed() called; job doesn't
>                               do any work any more)
>         event: BLOCK_JOB_DONE
> 4a. DONE --> PENDING
>         via: auto transition (all jobs in the transaction are DONE)
>         event: BLOCK_JOB_PENDING
> 4b. PENDING --> COMPLETED | CANCELLED
>         via: block-job-finalize
>         event: COMPLETED | ERROR
> 
> The naming clearly leaves a lot to be desired, I'm just running out of
> names that actually make sense... But I hope you can see the mechanism
> that I have in mind.
> 

I think so, "DONE" is the state where it's blocked on the transaction to
finish. "PENDING" is the one where it's blocked on the user to allow it
to move forward and call commit/abort/etc.

>>> 4. On block-job-reap, call the .commit/.abort callbacks of the jobs in
>>>    the transaction. They will do most of the work that is currently done
>>>    in the completion callbacks, in particular any graph changes. If we
>>>    need to allow error cases, we can add a .prepare_completion callback
>>>    that can still let the whole transaction fail.
>>
>> Makes sense by analogy. Probably worth having anyway. I moved some
>> likely-to-deadlock code from the backup cleanup into .commit even when
>> it runs outside of transactions. Other jobs can likely benefit from some
>> simplified assumptions by running in that context, too.
>>
>>> 5. Send the final QMP completion event for each job in the transaction
>>>    with the final error code. This is the existing BLOCK_JOB_COMPLETED
>>>    or BLOCK_JOB_CANCELLED event.
>>>
>>> The current RFC still executes .commit/.abort before block-job-reap, so
>>> the graph changes happen too early to be under control of the management
>>> tool.
>>>
>>>> RFC:
>>>> The next version will add tests for transactions.
>>>> Kevin, can you please take a look at bdrv_is_root_node and how it is
>>>> used with respect to do_drive_backup? I suspect that in this case that
>>>> "is root" should actually be "true", but a node in use by a job has
>>>> two roles; child_root and child_job, so it starts returning false here.
>>>>
>>>> That's fine because we prevent a collision that way, but it makes the
>>>> error messages pretty bad and misleading. Do you have a quick suggestion?
>>>> (Should I just amend the loop to allow non-root nodes as long as they
>>>> happen to be jobs so that the job creation code can check permissions?)
>>>
>>> We kind of sidestepped this problem by deciding that there is no real
>>> reason for the backup job to require the source to be a root node.
>>>
>>> I'm not completely sure how we could easily get a better message while
>>> still requiring a root node (and I suppose there are other places that
>>> rightfully still require a root node). Ignoring children with child_job
>>> feels ugly, but might be the best option.
>>>
>>> Note that this will not make the conflicting command work suddenly,
>>> because every node that has a child_job parent also has op blockers for
>>> everything, but the error message should be less confusing than "is not
>>> a root node".
>>>
>>> Kevin
>>>
>>
>> TLDR:
>>
>> - I think we may need to have optional manual completion steps both
>> before and after the job .prepare()/.commit()/.abort() phase.
>> - Before, like "block-job-complete" to allow graph changes to be under
>> management tool control, and
>> - After, so that final job success status can be queried even if the
>> event was missed.
> 
> Agreed (except that I don't see what "block-job-complete" has to do with
> it, this command is about an earlier transition).
> 
>> Proposal:
>>
>> (1) Extend block-job-complete semantics to all jobs that opt in via
>> "auto-complete: false" which is not allowed to be set for mirror jobs
>> (2) If the modern overloading of the BLOCK_JOB_READY event is apt to
>> cause confusion for existing tools, a new event BLOCK_JOB_PENDING could
>> be emitted instead for any job capable of accepting the
>> auto-complete=true/false parameter and emit it upon reaching this state.
>> (3) Continue forward with this patchset's current persistent/reap
>> nomenclature to prevent automatic cleanup if desired, and
>> (4) Implement transaction-wide settings for auto-complete alongside a
>> new "transaction complete" event to allow for a transaction-wide
>> "complete" command.
> 
> Let me try to just consolidate all of the above into a single state
> machine:
> 
> 1.  CREATED --> RUNNING
>         driver callback: .start
> 2a. RUNNING --> READY | CANCELLED
>         via: auto transition (when bulk copy is finished) / block-job-cancel
>         event: BLOCK_JOB_READY
> 2b. READY --> READY (COMPLETING) | READY (CANCELLING)
>         via: block-job-complete / block-job-cancel
>         event: none
>         driver callback: .complete / none
> 3.  READY (CANCELLING | COMPLETING) --> DONE
>         via: auto transition
>              (CANCELLING: after draining in-flight mirror requests;
>               COMPLETING: when images are in sync)
>         event: BLOCK_JOB_DONE
> 4.  DONE --> PENDING
>         via: auto transition (all jobs in the transaction are DONE)
>         event: BLOCK_JOB_PENDING
> 5.  PENDING --> FINISHED
>         via: block-job-finalize
>         event: COMPLETED | CANCELLED
>         driver callback: .prepare_finalize / .commit / .abort
> 6.  FINISHED --> NULL
>         via: block-job-reap
>         event: none
>         driver callback: .clean
> 
> I removed COMPLETED/CANCELLED states because they are never externally
> visible. You proposed an "auto transition" there, but the transition
> would be immediately after the previous one, so clients always see
> PENDING --> NULL | FINISHED.
> 
> We would have two booleans to make explicit transition automatically:
> 
>     auto-finalize for block-job-finalize (default: true)
>     auto-reap     for block-job-reap     (default: true)
> 
> Both of them would be executed automatically as soon as the respective
> commands would be available.
> 
> We could add more auto-* options for the remaining explicit transition
> (block-job-complete/cancel in READY), but these are not important for
> the problems we're trying to solve here. They might become interesting
> if we do decide that we want a single copy block job instead of doing
> similar things in mirror, commit and backup.
> 
> The naming needs some improvements (done -> pending -> finished looks
> really odd), but does this make sense otherwise?
> 
> Kevin
> 
I think so. We'll see if I understand when I write v3 :)
