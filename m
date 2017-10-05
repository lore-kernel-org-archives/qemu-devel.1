Received: from eggs.gnu.org ([2001:4830:134:3::10]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzvFP-0006H4-9s
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 21:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzvFN-0003QY-I8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 21:46:47 -0400
References: <20171004015205.20724-1-jsnow@redhat.com>
	<20171004182732.GE9801@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <7fd66217-8eda-8de2-f34f-148f69f9df4d@redhat.com>
Date: Wed, 4 Oct 2017 21:46:24 -0400
MIME-Version: 1.0
In-Reply-To: <20171004182732.GE9801@localhost.localdomain>
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
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

"Oh boy, another email from John! I bet it's concisely worded."

Ha ha. I see my reputation precedes me.

"Holy crap dude, that's a lot of words you've typed down there!"

It's okay, skip to the "TLDR" for the conclusion I arrived at if you
don't care how I got there!

"Sigh, okay, John."

Yes!!

On 10/04/2017 02:27 PM, Kevin Wolf wrote:
> Am 04.10.2017 um 03:52 hat John Snow geschrieben:
>> For jobs that complete when a monitor isn't looking, there's no way to
>> tell what the job's final return code was. We need to allow jobs to
>> remain in the list until queried for reliable management.
> 
> Just a short summary of what I discussed with John on IRC:
> 
> Another important reason why we want to have an explicit end of block
> jobs is that job completion often makes changes to the graph. For a
> management tool that manages the block graph on a node level, it is a
> big problem if graph changes can happen at any point that can lead to
> bad race conditions. Giving the management tool control over the end of
> the block job makes it aware that graph changes happen.
> 
> This means that compared to this RFC series, we need to move the waiting
> earlier in the process:
> 
> 1. Block job is done and calls block_job_completed()
> 2. Wait for other block jobs in the same job transaction to complete
> 3. Send a (new) QMP event to the management tool to notify it that the
>    job is ready to be reaped

Oh, I suppose to distinguish it from "COMPLETED" in that sense, because
it isn't actually COMPLETED anymore under your vision, so it requires a
new event in this proposal.

This becomes a bit messy, bumping up against both "READY" and a
transactional pre-completed state semantically. Uhhhh, for lack of a
better word in the timeframe I'd like to complete this email in, let's
call this new theoretical state "PENDING"?

So presently, a job goes through the following life cycle:

1. CREATED --> RUNNING
2. RUNNING <--> PAUSED
3. RUNNING --> (READY | COMPLETED | CANCELED)
4. READY --> (COMPLETED | CANCELED)
5. (COMPLETED | CANCELED) --> NULL

Where we emit an event upon entering "READY", "COMPLETED" or "CANCELED".

My patchset here effectively adds a new optional terminal state:

5. (COMPLETED | CANCELED) --> (NULL | FINISHED)
6. FINISHED --> NULL

Where the last transition from FINISHED to NULL is performed via
block-job-reap, but notably we get to re-use the events for COMPLETED |
CANCELED to indicate the availability of this operation to be performed.

What happens in the case of transactionally managed jobs presently is
that jobs get stuck as they enter the COMPLETED|CANCELED state. If you
were to query them they behave as if they're RUNNING. There's no
discrete state that exists for this presently.

You can cancel these as normal, but I'm not sure if you can pause them,
actually. (Note to self, test that.) I think they have almost exactly
like any RUNNING job would.

What you're proposing here is the formalization of the pre-completion
state ("PENDING") and that in this state, a job outside of a transaction
can exist until it is manually told to finally, once and for all,
actually finish its business. We can use this as a hook to perform and
last graph changes so they will not come as a surprise to the management
application. Maybe this operation should be called "Finalize". Again,
for lack of a better term in the timeframe, I'll refer to it as such for
now.

I think importantly this actually distinguishes it from "reap" in that
the commit phase can still fail, so we can't let the job follow that
auto transition back to the NULL state. That means that we'd need both a
block-job-finalize AND a block-job-reap to accomplish both of the
following goals:

(1) Allow the management application to control graph changes [libvirt]
(2) Prevent auto transitions to NULL state for asynchronous clients [A
requirement mentioned by Virtuozzo]

It looks like this, overall:

1. CREATED --> RUNNING
2. RUNNING <--> PAUSED
3. RUNNING --> PENDING
	via: auto transition
	event: BLOCK_JOB_PENDING
4. PENDING --> (COMPLETED | CANCELED)
	via: block-job-finalize
	event: (COMPLETED | ERROR)
5. (COMPLETED | CANCELED) --> (NULL | FINISHED)
	via: auto transition
	event: none
6. FINISHED --> NULL
	via: block-job-reap
	event: none

"Hey, wait, where did the ready state go?"

Good question, I'm not sure how it fits in to something like "PENDING"
which is, I think NEARLY equivalent to a proposed pending->finalized
transition. Is it meaningful to have a job go from
running->ready->pending or running->pending->ready? I actually doubt it is.

The only difference really is that not all jobs use the READY -->
COMPLETE transition. We could implement it into those jobs if the job is
created with some kind of boolean, like

auto-complete: true/false

where this defaults to true, the legacy behavior.

For "mirror" we would just omit allowing people to set this setting
(auto-complete is effectively always off) because it is requisite and
essential to the operation of the job.

"OK, maybe that could work; what about transactions?"

Transactions have to be a bit of their own case, I think.

Essentially jobs that transactionally complete already hang around in
pending until all jobs complete, so they can do so together.

What we don't really want is to force users to have to dig into the jobs
manually and complete each one individually. (I think...?) or have to
deal with the managerial nightmare of having some autocomplete, some
that don't, etc.

What I propose for transactions is:

1) Add a new property for transactions also named "auto-complete"
2) If the property is set to false, Jobs in this transaction will have
their auto-complete values forcibly set to false
3) Once all jobs in the transaction are set to pending, emit an event
("TRANSACTION_READY", for instance)
4) Allow the transaction to be manually committed.

