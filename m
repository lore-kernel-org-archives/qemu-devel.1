Received: from eggs.gnu.org ([209.51.188.92]:34448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF6yo-0004M0-Fj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF6yh-0000mH-6E
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:57:09 -0400
References: <cover.1554992449.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
Date: Sat, 13 Apr 2019 02:56:57 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S1FvTWEbNxoaWTWVtF8d4vDWDByYZSRRp"
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] Fix check for default backing
 files in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S1FvTWEbNxoaWTWVtF8d4vDWDByYZSRRp
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6c17d784-c5e4-9a3c-c38c-19940352ea35@redhat.com>
Subject: Re: [PATCH for-4.1 0/2] Fix check for default backing files in
 bdrv_reopen_prepare()
References: <cover.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 16:23, Alberto Garcia wrote:
> Hi,
>=20
> Patch 1 is the fix for the bug reported by Max here:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00293.html
>=20
> Patch 2 fixes a different (but slightly related) issue that I found
> while preparing the first patch.

I think the real problem is that bs->backing_file is not a cache for
bs->backing->bs->filename.

In fact, every user of bs->backing_file expects it to be something
different.  Some expect it to be a cache for bs->backing->bs->filename,
some expect it to be what the image header says (i.e., it if=E2=80=99s a
relative path, it=E2=80=99s relative to the overlay), some expect it to b=
e what
the image header says, but relative paths to be translated so they are
relative to qemu=E2=80=99s CWD.

All of this should be cleaned up and this is what patch 7 in my "block:
Deal with filters" series does:

http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html

Max


--S1FvTWEbNxoaWTWVtF8d4vDWDByYZSRRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyxM9kACgkQ9AfbAGHV
z0A5fgf/WD/6zyV0HTg8MluSe1wc6yhqC138nscCnbbnP/UBfQLelZnhAnHxRaFO
HxN40qoDUZz8FVfcffplpEoWQc8bzh+gr3xY56jWl2bVbtFDtVcN+J7xX5ym1Lzj
w5LPNxqFFBEg+hf3Rgs4kH/8gc8SPJQUFabL2JS5Ojl4aWzjl7AxeGElgiEYkQcY
24Ok9SWOjpphzFlvJZdJzpTWzsx7Y+xf6jOSJQSu6xrZxgfSCTjPUMQBtcQ8QY+v
d0FEspW00tZYnC3rjJAfnzQyMlndVkS7dxxMnB2YBrjxWKFhL1i86nfd5RydZxQ6
fLq5h99EQLnPE6F/t3Vr2GiAk4S4YQ==
=OFWO
-----END PGP SIGNATURE-----

--S1FvTWEbNxoaWTWVtF8d4vDWDByYZSRRp--
