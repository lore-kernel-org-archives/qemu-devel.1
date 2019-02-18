Received: from eggs.gnu.org ([209.51.188.92]:54100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gveoA-00032R-Ea
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvegO-0002lj-En
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:53:49 -0500
Date: Mon, 18 Feb 2019 17:47:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190218064709.GD9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 02/12] target/ppci/mmu: Use LPCR:HR to
 chose radix vs. hash translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:19PM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Now that LPCR:HR is set properly for SPAPR, use it for deciding
> the translation type, which also works for bare metal
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/mmu-book3s-v3.h | 14 +++++++++-----
>  target/ppc/mmu-book3s-v3.c | 11 ++++++++++-
>  target/ppc/mmu_helper.c    |  9 ++-------
>  3 files changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index fdf80987d7b2..41b77158622a 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -43,14 +43,18 @@ static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
>  }
> =20
> -static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> +/*
> + * The LPCR:HR bit is a shortcut that avoids having to
> + * dig out the partition table in the fast path. This is
> + * also how the HW uses it.
> + */
> +static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
>  {
> -    PPCVirtualHypervisorClass *vhc =3D
> -        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> -
> -    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> +    return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
>  }
> =20
> +hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
> +
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx);
> =20
> diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> index b60df4408f3b..a174e7efc57c 100644
> --- a/target/ppc/mmu-book3s-v3.c
> +++ b/target/ppc/mmu-book3s-v3.c
> @@ -26,9 +26,18 @@
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                                int mmu_idx)
>  {
> -    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> +    if (ppc64_v3_radix(cpu)) { /* Guest uses radix */
>          return ppc_radix64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>      } else { /* Guest uses hash */
>          return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
>      }
>  }
> +
> +hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr)
> +{
> +    if (ppc64_v3_radix(cpu)) {
> +        return ppc_radix64_get_phys_page_debug(cpu, eaddr);
> +    } else {
> +        return ppc_hash64_get_phys_page_debug(cpu, eaddr);
> +    }
> +}
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index cefed34da4f2..ae81ee18ae95 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1342,7 +1342,7 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf=
, CPUPPCState *env)
>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>          break;
>      case POWERPC_MMU_3_00:
> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +        if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
>              /* TODO - Unsupported */
>          } else {
>              dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> @@ -1497,12 +1497,7 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
addr addr)
>      case POWERPC_MMU_2_07:
>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>      case POWERPC_MMU_3_00:
> -        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> -            return ppc_radix64_get_phys_page_debug(cpu, addr);
> -        } else {
> -            return ppc_hash64_get_phys_page_debug(cpu, addr);
> -        }
> -        break;
> +        return ppc64_v3_get_phys_page_debug(cpu, addr);
>  #endif
> =20
>      case POWERPC_MMU_32B:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxqVOoACgkQbDjKyiDZ
s5Kb8xAA2JdIy0GQ7e4dYU7BB99Ipuw12wFol+KALHAccGDfEGSCrvjGm0ukWLIX
vG2BvqLy6DWf0S6Di5qKuBl2sN5EkiLlPmmwVuaBJqZTj+feiCez87n3sDfSfbOE
zX9FX243b9nktoOq6n2rjNPsyDa3WkU/h4Cc2qW0e4JuBXgloY57VlKtF0+BUtA5
X2x7mnd63CtYN2HZz2IOD1tUsCWBjwA0b/jmGZCLKwZnuQo5N9ywO3hrWgJsUlxy
LllEGGDIfyuxU/VTyCf+YrCqjx9wNzSAGolT+BSn3snz3SsALaU65o+DnFJv4sSp
Jie7VgHPLm3AHNFQ62k9JzS8CgzJdMh6NWS5GK6GSL7XDd6cHjJkEKX3PHyWdOz8
q8pfMi4gyS2Aw+uL+L7o17Mg0egVty+jPCdPDAlQLTii8lB6vZz34BudHjlIM3Mb
lsiHfef2b60IArYwAkWgD+JvVXsXfy0StupFl/m+oIqMMBPntht/PEAcAiApnzCf
/vZikF7spY9jfSPGItizjnpGL47s1C5y5lwiCDcLpKnFP5A0SuRltAUHYfM+fVQs
aNH/PIRz7b1KiqC6o0DkuHuHCy1zG4nGS0vvGBdlzzLiOVmjDArqpMgc2KbGTcU8
DyTpGsaouO/RrA2bbTj23UnUPNO6dwHezce7xsma8oXHrZGkaMo=
=tPuf
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
