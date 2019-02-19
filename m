Received: from eggs.gnu.org ([209.51.188.92]:37357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvxZO-0007T2-Db
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvxZL-0007EB-SP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:03:49 -0500
Date: Tue, 19 Feb 2019 15:05:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219040529.GW9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c7rykKtsZvepKFKR"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-8-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 07/12] target/ppc: Add basic support for
 "new format" HPTE as found on POWER9
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


--c7rykKtsZvepKFKR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:24PM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> POWER9 (arch v3) slightly changes the HPTE format. The B bits move
> from the first to the second half of the HPTE, and the AVPN/ARPN
> are slightly shorter.
>=20
> However, under SPAPR, the hypercalls still take the old format
> (and probably will for the foreseable future).
>=20
> The simplest way to support this is thus to convert the HPTEs from
> new to old format when reading them if the MMU model is v3 and there
> is no virtual hypervisor, leaving the rest of the code unchanged.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Kinda hacky, but definitely the easiest way in the short to medium term.

> ---
>  target/ppc/mmu-book3s-v3.h | 12 ++++++++++++
>  target/ppc/mmu-hash64.h    |  5 +++++
>  target/ppc/mmu-hash64.c    |  5 +++++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 4e59742d7eac..216ff296c088 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -56,6 +56,18 @@ static inline bool ppc64_v3_radix(PowerPCCPU *cpu)
>      return !!(cpu->env.spr[SPR_LPCR] & LPCR_HR);
>  }
> =20
> +static inline void ppc64_v3_new_to_old_hpte(target_ulong *pte0,
> +                                            target_ulong *pte1)
> +{
> +    /* Insert B into pte0 */
> +    *pte0 =3D (*pte0 & HPTE64_V_COMMON_BITS) |
> +            ((*pte1 & HPTE64_R_3_0_SSIZE_MASK) <<
> +             (HPTE64_V_SSIZE_SHIFT - HPTE64_R_3_0_SSIZE_SHIFT));
> +
> +    /* Remove B from pte1 */
> +    *pte1 =3D *pte1 & ~HPTE64_R_3_0_SSIZE_MASK;
> +}
> +
>  hwaddr ppc64_v3_get_phys_page_debug(PowerPCCPU *cpu, vaddr eaddr);
> =20
>  int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index f11efc9cbc1f..016d6b44ee75 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -102,6 +102,11 @@ void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> =20
> +/* Format changes for ARCH v3 */
> +#define HPTE64_V_COMMON_BITS    0x000fffffffffffffULL
> +#define HPTE64_R_3_0_SSIZE_SHIFT 58
> +#define HPTE64_R_3_0_SSIZE_MASK (3ULL << HPTE64_R_3_0_SSIZE_SHIFT)
> +
>  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>  {
>      if (cpu->vhyp) {
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index b3c4d33faa55..9afaab8a177c 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -514,6 +514,11 @@ static hwaddr ppc_hash64_pteg_search(PowerPCCPU *cpu=
, hwaddr hash,
>          smp_rmb();
>          pte1 =3D ppc_hash64_hpte1(cpu, pteg, i);
> =20
> +        /* Convert format if necessary */
> +        if (cpu->env.mmu_model =3D=3D POWERPC_MMU_3_00 && !cpu->vhyp) {
> +            ppc64_v3_new_to_old_hpte(&pte0, &pte1);
> +        }
> +
>          /* This compares V, B, H (secondary) and the AVPN */
>          if (HPTE64_V_COMPARE(pte0, ptem)) {
>              *pshift =3D hpte_page_shift(sps, pte0, pte1);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c7rykKtsZvepKFKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrgIkACgkQbDjKyiDZ
s5J3FxAA5fREPWCJWcCg5yIV+Rw1izzyJrw7nhEX8wc09o6ZgPa+m+0BisRC3x+F
cP8XOHEMpO4l2ZwsrhYBYbJvYHC8gA8tR5z+6w6dc+2QIPfZRExVz2oFrtC+ZqQL
OisM0UqufKYoPGV2J9eXYde8nPypJBATd6qQgC/MoZqgNq9wxXJnpGftccqYbAiL
+5gCFm7pgQc2bQJs8aNfgDSqAEs0zYEkNjHEIMKTHWGlUNqYWUHrJOR2CmG9LHCx
0clMMtYUbE9AFmd6ghdTMQWInkcMb3tOYOp5R5sxtzQvSBbzM5JDo5ffYHGgLEW9
/9zfitt0t0QtAHF+78XJbT9767AiMb72M+2wzg5KIl9ouopP9AgeGzXYv4aNLYwR
5h8zqcozOMPP3L/7N5e8hhwOXFcxALtDPKHexDET5OjWU6FiyH9ZMGgHkNqOndOo
5vFd8/2LMEYKBU+sMnHknc3yLoZ8IOpAn/EMH1VO6FAyQqfAYJZT3HTY1/zHX8ww
kc5JMqyzn2rmWqOCTo4VNKnwt5iDMEMscLOW4n2Id2ra7fEK52Zn7xLmE6JJebLe
JjMS3WcEImNX4jRkIK4wUxa3F2lfI5TklQuU3vLeoGKUOh0eFLrqHjx1EKbSpxfI
HyUOTM1dx+gyX2LIusng+peoUz0dBUWKyehvjgLuwctfif096Vw=
=0MGb
-----END PGP SIGNATURE-----

--c7rykKtsZvepKFKR--
