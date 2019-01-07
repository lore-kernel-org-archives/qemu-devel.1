Received: from eggs.gnu.org ([209.51.188.92]:49938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggMnX-0006R8-2x
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 23:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggMnW-0000Gi-1I
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 23:45:59 -0500
Date: Mon, 7 Jan 2019 15:29:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190107042943.GE13339@umbus.fritz.box>
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-9-clg@kaod.org>
	<20190103043340.GT10853@umbus.fritz.box>
	<f21712f9-0b67-cbe2-fa5c-7207dd9321be@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <f21712f9-0b67-cbe2-fa5c-7207dd9321be@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xics: allow ICSState to have an
 offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 06:45:25PM +0100, C=E9dric Le Goater wrote:
> On 1/3/19 5:33 AM, David Gibson wrote:
> > On Wed, Jan 02, 2019 at 06:57:41AM +0100, C=E9dric Le Goater wrote:
> >> commit 15ed653fa49a ("ppc/xics: An ICS with offset 0 is assumed to be
> >> uninitialized") introduced an extra check on the ICS offset which is
> >> not strictly necessary.
> >=20
> > The commit message for that suggests it was added to make pnv easier.
> > I take it you no longer need this for the current or expected pnv
> > code?
>=20
> This is really just a runtime check which makes sure that the=20
> ICSState offset is initialized by the FW before being used.
>=20
> The problem is more global. It comes from the fact the ICSState=20
> offset in QEMU and the XICS offset in KVM is hardcoded to 0x1000.=20
>=20
>   Thinking aloud :
>=20
>     May be we should default the offset to 0 and introduce a service=20
>     to set the value in QEMU and KVM.  =20
>=20
> The 'dual' interrupt mode (using the qirq array at the machine level)=20
> needs the IRQ number space of the XIVE and XICS interrupt mode to
> be in sync, that is to start a 0x0, even if the lower 4K are ignored
> in XICS.  =20
>=20
> So the 'dual' mode tunes the offset to 0 once the ICSState is created
> and ignores the lower 4K when initializing the KVM XICS device.

Hm, ok.

I've applied patches 5..8.

>=20
> C.
>=20
> >> Revert the change to be able to map the XICS IRQ number space on the
> >> XIVE IRQ number space.
> >=20
> >=20
> >=20
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xics.h | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >> index 7668c381a887..07508cbd217e 100644
> >> --- a/include/hw/ppc/xics.h
> >> +++ b/include/hw/ppc/xics.h
> >> @@ -139,8 +139,7 @@ struct ICSState {
> >> =20
> >>  static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
> >>  {
> >> -    return (ics->offset !=3D 0) && (nr >=3D ics->offset)
> >> -        && (nr < (ics->offset + ics->nr_irqs));
> >> +    return (nr >=3D ics->offset) && (nr < (ics->offset + ics->nr_irqs=
));
> >>  }
> >> =20
> >>  struct ICSIRQState {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwy1bMACgkQbDjKyiDZ
s5LJfxAAnTLQkfeQWVd38mHAAWFEvQs+G1rCoN454juPmCvdGT/yejN2j4H31/94
Uww+oi58aOOct3XxWV7z7zc0EuAOvS3SMsYPAsVQuwQ4/Xk4VQFc353rOnUhC80O
ITtmbLMoh994cAORT5+WDkAPUcHolSE3TW8id3+kqTlO4hK8sJ7qK6C7mFIO0aQQ
v2dnaKxN1gLC1yP7ICHskcODL7na/+gHP1yBHbhtkIKy9CECTTm7lwLeghoeffOj
UEh1QWcQX/TI0uvpjD7GqpZWlQsXZfNuhiQK6abwctFEIQ3FT5BoNpULSi1C+11K
QzmXIx6qmQd+oBkB6koeJDrS40LRqBpZKRJ2SG+m+/sO1THjYos5+KEDCV3VlvG1
iEFnBKwjPWlS82FsGsU0nC+bTA1PCX6rEZJvm3dn5xYrhuF1yC+DwcnMcdVe/agQ
/sCKIVzzfkYlBJoJDFGdsnRt7PVNhSzf0jVXq3mJGEuFp//SH2GhBArbQDdcEQ5D
aupgetroHNFGbLWhH55Wjp5A7wC/ahDzKFcnlCzN3spmC8FL4JLQtgZTVtSI95BD
fx8R7+y7p90cUls5wipoB10FwcydRdl/sZQE4Yj9TFJ3e+bPvdIi/qQG9racQhD5
pTorvY5/qXlzPuZmIIfY6MuTuRHMFZC1RBB0iKe2GWGdJTJdByg=
=+inr
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
