Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fY6p3-00045p-0T
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fY6p1-0005tx-JT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 05:33:09 -0400
Date: Wed, 27 Jun 2018 19:09:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180627090917.GI14434@umbus.fritz.box>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <20180626161921.27941-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 01/13] target/ppc: Add do_unaligned_access
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 09:19:09AM -0700, Richard Henderson wrote:
> This allows faults from MO_ALIGN to have the same effect
> as from gen_check_align.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

So, most powerpc cpus can handle most unaligned accesses without an
exception.  I'm assuming this series won't preclude that?

> ---
>  target/ppc/internal.h           |  5 +++++
>  target/ppc/excp_helper.c        | 18 +++++++++++++++++-
>  target/ppc/translate_init.inc.c |  1 +
>  3 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 1f441c6483..a9bcadff42 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -252,4 +252,9 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUP=
PCState *env)
>  void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
>  void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
>  void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
> +
> +/* Raise a data fault alignment exception for the specified virtual addr=
ess */
> +void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                 MMUAccessType access_type,
> +                                 int mmu_idx, uintptr_t retaddr);
>  #endif /* PPC_INTERNAL_H */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index c092fbead0..d6e97a90e0 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -22,7 +22,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> -
> +#include "internal.h"
>  #include "helper_regs.h"
> =20
>  //#define DEBUG_OP
> @@ -1198,3 +1198,19 @@ void helper_book3s_msgsnd(target_ulong rb)
>      qemu_mutex_unlock_iothread();
>  }
>  #endif
> +
> +void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
> +                                 MMUAccessType access_type,
> +                                 int mmu_idx, uintptr_t retaddr)
> +{
> +    CPUPPCState *env =3D cs->env_ptr;
> +    uint32_t insn;
> +
> +    /* Restore state and reload the insn we executed, for filling in DSI=
SR.  */
> +    cpu_restore_state(cs, retaddr, true);
> +    insn =3D cpu_ldl_code(env, env->nip);
> +
> +    cs->exception_index =3D POWERPC_EXCP_ALIGN;
> +    env->error_code =3D insn & 0x03FF0000;
> +    cpu_loop_exit(cs);
> +}
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 76d6f3fd5e..7813b1b004 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10457,6 +10457,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->set_pc =3D ppc_cpu_set_pc;
>      cc->gdb_read_register =3D ppc_cpu_gdb_read_register;
>      cc->gdb_write_register =3D ppc_cpu_gdb_write_register;
> +    cc->do_unaligned_access =3D ppc_cpu_do_unaligned_access;
>  #ifdef CONFIG_USER_ONLY
>      cc->handle_mmu_fault =3D ppc_cpu_handle_mmu_fault;
>  #else

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlszVDoACgkQbDjKyiDZ
s5IDiQ/+O+1uIX0mfkPx8SESOL0I3IBZfoGfcRzz59Vn05YBK7VDHw1y9jvX0D01
c5CmMWJG90DJ9cwpqokJNHsKmq1y1RYMeStqjlMEpQCdYEsxYQrv5aWTamdC2PoK
tIbfG8lHUPQ11sv7LG06BfTZmLCw0dxTMcx9Z6Mn/WsN76NbbPlR/pbz6zcvuCcw
gNwiNnbaQIE0K1hB1MKoV3mjPkoy4BSgoLUnwLwqGNM72HtjmrvjexPAzO8FjNwy
NL37yBj1W3YPaAJQHWajn+DsPTlLrqn/b27bbvAi/A71bdnqPEV9AkEhty8B6/ah
8drKgW0jQ0x1CwiFHbwNVYhsdGeeh4CdUxanb2Sy/8Tb/M0HN5qX5kCTij3sJmPW
DQs09KTSQ47ZyvK1i0jQrwrXv5q8YBQ6jNq/ltPWftj7iDzFO/qAXqJ8Gs3MF7v0
EooU+0JQrKVfEFiWYY1XRBJQ0tkWfYBViJbX4UgILXkPCue+pFn/CqfQpHGNK4Pz
d0RIf7fxnc60eV56FwJvl0Bej7gyJ6USNSHXxRRmVm8H/nS+ZmFa0Vg45VdTitvq
C9ogFedrZ1vERwXPWWQOJOHgW4zMbwdx7899CW64H8nFO3mL2+EQTFT7/e7tXj6k
5tiNyBYxGFRjlfz8FYM5dmFB4MxTzx7bN3pCNsfrF3JHAciBBnU=
=vT86
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
