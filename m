Received: from eggs.gnu.org ([209.51.188.92]:51338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1guKKl-0000Ln-Mr
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1guKKh-0007pg-G7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:57:57 -0500
Received: from mail-eopbgr820090.outbound.protection.outlook.com
	([40.107.82.90]:36832
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1guKKV-0007OT-IC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:57:46 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 14 Feb 2019 16:57:32 +0000
Message-ID: <BN6PR2201MB125158759A9AA79430DA7EDEC6670@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1549902684-21740-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1549902684-21740-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/6] target/mips: compare virtual
 addresses in LL/SC sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, Paul Burton <pburton@wavecomp.com>, "cota@braap.org" <cota@braap.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, February 11, 2019 5:31 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo; alex.be=
nnee@linaro.org; Paul > Burton; cota@braap.org
> Subject: [PATCH v3 1/6] target/mips: compare virtual addresses in LL/SC s=
equence
>=20
> From: Leon Alrae <leon.alrae@imgtec.com>
>=20
> Do only virtual addresses comaprisons in LL/SC sequence emulations.
>=20
> Until this patch, physical addresses had been compared in SC part of
> LL/SC sequence, even though such comparisons could be avoided. Getting
> rid of them allows throwing away SC helpers and having common SC
> implementations in user and system mode, avoiding the need for two
> separate implementations selected by #ifdef CONFIG_USER_ONLY.
>=20
> Correct guest software should not rely on LL/SC if they accesses the
> same physical address via different virtual addresses or if page
> mapping gets changed between LL/SC due to manipulating TLB entries.
> MIPS Instruction Set Manual clearly says that an RMW sequence must
> use the same address in the LL and SC (virtual address, physical
> address, cacheability and coherency attributes must be identical).
> Otherwise, the result of the SC is not predictable. This patch takes
> advantage of this fact and removes the virtual->physical address
> translation from SC helper.
>=20
> lladdr served as Coprocessor 0 LLAddr register which captures physical
> address of the most recent LL instruction, and also lladdr was used
> for comparison with following SC physical address. This patch changes
> the meaning of lladdr - now it will only keep the virtual address of
> the most recent LL. Additionally, CP0_LLAddr field is introduced which
> is the actual Coperocessor 0 LLAddr register that guest can access.
>=20
> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Acked-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  target/mips/cpu.h       |  3 ++-
>  target/mips/machine.c   |  7 ++++---
>  target/mips/op_helper.c | 29 +++++++++++++++++------------
>  target/mips/translate.c |  4 ++--
>  4 files changed, 25 insertions(+), 18 deletions(-)
>=20

This patch was authored long time ago (perhaps two years ago), and
there were some changes in the related areas in the meantime. This
means that some code portions (for example, SC vs. SCWP handliing)
are not as consistent as they could be. But this doeasn't affect the
core of MTTCG feature, and can be handled separately in future
cleanups, so for this patch anyway:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 473d26d..f10e016 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -867,13 +867,14 @@ struct CPUMIPSState {
>  #define CP0C5_NFExists     0
>      int32_t CP0_Config6;
>      int32_t CP0_Config7;
> +    uint64_t CP0_LLAddr;
>      uint64_t CP0_MAAR[MIPS_MAAR_MAX];
>      int32_t CP0_MAARI;
>      /* XXX: Maybe make LLAddr per-TC? */
>  /*
>   * CP0 Register 17
>   */
> -    uint64_t lladdr;
> +    target_ulong lladdr; /* LL virtual address compared against SC */
>      target_ulong llval;
>      target_ulong llnewval;
>      uint64_t llval_wp;
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 1341ab1..70d277d 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -214,8 +214,8 @@ const VMStateDescription vmstate_tlb =3D {
>=20
>  const VMStateDescription vmstate_mips_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 17,
> -    .minimum_version_id =3D 17,
> +    .version_id =3D 18,
> +    .minimum_version_id =3D 18,
>      .post_load =3D cpu_post_load,
>      .fields =3D (VMStateField[]) {
>          /* Active TC */
> @@ -293,9 +293,10 @@ const VMStateDescription vmstate_mips_cpu =3D {
>          VMSTATE_INT32(env.CP0_Config3, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config6, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config7, MIPSCPU),
> +        VMSTATE_UINT64(env.CP0_LLAddr, MIPSCPU),
>          VMSTATE_UINT64_ARRAY(env.CP0_MAAR, MIPSCPU, MIPS_MAAR_MAX),
>          VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),
> -        VMSTATE_UINT64(env.lladdr, MIPSCPU),
> +        VMSTATE_UINTTL(env.lladdr, MIPSCPU),
>          VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),
>          VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
>          VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index aebad24..44f2626 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -349,15 +349,15 @@ static inline hwaddr do_translate_address(CPUMIPSSt=
ate *env,
>                                                        target_ulong addre=
ss,
>                                                        int rw, uintptr_t =
retaddr)
>  {
> -    hwaddr lladdr;
> +    hwaddr paddr;
>      CPUState *cs =3D CPU(mips_env_get_cpu(env));
>=20
> -    lladdr =3D cpu_mips_translate_address(env, address, rw);
> +    paddr =3D cpu_mips_translate_address(env, address, rw);
>=20
> -    if (lladdr =3D=3D -1LL) {
> +    if (paddr =3D=3D -1LL) {
>          cpu_loop_exit_restore(cs, retaddr);
>      } else {
> -        return lladdr;
> +        return paddr;
>      }
>  }
>=20
> @@ -370,7 +370,8 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong arg, int > mem_idx)  \
>          }                                                               =
      \
>          do_raise_exception(env, EXCP_AdEL, GETPC());                    =
      \
>      }                                                                   =
      \
> -    env->lladdr =3D do_translate_address(env, arg, 0, GETPC());         =
        \
> +    env->CP0_LLAddr =3D do_translate_address(env, arg, 0, GETPC());     =
        \
> +    env->lladdr =3D arg;                                                =
        \
>      env->llval =3D do_##insn(env, arg, mem_idx, GETPC());               =
        \
>      return env->llval;                                                  =
      \
>  }
> @@ -392,7 +393,7 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong > arg1,              \
>          }                                                               =
      \
