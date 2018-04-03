Received: from eggs.gnu.org ([2001:4830:134:3::10]:41031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3Mnd-0006cu-PH
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3Mnc-0006N8-P0
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:20:37 -0400
Date: Tue, 3 Apr 2018 15:20:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180403142026.GG4467@stefanha-x1.localdomain>
References: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
	<20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QUtM4HrvTDgK_u8hDSSy4KaeCjskDdM7-AZjShd50Qw5g@mail.gmail.com>
	<57467bb4-9143-2239-87a2-4bada0e1719d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <57467bb4-9143-2239-87a2-4bada0e1719d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Jeff Cody <jcody@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 11:32:00AM +0800, QingFeng Hao wrote:
>=20
> =E5=9C=A8 2018/3/23 18:04, Stefan Hajnoczi =E5=86=99=E9=81=93:
> > On Fri, Mar 23, 2018 at 3:43 AM, QingFeng Hao <haoqf@linux.vnet.ibm.com=
> wrote:
> > > Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_s=
hutdown()".
> > > It's because of the newly introduced function vm_shutdown calls bdrv_=
drain_all,
> > > which is called later by bdrv_close_all. bdrv_drain_all resumes the j=
obs
> > > that doubles the speed and offset is doubled.
> > > Some jobs' status are changed as well.
> > >=20
> > > The fix is to not resume the jobs that are already yielded and also c=
hange
> > > 185.out accordingly.
> > >=20
> > > Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> > > Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > > ---
> > >   blockjob.c                 | 10 +++++++++-
> > >   include/block/blockjob.h   |  5 +++++
> > >   tests/qemu-iotests/185.out | 11 +++++++++--
> >=20
> > If drain no longer forces the block job to iterate, shouldn't the test
> > output remain the same?  (The means the test is fixed by the QEMU
> > patch.)
> >=20
> > >   3 files changed, 23 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/blockjob.c b/blockjob.c
> > > index ef3ed69ff1..fa9838ac97 100644
> > > --- a/blockjob.c
> > > +++ b/blockjob.c
> > > @@ -206,11 +206,16 @@ void block_job_txn_add_job(BlockJobTxn *txn, Bl=
ockJob *job)
> > >=20
> > >   static void block_job_pause(BlockJob *job)
> > >   {
> > > -    job->pause_count++;
> > > +    if (!job->yielded) {
> > > +        job->pause_count++;
> > > +    }
> >=20
> > The pause cannot be ignored.  This change introduces a bug.
> >=20
> > Pause is not a synchronous operation that stops the job immediately.
> > Pause just remembers that the job needs to be paused.   When the job
> > runs again (e.g. timer callback, fd handler) it eventually reaches
> > block_job_pause_point() where it really pauses.
> >=20
> > The bug in this patch is:
> >=20
> > 1. The job has a timer pending.
> > 2. block_job_pause() is called during drain.
> > 3. The timer fires during drain but now the job doesn't know it needs
> > to pause, so it continues running!
> >=20
> > Instead what needs to happen is that block_job_pause() remains
> > unmodified but block_job_resume if extended:
> >=20
> > static void block_job_resume(BlockJob *job)
> > {
> >      assert(job->pause_count > 0);
> >      job->pause_count--;
> >      if (job->pause_count) {
> >          return;
> >      }
> > +    if (job_yielded_before_pause_and_is_still_yielded) {
> Thanks a lot for your great comments! But I can't figure out how to check
> this.
> >      block_job_enter(job);
> > +    }
> > }
> >=20
> > This handles the case I mentioned above, where the yield ends before
> > pause ends (therefore resume must enter the job!).
> >=20
> > To make this a little clearer, there are two cases to consider:
> >=20
> > Case 1:
> > 1. Job yields
> > 2. Pause
> > 3. Job is entered from timer/fd callback
> How do I know that if job is entered from ...? thanks

Sorry, in order to answer your question properly I would have to study
the code and get the point where I could write the patch myself.

I have sent a patch to update the test output for the upcoming QEMU 2.12
release.  At this time in the release cycle it's the most appropriate
solution.

Stefan

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaw42qAAoJEJykq7OBq3PIF1sH/1t1TzUCIHOqRciax2D+vtEw
xkuHxPR+fjl+MlRcFdP3Zj1+/zP79tTZomHVrsbVuYqvnFIUAIZSjMZCgzmy217q
7gPWrLTazibRQVPt01CIU5X4u3b6pBe37nhD9Jn+IGFtthexYwq4z59S8sxIIk/L
AQ+TpfCsBpL4xiJ9Y6PbNzXlaU75yEdYb8UjAjm/vxSGrEE5+bna6ZEmo7pQMJtC
vgTTf3/MarEcYgBw8IvaLfIuS4GW+fgGXKLIREzJXvdLP2CcL/zUB+dTmm/p2lJj
CQ4XASf3XCNzTDssbxHxMdslqG8J5cA/2hiodt5NxeX6W7yOBx2YYOqEEiJMPDM=
=4XvK
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
