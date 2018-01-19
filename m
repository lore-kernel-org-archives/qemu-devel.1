Received: from eggs.gnu.org ([2001:4830:134:3::10]:54273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecOFu-0003Pf-DX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecOFs-0004JW-Nk
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 23:26:18 -0500
Date: Fri, 19 Jan 2018 15:22:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119042237.GF30352@umbus.fritz.box>
References: <20180118145403.6527-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hjFmXiTvfEJBEd4m"
Content-Disposition: inline
In-Reply-To: <20180118145403.6527-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: add support for hypervisor
 doorbells on book3s CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--hjFmXiTvfEJBEd4m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 03:54:03PM +0100, C=E9dric Le Goater wrote:
> The hypervisor doorbells are used by skiboot and Linux on POWER9
> processors to wake up secondaries.
>=20
> This adds processor control support to the Server architecture by
> reusing the Embedded support. They are very similar, only the bits
> definition of the CPU identifier differ.
>=20
> Still to be done is message broadcast to all threads of the same
> processor.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12, thanks.

> ---
>=20
>  Changes since v2:
>=20
>  - introduced specific msgclr/snd helpers for book3s=20
>=20
>  target/ppc/cpu.h            |  8 +++++--
>  target/ppc/excp_helper.c    | 52 +++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/helper.h         |  2 ++
>  target/ppc/translate.c      | 25 ++++++++++++++++++++--
>  target/ppc/translate_init.c |  2 +-
>  5 files changed, 84 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b8f4dfc1084a..603a38cae83f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -930,7 +930,7 @@ enum {
>  #define BOOKE206_MAX_TLBN      4
> =20
>  /***********************************************************************=
******/
> -/* Embedded.Processor Control */
> +/* Server and Embedded Processor Control */
> =20
>  #define DBELL_TYPE_SHIFT               27
>  #define DBELL_TYPE_MASK                (0x1f << DBELL_TYPE_SHIFT)
> @@ -940,11 +940,15 @@ enum {
>  #define DBELL_TYPE_G_DBELL_CRIT        (0x03 << DBELL_TYPE_SHIFT)
>  #define DBELL_TYPE_G_DBELL_MC          (0x04 << DBELL_TYPE_SHIFT)
> =20
> -#define DBELL_BRDCAST                  (1 << 26)
> +#define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
> +
> +#define DBELL_BRDCAST                  PPC_BIT(37)
>  #define DBELL_LPIDTAG_SHIFT            14
>  #define DBELL_LPIDTAG_MASK             (0xfff << DBELL_LPIDTAG_SHIFT)
>  #define DBELL_PIRTAG_MASK              0x3fff
> =20
> +#define DBELL_PROCIDTAG_MASK           PPC_BITMASK(44, 63)
> +
>  /***********************************************************************=
******/
>  /* Segment page size information, used by recent hash MMUs
>   * The format of this structure mirrors kvm_ppc_smmu_info
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 4e548a448747..c092fbead036 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -417,6 +417,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>      case POWERPC_EXCP_HISI:      /* Hypervisor instruction storage excep=
tion */
>      case POWERPC_EXCP_HDSEG:     /* Hypervisor data segment exception   =
     */
>      case POWERPC_EXCP_HISEG:     /* Hypervisor instruction segment excep=
tion */
> +    case POWERPC_EXCP_SDOOR_HV:  /* Hypervisor Doorbell interrupt       =
     */
>      case POWERPC_EXCP_HV_EMU:
>          srr0 =3D SPR_HSRR0;
>          srr1 =3D SPR_HSRR1;
> @@ -846,6 +847,11 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>              powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_DOORI);
>              return;
>          }
> +        if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDOORBELL)) {
> +            env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDOORBELL);
> +            powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_SDOOR_HV);
> +            return;
> +        }
>          if (env->pending_interrupts & (1 << PPC_INTERRUPT_PERFM)) {
>              env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_PERFM);
>              powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_PERFM);
> @@ -1145,4 +1151,50 @@ void helper_msgsnd(target_ulong rb)
>      }
>      qemu_mutex_unlock_iothread();
>  }
> +
> +/* Server Processor Control */
> +static int book3s_dbell2irq(target_ulong rb)
> +{
> +    int msg =3D rb & DBELL_TYPE_MASK;
> +
> +    /* A Directed Hypervisor Doorbell message is sent only if the
> +     * message type is 5. All other types are reserved and the
> +     * instruction is a no-op */
> +    return msg =3D=3D DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL =
: -1;
> +}
> +
> +void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
> +{
> +    int irq =3D book3s_dbell2irq(rb);
> +
> +    if (irq < 0) {
> +        return;
> +    }
> +
> +    env->pending_interrupts &=3D ~(1 << irq);
> +}
> +
> +void helper_book3s_msgsnd(target_ulong rb)
> +{
> +    int irq =3D book3s_dbell2irq(rb);
> +    int pir =3D rb & DBELL_PROCIDTAG_MASK;
> +    CPUState *cs;
> +
> +    if (irq < 0) {
> +        return;
> +    }
> +
> +    qemu_mutex_lock_iothread();
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *cenv =3D &cpu->env;
> +
> +        /* TODO: broadcast message to all threads of the same  processor=
 */
> +        if (cenv->spr_cb[SPR_PIR].default_value =3D=3D pir) {
> +            cenv->pending_interrupts |=3D 1 << irq;
> +            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        }
> +    }
> +    qemu_mutex_unlock_iothread();
> +}
>  #endif
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index bb6a94a8b390..5b739179b8b5 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -679,6 +679,8 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, e=
nv, tl, tl)
>  DEF_HELPER_FLAGS_1(602_mfrom, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_1(msgsnd, void, tl)
>  DEF_HELPER_2(msgclr, void, env, tl)
> +DEF_HELPER_1(book3s_msgsnd, void, tl)
> +DEF_HELPER_2(book3s_msgclr, void, env, tl)
>  #endif
> =20
>  DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 396f422cf407..4325aa90a6fa 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6175,7 +6175,12 @@ static void gen_msgclr(DisasContext *ctx)
>      GEN_PRIV;
>  #else
>      CHK_HV;
> -    gen_helper_msgclr(cpu_env, cpu_gpr[rB(ctx->opcode)]);
> +    /* 64-bit server processors compliant with arch 2.x */
> +    if (ctx->insns_flags & PPC_SEGMENT_64B) {
> +        gen_helper_book3s_msgclr(cpu_env, cpu_gpr[rB(ctx->opcode)]);
> +    } else {
> +        gen_helper_msgclr(cpu_env, cpu_gpr[rB(ctx->opcode)]);
> +    }
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> @@ -6185,10 +6190,24 @@ static void gen_msgsnd(DisasContext *ctx)
>      GEN_PRIV;
>  #else
>      CHK_HV;
> -    gen_helper_msgsnd(cpu_gpr[rB(ctx->opcode)]);
> +    /* 64-bit server processors compliant with arch 2.x */
> +    if (ctx->insns_flags & PPC_SEGMENT_64B) {
> +        gen_helper_book3s_msgsnd(cpu_gpr[rB(ctx->opcode)]);
> +    } else {
> +        gen_helper_msgsnd(cpu_gpr[rB(ctx->opcode)]);
> +    }
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> +static void gen_msgsync(DisasContext *ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV;
> +#else
> +    CHK_HV;
> +#endif /* defined(CONFIG_USER_ONLY) */
> +    /* interpreted as no-op */
> +}
> =20
>  #if defined(TARGET_PPC64)
>  static void gen_maddld(DisasContext *ctx)
> @@ -6669,6 +6688,8 @@ GEN_HANDLER2_E(msgsnd, "msgsnd", 0x1F, 0x0E, 0x06, =
0x03ff0001,
>                 PPC_NONE, PPC2_PRCNTL),
>  GEN_HANDLER2_E(msgclr, "msgclr", 0x1F, 0x0E, 0x07, 0x03ff0001,
>                 PPC_NONE, PPC2_PRCNTL),
> +GEN_HANDLER2_E(msgsync, "msgsync", 0x1F, 0x16, 0x1B, 0x00000000,
> +               PPC_NONE, PPC2_PRCNTL),
>  GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
>  GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
>  GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index ab70b3a25c1d..87a23f0f6265 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8866,7 +8866,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                          PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>                          PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300;
> +                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL;
>      pcc->msr_mask =3D (1ull << MSR_SF) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hjFmXiTvfEJBEd4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphco0ACgkQbDjKyiDZ
s5I04xAA19vEydImWVRQYFXKqGspj2fI53VFLwmJJYp295/Z33HGeRGeGAaT8AsW
CMAGwhzgvRGTgoit7GJ8N3E3QK5DdZXngOwTKb4pGuzC1fnp0E6T2mAZ0WOVgkAl
ZtTGVQs7doUnkfPMMDYzjsTM+dCq5Y3TrFOWuyrxD2q0gCfW0m6V7Fdx8xqBz/dR
5QIQLkFu14+tw8nmx54UZTBBJkgthBavapK/QryzziCaZO/m9SXF07ObTVZYvD6A
CfFNyZVWKyh/NeyQjS3bnA3NlZvRFsJtlTSGV3fO6BhLXOEdl7tt8Jvsf/0+Js/o
8tFb/9qDTP87JxQPUZ1VjyTJSuszFschNO+zKUcwob+nTU3lZObjDHudgOkiU0zA
HyYF31t4c/lAW+Jg/KmS64o19gUYyMw0sdfsoVgB8zxYBLbXMZFl8ilOwZFQ+bwN
hAuLmnFQDQw+KzQkK12SSEZPaLpf1BoaOUkM4YkTvuHF1sUEswl2wsxPXmWy32+J
OvPZOz00PWyCyEPYMut4+N/xqoJU5KxyhaGXWx8GL8BkjWPs5bxSO1WOMzh32PqR
c41jRMXQ7OSaXrOP5XJftHPZ235z3VkKmgD9tB8seNi+SX5XyDVxy9U7ZjHyQHhf
bj4wBQHNSaOnnzmu5fuWwLkOrqAJw0Hr2Z7N5eA5eyJzAz7vDVE=
=xeZY
-----END PGP SIGNATURE-----

--hjFmXiTvfEJBEd4m--
