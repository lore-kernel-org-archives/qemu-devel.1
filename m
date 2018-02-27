Received: from eggs.gnu.org ([2001:4830:134:3::10]:59714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqkpn-0006m9-9B
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqkpm-0006tN-5p
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:22:43 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-6-jsnow@redhat.com>
	<fbfc54ab-1aba-97e3-0779-7675133ada71@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7c8f4eec-2f61-6024-15b7-34251d94638f@redhat.com>
Date: Tue, 27 Feb 2018 14:22:35 -0500
MIME-Version: 1.0
In-Reply-To: <fbfc54ab-1aba-97e3-0779-7675133ada71@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 05/21] blockjobs: add state transition
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 01:58 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> The state transition table has mostly been implied. We're about to mak=
e
>> it a bit more complex, so let's make the STM explicit instead.
>>
>> Perform state transitions with a function that for now just asserts th=
e
>> transition is appropriate.
>>
>> Transitions:
>> Undefined -> Created: During job initialization.
>=20
> Unless we use Created as the default state 0 for g_new0().
>=20

I liked the idea of letting jobs be created in an "indeterminate" state
until we actually initialize them to be of use -- that is, jobs that
could be said to semantically understand and act on the "START" verb
(which is, as of today, an internal command only.)

The only meaningful action on a job of indeterminate state, then, would
be to DEFINE that job. (I.e. what block_job_create does.)

What I'm getting at is that block_job_start() on a job that was just
created will explode, and I'd like "created" to mean "This job can be
started."

It's not a distinction that matters in the codebase RIGHT NOW, but
that's how I came to think of the STM. We could likely optimize that
transition out because we always create and immediately define it, but
it felt ... nicer from an (internal) API point of view to have defined
the construction and destruction transitions explicitly.

Anyway, it can be removed; it's not a hill worth dying on. I only insist
that the bike shed not be olive green.

>> Created=C2=A0=C2=A0 -> Running: Once the job is started.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Jobs cannot =
transition from "Created" to "Paused"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 directly, bu=
t will instead synchronously
>> transition
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to running t=
o paused immediately.
>> Running=C2=A0=C2=A0 -> Paused:=C2=A0 Normal workflow for pauses.
>> Running=C2=A0=C2=A0 -> Ready:=C2=A0=C2=A0 Normal workflow for jobs rea=
ching their sync point.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (e.g. mirror=
)
>> Ready=C2=A0=C2=A0=C2=A0=C2=A0 -> Standby: Normal workflow for pausing =
ready jobs.
>> Paused=C2=A0=C2=A0=C2=A0 -> Running: Normal resume.
>> Standby=C2=A0=C2=A0 -> Ready:=C2=A0=C2=A0 Resume of a Standby job.
>>
>>
>> +---------+
>> |UNDEFINED|
>> +--+------+
>> =C2=A0=C2=A0=C2=A0 |
>> +--v----+
>> |CREATED|
>> +--+----+
>> =C2=A0=C2=A0=C2=A0 |
>> +--v----+=C2=A0=C2=A0=C2=A0=C2=A0 +------+
>> |RUNNING<----->PAUSED|
>> +--+----+=C2=A0=C2=A0=C2=A0=C2=A0 +------+
>> =C2=A0=C2=A0=C2=A0 |
>> +--v--+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------+
>> |READY<------->STANDBY|
>> +-----+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------+
>>
>>
>> Notably, there is no state presently defined as of this commit that
>> deals with a job after the "running" or "ready" states, so this table
>> will be adjusted alongside the commits that introduce those states.
>=20
> The ascii-art tables help in this and other patches.=C2=A0 Thanks for
> producing them.
>=20
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 block/trace-events |=C2=A0 3 +++
>> =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42=
 ++++++++++++++++++++++++++++++++++++------
>> =C2=A0 2 files changed, 39 insertions(+), 6 deletions(-)
>>
>=20
>> +static void block_job_state_transition(BlockJob *job, BlockJobStatus =
s1)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BlockJobStatus s0 =3D job->status;
>> +=C2=A0=C2=A0=C2=A0 if (s0 =3D=3D s1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }

If I remove this clause, I actually would have noticed that technically
I attempt to transition from CREATED to CREATED. Maybe I ought to remove
this...

>> +=C2=A0=C2=A0=C2=A0 assert(s1 >=3D 0 && s1 <=3D BLOCK_JOB_STATUS__MAX)=
;
>=20
> Or, if you keep the zero state distinct from valid states, this could b=
e
> 'assert(s1 > 0 && ...)'
>=20
>> @@ -320,7 +349,7 @@ void block_job_start(BlockJob *job)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->pause_count--;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->busy =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->paused =3D false;
>> -=C2=A0=C2=A0=C2=A0 job->status =3D BLOCK_JOB_STATUS_RUNNING;
>> +=C2=A0=C2=A0=C2=A0 block_job_state_transition(job, BLOCK_JOB_STATUS_R=
UNNING);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_coroutine_enter(blk_bs(job->blk), =
job->co);
>> =C2=A0 }
>> =C2=A0 @@ -704,6 +733,7 @@ void *block_job_create(const char *job_id, =
const
>> BlockJobDriver *driver,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->refcnt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->manual=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D (flags & BLOCK_JOB_MANUAL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->status=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D BLOCK_JOB_STATUS_CREATED;
>> +=C2=A0=C2=A0=C2=A0 block_job_state_transition(job, BLOCK_JOB_STATUS_C=
REATED);
>=20
> Oops, missing a deletion of the job->status assignment line.
>=20

I am indeed.
