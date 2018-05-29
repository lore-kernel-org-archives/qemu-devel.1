Received: from eggs.gnu.org ([2001:4830:134:3::10]:47090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fNeP8-0007gW-5B
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fNeP6-00064R-RE
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:11:10 -0400
Date: Tue, 29 May 2018 15:10:58 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180529131058.GP20558@paraplu>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
	<26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
	<20180524082412.GC4008@localhost.localdomain>
	<1988292d-467a-9c63-e64d-035b0e93348a@redhat.com>
	<20180525080035.GA5562@localhost.localdomain>
	<20180529115907.GA1933@paraplu>
	<e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Tue, May 29, 2018 at 02:30:47PM +0200, Max Reitz wrote:
> On 2018-05-29 13:59, Kashyap Chamarthy wrote:
> > On Fri, May 25, 2018 at 10:00:35AM +0200, Kevin Wolf wrote:

[...]

> >> It can, and it already has its final semantics, so nothing has to ch=
ange
> >> before 3.0. job-cancel is equivalent to block-job-cancel with fixed
> >> force=3Dtrue. If you want the complete-by-cancel behaviour of mirror=
, you
> >> have to use block-job-cancel for now, because job-cancel doesn't pro=
vide
> >> that functionality.
> >=20
> > I think by "complete-by-cancel" you are referring to this[*] magic
> > behaviour, mentioned in the last sentence here:
> >=20
> >     When you cancel an in-progress =E2=80=98mirror=E2=80=99 job befor=
e the source and
> >     target are synchronized, block-job-cancel will emit the event
> >     BLOCK_JOB_CANCELLED. However, note that if you cancel a =E2=80=98=
mirror=E2=80=99 job
> >     after it has indicated (via the event BLOCK_JOB_READY) that the
> >     source and target have reached synchronization, then the event
> >     emitted by block-job-cancel changes to BLOCK_JOB_COMPLETED.
> >=20
> >=20
> > [*] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/live=
-block-operations.rst#l515
> >=20
> >> So what we can change later is adding a way to initiate this seconda=
ry
> >> completion mode with a job-* command (probably with a new option for
> >> job-complete). But we wouldn't change the semantics of exisiting
> >> commands.
> >=20
> > Ah, so if I'm understanding it correctly, the existing subtle magic o=
f
> > "complete-by-cancel" will be rectified by separting the two distinct
> > operations: 'job-cancel' and 'job-complete'.
>=20
> Not really, because we already had those two operations for block jobs.
> The thing is that block-job-complete (and thus job-complete) will pivot
> to the target disk, but block-job-cancel doesn't.

Indeed; from the doc linked earlier: "Issuing the command
``block-job-complete`` (after it emits the event
``BLOCK_JOB_COMPLETED``) will adjust the guest device (i.e. live QEMU)
to point to the target image, [E], causing all the new writes from this
point on to happen there."

> The special behavior is that you can use block-job-cancel after
> BLOCK_JOB_READY to complete the job, but not pivot to it.  I don't thin=
k
> we have a real plan on how to represent that with the generic job
> commands, we just know that we don't want to use job-cancel.

Ah, thanks for clarifying.  Yes, what you say makes sense =E2=80=94  not =
using
'job-cancel' to represent completion.

> (Maybe we can add a flag to job-complete (which to me does not sound
> like a good idea), or you could set flags on jobs while they are
> running, so you can set a do-not-pivot flag on the mirror job before yo=
u
> complete it.)

Yeah, spelling that out, 'do-not-pivot' or something along those lines,
as a flag makes it clearer.  "Implicit is better than explicit".

--=20
/kashyap
