Received: from eggs.gnu.org ([2001:4830:134:3::10]:40199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4aQ-0003ao-W2
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4aN-0008JE-0V
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:48:27 -0500
Date: Wed, 13 Dec 2017 10:48:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213104819.GG16782@stefanha-x1.localdomain>
References: <20171211234609.30497-1-jsnow@redhat.com>
	<20171212000824.GE20604@localhost.localdomain>
	<75812f29-9d2e-9a68-8eee-5b020c0990f6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <75812f29-9d2e-9a68-8eee-5b020c0990f6@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: kick jobs on
 set-speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 01:22:28PM -0500, John Snow wrote:
>=20
>=20
> On 12/11/2017 07:08 PM, Jeff Cody wrote:
> > On Mon, Dec 11, 2017 at 06:46:09PM -0500, John Snow wrote:
> >> If users set an unreasonably low speed (like one byte per second), the
> >> calculated delay may exceed many hours. While we like to punish users
> >> for asking for stupid things, we do also like to allow users to correct
> >> their wicked ways.
> >>
> >> When a user provides a new speed, kick the job to allow it to recalcul=
ate
> >> its delay.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  blockjob.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/blockjob.c b/blockjob.c
> >> index 715c2c2680..43f01ad190 100644
> >> --- a/blockjob.c
> >> +++ b/blockjob.c
> >> @@ -483,6 +483,7 @@ static void block_job_completed_txn_success(BlockJ=
ob *job)
> >>  void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
> >>  {
> >>      Error *local_err =3D NULL;
> >> +    int64_t old_speed =3D job->speed;
> >> =20
> >>      if (!job->driver->set_speed) {
> >>          error_setg(errp, QERR_UNSUPPORTED);
> >> @@ -495,6 +496,10 @@ void block_job_set_speed(BlockJob *job, int64_t s=
peed, Error **errp)
> >>      }
> >> =20
> >>      job->speed =3D speed;
> >> +    /* Kick the job to recompute its delay */
> >> +    if ((speed > old_speed) && timer_pending(&job->sleep_timer)) {
> >=20
> > job->sleep_timer is protected by block_job_mutex (via
> > block_job_lock/unlock); is it safe for us to check it here outside the
> > mutex?
> >=20
>=20
> My hunch is that in this specific case that it is; but only because of
> assumptions about holding the aio_context and the QEMU global mutex here.
>=20
> > But in any case, I think we could get rid of the timer_pending check, a=
nd
> > just always kick the job if we have a speed increase.  block_job_enter()
> > should do the right thing (mutex protected check on job->busy and
> > job->sleep_timer).
> >=20
>=20
> I could lock it for inarguable correctness; I just didn't want to kick a
> job that didn't actually require any kicking to limit any potential
> problems from that interaction.
>=20
> (I'm fond of the extra conditional because I feel like it makes the
> intent of the kick explicit.)
>=20
> I can remove it.

Removing the conditional would introduce a bug.  block_job_enter() will
unpause the job.

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMQVzAAoJEJykq7OBq3PIs1kH/2WQdR/2f9dTnc8UQ94sXqrL
RdQtgA4tzYuI8ek3a/h1ygqlTCa7H/F8QG8Pl2sZmoZRqiKPB113OeUrOb6Vq4br
wTH1i9Ycee6A7K+iRFmzbsQEUv72qaHWjX/QIRdc4nHIs0jrORZCZ3hTucTZlPly
vdkRbwzSFNMCLBKIpbiIEJpVDLk3kjP62oaQcEEjXP56ERBmd6/SvidOx+qLYP5z
t3B04kOw+nhI1xYG5qFZ1GCMn/tucdO0EOxQ2x4+mXG+rkiOOZCIfZerJiwCX4Sq
dln9/tF/7DHwxDeRkBmDGSNAJy+p53SEGmMW/ka31Zc+EyeBJk6jGGlV/ELfrO0=
=u+sm
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
