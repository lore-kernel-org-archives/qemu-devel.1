Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8QuI-0003ot-PP
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8QuH-0006hD-Qg
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:44:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180310082746.24198-1-jsnow@redhat.com>
Date: Tue, 17 Apr 2018 15:44:07 +0200
In-Reply-To: <20180310082746.24198-1-jsnow@redhat.com> (John Snow's message of
	"Sat, 10 Mar 2018 03:27:25 -0500")
Message-ID: <87zi22c5i0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

John Snow <jsnow@redhat.com> writes:

> This series seeks to address two distinct but closely related issues
> concerning the job management API.
>
> (1) For jobs that complete when a monitor is not attached and receiving
>     events or notifications, there's no way to discern the job's final
>     return code. Jobs must remain in the query list until dismissed
>     for reliable management.
>
> (2) Jobs that change the block graph structure at an indeterminate point
>     after the job starts compete with the management layer that relies
>     on that graph structure to issue meaningful commands.
>
>     This structure should change only at the behest of the management
>     API, and not asynchronously at unknown points in time. Before a job
>     issues such changes, it must rely on explicit and synchronous
>     confirmation from the management API.
>
> These changes are implemented by formalizing a State Transition Machine
> for the BlockJob subsystem.
>
> Job States:
>
> UNDEFINED       Default state. Internal state only.
> CREATED         Job has been created
> RUNNING         Job has been started and is running
> PAUSED          Job is not ready and has been paused
> READY           Job is ready and is running
> STANDBY         Job is ready and is paused
>
> WAITING         Job is waiting on peers in transaction
> PENDING         Job is waiting on ACK from QMP
> ABORTING        Job is aborting or has been cancelled
> CONCLUDED       Job has finished and has a retcode available
> NULL            Job is being dismantled. Internal state only.
>
> Job Verbs:
>
> CANCEL          Instructs a running job to terminate with error,
>                 (Except when that job is READY, which produces no error.)
> PAUSE           Request a job to pause.
> RESUME          Request a job to resume from a pause.
> SET-SPEED       Change the speed limiting parameter of a job.
> COMPLETE        Ask a READY job to finish and exit.
>
> FINALIZE        Ask a PENDING job to perform its graph finalization.
> DISMISS         Finish cleaning up an empty job.

For each job verb and job state: what's the new job state?

> And here's my stab at a diagram:
>
>                  +---------+
>                  |UNDEFINED|
>                  +--+------+
>                     |
>                  +--v----+
>        +---------+CREATED+-----------------+
>        |         +--+----+                 |
>        |            |                      |
>        |         +--+----+     +------+    |
>        +---------+RUNNING<----->PAUSED|    |
>        |         +--+-+--+     +------+    |
>        |            | |                    |
>        |            | +------------------+ |
>        |            |                    | |
>        |         +--v--+       +-------+ | |
>        +---------+READY<------->STANDBY| | |
>        |         +--+--+       +-------+ | |
>        |            |                    | |
>        |         +--v----+               | |
>        +---------+WAITING+---------------+ |
>        |         +--+----+                 |
>        |            |                      |
>        |         +--v----+                 |
>        +---------+PENDING|                 |
>        |         +--+----+                 |
>        |            |                      |
>     +--v-----+   +--v------+               |
>     |ABORTING+--->CONCLUDED|               |
>     +--------+   +--+------+               |
>                     |                      |
>                  +--v-+                    |
>                  |NULL+--------------------+
>                  +----+

Is this diagram missing a few arrowheads?  E.g. on the edge between
RUNNING and WAITING.

Might push the limits of ASCII art, but here goes anyway: can we label
the arrows with job verbs?

Can you briefly explain how this state machine addresses (1) and (2)?
