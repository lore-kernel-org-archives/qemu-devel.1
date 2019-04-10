Received: from eggs.gnu.org ([209.51.188.92]:33016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEFDf-0005Wj-7K
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEFDe-0007hV-5B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:32:59 -0400
References: <20190410152429.8076-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
Date: Wed, 10 Apr 2019 10:32:47 -0500
MIME-Version: 1.0
In-Reply-To: <20190410152429.8076-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk"
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if
 there is an early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <bc400e47-0140-1983-9a1b-16eb1f30fdb3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Make base read-only if there
 is an early failure
References: <20190410152429.8076-1-berto@igalia.com>
In-Reply-To: <20190410152429.8076-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 10:24 AM, Alberto Garcia wrote:
> You can reproduce this by passing an invalid filter-node-name (like
> "1234") to block-commit. In this case the base image is put in
> read-write mode but is never reset back to read-only.
>=20

Is it worth iotest coverage?

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index ba60fef58a..698eda1dfe 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -384,6 +384,9 @@ fail:
>      if (s->top) {
>          blk_unref(s->top);
>      }
> +    if (s->base_read_only) {
> +        bdrv_reopen_set_read_only(base, true, NULL);
> +    }
>      job_early_fail(&s->common.job);
>      /* commit_top_bs has to be replaced after deleting the block job,
>       * otherwise this would fail because of lack of permissions. */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuDJ8ACgkQp6FrSiUn
Q2om6Af+JXBOhMwwGuFpb2hnTImvIhSc5xvm0LU2yQa3sfaVOvIwueqq3bzMMFYU
kxxfBQ2SQYEnWFpVqB0eOPQamzmT8vXGBOvACvxXYDtffPAswhoqKGYZOetZWadE
MRIYM018C9J0OcZ38DKNUzV/2hlBClGSL+fCDwvC6C2gf7AeSwZv5xk2uX0kIv5Z
ZoWXkIs/oyoAjNGqOiRwrqMQ2W2iLbRCRbJgBoec4i2odqw093PgRgYwfqmzuCZr
qcIWPKiWgKafVI+GgYhrr7GH7BS0vr9wYRVVMWeIf+bbhQyhk5JSreO8M0zoKzMU
Bkc5mCL3DZMwF0bsDo3N9sTpBJOTzw==
=4eFA
-----END PGP SIGNATURE-----

--SSfFH4GuxXhoBL1jyp2RhZk14GPbZhGxk--
