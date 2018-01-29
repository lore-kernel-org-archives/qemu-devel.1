Received: from eggs.gnu.org ([2001:4830:134:3::10]:48150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Miodrag.Dinic@mips.com>) id 1eg6jU-0006IO-5C
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Miodrag.Dinic@mips.com>) id 1eg6jQ-0001Zt-27
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:32:12 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:41349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Miodrag.Dinic@mips.com>)
	id 1eg6jP-0008V6-TJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:32:08 -0500
From: Miodrag Dinic <Miodrag.Dinic@mips.com>
Date: Mon, 29 Jan 2018 10:30:12 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD61223D44F@MIPSMAIL01.mipstec.com>
References: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1516377391-25945-2-git-send-email-aleksandar.markovic@rt-rk.com>,
	<87k1wdolqq.fsf@linaro.org>
In-Reply-To: <87k1wdolqq.fsf@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Aleksandar
	Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard
	Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <Yongbok.Kim@mips.com>, Aleksandar Markovic <Aleksandar.Markovic@mips.com>, Goran Ferenc <Goran.Ferenc@mips.com>, Petar Jovanovic <Petar.Jovanovic@mips.com>

Hi Alex,=0A=
=0A=
thank you for your comments, and sorry for such a late response, Aleksandar=
 is currently on sick leave, but I will try to address your concern.=0A=
Actually, answer to your question is already in the commit message of this =
patch, I'm copying it here for convenience:=0A=
=0A=
    Given our LL/SC emulation is already very simplified (as we only compar=
e=0A=
    the address and value), using virtual addresses instead of physical doe=
s=0A=
    not seem to be a gross violation. Correct guest software should not rel=
y=0A=
    on LL/SC if they accesses the same physical address via different virtu=
al=0A=
    addresses or if page mapping gets changed between LL/SC due to manipula=
ting=0A=
    tlb entries. MIPS Instruction Set Manual clearly says that an RMW seque=
nce=0A=
    must use the same address in the LL and SC (virtual address, physical=
=0A=
    address, cacheability and coherency attributes must be identical). Othe=
rwise=0A=
    the result of the SC is not predictable. This patch takes advantage of =
this=0A=
    fact and removes the virtual -> physical address translation from SC he=
