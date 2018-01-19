Received: from eggs.gnu.org ([2001:4830:134:3::10]:43881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecZXx-00029M-5G
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ecZXt-0002WI-1p
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:29:41 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ecZXs-0002UT-O0
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:29:36 -0500
Received: by mail-wr0-x242.google.com with SMTP id 16so2064860wry.12
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:29:36 -0800 (PST)
References: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1516377391-25945-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1516377391-25945-2-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Jan 2018 16:29:33 +0000
Message-ID: <87k1wdolqq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] target/mips: compare virtual addresses
 in LL/SC sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Leon Alrae <leon.alrae@imgtec.com>
>
> Do only virtual addresses comaprisons in LL/SC sequence.

Doesn't this make things less correct? I know we currently use virtual
addresses for the ARM code but in theory you could map two virtual pages
to the same physical page and then violate the LL/SC behaviour.

Of course I can't imagine why you might do that.

>
> Until this patch, physical addresses had been compared in LL/SC
> sequence. Unfortunately, that meant that, on each SC, the address
> translation had to be done, which is a quite complex operation.
> Getting rid of that allows throwing away SC helpers and having
> common SC implementations in user and system mode, avoiding two
> separate implementations selected by #ifdef CONFIG_USER_ONLY.
>
> Given that LL/SC emulation was already very simplified (as only the
> address and value were compared), using virtual addresses instead of
> physical does not seem to be a violation. Correct guest software
> should not rely on LL/SC if they accesses the same physical address
> via different virtual addresses or if page mapping gets changed
> between LL/SC due to manipulating TLB entries. MIPS Instruction Set
> Manual clearly says that an RMW sequence must use the same address
> in the LL and SC (virtual address, physical address, cacheability
> and coherency attributes must be identical). Otherwise, the result of
> the SC is not predictable. This patch takes advantage of this fact
> and removes the virtual->physical address translation from SC helper.
>
> lladdr served as Coprocessor 0 LLAddr register which captures physical
> address of the most recent LL instruction, and also lladdr was used
> for comparison with following SC physical address. This patch changes
> the meaning of lladdr - now it will only keep the virtual address of
> the most recent LL. Additionally we introduce CP0_LLAddr which is the
> actual Coperocessor 0 LLAddr register that guest can access.
>
> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  target/mips/cpu.h       |  3 ++-
>  target/mips/machine.c   |  7 ++++---
>  target/mips/op_helper.c | 29 +++++++++++++++++------------
>  target/mips/translate.c |  4 ++--
>  4 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 7f8ba5f..57ca861 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -480,10 +480,11 @@ struct CPUMIPSState {
>  #define CP0C5_NFExists   0
>      int32_t CP0_Config6;
>      int32_t CP0_Config7;
> +    uint64_t CP0_LLAddr;
>      uint64_t CP0_MAAR[MIPS_MAAR_MAX];
>      int32_t CP0_MAARI;
>      /* XXX: Maybe make LLAddr per-TC? */
> -    uint64_t lladdr;
> +    target_ulong lladdr; /* LL virtual address compared against SC */
>      target_ulong llval;
>      target_ulong llnewval;
>      target_ulong llreg;
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 20100d5..155170c 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb =3D {
>
>  const VMStateDescription vmstate_mips_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 10,
> -    .minimum_version_id =3D 10,
> +    .version_id =3D 11,
> +    .minimum_version_id =3D 11,
>      .post_load =3D cpu_post_load,
>      .fields =3D (VMStateField[]) {
>          /* Active TC */
> @@ -283,9 +283,10 @@ const VMStateDescription vmstate_mips_cpu =3D {
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
> index e537a8b..283669c 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -255,15 +255,15 @@ static inline hwaddr do_translate_address(CPUMIPSSt=
ate *env,
>                                                        target_ulong addre=
ss,
>                                                        int rw, uintptr_t =
retaddr)
>  {
> -    hwaddr lladdr;
> +    hwaddr paddr;
>      CPUState *cs =3D CPU(mips_env_get_cpu(env));
>
> -    lladdr =3D cpu_mips_translate_address(env, address, rw);
> +    paddr =3D cpu_mips_translate_address(env, address, rw);
>
> -    if (lladdr =3D=3D -1LL) {
> +    if (paddr =3D=3D -1LL) {
>          cpu_loop_exit_restore(cs, retaddr);
>      } else {
> -        return lladdr;
> +        return paddr;
>      }
>  }
>
> @@ -274,7 +274,8 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong arg, int mem_idx)  \
>          env->CP0_BadVAddr =3D arg;                                      =
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
> @@ -294,7 +295,7 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong arg1,              \
>          env->CP0_BadVAddr =3D arg2;                                     =
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
> @@ -873,7 +874,7 @@ target_ulong helper_mftc0_status(CPUMIPSState *env)
>
>  target_ulong helper_mfc0_lladdr(CPUMIPSState *env)
>  {
> -    return (int32_t)(env->lladdr >> env->CP0_LLAddr_shift);
> +    return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAddr_shift);
>  }
>
>  target_ulong helper_mfc0_maar(CPUMIPSState *env)
> @@ -949,7 +950,7 @@ target_ulong helper_dmfc0_tcschefback(CPUMIPSState *e=
nv)
>
>  target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)
>  {
> -    return env->lladdr >> env->CP0_LLAddr_shift;
> +    return env->CP0_LLAddr >> env->CP0_LLAddr_shift;
>  }
>
>  target_ulong helper_dmfc0_maar(CPUMIPSState *env)
> @@ -1177,7 +1178,8 @@ void helper_mtc0_tcrestart(CPUMIPSState *env, targe=
t_ulong arg1)
>  {
>      env->active_tc.PC =3D arg1;
>      env->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);
> -    env->lladdr =3D 0ULL;
> +    env->CP0_LLAddr =3D 0;
> +    env->lladdr =3D 0;
>      /* MIPS16 not implemented. */
>  }
>
> @@ -1189,12 +1191,14 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, ta=
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
> @@ -1620,7 +1624,7 @@ void helper_mtc0_lladdr(CPUMIPSState *env, target_u=
long arg1)
>  {
>      target_long mask =3D env->CP0_LLAddr_rw_bitmask;
>      arg1 =3D arg1 << env->CP0_LLAddr_shift;
> -    env->lladdr =3D (env->lladdr & ~mask) | (arg1 & mask);
> +    env->CP0_LLAddr =3D (env->CP0_LLAddr & ~mask) | (arg1 & mask);
>  }
>
>  #define MTC0_MAAR_MASK(env) \
> @@ -2318,6 +2322,7 @@ static inline void exception_return(CPUMIPSState *e=
nv)
>  void helper_eret(CPUMIPSState *env)
>  {
>      exception_return(env);
> +    env->CP0_LLAddr =3D 1;
>      env->lladdr =3D 1;
>  }
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d05ee67..c9104a7 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4913,7 +4913,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
>      case 17:
>          switch (sel) {
>          case 0:
> -            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
> +            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_LLAddr),
>                               ctx->CP0_LLAddr_shift);
>              rn =3D "LLAddr";
>              break;
> @@ -20440,7 +20440,7 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, f=
printf_function cpu_fprintf,
>                  env->CP0_Status, env->CP0_Cause, env->CP0_EPC);
>      cpu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"
>                  PRIx64 "\n",
> -                env->CP0_Config0, env->CP0_Config1, env->lladdr);
> +                env->CP0_Config0, env->CP0_Config1, env->CP0_LLAddr);
>      cpu_fprintf(f, "    Config2 0x%08x Config3 0x%08x\n",
>                  env->CP0_Config2, env->CP0_Config3);
>      cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",


--
Alex Benn=C3=A9e
