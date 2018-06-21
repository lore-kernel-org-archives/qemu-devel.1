Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVo5l-0003dp-Ok
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVo5k-0006uV-Lg
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:08:53 -0400
Date: Thu, 21 Jun 2018 11:08:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621010841.GC32328@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/9] spapr: Clean up pagesize handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 04:35:57PM +1000, David Gibson wrote:
> Currently the "pseries" machine type will (usually) advertise
> different pagesizes to the guest when running under KVM and TCG, which
> is not how things are supposed to work.
>=20
> This comes from poor handling of hardware limitations which mean that
> under KVM HV the guest is unable to use pagesizes larger than those
> backing the guest's RAM on the host side.
>=20
> The new scheme turns things around by having an explicit machine
> parameter controlling the largest page size that the guest is allowed
> to use.  This limitation applies regardless of accelerator.  When
> we're running on KVM HV we ensure that our backing pages are adequate
> to supply the requested guest page sizes, rather than adjusting the
> guest page sizes based on what KVM can supply.
>=20
> This means that in order to use hugepages in a PAPR guest it's
> necessary to add a "cap-hpt-max-page-size=3D16m" machine parameter as
> well as setting the mem-path correctly.  This is a bit more work on
> the user and/or management side, but results in consistent behaviour
> so I think it's worth it.
>=20
> Longer term, we might also use this parameter to control IOMMU page
> sizes.  But, I'm still working out how restrictions deriving from the
> guest kernel, host kernel and hardware capabilities all interact here.
>=20
> This applies on top of my ppc-for-3.0 tree.

Greg, C=E9dric, could you try to review this series pretty soon?

I'd really like to get it merged, because it's the basis for a number
of fixes for assorted problems with hugepage behaviour.

>=20
> Changes since RFC:
>  * Add preliminary cleanups to allow us to evaluate effective
>    capabilities levels earlier.
>  * Don't try to remove double resetting of cpus.  It doesn't quite
>    work, and is no longer necessary with the above.
>  * Some user-friendliness improvements: use "hpt-max-page-size"
>    instead of the cryptic "hpt-mps", and take an actual page size
>    (allowing k/m/g suffixies) instead of a shift
>=20
> David Gibson (9):
>   target/ppc: Allow cpu compatiblity checks based on type, not instance
>   spapr: Compute effective capability values earlier
>   spapr: Add cpu_apply hook to capabilities
>   target/ppc: Add kvmppc_hpt_needs_host_contiguous_pages() helper
>   spapr: Maximum (HPT) pagesize property
>   spapr: Use maximum page size capability to simplify memory backend
>     checking
>   target/ppc: Add ppc_hash64_filter_pagesizes()
>   spapr: Limit available pagesizes to provide a consistent guest
>     environment
>   spapr: Don't rewrite mmu capabilities in KVM mode
>=20
>  hw/ppc/spapr.c          |  45 +++++++-----
>  hw/ppc/spapr_caps.c     | 156 ++++++++++++++++++++++++++++++++++++----
>  hw/ppc/spapr_cpu_core.c |   4 ++
>  include/hw/ppc/spapr.h  |  11 ++-
>  target/ppc/compat.c     |  27 +++++--
>  target/ppc/cpu.h        |   4 ++
>  target/ppc/kvm.c        | 146 ++++++++++++++++++-------------------
>  target/ppc/kvm_ppc.h    |  11 ++-
>  target/ppc/mmu-hash64.c |  59 +++++++++++++++
>  target/ppc/mmu-hash64.h |   3 +
>  10 files changed, 349 insertions(+), 117 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsq+pYACgkQbDjKyiDZ
s5KcBQ/+ILPNeDiyDKskvPNVDD0hD7dbEDVaNkVSw1njGBUhjbdXi5zFaXQGlYgs
SaWcgOW9vpW0DRsqu27vudD90D5WHX6TNrQ+jrQNYvebwSEyzzEMGga2dUf5ZW6T
zeyKJEcdsxtHirY2w4H4prrO3QTExRmGpbCGrmYeDzETYPtQuLGiMgTWmBJtsslU
561xtJSBVynCxMQ/0JbgeVlOh79NP1X23cvWHAYWSkNclbb44JMERzHZpebqSOaR
5KzMNLJt7cOy4s1IBZJY/0cOP6ibKLyFN18Snb/wUtKwMVR2DRjEzJNYB6OwIP9s
BpjuJtnopJ+XGZPXvrtGrPHFtN6XCK0q6oQVp8nB/L1JyceJ1Sh6Aud1tMtmztNG
5pbr+h/68MHPAN2MFPSVcHNeOHFpzzwzm+bZ/FwsK7repE2UWfErE4p312j5unmX
/8Yg8i4vSZ49to54HfPfqmfVVsO0BLufrtpFw7U6HZwcndNa2WqmtyG1JWtXeOXC
w7ND3YqLbAHFIfl/hlmZplaaV53jLll4h4BFX9MZMHLu9+JdDMHLxZPLmXOd0/eJ
SVKoUGktILMEjKIBn3yMm8lCRZ3bMotREpkdR8H02z3ECzo3XFj8oH+54xnVDIhP
Sh50LqqrGUHuwFfvr2mfd6uPSyjVBzL4/At38GAMUslgmrAV6Qg=
=7mgv
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
