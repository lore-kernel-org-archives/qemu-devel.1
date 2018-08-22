Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRXz-000564-GC
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRXy-0000pw-DU
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:43:35 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Date: Wed, 22 Aug 2018 13:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="roRUfIzqUmcseX92vTH6dcluYV2olKzzt"
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--roRUfIzqUmcseX92vTH6dcluYV2olKzzt
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Subject: Re: [PATCH 3/7] jobs: add exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-4-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> All jobs do the same thing when they leave their running loop:
> - Store the return code in a structure
> - wait to receive this structure in the main thread
> - signal job completion via job_completed
>=20
> Few jobs do anything beyond exactly this. Consolidate this exit
> logic for a net reduction in SLOC.
>=20
> More seriously, when we utilize job_defer_to_main_loop_bh to call
> a function that calls job_completed, job_finalize_single will run
> in a context where it has recursively taken the aio_context lock,
> which can cause hangs if it puts down a reference that causes a flush.
>=20
> You can observe this in practice by looking at mirror_exit's careful
> placement of job_completed and bdrv_unref calls.
>=20
> If we centralize job exiting, we can signal job completion from outside=

> of the aio_context, which should allow for job cleanup code to run with=

> only one lock, which makes cleanup callbacks less tricky to write.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/job.h |  7 +++++++
>  job.c              | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+)

Currently all jobs do this, the question of course is why.  The answer
is because they are block jobs that need to do some graph manipulation
in the main thread, right?

OK, that's reasonable enough, that sounds like even non-block jobs may
need this (i.e. modify some global qemu state that you can only do in
the main loop).  Interestingly, the create job only calls
job_completed() of which it says nowhere that it needs to be executed in
the main loop.

=2E..on second thought, do we really want to execute job_complete() in th=
e
main loop?  First of all, all of the transactional functions will run in
the main loop.  Which makes sense, but it isn't noted anywhere.
Secondly, we may end up calling JobDriver.user_resume(), which is
probably not something we want to call in the main loop.

OTOH, job_finish_sync() is something that has to be run in the main loop
because it polls the main loop (and as far as my FUSE experiments have
told me, polling a foreign AioContext doesn't work).

So...  I suppose it would be nice if we had a real distinction which
functions are run in which AioContext.  It seems like we indeed want to
run job_completed() in the main loop, but what to do about the
user_resume() call in job_cancel_async()?

(And it should be noted for all of the transactional methods that they
are called in the main loop.)


OK, so that's that.  Now that I know what it's for, I'd like to ask for
a different name.  exit() means kill the process.  JobDriver.exit() will
not mean kill the job.  That's where I get a headache.

This function is for allowing the job to carry out global qemu state
modifications in the main loop.  Neither is that exiting in the sense
that the job is destroyed (as this is done only later, and the job gets
to take part in it through the transactional callbacks, and .free()),
nor is it exiting in the sense that the job needs to do all
pre-transactional clean-ups here (they are supposed to do that in .run()
-- *unlees* something needs the main loop).

I'd like .main_loop_settle().  Or .main_loop_post_run().  I think it's
OK to have names that aren't as cool and tense as possible, when in
return they actually tell you what they're doing.  (Sure,
=2Emain_loop_post_run() sounds really stupid, but it tells you exactly
when the function is called and what it's for.)

(Maybe the problem of all your naming woes really is just that you
always try to find a single word that describes what's going on :-) -- I
don't want to go into ProblemSolveFactoryObserverFactorySingleton
either, but it's OK to use an underscore once in a while.)

Max


--roRUfIzqUmcseX92vTH6dcluYV2olKzzt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9TFoACgkQ9AfbAGHV
z0ABbQgAso2PcnoV/AVz7gU4bDKWppaz1YSV1h1N/mNTvjYrBQzc5s1fGjiTgUUO
DuYx9ycFj/z6flIK7elGRkBD11orFqCbZhFWPWJ/hm6rCahRAXCZ+wlcrcHse61m
OxdxjzCwZU365LzTPne5XtNvk9aNKEDP35VyEsnPs/OU4dWTiyo5vkgnmyWHqlWc
mA37HZNyb2yM/DkUKOT+210+JpYpliQMccLgcDCHqrLYkg5rIIzjmoXcn3SGufeV
nP1JM0VgZmyEVuNKhcNAk8NYq5hbH2sZyTwmhe36FyO4FhyKOxrPRsP/6rSNOWjX
4mTgpsdMDrxkDOZUAkqdagJwFhmB/Q==
=ZpGu
-----END PGP SIGNATURE-----

--roRUfIzqUmcseX92vTH6dcluYV2olKzzt--
