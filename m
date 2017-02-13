Received: from eggs.gnu.org ([2001:4830:134:3::10]:43216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd7ZI-0006Dd-FX
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 22:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd7ZG-0007Nv-DY
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 22:44:48 -0500
Date: Mon, 13 Feb 2017 14:44:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213034433.GQ25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-7-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7a4X6VOqfbl9xMrG"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-7-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 06/10] target/ppc: Don't use
 SDR1 when running under a POWER9 cpu model
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


--7a4X6VOqfbl9xMrG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:25:56PM +1100, Suraj Jitindar Singh wrote:
> The SDR1 register was used on pre-POWER9 processors to store the location
> of the hash page table, however now this information will be stored in the
> partition table so we don't have SDR1 anymore. Additionally this register
> was only applicable for powernv as it is a hypervisor resource and thus
> shouldn't be accessed on a pseries machine.
>=20
> We no longer generate the SDR1 register if we are on a POWER9 or later cp=
u.
> We also rename the functions ppc_hash64_set_sdr1->ppc_hash64_set_htab and
> ppc_store_sdr1->ppc_store_htab to indicate that they are primarily
> concerned with setting htab_[base/mask].
>=20
> We still set SDR1 in ppc_hash64_set_external_hpt for non-POWER9 cpus as
> this is used for kvm-pr to tell the hypervisor where the hash table is,
> note this means kvm-pr isn't yet supported on a POWER9 cpu model.
>=20
> We set SDR1 in ppc_store_htab for non-POWER9 cpus as this is the called
> by the powernv machine code to restore the sdr1 (and htab_[mask/base])
> on incoming migration, note this means that the powernv machine isn't
> yet supported on a POWER9 cpu model.
>=20
> We also adapt the debug code to only print the SDR1 value if the register
> has been created.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I think this is a bit over-enthusiastic in some places.

> ---
>  target/ppc/cpu.h            |  2 +-
>  target/ppc/kvm.c            |  2 +-
>  target/ppc/machine.c        |  4 ++--
>  target/ppc/misc_helper.c    |  3 ++-
>  target/ppc/mmu-hash64.c     | 12 +++++++++---
>  target/ppc/mmu-hash64.h     |  2 +-
>  target/ppc/mmu_helper.c     | 12 +++++++++---
>  target/ppc/translate.c      |  7 +++++--
>  target/ppc/translate_init.c | 17 ++++++++++++++---
>  9 files changed, 44 insertions(+), 17 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a148729..1ae0719 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1265,7 +1265,7 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr a=
ddress, int rw,
>  #endif
> =20
>  #if !defined(CONFIG_USER_ONLY)
> -void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
> +void ppc_store_htab(CPUPPCState *env, target_ulong value);
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  void ppc_store_msr (CPUPPCState *env, target_ulong value);
> =20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 663d2e7..5e2323c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1228,7 +1228,7 @@ static int kvmppc_get_books_sregs(PowerPCCPU *cpu)
>      }
> =20
>      if (!env->external_htab) {
> -        ppc_store_sdr1(env, sregs.u.s.sdr1);
> +        ppc_store_htab(env, sregs.u.s.sdr1);

If the CPU has no SDR1, the sdr1 field in sregs can't really mean
anything, so the name change is not relevant here.

>      }
> =20
>      /* Sync SLB */
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index df9f7a4..f6d5ade 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -77,7 +77,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int =
version_id)
>      for (i =3D 0; i < 1024; i++)
>          qemu_get_betls(f, &env->spr[i]);
>      if (!env->external_htab) {
> -        ppc_store_sdr1(env, sdr1);
> +        ppc_store_htab(env, sdr1);

Likewise here - this function is only called reading an old migration
stream that expects an SDR1 to be present anyway.

>      }
>      qemu_get_be32s(f, &env->vscr);
>      qemu_get_be64s(f, &env->spe_acc);
> @@ -230,7 +230,7 @@ static int cpu_post_load(void *opaque, int version_id)
> =20
>      if (!env->external_htab) {
>          /* Restore htab_base and htab_mask variables */
> -        ppc_store_sdr1(env, env->spr[SPR_SDR1]);
> +        ppc_store_htab(env, env->spr[SPR_SDR1]);

For POWER9 this will be a no-op:
   - for powernv the hpt will be set by the loading of the partition
     table, making this irrelevant
   - for pseries, it won't be called since external_htab will be true

So this case doesn't require the name change either.

>      }
> =20
>      /* Invalidate all msr bits except MSR_TGPR/MSR_HVB before restoring =
*/
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index ab432ba..49ba767 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -84,7 +84,8 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong v=
al)
> =20
>      if (!env->external_htab) {
>          if (env->spr[SPR_SDR1] !=3D val) {
> -            ppc_store_sdr1(env, val);
> +            env->spr[SPR_SDR1] =3D val;
> +            ppc_store_htab(env, val);

This is only called for CPUs which actually have an SDR1, so no name
change required by this caller.

>              tlb_flush(CPU(cpu));
>          }
>      }
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 7c5d589..e658873 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -285,13 +285,12 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env,=
 target_ulong rb)
