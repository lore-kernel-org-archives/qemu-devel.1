Received: from eggs.gnu.org ([2001:4830:134:3::10]:47573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYjX4-0006rg-KX
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYjX3-0003xk-Ra
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:16:22 -0500
References: <20170130161441.30493-1-berto@igalia.com>
	<w51vaswzeui.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b4195fb7-5c5f-ccc8-89b0-02d1a5d4fa6f@redhat.com>
Date: Wed, 1 Feb 2017 02:16:12 +0100
MIME-Version: 1.0
In-Reply-To: <w51vaswzeui.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EBaD7dEwtX8jqVTJUmcGLFCETrDoFQpj2"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
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
--EBaD7dEwtX8jqVTJUmcGLFCETrDoFQpj2
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b4195fb7-5c5f-ccc8-89b0-02d1a5d4fa6f@redhat.com>
Subject: Re: [PATCH] qcow2: Optimize the refcount-block overlap check
References: <20170130161441.30493-1-berto@igalia.com>
 <w51vaswzeui.fsf@maestria.local.igalia.com>
In-Reply-To: <w51vaswzeui.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.01.2017 17:34, Alberto Garcia wrote:
> On Mon 30 Jan 2017 05:14:41 PM CET, Alberto Garcia wrote:
>=20
>> This patch keeps the index of the last used (i.e. non-zero) entry in
>> the refcount table and updates it every time the table changes. The
>> refcount-block overlap check then uses that index instead of reading
>> the whole table.
>=20
> Note that while I decided to go for this approach the patch can be made=

> much simpler by simply stopping at the first empty entry in the refcoun=
t
> table:
>=20
>     if ((chk & QCOW2_OL_REFCOUNT_BLOCK) && s->refcount_table) {
>         for (i =3D 0; i < s->refcount_table_size; i++) {
>             if (!(s->refcount_table[i] & REFT_OFFSET_MASK)) {
>                 break;
>             }
>             if (overlaps_with(s->refcount_table[i] & REFT_OFFSET_MASK,
>                 s->cluster_size)) {
>                 return QCOW2_OL_REFCOUNT_BLOCK;
>             }
>         }
>     }
>=20
> I don't think QEMU produces files where refcount_table[i] =3D=3D 0 but
> refcount_table[i + 1] !=3D 0. Do they even make sense? In any case, my
> patch would cover those cases too, but this simplified version wouldn't=
=2E

I think it would be reasonable enough to assume that such images don't
exist (and if they do, we don't do overlap checks above the hole -- that
isn't exactly the end of the world). But your patch looks simple enough
as it is.

Max


--EBaD7dEwtX8jqVTJUmcGLFCETrDoFQpj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRNtwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2DsH/jlT5xy1dVzgP6h7WRIkDhcF67s9MY4r
EtV1pwE7VLXbstQIEqJIte2g+J/dGgFkhk4SinIJAPSjahnHsSS84EQsHTQqyQyA
gwTUpGXoVXGBi4gTLdvlxS+6q5WI8Nvh4rBh9/OJ4eXnHWiUI5lNWL38vSZk9YzQ
ODQNd1xfCRfKncL5STQ/m0g/S4u003qnwm2vTQdy1MBnbFIoY2TYSsw/Qav9yBVs
jzr75fQEYDSwJVRI30NMZRb+jyM+Sns03ByCUaAQPVIi9cxFtB+3XEYtWl82Vbic
peEa9eOnfpCmu+nK1GXuR8CzX/8KvMKVn5mCdZR8NPtPwDWNDi1By5k=
=ehyP
-----END PGP SIGNATURE-----

--EBaD7dEwtX8jqVTJUmcGLFCETrDoFQpj2--
