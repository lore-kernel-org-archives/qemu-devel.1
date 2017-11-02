Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJEe-00019I-UH
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJEd-0001x5-Ti
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:24:56 -0400
References: <cover.1509550787.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5d18fa25-bde1-31a6-568e-3d224c5bbe8b@redhat.com>
Date: Thu, 2 Nov 2017 18:24:40 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1509550787.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BJ0se0XIxfTsqa1LwqdE1Q30j7hDMSboW"
Subject: Re: [Qemu-devel] [PATCH 0/4] Misc qcow2 corruption checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BJ0se0XIxfTsqa1LwqdE1Q30j7hDMSboW
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <5d18fa25-bde1-31a6-568e-3d224c5bbe8b@redhat.com>
Subject: Re: [PATCH 0/4] Misc qcow2 corruption checks
References: <cover.1509550787.git.berto@igalia.com>
In-Reply-To: <cover.1509550787.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-01 16:42, Alberto Garcia wrote:
> Misc qcow2 corruption checks
>=20
> This series contains a few checks that prevent QEMU from crashing
> under some scenarios with corrupted qcow2 images.
>=20
> The first patch solves the crash reported here:
>=20
>   https://bugs.launchpad.net/qemu/+bug/1728615
>=20
> And the others solve similar crashes that I detected in the process of
> fixing this one.
>=20
> Regards,
>=20
> Berto

There are two more cases which might need a check that the return value
of an allocation function isn't 0:

The first is qcow2_alloc_bytes() which has an assert(offset) after
potentially setting offset =3D new_cluster (with new_cluster being the
return value of alloc_clusters_noref()).

The second is qcow2_crypto_hdr_init_func() which is simply missing a
pre-write overlap check.

The rest (besides L2 table and refblock allocation) should be guarded by
the pre-write overlap check.

Do you want to fix these or do we need another volunteer? :-)

Max


--BJ0se0XIxfTsqa1LwqdE1Q30j7hDMSboW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7VNgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARTEH/iCyOhiBzb7ZmY1UWse8odjEjASFuD1O
JPjTxQA+esbxs6fzr3kAP35htQDZL0Pq5LhGzbwKFEW9xcMmaIJfY9nvhY27vb1j
8C39nF8jUe5XkfdFUcCViGwqUBMlcpqM8nkNCbM2eM1RCFCsVezmS6cWOH4J/AK4
DkQj6DjdQri2LFjcF3Y1RhHPEjOAeUVfibhIkZzfR3DlDshG/1haQOJt1crDHK9T
rvTQHdLtWJTekNBD6CODJPG5BuUt1Du3AcoEDlXZXpOtMhCxusaUCLWtH468ZAe0
BjpzylJ3oYXDtzBmm/tyJbI9rLsAl2hi0FSQEha68sqcSuk2bM8jwqE=
=Xpkf
-----END PGP SIGNATURE-----

--BJ0se0XIxfTsqa1LwqdE1Q30j7hDMSboW--
