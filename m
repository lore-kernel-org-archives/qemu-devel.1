Received: from eggs.gnu.org ([2001:4830:134:3::10]:35545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXIFZ-0007P5-2i
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXIFV-0005ht-1B
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:33:09 -0400
Date: Mon, 25 Jun 2018 13:25:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180625032557.GC22971@umbus.fritz.box>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<20180625004658.GB22971@umbus.fritz.box>
	<A7359F37-F1CD-4AE4-9594-36557AAD0386@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline
In-Reply-To: <A7359F37-F1CD-4AE4-9594-36557AAD0386@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 24, 2018 at 11:24:17PM -0400, G 3 wrote:
>=20
> On Jun 24, 2018, at 8:46 PM, David Gibson wrote:
>=20
> > On Fri, Jun 22, 2018 at 10:22:58PM -0400, John Arbuckle wrote:
> > > When the fdiv instruction divides a finite number by zero,
> > > the result actually depends on the FPSCR[ZE] bit. If this
> > > bit is set, the return value is zero. If it is not set
> > > the result should be either positive or negative infinity.
> > > The sign of this result would depend on the sign of the
> > > two inputs. What currently happens is only infinity is
> > > returned even if the FPSCR[ZE] bit is set. This patch
> > > fixes this problem by actually checking the FPSCR[ZE] bit
> > > when deciding what the answer should be.
> > >=20
> > > fdiv is suppose to only set the FPSCR's FPRF bits during a
> > > division by zero situation when the FPSCR[ZE] is not set.
> > > What currently happens is these bits are always set. This
> > > patch fixes this problem by checking the FPSCR[ZE] bit to
> > > decide if the FPRF bits should be set.
> > >=20
> > > https://www.pdfdrive.net/powerpc-microprocessor-family-the-programmin=
g-environments-for-32-e3087633.html
> > > This document has the information on the fdiv. Page 133 has the
> > > information on what action is executed when a division by zero
> > > situation takes place.
> >=20
> > I'm looking at that table and there is definitely no mention of a 0
> > *result* in any situation.  So this patch is definitely wrong on that
> > point.  If there's something else this is fixing, then the commit
> > message needs to describe that.
>=20
> I did not find any mention of a zero result *yet*. There could be mention=
 of
> something in another document. I will see what I can find. Right now I do
> have example code that I ran on a PowerPC 970 CPU and the results are as
> follows:
>=20
> When dividing by zero:
>=20
> if FPSCR[ZE] is enabled
> 	then answer =3D 0

Really?  Or is it just that the result register already contained zero
and is being left unchanged as the document says should happen?

> if FPSCR[ZE] is disabled
> 	then answer =3D 0x7ff0000000000000
>=20
> I think this feature may be undocumented.
>=20
> Here is the example program I used. When I ran this program, the FPSCR is
> set to zero initially (all bits disabled). When the mtfsb1 instruction is
> executed, the ZE bit is set. I ran this program twice. Once with the mtfs=
b1
> line uncommented, and another time with the line commented. The result for
> the answer was different in each situation.
>=20
> #include <stdio.h>
> #include <stdint.h>
> #include <inttypes.h>
>=20
> // Used to convert unsigned integer <--> double
> union Converter
> {
>     double d;
>     uint64_t i;
> };
> typedef union Converter Converter;
>=20
> int main (int argc, const char * argv[]) {
>     Converter answer;
>     //asm volatile("mtfsb1 27"); /* Set ZE bit */
>     asm volatile("fdiv %0, %1, %2" : "=3Df"(answer.d) : "f"(1.0), "f"(0.0=
));
>     printf("answer =3D 0x%" PRIx64 "\n", answer.i);
>     return 0;
> }
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlswYMIACgkQbDjKyiDZ
s5LkHQ/9HylqRQCkgVuDBiPxmE3opswxcPbJoJzpIGcYMh36I6GkLenMnseuzWxv
gpZD5WJzQuouaqGexaCsTDwMrBll4FM3lJnyagLLTUc77SQQLxEs8kO2rszqxKI5
QOJ7fZzmC5ma9zm981K4hTALGPlrm7XbfZA/z5lF1ANXeWa+yixcdrImV3Br1ufG
mh0LgBujh7PiinZzxdeSI2+f9KxIRxYju/sQR+rhvHqgngacCtMz/4STuJy9iEZG
cMJtBbbasstY1i+7MBMKsehDZMjYXvKh54ks4e6zjDXIyHUHBsBmF8v5/846rzxL
iAXUJLZn/WDI9bwx7tMz4pivjCyWC87Q/xPYqzYWzKJX8XJa+KizpswHZryVX+lm
nY19OT3uThOqqzzA0MbO/cCtGX/f3O3W1UY4wuWXKE0LhGKXPFZoolbiGRW8Ra7H
l6uKNuyx1vpydxViWir6fea6gdNxDgFLcUXnftLP5ihtLXLrkoL01I011fQCqktX
ANCBSCoZk73jjK/oJrvhKVHmDhMkq7TxuP1fSz+uXTlL+BgQmace5qo5NtcvIz/j
ak24mfDRlT1xeML2MvCaJVs0pYEZW+Iz+xwRUVyr/2uR+/o8bgGSunYZvQk4YkGx
DPCYLS0rkyX4b1M9OWP5qE/iwpLjHnQNWS2gC1TgZkxMV5XM9ow=
=So/y
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
