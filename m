Received: from eggs.gnu.org ([2001:4830:134:3::10]:36327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfF2-0008Cr-4t
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfEy-0000Mo-V4
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:08:16 -0500
Date: Mon, 4 Dec 2017 12:00:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204010040.GF2130@umbus.fritz.box>
References: <1512143347-20128-1-git-send-email-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <1512143347-20128-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] target/ppc: Fix system
 lockups caused by interrupt_request state corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 03:49:07PM +0000, Richard Purdie wrote:
> Occasionally in Linux guests on x86_64 we're seeing logs like:
>=20
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 0000=
0004
>=20
> when they should read:
>=20
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 0000=
0002
>=20
> The "00000004" is CPU_INTERRUPT_EXITTB yet the code calls
> cpu_interrupt(cs, CPU_INTERRUPT_HARD) ("00000002") in this function
> just before the log message. Something is causing the HARD bit setting
> to get lost.
>=20
> The knock on effect of losing that bit is the decrementer timer interrupts
> don't get delivered which causes the guest to sit idle in its idle handler
> and 'hang'.
>=20
> The issue occurs due to races from code which sets CPU_INTERRUPT_EXITTB.
>=20
> Rather than poking directly into cs->interrupt_request, that code needs t=
o:
>=20
> a) hold BQL
> b) use the cpu_interrupt() helper
>=20
> This patch fixes the call sites to do this, fixing the hang.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

I strongly suspect there's a better way to do this long term - a lot
of that old ppc TCG code is really crufty.  But as best I can tell,
this is certainly a fix over what we had.  So, applied to ppc-for-2.11.

> ---
>  target/ppc/excp_helper.c | 16 +++++++++++++---
>  target/ppc/helper_regs.h | 10 ++++++++--
>  2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> v2: Fixes a compile issue with master and ensures BQL is held in one case
> where it potentially wasn't.
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index e6009e7..8040277 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -207,7 +207,13 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>                          "Entering checkstop state\n");
>              }
>              cs->halted =3D 1;
> -            cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +            if (!qemu_mutex_iothread_locked()) {
> +                qemu_mutex_lock_iothread();
> +                cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +                qemu_mutex_unlock_iothread();
> +            } else {
> +                cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +            }
>          }
>          if (env->msr_mask & MSR_HVB) {
>              /* ISA specifies HV, but can be delivered to guest with HV c=
lear
> @@ -940,7 +946,9 @@ void helper_store_msr(CPUPPCState *env, target_ulong =
val)
> =20
>      if (excp !=3D 0) {
>          CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        qemu_mutex_lock_iothread();
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +        qemu_mutex_unlock_iothread();
>          raise_exception(env, excp);
>      }
>  }
> @@ -995,7 +1003,9 @@ static inline void do_rfi(CPUPPCState *env, target_u=
long nip, target_ulong msr)
>      /* No need to raise an exception here,
>       * as rfi is always the last insn of a TB
>       */
> -    cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +    qemu_mutex_lock_iothread();
> +    cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +    qemu_mutex_unlock_iothread();
> =20
>      /* Reset the reservation */
>      env->reserve_addr =3D -1;
> diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> index 2627a70..0beaad5 100644
> --- a/target/ppc/helper_regs.h
> +++ b/target/ppc/helper_regs.h
> @@ -20,6 +20,8 @@
>  #ifndef HELPER_REGS_H
>  #define HELPER_REGS_H
> =20
> +#include "qemu/main-loop.h"
> +
>  /* Swap temporary saved registers with GPRs */
>  static inline void hreg_swap_gpr_tgpr(CPUPPCState *env)
>  {
> @@ -114,11 +116,15 @@ static inline int hreg_store_msr(CPUPPCState *env, =
target_ulong value,
>      }
>      if (((value >> MSR_IR) & 1) !=3D msr_ir ||
>          ((value >> MSR_DR) & 1) !=3D msr_dr) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        qemu_mutex_lock_iothread();
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +        qemu_mutex_unlock_iothread();
>      }
>      if ((env->mmu_model & POWERPC_MMU_BOOKE) &&
>          ((value >> MSR_GS) & 1) !=3D msr_gs) {
> -        cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +        qemu_mutex_lock_iothread();
> +        cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> +        qemu_mutex_unlock_iothread();
>      }
>      if (unlikely((env->flags & POWERPC_FLAG_TGPR) &&
>                   ((value ^ env->msr) & (1 << MSR_TGPR)))) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloknjUACgkQbDjKyiDZ
s5KmERAAqQNAsVGrWH/n5sUpOu0LauowUCaoH0l8F9SNM5f6xDCEvehAEqQjwX+u
bB+o6hbLAqyxFQ7O/WuOUXoeYpUtn1cV9jY7awwJqnHPIop0c+j2o1pNHbsUMlRg
F5FaEsbAVMLXdS23UA+bYAycTcv5xbx0e8GTemjfdgNKALvurqXBL89gWheu0UWb
WOJrk5boQ38iwlc0zlXU3PQ8PrTH2XLL0GeLQc+k7j3iPNwUt+MBXc5Izfpk6NKi
3J9+/5bP3gf34JEJAwn8b5xMc9ocMSD0Bxw3uaiP/GpFdZpGPqgoud8qTpSUZ0MG
5L1HXmM9s6PU90Gd4qLRRn+eGrzqjXl3KvwXrMCHGIB74+q4esxR7HOtlC3oM6w8
5AFqX/xLDlLsxiKrOLJrmYtIzoVNgVZqJAMWYqMqg39nLbsAr84D0p3c6Td/juwP
FRdYAzguy1pP4Vc8dG+odxvFupJVlnUCE9nWhUnSg1evAEI7KtDXyy79U3hhz50J
P2jWbbdSyQJLWbvO14o/FBfSFKz7x35AeWOaT3BBX8rj45ienkPbDoBoF5tQE/54
VfqIVwfNtYi4RQWtwx/Z9Cx5josdtWVpD2FD51pBrj7bbD+GTM1bS7AD7n81BI/x
5kAmlXFuXkX8HHsIcpZZZDcjoaIGKoqk2VukKNUPxQnBnG8aal0=
=Iy7X
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
