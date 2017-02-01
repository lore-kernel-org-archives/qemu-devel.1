Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmLl-0006a8-Jx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYmLk-0003G1-2g
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 23:16:53 -0500
Date: Wed, 1 Feb 2017 15:16:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201041617.GO30639@umbus.fritz.box>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-10-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E187YRO8KGM40JwS"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-10-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/17] target/ppc/POWER9: Remove SDR1
 register
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


--E187YRO8KGM40JwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:15PM +1100, Suraj Jitindar Singh wrote:
> The SDR1 registers was used to store the location of the hash page table.
>=20
> This register no longer exists on POWER9 processors, so don't create it.
>=20
> We now store the hash page table location in the process table entry.
>=20
> We now check if the SDR1 register exists before printing its value when
> displaying register debug info.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/kvm.c            | 10 +++++++++-
>  target/ppc/mmu-hash64.c     | 15 ++++++++++++++-
>  target/ppc/translate.c      |  6 ++++--
>  target/ppc/translate_init.c | 16 +++++++++++++---
>  4 files changed, 40 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 9c4834c..6016930 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -930,7 +930,15 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
> =20
>      sregs.pvr =3D env->spr[SPR_PVR];
> =20
> -    sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        if (env->external_patbe)
> +            sregs.u.s.sdr1 =3D env->external_patbe->patbe0;

I take it from this that KVM is expecting the address of the guest HPT
in the SDR1 slot of sregs, even on POWER9?  Rather than using a new
ONE_REG entry for the POWER9 data.

Note that this slot was already a hack for PR KVM - we are putting a
userspace address in there, which is clearly not a real SDR1 value.
For HV KVM, I think this value is ignored entirely, since in that case
KVM allocates / controls the guest HPT, not qemu.

> +        break;
> +    default:
> +        sregs.u.s.sdr1 =3D env->spr[SPR_SDR1];
> +        break;
> +    }

So.. maybe we should take this opportunity to clean this path up and
special case all "external HPT" cases to pass the relevant value to PR
KVM without abusing the env->spr[SPR_SDR1] field.

> =20
>      /* Sync SLB */
>  #ifdef TARGET_PPC64
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index fe7da18..b9d4f4e 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -291,7 +291,20 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulo=
ng value,
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong htabsize =3D value & SDR_64_HTABSIZE;
> =20
> -    env->spr[SPR_SDR1] =3D value;
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        /*
> +         * Technically P9 doesn't have a SDR1, the hash table address sh=
ould be
> +         * stored in the partition table entry instead.
> +         */
> +        if (env->external_patbe)
> +            env->external_patbe->patbe0 =3D value;

This definitely doesn't belong in a function called ..._set_sdr1().
Either rename this function or (probably better), set the partition
table entry from a new function and make the decision in the caller.


> +        break;
> +    default:
> +        env->spr[SPR_SDR1] =3D value;
> +        break;
> +    }
> +
>      if (htabsize > 28) {
>          error_setg(errp,
>                     "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 1212180..521aed3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6922,9 +6922,11 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpr=
intf_function cpu_fprintf,
>      case POWERPC_MMU_2_06a:
>      case POWERPC_MMU_2_07:
>      case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_3_00:
>  #endif
> -        cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
> -                       "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],
> +        if (env->spr_cb[SPR_SDR1].name)
> +            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1=
]);
> +        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "=
\n",
>                      env->spr[SPR_DAR], env->spr[SPR_DSISR]);
>          break;
>      case POWERPC_MMU_BOOKE206:
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index a1994d3..c771ba3 100644
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
> =20
> -/* SPR common to all non-embedded PowerPC, including 601 */
> -static void gen_spr_ne_601 (CPUPPCState *env)
> +/* SPR common to all non-embedded PowerPC, including POWER9 */
> +static void gen_spr_ne_power9 (CPUPPCState *env)
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
> +static void gen_spr_ne_601 (CPUPPCState *env)
> +{
> +    gen_spr_ne_power9(env);
>      /* Memory management */
>      spr_register(env, SPR_SDR1, "SDR1",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -8222,7 +8229,6 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
> =20
>  static void init_proc_book3s_64(CPUPPCState *env, int version)
>  {
> -    gen_spr_ne_601(env);
>      gen_tbl(env);
>      gen_spr_book3s_altivec(env);
>      gen_spr_book3s_pmu_sup(env);
> @@ -8280,6 +8286,10 @@ static void init_proc_book3s_64(CPUPPCState *env, =
int version)
>          gen_spr_power8_book4(env);
>          gen_spr_power8_rpr(env);
>      }
> +    if (version >=3D BOOK3S_CPU_POWER9)
> +        gen_spr_ne_power9(env);
> +    else
> +        gen_spr_ne_601(env);
>      if (version < BOOK3S_CPU_POWER8) {
>          gen_spr_book3s_dbg(env);
>      } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E187YRO8KGM40JwS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkWERAAoJEGw4ysog2bOS+xMP/0OYXNhKCmCwCZPyeeWMsr2K
ZBTVqeueVmbQSAis3di9s2siw5MrwHwKs4aIurGuATnYhDPF0JWs9bjSCqzcM3Qi
6u6b2OlivcE6hHyIiUiO9WZOTuPhhNjxF+hJTUnRT1M436TUzkoKji9xam2Ghl41
qZgH3QzSM1nqz0ZNKzFAobLGA7t2uNbD1W0zjmc1cTU1ahLSHgbwGJWYo/9OFwTL
EMuZg4oLF5tvcl53+ez+K04zWZO1+be3vjyFkV1WMwqXem2IKrcum8ioBf+GkIkT
HTEH3sYkmLcuojYr1NELuOBs7W2qVPvt5UIG2BMlEURGMEyCPq2lCv4c/a0FRqiC
bnxcLMfKbCjQrvcgbjjb+xvxQOFFIlYH/U3o9MTor0NLXskF3cmwRyfn+rUj6+ON
MJVjEY4zrQ8ySr8hSHV81KiZ7Ysr0X0wb+sgQ2qzHN74Wem723Ya0wJt+BKILuR4
zL48K4z+PdgkdEJ7pvrt0D5rhPp3VVn4Qjp++hZrNaXrMhNQaJ9+GQoNtNhB2/Na
CaWfMcyqAsuI0C/4ngHs409JIuOJywWO9iEyitPKbecbCST0Q2ELu15TkcjaY0I1
9xvj6s4ZHfqQWofo5pq5/YnIqHuyJ0HmINfaiqhj/LB/yWSmswaRNJBEw6rKBiDi
Wm1n6OsctcIO6IPeOB3B
=MGsr
-----END PGP SIGNATURE-----

--E187YRO8KGM40JwS--
