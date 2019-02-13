Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6T-0008GF-N6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwh-00062T-Da
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:56 -0500
Date: Wed, 13 Feb 2019 16:12:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213051248.GR1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1pyOwMoA9G3DWfK"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-17-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 16/19] target/ppc: Add Hypervisor
 Virtualization Interrupt on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--X1pyOwMoA9G3DWfK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:22AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This adds support for delivering that exception
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h                |  5 ++++-
>  target/ppc/excp_helper.c        | 17 ++++++++++++++++-
>  target/ppc/translate_init.inc.c | 16 +++++++++++++++-
>  3 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b69410ea2541..385d33bd37ff 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -160,8 +160,10 @@ enum {
>      /* Server doorbell variants */
>      POWERPC_EXCP_SDOOR    =3D 99,
>      POWERPC_EXCP_SDOOR_HV =3D 100,
> +    /* ISA 3.00 additions */
> +    POWERPC_EXCP_HVIRT    =3D 101,
>      /* EOL                                                              =
     */
> -    POWERPC_EXCP_NB       =3D 101,
> +    POWERPC_EXCP_NB       =3D 102,
>      /* QEMU exceptions: used internally during code translation         =
     */
>      POWERPC_EXCP_STOP         =3D 0x200, /* stop translation            =
       */
>      POWERPC_EXCP_BRANCH       =3D 0x201, /* branch instruction          =
       */
> @@ -2344,6 +2346,7 @@ enum {
>      PPC_INTERRUPT_PERFM,          /* Performance monitor interrupt      =
  */
>      PPC_INTERRUPT_HMI,            /* Hypervisor Maintainance interrupt  =
  */
>      PPC_INTERRUPT_HDOORBELL,      /* Hypervisor Doorbell interrupt      =
  */
> +    PPC_INTERRUPT_HVIRT,          /* Hypervisor virtualization interrupt=
  */
>  };
> =20
>  /* Processor Compatibility mask (PCR) */
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 1a2f469a5fa2..d171a5eb6236 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -97,6 +97,9 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCSta=
te *env, int excp,
>      case POWERPC_EXCP_HV_MAINT:
>          *msr |=3D 0xaull << (63 - 45);
>          break;
> +    case POWERPC_EXCP_HVIRT:
> +        *msr |=3D 0x9ull << (63 - 45);
> +        break;
>      default:
>          cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
>                    excp);
> @@ -427,6 +430,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>      case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment excep=
tion */
>      case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt       =
     */
>      case POWERPC_EXCP_HV_EMU:
> +    case POWERPC_EXCP_HVIRT:     /* Hypervisor virtualization           =
     */
>          srr0 =3D SPR_HSRR0;
>          srr1 =3D SPR_HSRR1;
>          new_msr |=3D (target_ulong)MSR_HVB;
> @@ -809,7 +813,18 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>              return;
>          }
>      }
> -    /* Extermal interrupt can ignore MSR:EE under some circumstances */
> +
> +    /* Hypervisor virtualization interrupt */
> +    if (env->pending_interrupts & (1 << PPC_INTERRUPT_HVIRT)) {
> +        /* LPCR will be clear when not supported so this will work */
> +        bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
> +        if ((async_deliver || msr_hv =3D=3D 0) && hvice) {
> +            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_HVIRT);
> +            return;
> +        }
> +    }
> +
> +    /* External interrupt can ignore MSR:EE under some circumstances */
>      if (env->pending_interrupts & (1 << PPC_INTERRUPT_EXT)) {
>          bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
>          if (async_deliver || (env->has_hv_mode && msr_hv =3D=3D 0 && !lp=
es0)) {
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index c1719c46a383..6ffa4a8fe0fa 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -3313,6 +3313,15 @@ static void init_excp_POWER8(CPUPPCState *env)
>  #endif
>  }
> =20
> +static void init_excp_POWER9(CPUPPCState *env)
> +{
> +    init_excp_POWER8(env);
> +
> +#if !defined(CONFIG_USER_ONLY)
> +    env->excp_vectors[POWERPC_EXCP_HVIRT]    =3D 0x00000EA0;
> +#endif
> +}
> +
>  #endif
> =20
>  /***********************************************************************=
******/
> @@ -8783,7 +8792,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>      env->icache_line_size =3D 128;
> =20
>      /* Allocate hardware IRQ controller */
> -    init_excp_POWER8(env);
> +    init_excp_POWER9(env);
>      ppcPOWER7_irq_init(ppc_env_get_cpu(env));
>  }
> =20
> @@ -8836,6 +8845,11 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>              (env->spr[SPR_LPCR] & LPCR_HDEE)) {
>              return true;
>          }
> +        /* Hypervisor virtualization exception */
> +        if ((env->pending_interrupts & (1u << PPC_INTERRUPT_HVIRT)) &&
> +            (env->spr[SPR_LPCR] & LPCR_HVEE)) {
> +            return true;
> +        }
>          if (env->pending_interrupts & (1u << PPC_INTERRUPT_RESET)) {
>              return true;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X1pyOwMoA9G3DWfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjp1AACgkQbDjKyiDZ
s5JJ6A//aL84omqzfQ6meP5Vo0QfWCQbuvcU8yLBkJjHt0OJdhb4AoW+QBRD6ttv
HH1y4khNnfEV1DETEIG3fICIv73wkJtiy5E0izpGoclYZm0Z/Y3+SEVNeK4sGPbZ
uqSmRa63vmYztTYW0GRnj8oap7tYrAKcDjvGVdgsYdtiX9e36IjNigM+0AAf/4JB
/raxJJXr8skkjxyVO0NoyE3v10nAeQ6EDW7cpszL1d/oWQLzZqQCZgU65kbIFAHp
+g3QCOhOG4BqDy/10hl3P3aXv68msHHLvYnWskiDc8rKg9kiNMIJrQnlIhiHfJZR
86C4K7h44CKthJVP0JAMazZ2Tuv7d3bIS5PByXZ4lPYnIrAUC66ZZpNs0ccBUYzK
0SWDdRkB52JdZYAO5VMg/lwlEeUnQVvFMoxC+mkssgQL/sSKpuql9ClW3nLEeuqB
kOBczDhrnZk/+5ne13be0ve986L424y6/zqRbsk3sleHxrYQXU0pI0PpbIpQlvcY
s4Y5nAzrHagEu1F6lqRYBrrJvcEV1xVBkh4NseCoUXZm13plm0x0YkbpXVqU3bZI
krtwx6RX+N/loyF5l2gkYrhANU11E559kHzNHB/feR75AeSzIGa1Y9HovoBnXvc2
A9cK8cXz5tIDUhOTTsHdOXrN5MQg4mOclpXuuHeD/oXv07kVB70=
=HYu0
-----END PGP SIGNATURE-----

--X1pyOwMoA9G3DWfK--
