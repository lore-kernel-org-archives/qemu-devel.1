Received: from eggs.gnu.org ([2001:4830:134:3::10]:49492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fO826-0001Gl-2k
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fO7pc-0004S2-JP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:36:45 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
	<26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
	<20180524082412.GC4008@localhost.localdomain>
	<1988292d-467a-9c63-e64d-035b0e93348a@redhat.com>
	<20180525080035.GA5562@localhost.localdomain>
	<20180529115907.GA1933@paraplu>
	<e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <86c49bf8-58c2-6b05-34ac-7479f123089d@redhat.com>
Date: Wed, 30 May 2018 16:33:40 -0400
MIME-Version: 1.0
In-Reply-To: <e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 21/40] job: Convert
 block_job_cancel_async() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com



On 05/29/2018 08:30 AM, Max Reitz wrote:
> On 2018-05-29 13:59, Kashyap Chamarthy wrote:
>> On Fri, May 25, 2018 at 10:00:35AM +0200, Kevin Wolf wrote:
>>> Am 24.05.2018 um 19:42 hat John Snow geschrieben:
>>
>> [...]
>>
>> (Randomly chiming in for a small clarification.)
>>
>>>>>> or some other mechanism that accomplishes the same type of behavio=
r. It
>>>>>> would be nice if it did not have to be determined at job creation =
time
>>>>>> but instead could be determined later.
>>>>>
>>>>> I agree. We already made sure that job-cancel really means cancel o=
n the
>>>>> QAPI level, so we're free to do that. We just need to keep supporti=
ng
>>>>> block-job-cancel with the old semantics, so what I have is the easy
>>>>> conversion. We can change the internal implementation when we actua=
lly
>>>>> implement the selection of a completion mode.
>>>>>
>>>>> Kevin
>>>>>
>>>>
>>>> We need this before 3.0 though, yeah? unless we make job-cancel
>>>> x-job-cancel or some other warning that the way it works might chang=
e, yeah?
>>>>
>>>> Or do I misunderstand our leeway to change this at a later point in =
time?
>>>>
>>>> (can job-cancel apply to block jobs created with the legacy
>>>> infrastructure? My reading was "yes.")
>>>
>>> It can, and it already has its final semantics, so nothing has to cha=
nge
>>> before 3.0. job-cancel is equivalent to block-job-cancel with fixed
>>> force=3Dtrue. If you want the complete-by-cancel behaviour of mirror,=
 you
>>> have to use block-job-cancel for now, because job-cancel doesn't prov=
ide
>>> that functionality.
>>
>> I think by "complete-by-cancel" you are referring to this[*] magic
>> behaviour, mentioned in the last sentence here:
>>
>>     When you cancel an in-progress =E2=80=98mirror=E2=80=99 job before=
 the source and
>>     target are synchronized, block-job-cancel will emit the event
>>     BLOCK_JOB_CANCELLED. However, note that if you cancel a =E2=80=98m=
irror=E2=80=99 job
>>     after it has indicated (via the event BLOCK_JOB_READY) that the
>>     source and target have reached synchronization, then the event
>>     emitted by block-job-cancel changes to BLOCK_JOB_COMPLETED.
>>
>>
>> [*] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/live-=
block-operations.rst#l515
>>
>>> So what we can change later is adding a way to initiate this secondar=
y
>>> completion mode with a job-* command (probably with a new option for
>>> job-complete). But we wouldn't change the semantics of exisiting
>>> commands.
>>
>> Ah, so if I'm understanding it correctly, the existing subtle magic of
>> "complete-by-cancel" will be rectified by separting the two distinct
>> operations: 'job-cancel' and 'job-complete'.
>=20
> Not really, because we already had those two operations for block jobs.
> The thing is that block-job-complete (and thus job-complete) will pivot
> to the target disk, but block-job-cancel doesn't.
>=20
> The special behavior is that you can use block-job-cancel after
> BLOCK_JOB_READY to complete the job, but not pivot to it.  I don't thin=
k
> we have a real plan on how to represent that with the generic job
> commands, we just know that we don't want to use job-cancel.
>=20
> (Maybe we can add a flag to job-complete (which to me does not sound
> like a good idea), or you could set flags on jobs while they are
> running, so you can set a do-not-pivot flag on the mirror job before yo=
u
> complete it.)
>=20
> Max
>=20

Adding the completion-mode as a "setting" to the job has always been my
favorite way. Whether you set this setting at creation time or later
during runtime is not important.

When we issue job-complete, the job knows based on its own settings the
way it should do so, if there are multiple possibilities.

I only mentioned it as a flag to complete ... err, just in case it was
easier that way somehow. *shrug*.
