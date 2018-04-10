Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5wBR-00017G-3u
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f5wBP-0001F0-U0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:31:49 -0400
References: <cover.1523376013.git.berto@igalia.com>
	<74552e1d6e858d3159cb0c0e188e80bc9248e337.1523376013.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <271b88fe-6d19-fee3-cdc7-f76c046958dc@redhat.com>
Date: Tue, 10 Apr 2018 11:31:33 -0500
MIME-Version: 1.0
In-Reply-To: <74552e1d6e858d3159cb0c0e188e80bc9248e337.1523376013.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ByhBF8k0UahiGhfaKp3fW93MlIbu6xqHZ"
Subject: Re: [Qemu-devel] [PATCH 2/2] specs/qcow2: Clarify that compressed
 clusters have the COPIED bit reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ByhBF8k0UahiGhfaKp3fW93MlIbu6xqHZ
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <271b88fe-6d19-fee3-cdc7-f76c046958dc@redhat.com>
Subject: Re: [PATCH 2/2] specs/qcow2: Clarify that compressed clusters have
 the COPIED bit reset
References: <cover.1523376013.git.berto@igalia.com>
 <74552e1d6e858d3159cb0c0e188e80bc9248e337.1523376013.git.berto@igalia.com>
In-Reply-To: <74552e1d6e858d3159cb0c0e188e80bc9248e337.1523376013.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 11:05 AM, Alberto Garcia wrote:
> Compressed clusters are not supposed to have the COPIED bit set, but
> this is not made explicit in the specs, so let's document it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  docs/interop/qcow2.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index feb711fb6a..8e1547ded2 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -400,10 +400,10 @@ L2 table entry:
>                62:   0 for standard clusters
>                      1 for compressed clusters
> =20
> -              63:   0 for a cluster that is unused or requires COW, 1 =
if its
> -                    refcount is exactly one. This information is only =
accurate
> -                    in L2 tables that are reachable from the active L1=

> -                    table.
> +              63:   0 for clusters that are unused, compressed or requ=
ire COW.
> +                    1 for standard clusters whose refcount is exactly =
one.
> +                    This information is only accurate in L2 tables
> +                    that are reachable from the active L1 table.

This matches what qemu outputs, so the question becomes whether it is
technically necessary to make this requirement mandatory for 3rd-party
implementations.  But I'm in favor of the tighter wording, as it gets
rather hairy to check whether exactly one compressed cluster is
occupying a host cluster, plus I don't want to think about what happens
if a compressed cluster with the bit set crosses a host cluster boundary
(does it mean that compressed cluster is the only [remaining] source of
data for BOTH host clusters at once, where both the head of the first
host cluster and tail of the second host cluster is unused?)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ByhBF8k0UahiGhfaKp3fW93MlIbu6xqHZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrM5uUACgkQp6FrSiUn
Q2rBYgf8DHlAmtubqd5mSq5g8QWQwFkO35psY5oU4ueMj7p9KQzMWKt5grEi5FHu
+XccY54d3DLbeKF5hV1rCStuqjc/p88bNnoav/bT6E/821fNkTDojAccQsDXp2Kf
Ev3dmKSYRTKsUhTYb+0HZrgHTzGv7VuOWKd0fLMrI2JGRgGDqIAEGbV55+Epm1zZ
pPMx2gwaw3Arn4UegONunAIYui0Wrh6vyGajCYtxlnSLQexiZiXmquI0o4Wtehmj
JdwD/GxdJJppdhGBCsfiWnNbyWxcGKSXDRlK2Q9Bpno6icXWUkQ/99FMN/fyn1Pb
QcCCNXz6zpKXVJwI++mFcFgJFzYfQw==
=+lqc
-----END PGP SIGNATURE-----

--ByhBF8k0UahiGhfaKp3fW93MlIbu6xqHZ--
