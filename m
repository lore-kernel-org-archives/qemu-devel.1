Received: from eggs.gnu.org ([2001:4830:134:3::10]:46639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdG-0004RH-4F
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmdE-0006y6-AC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:34:58 -0500
Date: Wed, 1 Feb 2017 15:23:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201042310.GP30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-11-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DBUa/BSa4z6QPQv1"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-11-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/17] target/ppc/POWER9: Add POWER9
 mmu fault handler
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


--DBUa/BSa4z6QPQv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:16PM +1100, Suraj Jitindar Singh wrote:
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
>  target/ppc/mmu-hash64.c     |  8 ++++++++
>  target/ppc/mmu.h            |  8 ++++++++
>  target/ppc/mmu_helper.c     | 47 +++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/translate_init.c |  2 +-
>  4 files changed, 64 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index b9d4f4e..b476b3f 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -73,6 +73,14 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_u=
long eaddr)
>          }
>      }
> =20
> +    /* Check if in-memory segment tables are in use */
> +    if (ppc64_use_proc_tbl(cpu)) {
> +        /* TODO - Unsupported */
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented - segment table supp=
ort\n",
> +                      __func__);
> +        /* Not much we can do here, caller will generate a segment inter=
rupt */
> +    }

I think this logic would be better in the fault handler.  For the
fault path in the segment table case, I don't think we want to even
model the SLB (in hardware the SLB is an important optimization, but I
don't think the software SLB will be notably better than just looking
up the seg table directly).  I think the other users of slb_lookup()
are in contexts that only make sense in the context of a software
managed SLB anyway.

>      return NULL;
>  }
> =20
> diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
> index c7967c3..e07b128 100644
> --- a/target/ppc/mmu.h
> +++ b/target/ppc/mmu.h
> @@ -3,6 +3,10 @@
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> +/* Common Partition Table Entry Fields */
> +#define PATBE0_HR                0x8000000000000000
> +#define PATBE1_GR                0x8000000000000000
> +
>  /* Partition Table Entry */
>  struct patb_entry {
>      uint64_t patbe0, patbe1;
> @@ -11,6 +15,10 @@ struct patb_entry {
>  #ifdef TARGET_PPC64
> =20
>  void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp);
> +bool ppc64_use_proc_tbl(PowerPCCPU *cpu);
> +bool ppc64_radix_guest(PowerPCCPU *cpu);
> +int ppc64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> +                           int mmu_idx);
> =20
>  #endif /* TARGET_PPC64 */
> =20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index bc6c117..612f407 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -28,6 +28,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "helper_regs.h"
> +#include "qemu/error-report.h"
>  #include "mmu.h"
> =20
>  //#define DEBUG_MMU
> @@ -1281,6 +1282,17 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprint=
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
> @@ -1422,6 +1434,17 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, v=
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
> @@ -2919,3 +2942,27 @@ void ppc64_set_external_patb(PowerPCCPU *cpu, void=
 *patb, Error **errp)
> =20
>      env->external_patbe =3D (struct patb_entry *) patb;
>  }
> +
> +inline bool ppc64_use_proc_tbl(PowerPCCPU *cpu)

There's basically no point putting an inline on functions that are in
a .c rather than a .h (it will only be inlined for callers in this .o,
not elsewhere).  These are simple enough that I think they do belong
in the .h instead.

> +{
> +    return !!(cpu->env.spr[SPR_LPCR] & LPCR_UPRT);
> +}
> +
> +inline bool ppc64_radix_guest(PowerPCCPU *cpu)
> +{
> +    struct patb_entry *patbe =3D cpu->env.external_patbe;
> +
> +    return patbe && (patbe->patbe1 & PATBE1_GR);
> +}
> +
> +int ppc64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
> +                           int mmu_idx)

I think this name is too generic, since it's really only right for
POWER9 / MMU v3.

> +{
> +    if (ppc64_radix_guest(cpu)) { /* Guest uses radix */
> +        /* TODO - Unsupported */
> +        error_report("Guest Radix Support Unimplemented\n");
> +        abort();
> +    } else { /* Guest uses hash */
> +        return ppc_hash64_handle_mmu_fault(cpu, eaddr, rwx, mmu_idx);
> +    }
> +}
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index c771ba3..87297a7 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8850,7 +8850,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                      (1ull << MSR_LE);
>      pcc->mmu_model =3D POWERPC_MMU_3_00;
>  #if defined(CONFIG_SOFTMMU)
> -    pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
> +    pcc->handle_mmu_fault =3D ppc64_handle_mmu_fault;
>      /* segment page size remain the same */
>      pcc->sps =3D &POWER7_POWER8_sps;
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DBUa/BSa4z6QPQv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkWKuAAoJEGw4ysog2bOSiRQP+gLejXJ66NDR24/t1pABbsXc
lmv4josu+ysJ8wsUpHLjea+T7j6Ls5hk01hzcsIbCm3kmhLvwe/uF3awPwd04sip
inSV6CPmQ0HfmkkhWBvK9g4VFR8exTiQTVWrl+/bWT9tkocFQr82LpHG3LsqVTQO
NGdYKJORdIFlnQ/b2WCjtMNrV9cT5YUSBLHif8hadm3qjayoRnNbiTQuZ17WH0f7
r6RevXWXA8RAF4upsz566D5DDiuYV61/evqxvZtq+SLiW3BA4TC4r44j17GpOP+O
3nAdxJOpQzvd6J7VtiuWApA9wD8HYzNzZCjaBI349vuovX2cISpaAaiAHXCuk6cQ
/F9hrQTEjDecVSj8LtOALHIJvBOYIg0IsaQmeJqrX4i8XwoXk29ZtUp2SaYHQswM
qiobQgx2u+pDAgT6FosvEyr82oWLi22SnB+e0Cz4UQibZyKSehpj1nKB/S/mMeWz
J392a/DXjp2ielWMQfASTNdphxptL4T3NILiGuLzeG0jW/HXxPrB6N2IzU3h9nyl
Pl2L9iEp+MI4Oi8G7Y7gb6ji4PUBXNE/n0rJlmiZ9UjSf5UohA65PDmHyACvrpCt
mMJk3cTul9AwZ10axTYOzPMy8HNJz6lgxO7DgXGDHFYbc5eC93Cl+HiBqHkkCZEa
vodKW5AYRZ9g8jATF/uH
=Yxkh
-----END PGP SIGNATURE-----

--DBUa/BSa4z6QPQv1--
