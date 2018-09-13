Received: from eggs.gnu.org ([2001:4830:134:3::10]:51011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0XdZ-0000HI-Lu
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 15:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0XdX-0000Wz-Mp
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 15:50:48 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-11-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <14983d02-bde3-809f-e8e3-e28e6ec7ccb1@redhat.com>
Date: Thu, 13 Sep 2018 21:50:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-11-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hPbUkN2dYAFCkFDcbJ0TTWUKXXjWSAbaP"
Subject: Re: [Qemu-devel] [PATCH v2 10/17] block-backend: Fix potential
 double blk_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hPbUkN2dYAFCkFDcbJ0TTWUKXXjWSAbaP
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <14983d02-bde3-809f-e8e3-e28e6ec7ccb1@redhat.com>
Subject: Re: [PATCH v2 10/17] block-backend: Fix potential double blk_delete()
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-11-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-11-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> blk_unref() first decreases the refcount of the BlockBackend and calls
> blk_delete() if the refcount reaches zero. Requests can still be in
> flight at this point, they are only drained during blk_delete():
>=20
> At this point, arbitrary callbacks can run. If any callback takes a
> temporary BlockBackend reference, it will first increase the refcount t=
o
> 1 and then decrease it to 0 again, triggering another blk_delete(). Thi=
s
> will cause a use-after-free crash in the outer blk_delete().
>=20
> Fix it by draining the BlockBackend before decreasing to refcount to 0.=

> Assert in blk_ref() that it never takes the first refcount (which would=

> mean that the BlockBackend is already being deleted).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hPbUkN2dYAFCkFDcbJ0TTWUKXXjWSAbaP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluav3AACgkQ9AfbAGHV
z0DIzAgAqouyO1MYX/Wt+zOd4pIS/DKXxP0Qt0p5LWsg4Hh8NrbpoXDy0hH44278
9Zpp6lKmSpz0pL6RsU2tFLh3H0ai/ddxGAvl5kyse/UQzwt3nxEG0aIu9BhrqkY9
2tiV+/oC4HH76Si2vHo4uE9hZi93nv5ShiqzD6nlkvrYiUQawvNX+T3zT/OwKIk/
0/09mEDQcTgzxMqEp319h7gYrMLCb/sbsohGSq7uVlUbX+Q6hN7uEvil5mk/IbJY
FOYU8UbOAth8ZGgGcIXstEk2QNOUAuOPseRnCxGiH3RcaW5cQkLJFAa/J2XJvRAa
pS6cSqb9PC1enrk0Tnt49a3/hIz9sw==
=7YYe
-----END PGP SIGNATURE-----

--hPbUkN2dYAFCkFDcbJ0TTWUKXXjWSAbaP--
