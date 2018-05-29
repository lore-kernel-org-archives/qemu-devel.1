Received: from eggs.gnu.org ([2001:4830:134:3::10]:55256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fNdHa-0003cs-Ab
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fNdHZ-0007XC-6O
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:59:18 -0400
Date: Tue, 29 May 2018 13:59:07 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180529115907.GA1933@paraplu>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
	<26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
	<20180524082412.GC4008@localhost.localdomain>
	<1988292d-467a-9c63-e64d-035b0e93348a@redhat.com>
	<20180525080035.GA5562@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180525080035.GA5562@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Fri, May 25, 2018 at 10:00:35AM +0200, Kevin Wolf wrote:
> Am 24.05.2018 um 19:42 hat John Snow geschrieben:

[...]

(Randomly chiming in for a small clarification.)

> > >> or some other mechanism that accomplishes the same type of behavio=
r. It
> > >> would be nice if it did not have to be determined at job creation =
time
> > >> but instead could be determined later.
> > >=20
> > > I agree. We already made sure that job-cancel really means cancel o=
n the
> > > QAPI level, so we're free to do that. We just need to keep supporti=
ng
> > > block-job-cancel with the old semantics, so what I have is the easy
> > > conversion. We can change the internal implementation when we actua=
lly
> > > implement the selection of a completion mode.
> > >=20
> > > Kevin
> > >=20
> >=20
> > We need this before 3.0 though, yeah? unless we make job-cancel
> > x-job-cancel or some other warning that the way it works might change=
, yeah?
> >=20
> > Or do I misunderstand our leeway to change this at a later point in t=
ime?
> >=20
> > (can job-cancel apply to block jobs created with the legacy
> > infrastructure? My reading was "yes.")
>=20
> It can, and it already has its final semantics, so nothing has to chang=
e
> before 3.0. job-cancel is equivalent to block-job-cancel with fixed
> force=3Dtrue. If you want the complete-by-cancel behaviour of mirror, y=
ou
> have to use block-job-cancel for now, because job-cancel doesn't provid=
e
> that functionality.

I think by "complete-by-cancel" you are referring to this[*] magic
behaviour, mentioned in the last sentence here:

    When you cancel an in-progress =E2=80=98mirror=E2=80=99 job before th=
e source and
    target are synchronized, block-job-cancel will emit the event
    BLOCK_JOB_CANCELLED. However, note that if you cancel a =E2=80=98mirr=
or=E2=80=99 job
    after it has indicated (via the event BLOCK_JOB_READY) that the
    source and target have reached synchronization, then the event
    emitted by block-job-cancel changes to BLOCK_JOB_COMPLETED.


[*] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/live-blo=
ck-operations.rst#l515

> So what we can change later is adding a way to initiate this secondary
> completion mode with a job-* command (probably with a new option for
> job-complete). But we wouldn't change the semantics of exisiting
> commands.

Ah, so if I'm understanding it correctly, the existing subtle magic of
"complete-by-cancel" will be rectified by separting the two distinct
operations: 'job-cancel' and 'job-complete'.


--=20
/kashyap
