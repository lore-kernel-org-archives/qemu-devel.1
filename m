Received: from eggs.gnu.org ([2001:4830:134:3::10]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fILv8-0003DU-JS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fILv7-0005xK-Ms
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:26:18 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-35-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <42c6e2f7-01ef-3ec9-67b4-a4a8569055f1@redhat.com>
Date: Tue, 15 May 2018 00:26:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-35-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C2h6ri1POsataJkOT8Wv1kW3sJ4qtfpWR"
Subject: Re: [Qemu-devel] [PATCH 34/42] job: Add job_dismiss()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C2h6ri1POsataJkOT8Wv1kW3sJ4qtfpWR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <42c6e2f7-01ef-3ec9-67b4-a4a8569055f1@redhat.com>
Subject: Re: [PATCH 34/42] job: Add job_dismiss()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-35-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-35-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves block_job_dismiss() to the Job layer.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  9 ---------
>  include/qemu/job.h       |  7 ++++++-
>  blockdev.c               |  8 +++++---
>  blockjob.c               | 13 -------------
>  job.c                    | 15 ++++++++++++++-
>  tests/test-blockjob.c    |  4 ++--
>  6 files changed, 27 insertions(+), 29 deletions(-)

[...]

> diff --git a/blockdev.c b/blockdev.c
> index 31319a6d5a..15753d9719 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3915,14 +3915,16 @@ void qmp_block_job_finalize(const char *id, Err=
or **errp)
>  void qmp_block_job_dismiss(const char *id, Error **errp)
>  {
>      AioContext *aio_context;
> -    BlockJob *job =3D find_block_job(id, &aio_context, errp);
> +    BlockJob *bjob =3D find_block_job(id, &aio_context, errp);
> +    Job *job;

clang (probably gcc as well if I had enabled tracing in that build...)
complains that this should be initialized to NULL because of...

> =20
> -    if (!job) {
> +    if (!bjob) {
>          return;
>      }
> =20
>      trace_qmp_block_job_dismiss(job);

=2E..this.

Max

> -    block_job_dismiss(&job, errp);
> +    job =3D &bjob->job;
> +    job_dismiss(&job, errp);
>      aio_context_release(aio_context);
>  }
> =20


--C2h6ri1POsataJkOT8Wv1kW3sJ4qtfpWR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr6DP8ACgkQ9AfbAGHV
z0AH7AgAr11LTiCJ71hmzmmFa9UUDeYbyJbUpL2uoAoO2Uy/iLUfYe3eI6nvRk8z
rxuhWxJptC4laLeWjPZJzw0dNBfkAlrBdr8+KV09EvhTs7j6NY0zygXWHytQjSja
6WIAbpsxsKRagLUizgHXNjssnU0iEPyYbhViYQsfNu606KGzkzCtJSqrKpa3lQSx
sHonduDB7Kwig/+HqTYDbW8OjOFpGTOm0R1o31ZQqwrBU9GgpReSJMLj8aXG8B4W
x/xHGW1o1sEOq3WN02e+4jsxjd8VhiSB/0LguDtMmxk9II8Bqh7Ww2+Ek0qsTIFd
wbZX3GaTmjbsb4CErOhEZ9/snvEPgQ==
=duUR
-----END PGP SIGNATURE-----

--C2h6ri1POsataJkOT8Wv1kW3sJ4qtfpWR--