>  /*
>   * 64-bit hash table MMU handling
>   */
> -void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> +void ppc_hash64_set_htab(PowerPCCPU *cpu, target_ulong value,
>                           Error **errp)

So, this function is useful for both POWER9 and other systems.
However the new name is also misleading, because with the change below
it sets things *about* the HPT without actually setting the HPT
itself.

I think it would make more sense to put the POWER9 vs. otherwise
conditional into here, so this will still set env[SPR_SDR1] on CPUs
which have the SPR.

>  {
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong htabsize =3D value & SDR_64_HTABSIZE;
> =20
> -    env->spr[SPR_SDR1] =3D value;
>      if (htabsize > 28) {
>          error_setg(errp,
>                     "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
> @@ -313,7 +312,14 @@ void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, vo=
id *hpt, int shift,
>      } else {
>          env->external_htab =3D MMU_HASH64_KVM_MANAGED_HPT;
>      }
> -    ppc_hash64_set_sdr1(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18),
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        break; /* Power 9 doesn't have an SDR1 */
> +    default:
> +        env->spr[SPR_SDR1] =3D (target_ulong) hpt | (shift - 18);
> +        break;
> +    }

This caller then becomes simpler.

> +    ppc_hash64_set_htab(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18),
>                          &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 7a0b7fc..e930934 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -91,7 +91,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> =20
> -void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> +void ppc_hash64_set_htab(PowerPCCPU *cpu, target_ulong value,
>                           Error **errp);
>  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
>                                   Error **errp);
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 172a305..e893e72 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1995,17 +1995,23 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, tar=
get_ulong addr)
> =20
>  /***********************************************************************=
******/
>  /* Special registers manipulation */
> -void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
> +void ppc_store_htab(CPUPPCState *env, target_ulong value)
>  {
>      qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, valu=
e);
>      assert(!env->external_htab);
> -    env->spr[SPR_SDR1] =3D value;
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00: /* POWER 9 doesn't have an SDR1 */
> +        break;
> +    default: /* Pre-POWER9 does */
> +        env->spr[SPR_SDR1] =3D value;
> +        break;
> +    }

=46rom looking at the rest of the patch, ppc_store_sdr1() (as opposed to
the lower level functions) is never called in a context where it would
make sense to have a non-SDR1 system, so the name should change.

>  #if defined(TARGET_PPC64)
>      if (env->mmu_model & POWERPC_MMU_64) {
>          PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>          Error *local_err =3D NULL;
> =20
> -        ppc_hash64_set_sdr1(cpu, value, &local_err);
> +        ppc_hash64_set_htab(cpu, value, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              error_free(local_err);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b48abae..473a40a 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6850,9 +6850,12 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpr=
intf_function cpu_fprintf,
>      case POWERPC_MMU_2_06a:
>      case POWERPC_MMU_2_07:
>      case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_3_00:
>  #endif
> -        cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
> -                       "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],
> +        if (env->spr_cb[SPR_SDR1].name) {
> +            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1=
]);
> +        }

This change is fine.

> +        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "=
\n",
>                      env->spr[SPR_DAR], env->spr[SPR_DSISR]);
>          break;
>      case POWERPC_MMU_BOOKE206:
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index be35cbd..f401d31 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -32,6 +32,7 @@
>  #include "qapi/visitor.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/ppc/ppc.h"
> +#include "mmu.h"
> =20
>  //#define PPC_DUMP_CPU
>  //#define PPC_DEBUG_SPR
> @@ -722,8 +723,8 @@ static void gen_spr_generic (CPUPPCState *env)
>                   0x00000000);
>  }
>

