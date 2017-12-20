Received: from eggs.gnu.org ([2001:4830:134:3::10]:39450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRWu4-000147-Tt
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 00:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRWu3-0007Wt-Nd
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 00:26:52 -0500
Date: Wed, 20 Dec 2017 16:13:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171220051306.GD5981@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-4-clg@kaod.org>
	<0876c4bd-676f-276d-3cf6-aef4a2a562e5@kaod.org>
	<1513558781.2533.0.camel@kernel.crashing.org>
	<5498d8f1-d0a9-c3fd-caa4-8b17867db2c2@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <5498d8f1-d0a9-c3fd-caa4-8b17867db2c2@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 03/19] spapr: introduce the XIVE
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 07:37:31AM +0100, C=E9dric Le Goater wrote:
> On 12/18/2017 01:59 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2017-12-14 at 16:24 +0100, C=E9dric Le Goater wrote:
> >> The API between the source and the IVRE is extremely simple :
> >>
> >>   static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> >>
> >> The IVRE then scans its IVT, finds the EQ, and moves on to the=20
> >> presenter.
> >=20
> > In HW it's an MMIO store between the two units (from the source to the
> > IVRE notification port). I wonder in the long run if we should model
> > that the same way...
>=20
> It's a problem for PowerNV. IVSEs should all have an 'IVT offset'=20
> register and a 'notify trigger port address' address register for=20
> this purpose. Real HW performs a 4bytes store of the IRQ number=20
> to forward the notification to the IVRE. It even makes the model=20
> a little simpler because we don't have to look for the appropriate=20
> PnvXive object to handle the routing. =20
>=20
> For sPAPR, we don't have such MMIOs but still, we could trigger=20
> directly the sPAPRXive object without using the qemu_irq objects
> which stand in the middle. XIVE IPIs don't use them at all and
> only use MMIOs.

Yeah, I think we're going to want a model more explicitly close to
what the hardware does.  It's tempting to shortcut it for PAPR, but a)
it'll probably cause us less trouble when we need to implement powernv
and b) I think it's less likely to break as we fill out the various
details we need.

>=20
> >> So, we can keep the IVRE engine (sPAPRXive) attached directly to=20
> >> the machine like we have today, this is good, and introduce multiple=
=20
> >> XIVE source objects. The sPAPR machine would have :=20
> >>
> >>  - one for the IPIs [ 0 - nr_servers ]
> >>  - one generic for the devices [ 4096 -  ]
> >>  - one for each phb ?=20
> >>
> >> The source address in the overall ESB MMIO region would be calculated=
=20
> >> from the offset of the source IRQ numbers in the IRQ number space.=20
> >> The offset could very well be hardcoded for each device. I don't see=
=20
> >> any XICS compatibility problems as we are sharing correctly the IRQ=20
> >> number space already.
> >>
> >>
> >> I am starting this discussion because the support for XIVE in the=20
> >> QEMU PowerNV machine will need multiple sources, just like for=20
> >> POWER8. PnvXive will be a bit different because the IVRE tables=20
> >> (IVT and EQDT) are in the virtual machine memory. Most of the settings=
=20
> >> are done in the VM. The QEMU PowerNV machine will still have to=20
> >> implement the triggering and the routing logic using the guest tables.=
=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo58WEACgkQbDjKyiDZ
s5IauxAA5w2sDqNt+jwd8eLdMID4WyQJVOGi2aU12R1ITlRKJac9tL3Vp77uvB7M
LmHzu+tXfgZs/Kxb35KHoolRJfGlJGiTTzMoi9x+FxvnSRkbF+khQnf0SR7MBquC
UCPSzJfZ1jwofFN+QPURyKhb2Eqz2NB/2nGClHhKjtedCzV+XWC/7qJh6arBIw/y
o5P5+YumjpgqRv7Wxp4aDnJkgSe9DcEYdzY/eX5Kn0L6H5oG3bXVr1NneOoscjVq
ITOM4mlRXuBgblXeQTbLM4sAMm9KEOwulDGH3rXncpGGZ/Nr/pD5XhAfT0IQh3sq
6IIj7OrDEeh8ukhCm15sb6NqcxWQbzI6+Fc5E7P8/BWx46FCwXZs18WMnFC7vwZU
E0sjzlR9QjzmmTHd6ISNPAtQSMaReu4/4BefegwbrGPyt/+F6ee23yc9VGtnCv5e
SKrKZnhxzo5XmuLxLR71QNxkZiSY08ta12D/aZubkBcn+vFqI82m31JzFsrWFIo8
vEX6haMJX4su/ujwPy8s10jQMn1VIz/yrh9+Oj4Sv9IpY6cQ+Lw1badQ7fIE4vEE
9l7s79lh5LQ1PhwUX2zOhs1AV08gUpcvPZMdRMBp2VUChi9HyZpHLpmErAlnTPLS
wHm4p8V/RD+V/HVSqU3HrZNEEGYS8xzCQ2TBm1nmN0frIlfcop8=
=S4Cj
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
