Received: from eggs.gnu.org ([2001:4830:134:3::10]:51055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsQwb-0004ru-6N
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsQjX-0001oK-2t
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:51:27 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-2-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
Date: Wed, 22 Aug 2018 12:51:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="USRdzgZAApObZdI4KLXjx4JKMphHujH7D"
Subject: Re: [Qemu-devel] [PATCH 1/7] jobs: change start callback to run
 callback
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
--USRdzgZAApObZdI4KLXjx4JKMphHujH7D
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
Subject: Re: [PATCH 1/7] jobs: change start callback to run callback
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-2-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Presently we codify the entry point for a job as the "start" callback,
> but a more apt name would be "run" to clarify the idea that when this
> function returns we consider the job to have "finished," except for
> any cleanup which occurs in separate callbacks later.
>=20
> As part of this clarification, change the signature to include an error=

> object and a return code. The error ptr is not yet used, and the return=

> code while captured, will be overwritten by actions in the job_complete=
d
> function.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            |  7 ++++---
>  block/commit.c            |  7 ++++---
>  block/create.c            |  8 +++++---
>  block/mirror.c            | 10 ++++++----
>  block/stream.c            |  7 ++++---
>  include/qemu/job.h        |  2 +-
>  job.c                     |  6 +++---
>  tests/test-bdrv-drain.c   |  7 ++++---
>  tests/test-blockjob-txn.c | 16 ++++++++--------
>  tests/test-blockjob.c     |  7 ++++---
>  10 files changed, 43 insertions(+), 34 deletions(-)

[...]

> diff --git a/job.c b/job.c
> index fa671b431a..898260b2b3 100644
> --- a/job.c
> +++ b/job.c
> @@ -544,16 +544,16 @@ static void coroutine_fn job_co_entry(void *opaqu=
e)
>  {
>      Job *job =3D opaque;
> =20
> -    assert(job && job->driver && job->driver->start);
> +    assert(job && job->driver && job->driver->run);
>      job_pause_point(job);
> -    job->driver->start(job);
> +    job->ret =3D job->driver->run(job, NULL);
>  }

Hmmm, this breaks the iff relationship with job->error.  We might call
job_update_rc() afterwards, but then job_completed() would need to free
it if it overwrites it with the error description from a potential error
object.

Also, I suspect the following patches might fix the relationship anyway?
 (But then an "XXX: This does not hold right now, but will be fixed in a
future patch" in the documentation of Job.error might help.)

Max


--USRdzgZAApObZdI4KLXjx4JKMphHujH7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9QB4ACgkQ9AfbAGHV
z0BdRQf/b8b25ZKl86iwAWq/15fBwV8zP5Qj7iLSv5AAp2Mek0CsAFmBIELhPHiY
H9LCJZD83FChc4Mba5PiSKROoRUND+wA5QXnth2aUkQH1+LsoLRiuFeqU1D0KNyb
eQQBsng+1MJsxkMFlN26jt3bjkhRo/XypeycY3xY2QVcJ2ApFRqdhTwue4BMENZa
5RMrua6etpCihGRzLGWJRNxlksMTo0wTvjwVc1IZI3rtzUJS9YVd5x+i4Zc+d3v1
D4J1v+CbHGmAnrErtIudiG0cq17mDjfadDV4BQJChFjvWHB3YQIH1MlnkXMIVjza
1tmi1AuXx7jXLscpY9u+xDXOAuLI6Q==
=vgEx
-----END PGP SIGNATURE-----

--USRdzgZAApObZdI4KLXjx4JKMphHujH7D--
