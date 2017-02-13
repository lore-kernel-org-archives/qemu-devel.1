Received: from eggs.gnu.org ([2001:4830:134:3::10]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd7vN-0002wl-Fx
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd7vL-0003BL-LE
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:07:37 -0500
Date: Mon, 13 Feb 2017 15:06:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213040636.GR25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-8-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aH/0uqREc1VzwMkO"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-8-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 07/10] target/ppc/POWER9: Add
 POWER9 mmu fault handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:57PM +1100, Suraj Jitindar Singh wrote:
> Add a new mmu fault handler for the POWER9 cpu and add it as the handler
> for the POWER9 cpu definition.
>=20
> This handler checks if the guest is radix or hash based on the value in t=
he
> partition table entry and calls the correct fault handler accordingly.
>=20
> The hash fault handling code has also been updated to check if the
> partition is using segment tables.
>=20
> Currently only legacy hash (no segment tables) is supported.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/mmu-hash64.c     |  9 ++++++++
>  target/ppc/mmu.h            | 50 +++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/mmu_helper.c     | 40 ++++++++++++++++++++++++++++++++++++
>  target/ppc/translate_init.c |  2 +-
>  4 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 target/ppc/mmu.h
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index e658873..ada8876 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -27,6 +27,7 @@
>  #include "kvm_ppc.h"
>  #include "mmu-hash64.h"
>  #include "exec/log.h"
> +#include "mmu.h"
> =20
>  //#define DEBUG_SLB
> =20
> @@ -766,6 +767,14 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr,
>      /* 2. Translation is on, so look up the SLB */
>      slb =3D slb_lookup(cpu, eaddr);
>      if (!slb) {
> +        /* No entry found, check if in-memory segment tables are in use =
*/
> +        if (ppc64_use_proc_tbl(cpu)) {
> +            /* TODO - Unsupported */
> +            qemu_log_mask(LOG_UNIMP, "%s: unimplemented - segment table =
support",
> +                          __func__);
> +            /* Not much we can do here, generate a segment interrupt */

I'd suggest a hw_error() here, or an error_report() and abort(1), both
of which will noisily crash.  qemu_log() is not much used these days,
and as I recall actually setting up the log file to get this
information is a bit of a pain.

> +        }
> +        /* Segment still not found, generate the appropriate interrupt */
>          if (rwx =3D=3D 2) {
>              cs->exception_index =3D POWERPC_EXCP_ISEG;
>              env->error_code =3D 0;
> diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> new file mode 100644
> index 0000000..9375921
> --- /dev/null
> +++ b/target/ppc/mmu.h

AFAICT the stuff in here is pretty much specific to the v3 MMU, so I
think this should be renamed accordingly (just as we have mmu-hash64.h
for hash specific things).

> @@ -0,0 +1,50 @@
> +/*
> + *  PowerPC emulation generic mmu definitions for qemu.
> + *
> + *  Copyright (c) 2017 Suraj Jitindar Singh, IBM Corporation
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#ifndef MMU_H
> +#define MMU_H
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +/* Partition Table Entry Fields */
> +#define PATBE1_GR 0x8000000000000000
> +
> +#ifdef TARGET_PPC64
> +
> +static inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)
> +{
> +    return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
> +}
> +
> +static inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> +{
> +    PPCVirtualHypervisorClass *vhc =3D
> +        PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +    return !!(vhc->get_patbe(cpu->vhyp) & PATBE1_GR);
> +}
> +
> +int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> +                              int mmu_idx);
> +
> +#endif /* TARGET_PPC64 */
> +
> +#endif /* CONFIG_USER_ONLY */
> +
> +#endif /* MMU_H */
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index e893e72..71ad771 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -28,6 +28,8 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "helper_regs.h"
> +#include "qemu/error-report.h"
> +#include "mmu.h"
> =20
>  //#define DEBUG_MMU
>  //#define DEBUG_BATS
> @@ -1280,6 +1282,17 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprint=
f, CPUPPCState *env)
>      case POWERPC_MMU_2_07a:
>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>          break;
> +    case POWERPC_MMU_3_00:
> +        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +            /* TODO - Unsupported */
> +        } else {
> +            if (ppc64_use_proc_tbl(ppc_env_get_cpu(env))) {
> +                /* TODO - Unsupported */
> +            } else {
> +                dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
> +                break;
> +            }
> +        }
>  #endif
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimplemented\n", __func__);
> @@ -1421,6 +1434,17 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
addr addr)
>      case POWERPC_MMU_2_07:
>      case POWERPC_MMU_2_07a:
>          return ppc_hash64_get_phys_page_debug(cpu, addr);
> +    case POWERPC_MMU_3_00:
> +        if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
> +            /* TODO - Unsupported */
> +        } else {
> +            if (ppc64_use_proc_tbl(ppc_env_get_cpu(env))) {
> +                /* TODO - Unsupported */
> +            } else {
> +                return ppc_hash64_get_phys_page_debug(cpu, addr);
> +            }
> +        }
> +        break;
>  #endif
> =20
>      case POWERPC_MMU_32B:
> @@ -2913,3 +2937,19 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMU=
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
> +int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> +                              int mmu_idx)
> +{
> +    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> +        /* TODO - Unsupported */
> +        error_report("Guest Radix Support Unimplemented");
> +        abort();
> +    } else { /* Guest uses hash */
> +        return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> +    }
> +}
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index f401d31..a3a23d8 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8829,7 +8829,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                      (1ull << MSR_LE);
>      pcc->mmu_model =3D POWERPC_MMU_3_00;
>  #if defined(CONFIG_SOFTMMU)
> -    pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> +    pcc->handle_mmu_fault =3D ppc64_v3_handle_mmu_fault;
>      /* segment page size remain the same */
>      pcc->sps =3D &POWER7_POWER8_sps;
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aH/0uqREc1VzwMkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoTDKAAoJEGw4ysog2bOSrrwP+wdcMmm3es7EX1Z+kMQhQ6oQ
sgbUof4b1SaPNXDxKqhh5pxkyvWcMtP+tcMNGc7H12KKPD4AJ1Q1p5qcTTDrScRd
k2RUJ4/dOuF9SvYMd8u7PUwnJahTqsDg0Bncb2qS1LqsUKr0Kgzw4NIlJvp3m2/s
Yh1bJCVHGHvWi101zSs+w3t4wR8myNpD1tmopi66/C86ShpVlOGRwiehv2W5YWrw
EStBzbsfGgVcqGnOY/2SAxZvE8f2RuV5SsvNxeaqgzH/a7VX5FqlQQgfbX6fAz51
n9JJTKUIFrgMi1TNVgaDcc7SoCbKlHPz6L7go+A2OguYw0GvTD8LE5K0xnrwEjF4
d2f+mnsUryLiCUJiiF/7YbWjHG5euF+PElBlP6uYx6wz6tWxSu0nawW5L86qf/UX
QtRX0w/6bA+5JwAQ1Xq0tUXgvzkhYG7Tjs0BPLRtDuxhiuFoxLygk3ouEYjaL/ue
UCJ7ShOGr9oEgCQossjN0c1AMifxy60VLnhH+oOdqjEQhLcjpNxWhdxm0gmw2Yns
6QHew0OxN252CsM+4Yr0qdXFuClMsLrqqtldqCDADe+GTasVNMyfMEmPxUJlW/t6
JJfeDL2v6tZTcirIPABbtOVn7U6SDiieVpFu4eyqdramWytvCNZu9AFPMqmNvOkc
cf018DTQNqG29a9/mX98
=yjqh
-----END PGP SIGNATURE-----

--aH/0uqREc1VzwMkO--
