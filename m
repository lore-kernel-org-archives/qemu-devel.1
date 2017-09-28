Received: from eggs.gnu.org ([2001:4830:134:3::10]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxix9-0000Kx-7k
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxix6-00013w-1a
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:14:51 -0400
Date: Thu, 28 Sep 2017 23:17:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928131744.GF6445@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170919082020.GT27153@umbus> <20170919084618.GY27153@umbus>
	<98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
	<1506587002.25626.20.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <1506587002.25626.20.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the
 XIVE interrupt controller (POWER9)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
List-ID: <qemu-devel.nongnu.org>


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 10:23:22AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2017-09-20 at 14:33 +0200, C=E9dric Le Goater wrote:
> > > > I'm thinking maybe trying to support the CAS negotiation of interru=
pt
> > > > controller from day 1 is warping the design.  A better approach mig=
ht
> > > > be first to implement XIVE only when given a specific machine optio=
n -
> > > > guest gets one or the other and can't negotiate.
> >=20
> > ok.=20
> >=20
> > CAS is not the most complex problem, we mostly need to share=20
> > the ICSIRQState array and the source offset. migration from older
> > machine is a problem. We are doomed to keep the existing XICS
> > framework available.
>=20
> I don't like sharing anything. I'd rather we had separate objects
> alltogether. If needed we can implement CAS by doing a partition reboot
> like pHyp does, at least initially, until we add ways to tear down and
> rebuild objects.

Right, I agree.  The difficulty isn't really CAS reboot or not, it's
more that altering the virtual hardware at runtime is.. awkward.. in
qemu.  And then there's the issue of migrating the state, which also
gets a bit complex.

As you've seen elsewhere, I think we need to get the XIVE model right
on its own first, then worry about those issues.

> The main issue is whether we can keep a consistent number space so the
> DT doesn't have to be completely rebuilt. If it does, then reboot will
> be the only practical option I'm afraid.

I think it should be possible to make a consistent number space.  At
present the irq allocation is kind of tied to xics, but I think that's
fixable.

> > > > That should allow a more natural XIVE design to emerge, *then* we c=
an
> > > > look at what's necessary to make boot-time negotiation possible.
> > >=20
> > > Actually, it just occurred to me that we might be making life hard for
> > > ourselves by trying to actually switch between full XICS and XIVE
> > > models.  Coudln't we have new machine types always construct the XIVE
> > > infrastructure,=20
> >=20
> > yes.
> >=20
> > > but then implement the XICS RTAS and hcalls in terms of the XIVE virt=
ual=20
> > > hardware.
>=20
> That's gross :-)
>=20
> This is also exactly what KVM does with real XIVE HW and there's also
> such an emulation in OPAL. I'd be weary of creating a 3rd one...
>=20
> I'd much prefer if we managed to:
>=20
>  - Split the source numbering from the various state tracking objects
> so we can have that common
>=20
>  - Either delay the creation to after CAS or tear down & re-create the
> state tracking objects at CAS time.
>=20
> > ok but migration will not be supported.
> >=20
> > > Since something more or less equivalent
> > > has already been done in both OPAL and the host kernel, I'm guessing
> > > this shouldn't be too hard at this point.
>=20
> It would very much suck to have yet another one of these.

Hm, ok.

> Also we need to understand how that would work in a KVM context, the
> kernel will provide a "XICS" state even on top of XIVE unless we switch
> the kernel object to native, but then the kernel will expect full
> exploitation.
>=20
> > Indeed that is how it is working currently on P9 kvm guests. hcalls are
> > implemented on top of XIVE native.
> >=20
> > Thanks,
> >=20
> >=20
> > C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnM9ngACgkQbDjKyiDZ
s5JaWxAAtnFRTzzPBHuFZ7LDTSJ6Yr6S6BEfuHG77lndehDvG+3cL5+QBmJZyLDE
H5RVP4rgNttz8J0AjH/HhN4Q5qRRrhe1vIpMgA+fj9lzmU/imv48K2kbaDXZMgwE
af8fT/ODgbQfTuMCVRJe7ZBGdIKweYxbErniqwtR+Bw4LjAC8mxLwNAFEF1RbOeZ
oWj//tMVE2IQaq6l24Q2msxBSoI6ypvuonCRPxH3+aTFphTfl4aL22YkAv7g93HJ
lXbqcd5BinfV9d26/NMjZ0czwVIErELMKly/IM2iCLOsoNhWIQouo4jINz17VzLr
XBYAEkhQRi8P0sqGlAPufY8++g1BBh6e1YB44V/Qo8zXJpumII7+/3IyGLKAcJ43
kZnKIuRCL8xGEfA5lg28CxuFUPvXsMbmeDHbE2OI4t0cl4rU8Us13/8+lr1F63TK
8fdcZs+yUW8ejvpEcliPzahDRBR0x6PuLJ6eCC/CMkqVil9q0B+v1b0mOJfFeXI0
cTDstXo5HzL5kwomN57gT12IxNIeHj1m19Urtd6ciaTeCFzoKp1/sMO9HEDOueco
UF/HZy4aZXCevucNCbPxtzrhbl+zmKGsEwyL+DzYdDesYsyrfeOkQ4LTzzjO+y0r
UM1dMxKm8AIkniDGnPfCOt9bnzW8VgsRmAt9NOPfyDYxHRbZweY=
=Nh1X
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
