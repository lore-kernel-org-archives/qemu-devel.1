Received: from eggs.gnu.org ([2001:4830:134:3::10]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI6P-0003JK-0r
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuHrl-000736-Fz
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:47:38 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-10-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e7af1590-c950-6d96-fc54-e268721bfd8c@redhat.com>
Date: Mon, 27 Aug 2018 15:47:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-10-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wCMoaes9PZOZCGSmb2LCGkDYelriZGPhw"
Subject: Re: [Qemu-devel] [PATCH v2 09/13] jobs: remove .exit callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wCMoaes9PZOZCGSmb2LCGkDYelriZGPhw
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <e7af1590-c950-6d96-fc54-e268721bfd8c@redhat.com>
Subject: Re: [PATCH v2 09/13] jobs: remove .exit callback
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-10-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Now that all of the jobs use the component finalization callbacks,
> there's no use for the heavy-hammer .exit callback anymore.
>=20
> job_exit becomes a glorified type shim so that we can call
> job_completed from aio_bh_schedule_oneshot.
>=20
> Move these three functions down into job.c to eliminate a
> forward reference.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/job.h        | 11 -------
>  job.c                     | 77 +++++++++++++++++++++------------------=
--------
>  tests/test-blockjob-txn.c |  4 +--
>  3 files changed, 36 insertions(+), 56 deletions(-)

[...]

> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
> index ef29f35e44..86606f92b3 100644
> --- a/tests/test-blockjob-txn.c
> +++ b/tests/test-blockjob-txn.c
> @@ -24,7 +24,7 @@ typedef struct {
>      int *result;
>  } TestBlockJob;
> =20
> -static void test_block_job_exit(Job *job)
> +static void test_block_job_clean(Job *job)
>  {
>      BlockJob *bjob =3D container_of(job, BlockJob, job);
>      BlockDriverState *bs =3D blk_bs(bjob->blk);
> @@ -73,7 +73,7 @@ static const BlockJobDriver test_block_job_driver =3D=
 {
>          .user_resume   =3D block_job_user_resume,
>          .drain         =3D block_job_drain,
>          .run           =3D test_block_job_run,
> -        .exit          =3D test_block_job_exit,
> +        .clean         =3D test_block_job_clean,
>      },
>  };

Not sure whether this change warrants its own patch, but it probably
should be noted in the commit message.

With that done (or with this change split off into its own patch):

Reviewed-by: Max Reitz <mreitz@redhat.com>


--wCMoaes9PZOZCGSmb2LCGkDYelriZGPhw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluEAOwACgkQ9AfbAGHV
z0Bi2gf/TyIQOTO4P1ftkKdvQ5slwumJeir2HkAlOaUa5x7yCuD3J+d4yWzz2LY/
15bpogIesLoSae9nEZLQHh+siGY2nccMlkjpnfEwtVGB7J2ag0i0xK+8fIpjLSyt
DtPEsJbvk4OmasyXZ4AE8rc3AeQuwFoOYtadypml7+jvwjmO+QkpYeb8NuMjpvbK
hcuewwUcJdfH1FJ9h3QrEu6POVOW3VeQeENrLnC1/ggzDb7ORfzsQqfp6QRpsyx2
C8M3LSZdYQqvDXfHTomyqIAailz4K50KquBY8dTniqrYjnk9Jg8crSxsrs2pPd7M
Aked/IKaXM0iOwo0cB3d++7OLf9bOw==
=0aO8
-----END PGP SIGNATURE-----

--wCMoaes9PZOZCGSmb2LCGkDYelriZGPhw--
