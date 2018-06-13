Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSu4P-0006oN-J9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSu4M-0007LL-G9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 20:55:29 -0400
Date: Wed, 13 Jun 2018 10:45:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613004506.GM30690@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oiL9LJXJsdjS5rzq"
Content-Disposition: inline
In-Reply-To: <152882305541.114463.3137854902721347235.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--oiL9LJXJsdjS5rzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 07:04:15PM +0200, Greg Kurz wrote:
> Bits set in the PCR disable features of the processor. TCG currently
> doesn't implement that, ie, we always act like if PCR is all zeros.
>=20
> But it is still possible for the PCR to have a non-null value. This may
> confuse the guest.
>=20
> There are three distinct cases:
>=20
> 1) a powernv guest doing mtspr SPR_PCR
>=20
> 2) reset of a pseries guest if the max-cpu-compat machine property is set
>=20
> 3) CAS of a pseries guest
>=20
> This patch adds a ppc_store_pcr() helper that ensures we cannot put
> a non-null value in the PCR when using TCG. This helper also has
> error propagation support, so that each case listed above can be
> handled appropriately:
>=20
> 1) since the powernv machine is mostly used for OpenPOWER FW devel,
>    we just print an error and let QEMU continue execution
>=20
> 2) an error is printed and QEMU exits, ie, same behaviour as when
>    KVM doesn't support the requested compat mode
>=20
> 3) an error is printed and QEMU reports H_HARDWARE to the guest
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I'm not really convinced this is a good idea.  Printing a (non fatal)
error if the guest attempts to write a non-zero value to the PCR
should be ok.  However, you're generating a fatal error if the machine
tries to set the PCR in TCG mode.  That could easily happen using,
e.g. the cap-htm flag on a TCG guest.  That would take TCG from mostly
working, to refusing to run at all.

> ---
>  target/ppc/compat.c      |   26 ++++++++++++++++++++++++--
>  target/ppc/cpu.h         |    3 +++
>  target/ppc/misc_helper.c |    9 ++++++---
>  3 files changed, 33 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index 807c906f6848..08aa99e6ad47 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -138,8 +138,8 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_=
pvr, Error **errp)
>  {
>      const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
>      CPUPPCState *env =3D &cpu->env;
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      uint64_t pcr;
> +    Error *local_err =3D NULL;
> =20
>      if (!compat_pvr) {
>          pcr =3D 0;
> @@ -165,8 +165,30 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat=
_pvr, Error **errp)
>          }
>      }
> =20
> +    ppc_store_pcr(env, pcr, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      cpu->compat_pvr =3D compat_pvr;
> -    env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> +}
> +
> +void ppc_store_pcr(CPUPPCState *env, target_ulong value, Error **errp)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +
> +    /* TODO: this check should go away once we actually put the proper P=
CR
> +     * checks in the various bits of TCG that should have them.
> +     */
> +    if (!kvm_enabled() && value !=3D 0) {
> +        error_setg(errp, "TCG doesn't support PCR value 0x"TARGET_FMT_lx,
> +                   value);
> +        return;
> +    }
> +
> +    env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
>  }
> =20
>  typedef struct {
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a91f1a8777eb..fdaae34feffb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1296,6 +1296,9 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr a=
ddress, int size, int rw,
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
>  void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
> +#if defined(TARGET_PPC64)
> +void ppc_store_pcr(CPUPPCState *env, target_ulong value, Error **errp);
> +#endif
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  void ppc_store_msr (CPUPPCState *env, target_ulong value);
> =20
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index b88493009609..7a9b45a01453 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -21,6 +21,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
> =20
>  #include "helper_regs.h"
> =20
> @@ -102,10 +103,12 @@ void helper_store_ptcr(CPUPPCState *env, target_ulo=
ng val)
> =20
>  void helper_store_pcr(CPUPPCState *env, target_ulong value)
>  {
> -    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    Error *local_err =3D NULL;
> =20
> -    env->spr[SPR_PCR] =3D value & pcc->pcr_mask;
> +    ppc_store_pcr(env, value, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>  }
>  #endif /* defined(TARGET_PPC64) */
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oiL9LJXJsdjS5rzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgaRIACgkQbDjKyiDZ
s5KxsQ/+OGpoRKAEwFD0KbEiUjPGDYq1KGIJpZ7p4fEN4Pb7SfEE/pokZCcdshLF
/bZ3su5JC8J0GDYMLfefepw5Hyq+q9Otx9zQmcONoAYk/8j5XC9IKbA9+OaXhVAz
8Sb5pHbBT2oDHwgiNugbwBFV13K1YIXSPB+dLB3+wn9Y++uaocxcFB3FG7HzcgF+
vxNdurqpx3TI3Z0sUqarr+AWV4QN+tq8C6PqzDyvM36C2pvQqq85nbkY0GlWR73J
eJg1GHMnHCqKLKXGkP9zQzAFGRCJfut0VEZj+pcpLGj/o3BHWvFGd3AR14bYUw6+
LhmCBrILi970yXNAWRdxayardGYcu3BgF4UVySwmKSiSplNYwaoM+ijwV0DSycqP
1FgP2vDLNPJWgyZLtWg7XWUKR+hKFiVdFUoaAF59DhC/MCg09GMF+/+W0iz5z2Lz
lZNPFIdi5nJyYXmdp4tCtejomgMn61tcmLqc7TCwTl4lDw5hzfru6hGV6gdgFJcK
7A+TF3uwIQsj/PelAj9Rp3jvY96gROaMUqHR5/PNbR1qBrLSUOy+Nw5j+VzF5NDB
RJhJ2Id59M2Di+Qz28Y11YNU5mitz799RI8SM3v6AlWmPmwmbSrWsNNqc5oh1Y2/
oU3EO5RN2+ti1qlS8OFB/aAuAi5zQiG931CEdcojD8VCh2A7Bug=
=bmZf
-----END PGP SIGNATURE-----

--oiL9LJXJsdjS5rzq--