lper.=0A=
=0A=
Details about this can be found in the official documentation about SC (pag=
e 450) and SCD (page 454) : =0A=
https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00087-2B-MIPS=
64BIS-AFP-6.06.pdf=0A=
=0A=
Kind regards,=0A=
Miodrag=0A=
________________________________________=0A=
From: Alex Benn=E9e [alex.bennee@linaro.org]=0A=
Sent: Friday, January 19, 2018 5:29 PM=0A=
To: Aleksandar Markovic=0A=
Cc: qemu-devel@nongnu.org; Aurelien Jarno; Fam Zheng; Gerd Hoffmann; Lauren=
t Vivier; Paolo Bonzini; Peter Maydell; Philippe Mathieu-Daud=E9; Richard H=
enderson; Riku Voipio; Yongbok Kim; Aleksandar Markovic; Goran Ferenc; Miod=
rag Dinic; Petar Jovanovic=0A=
Subject: Re: [PATCH 1/7] target/mips: compare virtual addresses in LL/SC se=
quence=0A=
=0A=
Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:=0A=
=0A=
> From: Leon Alrae <leon.alrae@imgtec.com>=0A=
>=0A=
> Do only virtual addresses comaprisons in LL/SC sequence.=0A=
=0A=
Doesn't this make things less correct? I know we currently use virtual=0A=
addresses for the ARM code but in theory you could map two virtual pages=0A=
to the same physical page and then violate the LL/SC behaviour.=0A=
=0A=
Of course I can't imagine why you might do that.=0A=
=0A=
>=0A=
> Until this patch, physical addresses had been compared in LL/SC=0A=
> sequence. Unfortunately, that meant that, on each SC, the address=0A=
> translation had to be done, which is a quite complex operation.=0A=
> Getting rid of that allows throwing away SC helpers and having=0A=
> common SC implementations in user and system mode, avoiding two=0A=
> separate implementations selected by #ifdef CONFIG_USER_ONLY.=0A=
>=0A=
> Given that LL/SC emulation was already very simplified (as only the=0A=
> address and value were compared), using virtual addresses instead of=0A=
> physical does not seem to be a violation. Correct guest software=0A=
> should not rely on LL/SC if they accesses the same physical address=0A=
> via different virtual addresses or if page mapping gets changed=0A=
> between LL/SC due to manipulating TLB entries. MIPS Instruction Set=0A=
> Manual clearly says that an RMW sequence must use the same address=0A=
> in the LL and SC (virtual address, physical address, cacheability=0A=
> and coherency attributes must be identical). Otherwise, the result of=0A=
> the SC is not predictable. This patch takes advantage of this fact=0A=
> and removes the virtual->physical address translation from SC helper.=0A=
>=0A=
> lladdr served as Coprocessor 0 LLAddr register which captures physical=0A=
> address of the most recent LL instruction, and also lladdr was used=0A=
> for comparison with following SC physical address. This patch changes=0A=
> the meaning of lladdr - now it will only keep the virtual address of=0A=
> the most recent LL. Additionally we introduce CP0_LLAddr which is the=0A=
> actual Coperocessor 0 LLAddr register that guest can access.=0A=
>=0A=
> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>=0A=
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>=0A=
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>=0A=
> ---=0A=
>  target/mips/cpu.h       |  3 ++-=0A=
>  target/mips/machine.c   |  7 ++++---=0A=
>  target/mips/op_helper.c | 29 +++++++++++++++++------------=0A=
>  target/mips/translate.c |  4 ++--=0A=
>  4 files changed, 25 insertions(+), 18 deletions(-)=0A=
>=0A=
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h=0A=
> index 7f8ba5f..57ca861 100644=0A=
> --- a/target/mips/cpu.h=0A=
> +++ b/target/mips/cpu.h=0A=
> @@ -480,10 +480,11 @@ struct CPUMIPSState {=0A=
>  #define CP0C5_NFExists   0=0A=
>      int32_t CP0_Config6;=0A=
>      int32_t CP0_Config7;=0A=
> +    uint64_t CP0_LLAddr;=0A=
>      uint64_t CP0_MAAR[MIPS_MAAR_MAX];=0A=
>      int32_t CP0_MAARI;=0A=
>      /* XXX: Maybe make LLAddr per-TC? */=0A=
> -    uint64_t lladdr;=0A=
> +    target_ulong lladdr; /* LL virtual address compared against SC */=0A=
>      target_ulong llval;=0A=
>      target_ulong llnewval;=0A=
>      target_ulong llreg;=0A=
> diff --git a/target/mips/machine.c b/target/mips/machine.c=0A=
> index 20100d5..155170c 100644=0A=
> --- a/target/mips/machine.c=0A=
> +++ b/target/mips/machine.c=0A=
> @@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb =3D {=0A=
>=0A=
>  const VMStateDescription vmstate_mips_cpu =3D {=0A=
>      .name =3D "cpu",=0A=
> -    .version_id =3D 10,=0A=
> -    .minimum_version_id =3D 10,=0A=
> +    .version_id =3D 11,=0A=
> +    .minimum_version_id =3D 11,=0A=
>      .post_load =3D cpu_post_load,=0A=
>      .fields =3D (VMStateField[]) {=0A=
>          /* Active TC */=0A=
> @@ -283,9 +283,10 @@ const VMStateDescription vmstate_mips_cpu =3D {=0A=
>          VMSTATE_INT32(env.CP0_Config3, MIPSCPU),=0A=
>          VMSTATE_INT32(env.CP0_Config6, MIPSCPU),=0A=
>          VMSTATE_INT32(env.CP0_Config7, MIPSCPU),=0A=
> +        VMSTATE_UINT64(env.CP0_LLAddr, MIPSCPU),=0A=
>          VMSTATE_UINT64_ARRAY(env.CP0_MAAR, MIPSCPU, MIPS_MAAR_MAX),=0A=
>          VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),=0A=
> -        VMSTATE_UINT64(env.lladdr, MIPSCPU),=0A=
> +        VMSTATE_UINTTL(env.lladdr, MIPSCPU),=0A=
>          VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),=0A=
>          VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),=0A=
>          VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),=0A=
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c=0A=
> index e537a8b..283669c 100644=0A=
> --- a/target/mips/op_helper.c=0A=
> +++ b/target/mips/op_helper.c=0A=
> @@ -255,15 +255,15 @@ static inline hwaddr do_translate_address(CPUMIPSSt=
ate *env,=0A=
>                                                        target_ulong addre=
ss,=0A=
>                                                        int rw, uintptr_t =
retaddr)=0A=
>  {=0A=
> -    hwaddr lladdr;=0A=
> +    hwaddr paddr;=0A=
>      CPUState *cs =3D CPU(mips_env_get_cpu(env));=0A=
>=0A=
> -    lladdr =3D cpu_mips_translate_address(env, address, rw);=0A=
> +    paddr =3D cpu_mips_translate_address(env, address, rw);=0A=
>=0A=
> -    if (lladdr =3D=3D -1LL) {=0A=
> +    if (paddr =3D=3D -1LL) {=0A=
>          cpu_loop_exit_restore(cs, retaddr);=0A=
>      } else {=0A=
> -        return lladdr;=0A=
> +        return paddr;=0A=
>      }=0A=
>  }=0A=
>=0A=
> @@ -274,7 +274,8 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong arg, int mem_idx)  \=0A=
>          env->CP0_BadVAddr =3D arg;                                      =
        \=0A=
>          do_raise_exception(env, EXCP_AdEL, GETPC());                    =
      \=0A=
>      }                                                                   =
      \=0A=
