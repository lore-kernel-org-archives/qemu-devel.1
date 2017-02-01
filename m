Received: from eggs.gnu.org ([2001:4830:134:3::10]:44900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmLn-0006aH-76
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmLk-0003G7-2h
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:16:55 -0500
Date: Wed, 1 Feb 2017 15:09:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201040933.GN30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-9-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8CNmCRe8Sh4keFKJ"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-9-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 08/17] target/ppc/POWER9: Add external
 partition table pointer to cpu state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--8CNmCRe8Sh4keFKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:14PM +1100, Suraj Jitindar Singh wrote:
> Similarly to how we have an external hpt pointer in the cpu state, add
> an external partition table pointer and update it to point to the
> partition table entry in the machine state struct on cpu reset.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

As with the previous patch, I don't quite follow what's going on
here.  It seems to me that if the external HPT is set, that should
make the softmmu logic bypass *both* an HPT set by SDR1 (<=3D POWER8) or
an HPT set by the partition table (POWER9).  So I'm not sure why we
need the dummy partition table entry.

To look at it another way, the external HPT is special because it lies
outside the guest's address space, but we need its state because the
guest can manipulate it via hypercall.  For the partition table entry,
even if we're minimally modelling the HV parts of the POWER9 MMU,
isn't the partition table entry just fixed at startup?

> ---
>  hw/ppc/spapr_cpu_core.c | 12 ++++++++++--
>  target/ppc/cpu.h        |  3 +++
>  target/ppc/mmu.h        |  6 ++++++
>  target/ppc/mmu_helper.c | 12 ++++++++++++
>  4 files changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 8cc7058..72a7f90 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -17,6 +17,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "target/ppc/mmu-hash64.h"
>  #include "sysemu/numa.h"
> +#include "mmu.h"
> =20
>  static void spapr_cpu_reset(void *opaque)
>  {
> @@ -34,8 +35,15 @@ static void spapr_cpu_reset(void *opaque)
> =20
>      env->spr[SPR_HIOR] =3D 0;
> =20
> -    ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
> -                                &error_fatal);
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        ppc64_set_external_patb(cpu, spapr->patb, &error_fatal);
> +    default:
> +        /* We assume legacy until told otherwise, thus set HPT irrespect=
ive */
> +        ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
> +                                    &error_fatal);
> +        break;
> +    }
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 0ab49b3..e8b7c06 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -77,6 +77,7 @@
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
>  #include "fpu/softfloat.h"
> +#include "mmu.h"
> =20
>  #if defined (TARGET_PPC64)
>  #define PPC_ELF_MACHINE     EM_PPC64
> @@ -1009,6 +1010,8 @@ struct CPUPPCState {
>      target_ulong sr[32];
>      /* externally stored hash table */
>      uint8_t *external_htab;
> +    /* externally stored partition table entry */
> +    struct patb_entry *external_patbe;
>      /* BATs */
>      uint32_t nb_BATs;
>      target_ulong DBAT[2][8];
> diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> index 67b9707..c7967c3 100644
> --- a/target/ppc/mmu.h
> +++ b/target/ppc/mmu.h
> @@ -8,6 +8,12 @@ struct patb_entry {
>      uint64_t patbe0, patbe1;
>  };
> =20
> +#ifdef TARGET_PPC64
> +
> +void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp);
> +
> +#endif /* TARGET_PPC64 */
> +
>  #endif /* CONFIG_USER_ONLY */
> =20
>  #endif /* MMU_H */
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 2ab4562..bc6c117 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -28,6 +28,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "helper_regs.h"
> +#include "mmu.h"
> =20
>  //#define DEBUG_MMU
>  //#define DEBUG_BATS
> @@ -2907,3 +2908,14 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMU=
AccessType access_type,
>                                 retaddr);
>      }
>  }
> +
> +/***********************************************************************=
*******/
> +
> +/* ISA v3.00 (POWER9) Generic MMU Helpers */
> +
> +void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +
> +    env->external_patbe =3D (struct patb_entry *) patb;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8CNmCRe8Sh4keFKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkV98AAoJEGw4ysog2bOSli0P/06rwfABW3OG8RhDhM16kK/w
ng/73FvWl87JxgPPusGDKs2qCO4UTh1Xb4yf/0RskIg4i9ZAYSloSsYrDN5n8tL8
36tTZV85gSYUX/RToAy5cKKCQSfm4xRefvBz9KsxKFpHRm7XCL41NAjp60oWBp6p
bEXGxvigHVBNtXOIcFFKxij3m80euaF2M7NJoQbKKjbH6zppgLmwfxdUtRPnGTeD
eWKcncLC84+sAg+STFphcB0v9r1Fg9tzt/sZU9xpEuliq49dzJdYiFym+d8OIb+i
EmiKY7lVrcFGHgqx+3HZ9/EmmEi6HIIjR6+5xr3ojAut8hntGTjmRejrgzitgsae
BUb/OltkReNKq6H3UHOsxDbnSYpU5UXt9IYiWSGXbwqHo/ESMmfxR1kv2Zns1bET
OWQL2qwYSIhdTwmwXOhrNsOogjIsmVXUM4eaJwwnhWZr+IgGwSbLi1yE0u3y6Vpc
TXv3okjMnp5KsePVvonoQ8pmES5kE+XdzJlNuP5z0r6EuJxg3fqNii+KmG6h/363
n1nMIO0nftPWBllHDBZlw77ZYOHxnnImMWbPWOTni8kd44XNPOw5ehKhp+XlXC+9
ci/wdAw0MiK5qcyhaRTfUYU1pObWMmTtwQju7phUBAZdwJdyD3VqEwuC1HAX730+
26sAO+4wqdyDdq/CAKH8
=Op5f
-----END PGP SIGNATURE-----

--8CNmCRe8Sh4keFKJ--
