Received: from eggs.gnu.org ([2001:4830:134:3::10]:36158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRjS-0002eB-UO
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fsRjS-0002DN-1i
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 07:55:26 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-5-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <44f443a7-fd79-d2ec-e4a9-f228923e25db@redhat.com>
Date: Wed, 22 Aug 2018 13:55:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E2yPqPXkMq0drdtfyPUyg9nqlkZLW1nuN"
Subject: Re: [Qemu-devel] [PATCH 4/7] block/commit: utilize job_exit shim
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
--E2yPqPXkMq0drdtfyPUyg9nqlkZLW1nuN
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com
Message-ID: <44f443a7-fd79-d2ec-e4a9-f228923e25db@redhat.com>
Subject: Re: [PATCH 4/7] block/commit: utilize job_exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-5-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-17 21:04, John Snow wrote:
> Change the manual deferment to commit_complete into the implicit
> callback to job_exit, renaming commit_complete to commit_exit.
>=20
> This conversion does change the timing of when job_completed is
> called to after the bdrv_replace_node and bdrv_unref calls, which
> could have implications for bjob->blk which will now be put down
> after this cleanup.
>=20
> Kevin highlights that we did not take any permissions for that backend
> at job creation time, so it is safe to reorder these operations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/commit.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index 4a17bb73ec..93c3b6a39e 100644
> --- a/block/commit.c
> +++ b/block/commit.c

[...]

> @@ -93,8 +87,8 @@ static void commit_complete(Job *job, void *opaque)
> =20
>      if (!job_is_cancelled(job) && ret =3D=3D 0) {
>          /* success */
> -        ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
> -                                     s->backing_file_str);
> +        job->ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
> +                                          s->backing_file_str);

This makes me ask myself why .exit() doesn't just return an int, like
=2Erun().  And takes an Error **.

Max

>      } else {
>          /* XXX Can (or should) we somehow keep 'consistent read' block=
ed even
>           * after the failed/cancelled commit job is gone? If we alread=
y wrote


--E2yPqPXkMq0drdtfyPUyg9nqlkZLW1nuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt9TxUACgkQ9AfbAGHV
z0C+pAf9ESB6ao2xDpbmBDys3VT5Cm6RLlL+1DZBHw5sfCEd2hJmgLeF6h4BJ8Iu
E6O5UJfxxdpGKcnoSlAutDa9hcgQ+eYlerdsM4vvXprZRrcLKMG6wqxS0wo5H1U5
Egg2b48jXk3L+1Huz/Npm+4n0qLBjaPr8SjE1J5sdFSocIBdkbbTg+BcZTP9IGnH
cv6T9X2lsE4XV+bADwy5G/8qa/uOlswXxHLN9d6knnL4fMXMtvUxK+E6WHxyJ04y
6cJ2yus/DtlPGkJlvjP7q0ZWkHXHK2woFHESw/a1cYOI1j+ubWqtYmLEHb4N+YAx
uJV6nCdnyqLMJ/gwjg+gYoErwOTskQ==
=Ooki
-----END PGP SIGNATURE-----

--E2yPqPXkMq0drdtfyPUyg9nqlkZLW1nuN--
