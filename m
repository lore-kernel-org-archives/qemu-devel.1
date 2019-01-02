Received: from eggs.gnu.org ([208.118.235.92]:47586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXl-0004lo-D5
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXh-00063G-CR
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:09 -0500
Date: Wed, 2 Jan 2019 13:59:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102025904.GH27457@umbus.fritz.box>
References: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <20181228135235.6859-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] target/ppc: remove various endian
 hacks from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2018 at 01:52:27PM +0000, Mark Cave-Ayland wrote:
> >From working on the TCG vector operations patchset, it is apparent that =
there
> are a large number of endian-based hacks in int_helper.c which can be rem=
oved by
> making use of the various Vsr* macros.
>=20
> Patch 1 is simple enough, and implements the complete set of Vsr* macros =
for
> both big endian and little endian hosts.
>=20
> Patches 2 and 3 rework the vector merge and multiply algorithms so that t=
hey
> no longer require the endian-dependent HI_IDX and LO_IDX macros.
>=20
> Patches 4 and 5 then completely remove the HI_IDX/LO_IDX and EL_IDX macro=
s by
> replacing the element accesses with their equivalent Vsr* macro instead.
>=20
> Patches 6 and 7 tidy up the VEXT_SIGNED macro and fix a potential shift b=
ug
> in the ROTRu32 and ROTRu64 macros pointed out by Richard during the revie=
w of
> v1.
>=20
> Finally patch 8 is an inspection-based removal of other HOST_WORDS_BIGEND=
IAN
> hacks in int_helper.c, again replacing accesses with the relevant Vsr* ma=
cro
> instead.
>=20
> Note that there are still some endian hacks left in int_helper.c after th=
is
> patchset: in particular the delightfully evil VECTOR_FOR_INORDER_I macro =
still
> remains in places where the index variable was used for purposes other th=
an
> accessing elements within the vector.
>=20
> There were also some parts where additional conversion could be done, but=
 I
> wasn't confident enough to make the change without access to PPC64 test i=
mages
> or real big-endian host hardware.

Applied to ppc-for-4.0, thanks.

>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Based-on: <20181223111525.581-1-mark.cave-ayland@ilande.co.uk> "target/pp=
c: prepare for conversion to TCG vector operations"
>=20
>=20
> v2:
> - Add R-B tags from Richard
> - Add patches 6 and 7 to simplify the VEXT_SIGNED macro and fix a potenti=
al
>   shift bug in the ROTRu32 and ROTRu64 macros
> - Don't require ordered access for VNEG and VGENERIC_DO macros as pointed=
 out
>   by Richard
>=20
>=20
> Mark Cave-Ayland (8):
>   target/ppc: implement complete set of Vsr* macros
>   target/ppc: rework vmrg{l,h}{b,h,w} instructions to use Vsr* macros
>   target/ppc: rework vmul{e,o}{s,u}{b,h,w} instructions to use Vsr*
>     macros
>   target/ppc: eliminate use of HI_IDX and LO_IDX macros from
>     int_helper.c
>   target/ppc: eliminate use of EL_IDX macros from int_helper.c
>   target/ppc: simplify VEXT_SIGNED macro in int_helper.c
>   target/ppc: remove ROTRu32 and ROTRu64 macros from int_helper.c
>   target/ppc: remove various HOST_WORDS_BIGENDIAN hacks in int_helper.c
>=20
>  target/ppc/int_helper.c | 521 ++++++++++++++++++++----------------------=
------
>  target/ppc/internal.h   |   9 +-
>  2 files changed, 223 insertions(+), 307 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsKPgACgkQbDjKyiDZ
s5KG6g/8CTH9AXZQl+/SjxBT0SKKfXHWTqqId/8pfpny48C/RkylCaTyGCql7xpU
7zW7IotDiok/pGwWf8SNKZm29AINE6UlaaRmfiK6CHROehLfqytskrCkeTe83GDA
TIaN9q7P9itLCXphYQ+2eKiCT9kGxcKEvZffg97s9eRCxyWURPBTfIcbyKMm/+16
o/6QCvnBsIL1z7L9CJUiqpZ5Zx2Z2YjuM12gUR1lLTtAZ4IKkReWjmi6n9X8zXip
FFQKvNpcyosZNKkO+lhS7cbYs7B4TMz5jhRQcKPnKV6gHVO0KuvCIqra4QStIyFg
R4Uc7Cjv/d4NyQNHe8QKvl40rzqr/7bE0f2rbDuXt8MP6Q6zHet1dHZRYHwPk1QE
vSkJX0x4GehbNepZJUrv9JGKlNNo/YEV4MJvGXXtIyKaLty+AuQYQqygyApGshNj
3AzcUw2x8U+sePM5FI/IeQtzmSdVBQiNiAg7/rWEHlsS5+kUubPYZCm4oK6AieDB
IeWyXlnwCATc96f8u8p6OBUQGVfx8PuaS2x8NJDSLRd84ylvHQRsg32bDW6Eveiv
34PlWI+3EFfEKnzRaE4Q2iPS9hgK3+LyMjU2DW0wVf301ztwQsRr4mWLler8Nx0C
KcnpCvbgvb1bPkX2/WpqOzidvH/OHiw/AX13tFUeO83H8E0paC8=
=bU8n
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
