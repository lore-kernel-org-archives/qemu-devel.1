Received: from eggs.gnu.org ([2001:4830:134:3::10]:58154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g1LvZ-0003uO-5Y
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 21:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g1LvY-0001Rl-9O
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 21:32:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g1LvX-0001Qw-Sv
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 21:32:44 -0400
Received: by mail-ot1-x344.google.com with SMTP id j9-v6so8032932otl.2
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 18:32:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180915161738.25257-2-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
	<20180915161738.25257-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Sep 2018 02:32:22 +0100
Message-ID: <CAFEAcA_e9i232hWsMCjQh6RHnNjEBj=Ng6nGuC2aNU4SSfiY-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/13] target/arm: Add ARM_FEATURE_SWP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 September 2018 at 17:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
> These insns have been removed from the ISA, but are also not
> present on some cpus with V7VE.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h       |  1 +
>  linux-user/elfload.c   |  3 ++-
>  target/arm/cpu.c       | 10 ++++++++++
>  target/arm/translate.c |  4 ++++
>  4 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 65c0fa0a65..acfb2f9104 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1495,6 +1495,7 @@ enum arm_features {
>      ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
>      ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
>      ARM_FEATURE_M_MAIN, /* M profile Main Extension */
> +    ARM_FEATURE_SWP,  /* implements swp/swpb */
>  };
>
>  static inline int arm_feature(CPUARMState *env, int feature)
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 8638612aec..fcac2563f1 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -450,7 +450,6 @@ static uint32_t get_elf_hwcap(void)
>      ARMCPU *cpu = ARM_CPU(thread_cpu);
>      uint32_t hwcaps = 0;
>
> -    hwcaps |= ARM_HWCAP_ARM_SWP;
>      hwcaps |= ARM_HWCAP_ARM_HALF;
>      hwcaps |= ARM_HWCAP_ARM_THUMB;
>      hwcaps |= ARM_HWCAP_ARM_FAST_MULT;
> @@ -458,7 +457,9 @@ static uint32_t get_elf_hwcap(void)
>      /* probe for the extra features */
>  #define GET_FEATURE(feat, hwcap) \
>      do { if (arm_feature(&cpu->env, feat)) { hwcaps |= hwcap; } } while (0)
> +
>      /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
> +    GET_FEATURE(ARM_FEATURE_SWP, ARM_HWCAP_ARM_SWP);
>      GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);

This has separated the comment about EDSP from the code line it
refers to.

>      GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
>      GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 258ba6dcaa..3bc7a16327 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1075,6 +1075,7 @@ static void arm926_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
>      set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
>      set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
> +    set_feature(&cpu->env, ARM_FEATURE_SWP);
>      cpu->midr = 0x41069265;
>      cpu->reset_fpsid = 0x41011090;
>      cpu->ctr = 0x1dd20d2;

In the current scheme of doing things I'd look for whether
we could say that some more generic thing implied SWP
rather than setting it in a lot of initfns (eg v5-but-not-v7VE?),
but maybe the later patches make that a bad approach
(haven't looked at the meat of this series).

> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c6a5d2ac44..2688380ae6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -9390,6 +9390,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                          TCGv taddr;
>                          TCGMemOp opc = s->be_data;
>
> +                        if (!arm_dc_feature(s, ARM_FEATURE_SWP)) {
> +                            goto illegal_op;
> +                        }
> +

We want to arrange to have SWP work anyway on linux-user,
I think, since the kernel will typically trap-and-emulate
it assuming it was built with CONFIG_SWP_EMULATE. (I don't
know if those kernels will advertise swp in the hwcaps,
but I guess not.)

>                          rm = (insn) & 0xf;
>
>                          if (insn & (1 << 22)) {
> --
> 2.17.1

thanks
-- PMM
