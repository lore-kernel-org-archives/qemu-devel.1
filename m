Received: from eggs.gnu.org ([2001:4830:134:3::10]:37381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTzzm-0004yO-P4
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTzzk-000580-Sz
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 20:59:30 -0500
Date: Tue, 4 Dec 2018 12:56:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181204015621.GG1682@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-17-clg@kaod.org>
	<20181128042547.GZ2251@umbus.fritz.box>
	<a57f6b4b-414e-efe7-475d-e6cbb87f61a8@kaod.org>
	<20181129012355.GP2251@umbus.fritz.box>
	<898d49bd-e430-fd07-e1ee-10d5822e3757@kaod.org>
	<20181130012315.GH30479@umbus.fritz.box>
	<35df014a-1876-1fa2-291c-880d15222a58@kaod.org>
	<20181203013640.GR30479@umbus.fritz.box>
	<bdc46ea5-aea5-566d-5262-95d84857e2c4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <bdc46ea5-aea5-566d-5262-95d84857e2c4@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 16/36] spapr: add hcalls support for the
 XIVE exploitation interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 05:49:37PM +0100, C=E9dric Le Goater wrote:
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    switch (qsize) {
> >>>>>>>> +    case 12:
> >>>>>>>> +    case 16:
> >>>>>>>> +    case 21:
> >>>>>>>> +    case 24:
> >>>>>>>> +        end.w3 =3D ((uint64_t)qpage) & 0xffffffff;
> >>>>>>>
> >>>>>>> It just occurred to me that I haven't been looking for this acros=
s any
> >>>>>>> of these reviews.  Don't you need byteswaps when accessing these
> >>>>>>> in-memory structures?
> >>>>>>
> >>>>>> yes this is done when some event data is enqueued in the EQ.
> >>>>>
> >>>>> I'm not talking about the data in the EQ itself, but the fields in =
the
> >>>>> END (and the NVT).
> >>>>
> >>>> XIVE is all BE.
> >>>
> >>> Yes... the qemu host might not be, which is why you need byteswaps.
> >>
> >> ok. I understand.
> >>
> >>> I realized eventually you have the swaps in your pnv get/set
> >>> accessors. =20
> >>
> >> Yes. because skiboot is BE, like the XIVE structures.
> >=20
> > skiboot's endiannness isn't really relevant, because we're modelling
> > below that level.
> >=20
> >>> I don't like that at all for a couple of reasons:
> >>>
> >>> 1) Although the END structure is made up of word-sized fields because
> >>> that's convenient, the END really is made of a bunch of subfields of
> >>> different sizes.  Knowing that it wouldn't be unreasonable for people
> >>> to expect they can look into the XIVE by byte offsets;=20
> >>
> >> These structures should be accessed with GETFIELD and SETFIELD macros
> >> using the XIVE definitions in the xive_regs.h header file. I would wan=
t=20
> >> to keep that common with skiboot  for sure.
> >=20
> > Right.  It might make sense to make some helper macros or inlines that
> > include both the GETFIELD/SETFIELD and the byteswap.
>=20
> ah. I have to evaluate the added complexity, because we don't really
> have a struct. it's just an array of BE words.

You're still treating as a struct which reflects an in-memory layout,
even if all the fields are words of the same size.

> So for each field or bit we are interested in, we would have an helper=20
> routine picking the correct word from the XIVE structure, doing the=20
> byteswap and extracting the value ?
>=20
> sigh.

Oh, no, I was just thinking a version of GETFIELD that byteswaps the
value before extracting the given field.  Likewise a SETFIELD variant
that swaps, deposits the field, then swaps back.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwF3sUACgkQbDjKyiDZ
s5LFZg/+JUUihmpgR6X5CFmJrdbQiZtDZU4yTiGY3hg4Z1iCmUSfVDkmZFWzoWg4
zdPR05ajtTawc9e/HJ3pv76IvO8fnsQprFLVac8lfMn1/ZMtlbCtfMv0IhKFOb17
RrmkpIqLF82dRuv3jYGTmULsVdFSY+1l8r3IH/AG+theKp0V3RNJKC69DE1bWunr
KGIqI8k0foJJDr5MvUWKd/gVleYTOo8uBM+wC8iy36GH709X3V5O+twhJO6OeTh6
wFPc6leeSjVBtrg4Gz17IT/4sOjeQmnVzKOldKsZjprF28pA6PvO+c1maQcCkwkT
6p036x3yXJqWZluBiiuTHSBlTjC2tKlGgtnxrxamIU30CHGB+XVZBVuX1UJoElUO
jb96j2NJWCX0l2mJkd9syvpNRyCnceyQC1Qn5e5Wp7+ryjG7M+4iZe/bPWlsRuYu
9HwR1ktcYuslnvjhbx2K0irvs9wkdCPEGnf1smlwL7YBJEipvTKzrRlgdwxAds2X
02+TF3Vu42TW1s2Xdacs+96jcY7ZAerX8INA+oxW/klYbd664KC/zr6qmJKroV3y
aRG+DrvbL4pp9ybceG2r3s2PkHqAnmG99id53Rtne6Gnp4grSsG2qp5t6JKY7Ysh
y7Sdjpnmah4TXySBmrQQ35aaZKhRq4IjXVJPrpyvZGZrggGOdMY=
=7sLy
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
