Received: from eggs.gnu.org ([2001:4830:134:3::10]:59782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBIRI-0003V6-Im
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBIRC-0002mA-MU
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:18:20 -0400
References: <20180421132929.21610-1-mreitz@redhat.com>
	<20180421132929.21610-2-mreitz@redhat.com>
	<w51in8g63r5.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <319c6e7b-c23c-09cd-4198-5b537a99c98c@redhat.com>
Date: Wed, 25 Apr 2018 13:18:03 +0200
MIME-Version: 1.0
In-Reply-To: <w51in8g63r5.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="obMYSMop57MIUSVtVh1gq860QgOjQS3qu"
Subject: Re: [Qemu-devel] [PATCH v2 1/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--obMYSMop57MIUSVtVh1gq860QgOjQS3qu
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <319c6e7b-c23c-09cd-4198-5b537a99c98c@redhat.com>
Subject: Re: [PATCH v2 1/9] block: Add COR filter driver
References: <20180421132929.21610-1-mreitz@redhat.com>
 <20180421132929.21610-2-mreitz@redhat.com>
 <w51in8g63r5.fsf@maestria.local.igalia.com>
In-Reply-To: <w51in8g63r5.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-24 17:08, Alberto Garcia wrote:
> On Sat 21 Apr 2018 03:29:21 PM CEST, Max Reitz wrote:
>> This adds a simple copy-on-read filter driver.  It relies on the alrea=
dy
>> existing COR functionality in the central block layer code, which may =
be
>> moved here once we no longer need it there.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>=20
>> +#define PERM_PASSTHROUGH (BLK_PERM_CONSISTENT_READ \
>> +                          | BLK_PERM_WRITE \
>> +                          | BLK_PERM_RESIZE)
>> +#define PERM_UNCHANGED (BLK_PERM_ALL & ~PERM_PASSTHROUGH)
>> +
>> +static void cor_child_perm(BlockDriverState *bs, BdrvChild *c,
>> +                           const BdrvChildRole *role,
>> +                           BlockReopenQueue *reopen_queue,
>> +                           uint64_t perm, uint64_t shared,
>> +                           uint64_t *nperm, uint64_t *nshared)
>> +{
>> +    if (c =3D=3D NULL) {
>> +        *nperm =3D (perm & PERM_PASSTHROUGH) | BLK_PERM_WRITE_UNCHANG=
ED;
>> +        *nshared =3D (shared & PERM_PASSTHROUGH) | PERM_UNCHANGED;
>> +        return;
>> +    }
>> +
>> +    *nperm =3D (perm & PERM_PASSTHROUGH) |
>> +             (c->perm & PERM_UNCHANGED);
>=20
> I admit I'm not completely familiar with this, but don't you need to ad=
d
> BLK_PERM_WRITE_UNCHANGED to *nperm ?

As long as it's requested in when the child is attached (which it is in
the "c =3D=3D NULL" case), it should be part of c->perm then.

(And since PERM_PASSTHROUGH does not contain WRITE_UNCHANGED, it is part
of PERM_UNCHANGED.)

Max

>> +    *nshared =3D (shared & PERM_PASSTHROUGH) |
>> +               (c->shared_perm & PERM_UNCHANGED);
>> +}
>=20
> Berto
>=20



--obMYSMop57MIUSVtVh1gq860QgOjQS3qu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrgY+sACgkQ9AfbAGHV
z0CJTAf/TWGw1TEe89P4A8f3EIyXFpsRiXsPrvNUzS65mjyZ9ZRHCYWutn9AyUox
Ab+Ang5WjCKK+Y3FMs4ku3Ap4dnYE5z/Oo5vjJxj8ZmZ7MBKCqyJc5qI8JSGNnnK
B6PHoL44JcJN3UAkM5LE44IGLzoAsMcVYP3DqZku+imEv1z4Kw9cc6wXmiLUBpbp
Z3mfoF0Mk0/L7JdlD2NvaLEFpRfg+jdvK6Wnzq6UHzL8upIIsycm4iyquqNadtd8
tbC9lWt5r51dJ2OiD0WrIluk95fh387arx54dO1vM6wPCS7I7iA7Da7XkV8tbzDK
rAJX3Xlg//NiV/AcyVeM/ykr5PRasg==
=pOAC
-----END PGP SIGNATURE-----

--obMYSMop57MIUSVtVh1gq860QgOjQS3qu--
