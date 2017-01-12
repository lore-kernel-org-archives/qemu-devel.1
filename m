Received: from eggs.gnu.org ([2001:4830:134:3::10]:48376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRXux-0003da-Bj
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRXuu-0008Iy-7w
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 00:27:19 -0500
Date: Thu, 12 Jan 2017 16:09:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112050920.GO14026@umbus.fritz.box>
References: <20161222052212.49006-1-aik@ozlabs.ru>
	<20161222052212.49006-3-aik@ozlabs.ru>
	<20170102234128.GI12761@umbus.fritz.box>
	<61109e6f-434a-303e-f0fc-bf1dab1ed63f@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7pXD3OQNRL3RjWCz"
Content-Disposition: inline
In-Reply-To: <61109e6f-434a-303e-f0fc-bf1dab1ed63f@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu 2/2] spapr_pci: Advertise 16M IOMMU
 pages when available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--7pXD3OQNRL3RjWCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 01:06:03PM +1100, Alexey Kardashevskiy wrote:
> On 03/01/17 10:41, David Gibson wrote:
> > On Thu, Dec 22, 2016 at 04:22:12PM +1100, Alexey Kardashevskiy wrote:
> >> On sPAPR, IOMMU page size varies and if QEMU is running with RAM
> >> backed with hugepages, we can advertise this to the guest so does
> >> this patch.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  hw/ppc/spapr_pci.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> >> index fd6fc1d953..09244056fc 100644
> >> --- a/hw/ppc/spapr_pci.c
> >> +++ b/hw/ppc/spapr_pci.c
> >> @@ -1505,6 +1505,9 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >>      }
> >> =20
> >>      /* DMA setup */
> >> +    /* This allows huge pages for IOMMU when guest is backed with hug=
e pages */
> >> +    sphb->page_size_mask |=3D qemu_getrampagesize();
> >=20
> > This doesn't look right - you're unconditionally enabling the host ram
> > page size, regardless of anything else.  Instead the backing page size
> > should be used to filter out those sizes which are possible from the
> > list of those supported by the guest hardware.  This patch will give
> > particularly odd results if you ran it on x86 with hugepages for
> > example: it would advertise a 2M IOMMU page size, which could never
> > exist on native POWER.
>=20
> Ok, I'll filter 16M out if passed to PHB and not supported by the host.
>=20
>=20
> > Except... come to think of it, why is the backing RAM page size
> > relevant at all?=20
>=20
> Because this is just an optimization/acceleration and I'd think the user
> wants to know if it is actually accelerated or not. If I always allow 16M
> pages, and QEMU is not backed with hugepages, then all H_PUT_TCE will go
> via slow path and consume as much memory for TCE as without hugepages, and
> it will only be visible to the user if TCE-tracepoints are enabled.

Hm, ok, fair enough.

> > Or rather.. I think VFIO should be able to cope with
> > any guest IOMMU page size which is larger than the host ram page size
>=20
> It could, I just do not see much benefit in it. pseries guest can negotia=
te
> 4k, 64k, 16m pages and this seems to cover everything we want, why would =
we
> want to emulate IOMMU page size?

Just for testing or debugging, I suppose.

>=20
> > (although if it's much larger it could get expensive in the host
> > tables).  This case would already be routine for ppc64 on x86, where
> > the guest IOMMU page size is 64kiB, but the host page size is 4 kiB.
>=20
>=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7pXD3OQNRL3RjWCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdw+AAAoJEGw4ysog2bOS3lEQAKZ38Sd+MZ1mBe1IDkfQJOjj
3+O20ph/hEL02oRnXtB+TX8Av6EAtk94gCEP1boKLv/sec1tipKxggjBSm4/gLhD
SxE3Lfs51DNkFWgfYnHRMA59DKaE/VE3Gzpi2t3lSzDe2U3eofmjUSB92KKrAHp6
vnxU/argqmtSx5/lZgtFb1YN7fRMWHfZ+UjnbYa8+tnXuGpFaKhtd7J2L6wQLjDX
Ox0dl19UdPt7nEc/kpSddtaVRbIkPQEvESGrI07Y+nhMAQEtM2xC1yIzAELh/z57
bwJv8JE7LxG5cys3iUH8P9ATnRHfSHG6bRj9u9yC8OTFI+ekRmon7qLhmX55SGFQ
Z/sTL8PxxSoEtqXCsQUVtrXeQGPU+bSAi6+EdCz7sxDBqJuXbi+S3q+E2P0Q7FaM
iBKt5pzR75SHFa4EQYxn39UOJvWaTFsnsqK6vhTG4NvELKzF9GW1Cgq2tHbzNH5m
t9qCLdX6vMZYAktywwwbJ/4NMj9lqqysK1tHBSMNKEeTpgcxg1E10k4k77Pgscgx
bXltj59E6XtRngomRPMuW+XxcvVNqwUGiGn1TUvsynoHXHd9IXf2Z6jRHXEIQHY1
xJpurlARJqCkyD/LBuuAB0EWRUBAa80yIfaZ0ZIRu6xs0OJc8TGL8wfbXTEPvMS2
ViN3RTG3t+fwDxLArafA
=YJP2
-----END PGP SIGNATURE-----

--7pXD3OQNRL3RjWCz--
