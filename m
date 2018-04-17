Received: from eggs.gnu.org ([2001:4830:134:3::10]:45095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f8Tu4-0005tN-9a
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f8Tu2-0008Pr-RM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:56:24 -0400
References: <20180310082746.24198-1-jsnow@redhat.com>
	<87zi22c5i0.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <e06b144e-9676-0b08-d6e9-35101a7cef84@redhat.com>
Date: Tue, 17 Apr 2018 12:56:16 -0400
MIME-Version: 1.0
In-Reply-To: <87zi22c5i0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/21] blockjobs: add explicit job
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 04/17/2018 09:44 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> This series seeks to address two distinct but closely related issues
>> concerning the job management API.
>>
>> (1) For jobs that complete when a monitor is not attached and receiving
>>     events or notifications, there's no way to discern the job's final
>>     return code. Jobs must remain in the query list until dismissed
>>     for reliable management.
>>
>> (2) Jobs that change the block graph structure at an indeterminate point
>>     after the job starts compete with the management layer that relies
>>     on that graph structure to issue meaningful commands.
>>
>>     This structure should change only at the behest of the management
>>     API, and not asynchronously at unknown points in time. Before a job
>>     issues such changes, it must rely on explicit and synchronous
>>     confirmation from the management API.
>>
>> These changes are implemented by formalizing a State Transition Machine
>> for the BlockJob subsystem.
>>
>> Job States:
>>
>> UNDEFINED       Default state. Internal state only.
>> CREATED         Job has been created
>> RUNNING         Job has been started and is running
>> PAUSED          Job is not ready and has been paused
>> READY           Job is ready and is running
>> STANDBY         Job is ready and is paused
>>
>> WAITING         Job is waiting on peers in transaction
>> PENDING         Job is waiting on ACK from QMP
>> ABORTING        Job is aborting or has been cancelled
>> CONCLUDED       Job has finished and has a retcode available
>> NULL            Job is being dismantled. Internal state only.
>>
>> Job Verbs:
>>

Backporting your quote up here:

> For each job verb and job state: what's the new job state?
>

That's not always 1:1, though I tried to address it in the commit messages.


>> CANCEL          Instructs a running job to terminate with error,
>>                 (Except when that job is READY, which produces no error.)

CANCEL will take a job to either NULL... (this is the early abort
pathway, prior to the job being fully realized.)

...or to ABORTING (from CREATED once it has fully realized the job, or
from RUNNING, READY, WAITING, or PENDING.)

>> PAUSE           Request a job to pause.

issued to RUNNING or READY, transitions to PAUSED or STANDBY respectively.

>> RESUME          Request a job to resume from a pause.

issued to PAUSED or STANDBY, transitions to RUNNING or READY respectively.

>> SET-SPEED       Change the speed limiting parameter of a job.

No run state change.

>> COMPLETE        Ask a READY job to finish and exit.
>>

Issued to a READY job, transitions to WAITING.

>> FINALIZE        Ask a PENDING job to perform its graph finalization.

Issued to a PENDING job, transitions to CONCLUDED.

>> DISMISS         Finish cleaning up an empty job.
> 

Issued to a CONCLUDED job, transitions to NULL.


>> And here's my stab at a diagram:
>>
>>                  +---------+
>>                  |UNDEFINED|
>>                  +--+------+
>>                     |
>>                  +--v----+
>>        +---------+CREATED+-----------------+
>>        |         +--+----+                 |
>>        |            |                      |
>>        |         +--+----+     +------+    |
>>        +---------+RUNNING<----->PAUSED|    |
>>        |         +--+-+--+     +------+    |
>>        |            | |                    |
>>        |            | +------------------+ |
>>        |            |                    | |
>>        |         +--v--+       +-------+ | |
>>        +---------+READY<------->STANDBY| | |
>>        |         +--+--+       +-------+ | |
>>        |            |                    | |
>>        |         +--v----+               | |
>>        +---------+WAITING<---------------+ |
>>        |         +--+----+                 |
>>        |            |                      |
>>        |         +--v----+                 |
>>        +---------+PENDING|                 |
>>        |         +--+----+                 |
>>        |            |                      |
>>     +--v-----+   +--v------+               |
>>     |ABORTING+--->CONCLUDED|               |
>>     +--------+   +--+------+               |
>>                     |                      |
>>                  +--v-+                    |
>>                  |NULL<--------------------+
>>                  +----+
> 
> Is this diagram missing a few arrowheads?  E.g. on the edge between
> RUNNING and WAITING.
> 

Apparently yes. :\

(Secretly fixed up in my reply.)

> Might push the limits of ASCII art, but here goes anyway: can we label
> the arrows with job verbs?
> 

Can you recommend a tool to help me do that? I've been using asciiflow
infinity (http://asciiflow.com) and it's not very good, but I don't have
anything better.

> Can you briefly explain how this state machine addresses (1) and (2)?
> 

(1) The CONCLUDED state allows jobs to persist in the job query list
after they would have disappeared in 2.11-era QEMU. This lets us query
for completion codes and to dismiss the job at our own leisure.

(2) The PENDING state allows jobs to wait in a nearly-completed state,
pending authorization from the QMP client to make graph changes.
Otherwise, the job has to asynchronously perform this cleanup and the
exact point in time is unknowable to the QMP client. By making a PENDING
state and a finalize callback (.prepare), we can make this portion of a
job's task synchronous.



"John, you added more than two states..."

Yup, this was to help simplify the existing state machine, believe it or
not. I modeled all jobs as transactions to eliminate different cleanup
routing and added two new interim states;

- WAITING
- ABORTING

to help make assertions about the valid transitions jobs can make. The
ABORTING state helps make it clear when a job is allowed to fail (and
emit QMP events related to such).

The WAITING state is simply advisory to help a client know that a job is
"finished" but cannot yet receive further instruction because of peers
in a transaction. This helps me to add nice QMP errors for any verbs
issued to such jobs. "Sorry pal, this job is waiting and can't hear you
right now!"

This kept the code cleaner than adding a bunch of very fragile boolean
error-checking pathways in dozens of helper functions to help avoid
illegal instructions on jobs not prepared to receive those instructions.

So these two new states don't help accomplish (1) or (2) strictly, but
they do facilitate the code additions that _do_ a lot less ugly.

--js
