Received: from eggs.gnu.org ([2001:4830:134:3::10]:35829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePcZq-0004FI-S4
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePcZm-0001cm-SU
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:06:06 -0500
Date: Fri, 15 Dec 2017 09:50:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171214225041.GZ2226@umbus.fritz.box>
References: <20171214180948.981-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ar0NSVY9gjTGNA2"
Content-Disposition: inline
In-Reply-To: <20171214180948.981-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: don't initialize PATB entry if
 max-cpu-compat < power9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--1ar0NSVY9gjTGNA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 07:09:48PM +0100, Laurent Vivier wrote:
> if KVM is enabled and KVM capabilities MMU radix is available,
> the partition table entry (patb_entry) for the radix mode is
> initialized by default in ppc_spapr_reset().
>=20
> It's a problem if we want to migrate the guest to a POWER8 host
> while the kernel is not started to set the value to the one
> expected for a POWER8 CPU.
>=20
> The "-machine max-cpu-compat=3Dpower8" should allow to migrate
> a POWER9 KVM host to a POWER8 KVM host, but because patb_entry
> is set, the destination QEMU tries to enable radix mode on the
> POWER8 host. This fails and cancels the migration:
>=20
>     Process table config unsupported by the host
>     error while loading state for instance 0x0 of device 'spapr'
>     load of migration failed: Invalid argument
>=20
> This patch doesn't set the PATB entry if the user provides
> a CPU compatibility mode that doesn't support radix mode.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-2.12.

> ---
>  hw/ppc/spapr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1ac7eb0f8c..66d0ed5256 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1440,7 +1440,10 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> -    if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
> +    first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> +    if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
> +        ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                         spapr->max_compat_pvr)) {
>          /* If using KVM with radix mode available, VCPUs can be started
>           * without a HPT because KVM will start them in radix mode.
>           * Set the GR bit in PATB so that we know there is no HPT. */
> @@ -1499,7 +1502,6 @@ static void ppc_spapr_reset(void)
>      g_free(fdt);
> =20
>      /* Set up the entry state */
> -    first_ppc_cpu =3D POWERPC_CPU(first_cpu);
>      first_ppc_cpu->env.gpr[3] =3D fdt_addr;
>      first_ppc_cpu->env.gpr[5] =3D 0;
>      first_cpu->halted =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ar0NSVY9gjTGNA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozAD4ACgkQbDjKyiDZ
s5JfrRAAmk/xXCZWhrtCJGCoC7gbu76m7taeXTrf6+sBy06uRvMNrs+m+GIoV9Wb
VX3ZExO3rw3JQK5EdbDoHFaL4woNoc986ZRDzaHiAkgnMvWgx1AxGeprLxJ8eGc8
GbNZt8ANNO+3I8H8mKIcSXGx+cvgPkyQgV+2Ozyl0OuNijb69l0ZrQxmZuioC00e
k78Vchha6XfEDCbDoqhsJoshV/nymZIeFTRrRPrOmqMfJkpvBUJDT/f9yZyDjCVW
VVHXRK+9umPLgDkfOB6bbD3g8l99i3nl8+2qmis7xORISAFniOm0Q+/XI9KoydRo
Xpr+BvBJ+I1LwFGBI2rGk8Xwu5079e2sSav8UsOpks5FiU898HfkLaUCKWlxeR0q
zgz2G0lsHR5TgUUPW6EE6WBw1mW+/z/P82cq1+vdBk300tjHgSEh/aBnnEMzJJ7L
YO1/IT8B7UcoURqnL0oAStsXJ6AVBnIB5ylr+eQUED7e7K8RXAJ1AuxM1VLpOQgD
hHjSaphvNtNZiSkKXdtAQL9VRu/GbhlibiRO3GTIO342xyikr02OVjlzrAU7Gp4s
kon/49oljHmYYccCJqVhbTi903be6HyZAAfuVcTy/jW1w0SWWpXkQIPwSCnpkvNs
FZDnDdw2EemFlpucsyfDOhHI6xmH7ShU1+FqQ1j2b18WOnYwVEg=
=Ecqr
-----END PGP SIGNATURE-----

--1ar0NSVY9gjTGNA2--
