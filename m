Received: from eggs.gnu.org ([2001:4830:134:3::10]:36658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ex5pg-0000wN-Gt
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 03:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ex5pf-00040l-B6
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 03:00:48 -0400
Date: Sat, 17 Mar 2018 15:15:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180317041504.GF4525@umbus.fritz.box>
References: <20180315133402.13470-1-clg@kaod.org>
	<20180315133402.13470-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20180315133402.13470-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] target/ppc: export external HPT via
 virtual hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 01:33:59PM +0000, C=E9dric Le Goater wrote:
> commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
> hypervisor") exported a set of methods to manipulate the HPT from the
> core hash MMU but the base address of the HPT was not part of them and
> SPR_SDR1 is still used under some circumstances, which is incorrect
> for the sPAPR machines.
>=20
> This is not a major change as only the logging should be impacted but
> nevertheless, it will help to introduce support for the hash MMU on
> POWER9 PowerNV machines.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This doesn't make sense.  The whole point of the "virtual hypervisor"
is that the hash table doesn't live within the guest address space,
and therefore it *has* no meaningful base address.  Basically
ppc_hash64_hpt_base() should never be called if vhyp is set.  If it
is, that's a bug.

> ---
>  hw/ppc/spapr.c          | 8 ++++++++
>  target/ppc/cpu.h        | 1 +
>  target/ppc/mmu-hash64.h | 5 +++++
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f1798457bc4d..2329664e0c2c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1327,6 +1327,13 @@ static hwaddr spapr_hpt_mask(PPCVirtualHypervisor =
*vhyp)
>      return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
>  }
> =20
> +static hwaddr spapr_hpt_base(PPCVirtualHypervisor *vhyp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> +
> +    return (hwaddr) spapr->htab;
> +}
> +
>  static target_ulong spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vh=
yp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
> @@ -4073,6 +4080,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->phb_placement =3D spapr_phb_placement;
>      vhc->hypercall =3D emulate_spapr_hypercall;
>      vhc->hpt_mask =3D spapr_hpt_mask;
> +    vhc->hpt_base =3D spapr_hpt_base;
>      vhc->map_hptes =3D spapr_map_hptes;
>      vhc->unmap_hptes =3D spapr_unmap_hptes;
>      vhc->store_hpte =3D spapr_store_hpte;
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7bde1884a142..4de0653a3984 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1258,6 +1258,7 @@ struct PPCVirtualHypervisorClass {
>      InterfaceClass parent;
>      void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
>      hwaddr (*hpt_mask)(PPCVirtualHypervisor *vhyp);
> +    hwaddr (*hpt_base)(PPCVirtualHypervisor *vhyp);
>      const ppc_hash_pte64_t *(*map_hptes)(PPCVirtualHypervisor *vhyp,
>                                           hwaddr ptex, int n);
>      void (*unmap_hptes)(PPCVirtualHypervisor *vhyp,
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index d297b97d3773..0ade8d15d9e4 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -100,6 +100,11 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
> =20
>  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>  {
> +    if (cpu->vhyp) {
> +        PPCVirtualHypervisorClass *vhc =3D
> +            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +        return vhc->hpt_base(cpu->vhyp);
> +    }
>      return cpu->env.spr[SPR_SDR1] & SDR_64_HTABORG;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqslkMACgkQbDjKyiDZ
s5Lwbw//fk+asKgtsON3HGC4rCziFNZaae8pgj6QE13YDY+Zx0r24RwBxMlQgl74
OHth9ZURnQzFdmIyKg7Y+vTmlnxzYZk+PKAFrJ4Jobo3tow9SphiYBPy3t+QljCT
j/PpqowWyUZBy6DkYTDo8KI39YwNIgF1rPx6pAYwNIBJ1+vMyhZPeZrNH5aZOKVG
MfB1wCLkjgdJthb9vGcXUq6TwElpSo3TyI6WjR267R06ug8rBZOtWT16ClbyQxEM
vy5EEqbbiN2T8biig8q7Sam9H+XNrERXoVcUeY9aRHHyF+PCG5jetYqsaFL8tG1h
tiMWAe1S5uZK0Q5QQix2tVqQ/BHvB1cL+eM7Nkw7mqOXYmajBBavaNQH9OVniue/
fCxawloCCOgQISoOJQUhGV2F3ThIT+z1DmuBdmEjOrWpN8nHXSkm7FDZZZbapMfS
Dgx5BQjYTq8ShW9DmPkG6mmDAENxYr7+jqcnZG4h0BhMJ5TmQf5bQhXy88wFLclC
zlBsF158Bnp3cfpGraWPD3h1OAJk0C3YYMAeyi3Y4JsJjOiBcP4yP0Ix57ovKaTe
cGtXChHlxm990kkO8ZQ5elTb9y2Xb2ZJzaI1PF2HIfJn92vpmukGlLWL+KaMp5CG
k1A9nHdMyjPbOnrkf9AyLKWv5xnqQdvWC1m/D8pp7ZDFXMk+o2U=
=3sjU
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