Hm, longer term, I think it would make more sense for POWER9 not to
try to use init_proc_book3s_64().  That function was created on the
assumption that all 64-bit book3s CPUs had a "classic" hash MMU.  With
POWER9 that's no longer the case.

Basically we want to remove the MMU related SPRs from
init_proc_book3s_64() (which might want a name change).  Both POWER9
and POWER8(etc) can call that function.  But then POWER8 and earlier
can call a new helper function to set up the hash MMU related SPRs,
and POWER9 will call a new function to create the MMUv3 SPRs.

> -/* SPR common to all non-embedded PowerPC, including 601 */
> -static void gen_spr_ne_601 (CPUPPCState *env)
> +/* SPR common to all non-embedded PowerPC, including POWER9 */
> +static void gen_spr_ne_power9(CPUPPCState *env)
>  {
>      /* Exception processing */
>      spr_register_kvm(env, SPR_DSISR, "DSISR",
> @@ -739,6 +740,12 @@ static void gen_spr_ne_601 (CPUPPCState *env)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_decr, &spr_write_decr,
>                   0x00000000);
> +}
> +
> +/* SPR common to all non-embedded PowerPC, including 601 */
> +static void gen_spr_ne_601(CPUPPCState *env)
> +{
> +    gen_spr_ne_power9(env);
>      /* Memory management */
>      spr_register(env, SPR_SDR1, "SDR1",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -8200,7 +8207,6 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
> =20
>  static void init_proc_book3s_64(CPUPPCState *env, int version)
>  {
> -    gen_spr_ne_601(env);
>      gen_tbl(env);
>      gen_spr_book3s_altivec(env);
>      gen_spr_book3s_pmu_sup(env);
> @@ -8258,6 +8264,11 @@ static void init_proc_book3s_64(CPUPPCState *env, =
int version)
>          gen_spr_power8_book4(env);
>          gen_spr_power8_rpr(env);
>      }
> +    if (version >=3D BOOK3S_CPU_POWER9) {
> +        gen_spr_ne_power9(env);
> +    } else {
> +        gen_spr_ne_601(env);
> +    }
>      if (version < BOOK3S_CPU_POWER8) {
>          gen_spr_book3s_dbg(env);
>      } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7a4X6VOqfbl9xMrG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoSufAAoJEGw4ysog2bOSI24P/RckKD1kWzTPOM/Nlvr3ycOQ
brGdIHEqQOCJ8Pvk3qHKr459SkovAgqP4fRmwQ3dUBDcIV5BOjkFgUFmfJSn7LJv
MTOPvCCI7/T1l2MWOnzNJ1DMI2JuO1dWdsdgnDM7jMRz6LCHBqSODH8mXJA37lV3
BpEFpH762XkIOSE5++v1pRackuZO95agGAdeyhYzPB7uppFyhU/lPTo0YYLQsL9c
DI/erUiCcducwA89z0NE/Uy7MF9Vhuhb6OIK9nB8dFwoMX8TVhyPGxwR1V44LXIH
fIkh7dLuFIR0N/mdHDmvhqP24gAafQlERg9gsfQllmXmwYL4PbBZ2iieVpfl1eXH
PHtpk7KycnAerLooTZB5eQyf3pqWWciX2X1cnaN8WCn9ULSWXoor5XMX1bOtdSzy
tWHiVOdJycjI/aGTmBksX9fyqv838B8SSgEdCy3jNPW9W/IyIIlM8WmlEfLB+VVw
KsfFYi0+5GOfkgrsV4elDnD9Smt+G1a11CZ9ovVGxx417ZM/q4GwlsMoTUh9WYLv
1aztITE5YjBEt7ofo20dxbvHf/Mkmw9Q7zYGYG/nt9jOXXkVx/jYBTjU2kQXqi+Q
8cYd8sU7LKBRT5I/ohuijC+gnRtw/M0YmqssTGEl2x0Q7jMBhbcsEChpaAkDNClu
5Tad5kxy74GrWXtSdQQD
=DweP
-----END PGP SIGNATURE-----

--7a4X6VOqfbl9xMrG--