>          do_raise_exception(env, EXCP_AdES, GETPC());                    =
      \
>      }                                                                   =
      \
> -    if (do_translate_address(env, arg2, 1, GETPC()) =3D=3D env->lladdr) =
{         \
> +    if (arg2 =3D=3D env->lladdr) {                                      =
          \
>          tmp =3D do_##ld_insn(env, arg2, mem_idx, GETPC());              =
        \
>          if (tmp =3D=3D env->llval) {                                    =
          \
>              do_##st_insn(env, arg2, arg1, mem_idx, GETPC());            =
      \
> @@ -987,7 +988,7 @@ target_ulong helper_mftc0_status(CPUMIPSState *env)
>=20
>  target_ulong helper_mfc0_lladdr(CPUMIPSState *env)
>  {
> -    return (int32_t)(env->lladdr >> env->CP0_LLAddr_shift);
> +    return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAddr_shift);
>  }
>=20
>  target_ulong helper_mfc0_maar(CPUMIPSState *env)
> @@ -1063,7 +1064,7 @@ target_ulong helper_dmfc0_tcschefback(CPUMIPSState =
*env)
>=20
>  target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)
>  {
> -    return env->lladdr >> env->CP0_LLAddr_shift;
> +    return env->CP0_LLAddr >> env->CP0_LLAddr_shift;
>  }
>=20
>  target_ulong helper_dmfc0_maar(CPUMIPSState *env)
> @@ -1299,7 +1300,8 @@ void helper_mtc0_tcrestart(CPUMIPSState *env, targe=
t_ulong arg1)
>  {
>      env->active_tc.PC =3D arg1;
>      env->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);
> -    env->lladdr =3D 0ULL;
> +    env->CP0_LLAddr =3D 0;
> +    env->lladdr =3D 0;
>      /* MIPS16 not implemented. */
>  }
>=20
> @@ -1311,12 +1313,14 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, ta=
rget_ulong arg1)
>      if (other_tc =3D=3D other->current_tc) {
>          other->active_tc.PC =3D arg1;
>          other->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);
> -        other->lladdr =3D 0ULL;
> +        other->CP0_LLAddr =3D 0;
> +        other->lladdr =3D 0;
>          /* MIPS16 not implemented. */
>      } else {
>          other->tcs[other_tc].PC =3D arg1;
>          other->tcs[other_tc].CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);
> -        other->lladdr =3D 0ULL;
> +        other->CP0_LLAddr =3D 0;
> +        other->lladdr =3D 0;
>          /* MIPS16 not implemented. */
>      }
>  }
> @@ -1868,7 +1872,7 @@ void helper_mtc0_lladdr(CPUMIPSState *env, target_u=
long arg1)
>  {
>      target_long mask =3D env->CP0_LLAddr_rw_bitmask;
>      arg1 =3D arg1 << env->CP0_LLAddr_shift;
> -    env->lladdr =3D (env->lladdr & ~mask) | (arg1 & mask);
> +    env->CP0_LLAddr =3D (env->CP0_LLAddr & ~mask) | (arg1 & mask);
>  }
>=20
>  #define MTC0_MAAR_MASK(env) \
> @@ -2566,6 +2570,7 @@ static inline void exception_return(CPUMIPSState *e=
nv)
>  void helper_eret(CPUMIPSState *env)
>  {
>      exception_return(env);
> +    env->CP0_LLAddr =3D 1;
>      env->lladdr =3D 1;
>  }
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e9b5d1d..307d4ea 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -6612,7 +6612,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
>      case CP0_REGISTER_17:
>          switch (sel) {
>          case 0:
> -            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
> +            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_LLAddr),
>                               ctx->CP0_LLAddr_shift);
>              register_name =3D "LLAddr";
>              break;
> @@ -29795,7 +29795,7 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, f=
printf_function > cpu_fprintf,
>                  env->CP0_Status, env->CP0_Cause, env->CP0_EPC);
>      cpu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"
>                  PRIx64 "\n",
> -                env->CP0_Config0, env->CP0_Config1, env->lladdr);
> +                env->CP0_Config0, env->CP0_Config1, env->CP0_LLAddr);
>      cpu_fprintf(f, "    Config2 0x%08x Config3 0x%08x\n",
>                  env->CP0_Config2, env->CP0_Config3);
>      cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",
> --
> 2.7.4
>=20
> =