The alternative is to leave it on a per-job basis and just stipulate
that any bizarre or inconvenient configurations are the fault of the
caller. Leaving transactions completely untouched should theoretically work.

> 4. On block-job-reap, call the .commit/.abort callbacks of the jobs in
>    the transaction. They will do most of the work that is currently done
>    in the completion callbacks, in particular any graph changes. If we
>    need to allow error cases, we can add a .prepare_completion callback
>    that can still let the whole transaction fail.

Makes sense by analogy. Probably worth having anyway. I moved some
likely-to-deadlock code from the backup cleanup into .commit even when
it runs outside of transactions. Other jobs can likely benefit from some
simplified assumptions by running in that context, too.

> 5. Send the final QMP completion event for each job in the transaction
>    with the final error code. This is the existing BLOCK_JOB_COMPLETED
>    or BLOCK_JOB_CANCELLED event.
> 
> The current RFC still executes .commit/.abort before block-job-reap, so
> the graph changes happen too early to be under control of the management
> tool.
> 
>> RFC:
>> The next version will add tests for transactions.
>> Kevin, can you please take a look at bdrv_is_root_node and how it is
>> used with respect to do_drive_backup? I suspect that in this case that
>> "is root" should actually be "true", but a node in use by a job has
>> two roles; child_root and child_job, so it starts returning false here.
>>
>> That's fine because we prevent a collision that way, but it makes the
>> error messages pretty bad and misleading. Do you have a quick suggestion?
>> (Should I just amend the loop to allow non-root nodes as long as they
>> happen to be jobs so that the job creation code can check permissions?)
> 
> We kind of sidestepped this problem by deciding that there is no real
> reason for the backup job to require the source to be a root node.
> 
> I'm not completely sure how we could easily get a better message while
> still requiring a root node (and I suppose there are other places that
> rightfully still require a root node). Ignoring children with child_job
> feels ugly, but might be the best option.
> 
> Note that this will not make the conflicting command work suddenly,
> because every node that has a child_job parent also has op blockers for
> everything, but the error message should be less confusing than "is not
> a root node".
> 
> Kevin
> 

TLDR:

- I think we may need to have optional manual completion steps both
before and after the job .prepare()/.commit()/.abort() phase.
- Before, like "block-job-complete" to allow graph changes to be under
management tool control, and
- After, so that final job success status can be queried even if the
event was missed.

Proposal:

(1) Extend block-job-complete semantics to all jobs that opt in via
"auto-complete: false" which is not allowed to be set for mirror jobs
(2) If the modern overloading of the BLOCK_JOB_READY event is apt to
cause confusion for existing tools, a new event BLOCK_JOB_PENDING could
be emitted instead for any job capable of accepting the
auto-complete=true/false parameter and emit it upon reaching this state.
(3) Continue forward with this patchset's current persistent/reap
nomenclature to prevent automatic cleanup if desired, and
(4) Implement transaction-wide settings for auto-complete alongside a
new "transaction complete" event to allow for a transaction-wide
"complete" command.

Hopefully that's not too braindead.

--js