> -    env->lladdr =3D do_translate_address(env, arg, 0, GETPC());         =
        \=0A=
> +    env->CP0_LLAddr =3D do_translate_address(env, arg, 0, GETPC());     =
        \=0A=
> +    env->lladdr =3D arg;                                                =
        \=0A=
>      env->llval =3D do_##insn(env, arg, mem_idx, GETPC());               =
        \=0A=
>      return env->llval;                                                  =
      \=0A=
>  }=0A=
> @@ -294,7 +295,7 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong arg1,              \=0A=
>          env->CP0_BadVAddr =3D arg2;                                     =
        \=0A=
>          do_raise_exception(env, EXCP_AdES, GETPC());                    =
      \=0A=
>      }                                                                   =
      \=0A=
> -    if (do_translate_address(env, arg2, 1, GETPC()) =3D=3D env->lladdr) =
{         \=0A=
> +    if (arg2 =3D=3D env->lladdr) {                                      =
          \=0A=
>          tmp =3D do_##ld_insn(env, arg2, mem_idx, GETPC());              =
        \=0A=
>          if (tmp =3D=3D env->llval) {                                    =
          \=0A=
>              do_##st_insn(env, arg2, arg1, mem_idx, GETPC());            =
      \=0A=
> @@ -873,7 +874,7 @@ target_ulong helper_mftc0_status(CPUMIPSState *env)=
=0A=
>=0A=
>  target_ulong helper_mfc0_lladdr(CPUMIPSState *env)=0A=
>  {=0A=
> -    return (int32_t)(env->lladdr >> env->CP0_LLAddr_shift);=0A=
> +    return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAddr_shift);=0A=
>  }=0A=
>=0A=
>  target_ulong helper_mfc0_maar(CPUMIPSState *env)=0A=
> @@ -949,7 +950,7 @@ target_ulong helper_dmfc0_tcschefback(CPUMIPSState *e=
nv)=0A=
>=0A=
>  target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)=0A=
>  {=0A=
> -    return env->lladdr >> env->CP0_LLAddr_shift;=0A=
> +    return env->CP0_LLAddr >> env->CP0_LLAddr_shift;=0A=
>  }=0A=
>=0A=
>  target_ulong helper_dmfc0_maar(CPUMIPSState *env)=0A=
> @@ -1177,7 +1178,8 @@ void helper_mtc0_tcrestart(CPUMIPSState *env, targe=
t_ulong arg1)=0A=
>  {=0A=
>      env->active_tc.PC =3D arg1;=0A=
>      env->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);=0A=
> -    env->lladdr =3D 0ULL;=0A=
> +    env->CP0_LLAddr =3D 0;=0A=
> +    env->lladdr =3D 0;=0A=
>      /* MIPS16 not implemented. */=0A=
>  }=0A=
>=0A=
> @@ -1189,12 +1191,14 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, ta=
rget_ulong arg1)=0A=
>      if (other_tc =3D=3D other->current_tc) {=0A=
>          other->active_tc.PC =3D arg1;=0A=
>          other->active_tc.CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);=0A=
> -        other->lladdr =3D 0ULL;=0A=
> +        other->CP0_LLAddr =3D 0;=0A=
> +        other->lladdr =3D 0;=0A=
>          /* MIPS16 not implemented. */=0A=
>      } else {=0A=
>          other->tcs[other_tc].PC =3D arg1;=0A=
>          other->tcs[other_tc].CP0_TCStatus &=3D ~(1 << CP0TCSt_TDS);=0A=
> -        other->lladdr =3D 0ULL;=0A=
> +        other->CP0_LLAddr =3D 0;=0A=
> +        other->lladdr =3D 0;=0A=
>          /* MIPS16 not implemented. */=0A=
>      }=0A=
>  }=0A=
> @@ -1620,7 +1624,7 @@ void helper_mtc0_lladdr(CPUMIPSState *env, target_u=
long arg1)=0A=
>  {=0A=
>      target_long mask =3D env->CP0_LLAddr_rw_bitmask;=0A=
>      arg1 =3D arg1 << env->CP0_LLAddr_shift;=0A=
> -    env->lladdr =3D (env->lladdr & ~mask) | (arg1 & mask);=0A=
> +    env->CP0_LLAddr =3D (env->CP0_LLAddr & ~mask) | (arg1 & mask);=0A=
>  }=0A=
>=0A=
>  #define MTC0_MAAR_MASK(env) \=0A=
> @@ -2318,6 +2322,7 @@ static inline void exception_return(CPUMIPSState *e=
nv)=0A=
>  void helper_eret(CPUMIPSState *env)=0A=
>  {=0A=
>      exception_return(env);=0A=
> +    env->CP0_LLAddr =3D 1;=0A=
>      env->lladdr =3D 1;=0A=
>  }=0A=
>=0A=
> diff --git a/target/mips/translate.c b/target/mips/translate.c=0A=
> index d05ee67..c9104a7 100644=0A=
> --- a/target/mips/translate.c=0A=
> +++ b/target/mips/translate.c=0A=
> @@ -4913,7 +4913,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)=0A=
>      case 17:=0A=
>          switch (sel) {=0A=
>          case 0:=0A=
> -            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),=0A=
> +            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_LLAddr),=0A=
>                               ctx->CP0_LLAddr_shift);=0A=
>              rn =3D "LLAddr";=0A=
>              break;=0A=
> @@ -20440,7 +20440,7 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, f=
printf_function cpu_fprintf,=0A=
>                  env->CP0_Status, env->CP0_Cause, env->CP0_EPC);=0A=
>      cpu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"=0A=
>                  PRIx64 "\n",=0A=
> -                env->CP0_Config0, env->CP0_Config1, env->lladdr);=0A=
> +                env->CP0_Config0, env->CP0_Config1, env->CP0_LLAddr);=0A=
>      cpu_fprintf(f, "    Config2 0x%08x Config3 0x%08x\n",=0A=
>                  env->CP0_Config2, env->CP0_Config3);=0A=
>      cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",=0A=
=0A=
=0A=
--=0A=
Alex Benn=E9e=0A=
