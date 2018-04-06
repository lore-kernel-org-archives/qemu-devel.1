Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4TLu-0006GM-L4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4TLt-0003mN-L5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:32:34 -0400
References: <20180406151759.11223-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29bf83ee-4ee2-5278-7dd8-31fb50b28842@redhat.com>
Date: Fri, 6 Apr 2018 10:32:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180406151759.11223-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kNoCd3VLVUL19x449Neul7zttM1gjOEuE"
Subject: Re: [Qemu-devel] [PATCH] iotests: 122 needs at least two refcount
 bits now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kNoCd3VLVUL19x449Neul7zttM1gjOEuE
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <29bf83ee-4ee2-5278-7dd8-31fb50b28842@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 122 needs at least two refcount
 bits now
References: <20180406151759.11223-1-mreitz@redhat.com>
In-Reply-To: <20180406151759.11223-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 10:17 AM, Max Reitz wrote:
> The new test case for compressed clusters (added in commit
> abd3622cc03cf41ed542126a540385f30a4c0175) requires two refcount bits to=

> succeed, so we need to skip the test when refcount_bits=3D1 was request=
ed.

We already questioned whether the changes to 122 were appropriate, given
that it didn't even use qemu-img convert.  Should we instead split this
into two tests (keeping 122 as it was before, and making the new
compressed refcount munging tests be separate), where only the new test
needs this filter?

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/122 | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> index 6cf4fcb866..95e7c51e72 100755
> --- a/tests/qemu-iotests/122
> +++ b/tests/qemu-iotests/122
> @@ -42,6 +42,10 @@ _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> =20
> +# Repairing the compressed image requires qemu-img check to store a
> +# refcount up to 3, which requires at least two refcount bits.
> +_unsupported_imgopts 'refcount_bits=3D1[^0-9]'
> +

This makes sense, but I'm withholding R-b until we decide if splitting
the tests is wiser.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kNoCd3VLVUL19x449Neul7zttM1gjOEuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHkwwACgkQp6FrSiUn
Q2rWLQf6Ar9PgZCGCi0L0EXu4j9RN5tZ9403LVXb+Q4B44jM9Z8sWFhEZYHmiSLq
6Xcwyp6qUNUHmclblRarfpgsQUxXDjd3HI45pWM+H+SWjr3ZeYmWqW1Vb7JdTwq9
tcMDm+3/Qb0OGL0ilEd+bkqzm7NNcRQj89jy/UTUrfo8i+IaIl8R+v/F+TXRzjca
IxVMgCNlFIWpCJ4SvmUoyo6+wbO1V1BgsX883ALFb0l5uucI6yvJhnuIn07fcZc1
lwbS77oyxPFHSngY6cBcrKjB1RPay0+jWS4T4lO8PPFqCqXmnAaGm0IdaLBdjVKm
l2bHBVX1wP/EudaTPPhu554V0jkWoA==
=bTG/
-----END PGP SIGNATURE-----

--kNoCd3VLVUL19x449Neul7zttM1gjOEuE--
