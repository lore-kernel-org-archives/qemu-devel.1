Received: from eggs.gnu.org ([2001:4830:134:3::10]:49131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eyIIP-00073L-LP
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eyIIO-0006Bv-Ao
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:31:25 -0400
Date: Tue, 20 Mar 2018 14:31:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180320143113.GD24329@stefanha-x1.localdomain>
References: <20180319093509.50881-1-haoqf@linux.vnet.ibm.com>
	<20180319093509.50881-2-haoqf@linux.vnet.ibm.com>
	<CAJSP0QVe4gXCvPdw15x3D_yp2v4mi8QqYujo5qgxyeGcCbGfpw@mail.gmail.com>
	<1cc764c9-7bc1-365e-8af4-fe5357677aed@de.ibm.com>
	<20180320101101.GA4865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20180320101101.GA4865@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1 1/1] iotests: fix test case
 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 11:11:01AM +0100, Kevin Wolf wrote:
> Am 19.03.2018 um 18:53 hat Christian Borntraeger geschrieben:
> >=20
> >=20
> > On 03/19/2018 05:10 PM, Stefan Hajnoczi wrote:
> > > On Mon, Mar 19, 2018 at 9:35 AM, QingFeng Hao <haoqf@linux.vnet.ibm.c=
om> wrote:
> > >> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_=
shutdown()".
> > >> It's because of the newly introduced function vm_shutdown calls bdrv=
_drain_all,
> > >> which is called later by bdrv_close_all. bdrv_drain_all resumes the =
jobs
> > >> that doubles the speed and offset is doubled.
> > >> Some jobs' status are changed as well.
> > >>
> > >> Thus, let's not call bdrv_drain_all in vm_shutdown.
> > >>
> > >> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > >> ---
> > >>  cpus.c | 5 +++--
> > >>  1 file changed, 3 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/cpus.c b/cpus.c
> > >> index 2e6701795b..ae2962508c 100644
> > >> --- a/cpus.c
> > >> +++ b/cpus.c
> > >> @@ -1006,8 +1006,9 @@ static int do_vm_stop(RunState state, bool sen=
d_stop)
> > >>              qapi_event_send_stop(&error_abort);
> > >>          }
> > >>      }
> > >> -
> > >> -    bdrv_drain_all();
> > >> +    if (send_stop) {
> > >> +        bdrv_drain_all();
> > >> +    }
> > >=20
> > > Thanks for looking into this bug!
> > >=20
> > > This if statement breaks the contract of the function when send_stop
> > > is false.  Drain ensures that pending I/O completes and that device
> > > emulation finishes before this function returns.  This is important
> > > for live migration, where there must be no more guest-related activity
> > > after vm_stop().
> > >=20
> > > This patch relies on the caller invoking bdrv_close_all() immediately
> > > after do_vm_stop(), which is not documented and could lead to more
> > > bugs in the future.
> > >=20
> > > I suggest a different solution:
> > >=20
> > > Test 185 relies on internal QEMU behavior which can change from time
> > > to time.  Buffer sizes and block job iteration counts are
> > > implementation details that are not part of qapi-schema.json or other
> > > documented behavior.
> > >=20
> > > In fact, the existing test case was already broken in IOThread mode
> > > since iothread_stop_all() -> bdrv_set_aio_context() also includes a
> > > bdrv_drain() with the side-effect of an extra blockjob iteration.
> > >=20
> > > After 4486e89c219 ("vl: introduce vm_shutdown()") both IOThread and
> > > non-IOThread mode perform the drain.  This has caused the test
> > > failure.
> > >=20
> > > Instead of modifying QEMU to keep the same arbitrary internal behavior
> > > as before, please send a patch that updates tests/qemu-iotests/185.out
> > > with the latest output.
> >=20
> > Wouldnt it be better if the test actually masks out the values the are =
not
> > really part of the "agreed upon" behaviour? Wouldnt block_job_offset fr=
om
> > common.filter be what we want?
>=20
> The test case has the following note:
>=20
> # Note that the reference output intentionally includes the 'offset' fiel=
d in
> # BLOCK_JOB_CANCELLED events for all of the following block jobs. They are
> # predictable and any change in the offsets would hint at a bug in the job
> # throttling code.
>=20
> Now the question is if this particular change is okay rather than
> hinting at a bug and we should update the reference output or whether we
> need to change qemu again.
>=20
> I think the change isn't really bad, but we are doing more useless work
> now than we used to do before, and we're exiting slower because we're
> spawning additional I/O that we have to wait for. So the better state
> was certainly the old one.

Here is the reason for the additional I/O and how it could be
eliminated:

child_job_drained_begin() pauses and child_job_drained_end() resumes the
job.  Resuming the job cancels the timer (if pending) and enters the
blockjob's coroutine.  This is why draining BlockDriverState forces an
extra iteration of the blockjob.

The current behavior is intended for the case where the job has I/O
pending at child_job_drained_begin() time.  When the I/O completes, the
job will see it must pause and it will yield at a pause point.  It makes
sense for child_job_drained_end() to resume the job so it can start I/O
again.

In our case this behavior doesn't make sense though.  The job already
yielded before child_job_drained_begin() and it doesn't need to resume
at child_job_drained_end() time.  We'd prefer to wait for the timer
expiry.

We need to distinguish these two cases to avoid resuming the job in the
latter case.  I think this would be the proper way to avoid unnecessary
blockjob activity across drain.

I favor updating the test output though, because the code change adds
complexity and the practical benefit is not obvious to me.

QingFeng, if you decide to modify blockjobs, please CC Jeffrey Cody
<jcody@redhat.com> and I'd also be happy to review the patch.

Stefan

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJasRsxAAoJEJykq7OBq3PIbboH/RsmLvhIClS7NTyzv5yEvc6x
H3/GS9rUJ0C+NsoJoYFqh8bGknkEASO81yA+uOmdSuhQChGWi3CvAqzRrQNmShh4
c2q6JvHtu3O5yJLMiu2fo9FhoU2r+uvbgmNYfGQJeLfiCatisZrebvB0I9X+hY6e
OpGqEy5PHTkwpN7okAnqoij9wHQ2DhlDPMaORrzXJUm90BO8jWYwcXCDXXUVtX3G
MPR3kKSk/qPySs5J4dvX5hShUn+on192FMaWxXO+ERwZhF96QIVsoNjJs3it9k0b
0Xnh8dNfIcpF+2EtpbmqjENs0aglBEQOm0W8Ee/6W8kWYgAc8t2wZ16Si1iliPg=
=WUat
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
