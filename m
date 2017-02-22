Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgaXV-0001bp-Sk
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgaXT-0001b8-7o
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:17:17 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b5417943-559e-05bd-3155-b5af1a91f8af@twiddle.net>
Date: Thu, 23 Feb 2017 04:17:06 +1100
MIME-Version: 1.0
In-Reply-To: <1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
> and corresponding defines.
>
> Moreover, CA32 is updated when CA is updated and OV32 is updated when OV
> is updated.
>
> Arithmetic instructions:
>     * Addition and Substractions:
>
>         addic, addic., subfic, addc, subfc, adde, subfe, addme, subfme,
>         addze, and subfze always updates CA and CA32.
>
>         => CA reflects the carry out of bit 0 in 64-bit mode and out of
>            bit 32 in 32-bit mode.
>         => CA32 reflects the carry out of bit 32 independent of the
>            mode.
>
>         => SO and OV reflects overflow of the 64-bit result in 64-bit
>            mode and overflow of the low-order 32-bit result in 32-bit
>            mode
>         => OV32 reflects overflow of the low-order 32-bit independent of
>            the mode
>
>     * Multiply Low and Divide:
>
>         For mulld, divd, divde, divdu and divdeu: SO, OV, and OV32 bits
>         reflects overflow of the 64-bit result
>
>         For mullw, divw, divwe, divwu and divweu: SO, OV, and OV32 bits
>         reflects overflow of the 32-bit result
>
>      * Negate with OE=1 (nego)
>
>        For 64-bit mode if the register RA contains
>        0x8000_0000_0000_0000, OV and OV32 are set to 1.
>
>        For 32-bit mode if the register RA contains 0x8000_0000, OV and
>        OV32 are set to 1.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.c            | 19 +++++++++++++++++--
>  target/ppc/cpu.h            |  7 +++++++
>  target/ppc/translate.c      | 29 ++++++++++++++++++++++++-----
>  target/ppc/translate_init.c |  4 ++--
>  4 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index de3004b..89c1ccb 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -23,8 +23,15 @@
>
>  target_ulong cpu_read_xer(CPUPPCState *env)
>  {
> -    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
> +    target_ulong xer;
> +
> +    xer = env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
>          (env->ca << XER_CA);
> +
> +    if (is_isa300(env)) {
> +        xer |= (env->ov32 << XER_OV32) | (env->ca32 << XER_CA32);
> +    }
> +    return xer;
>  }
>
>  void cpu_write_xer(CPUPPCState *env, target_ulong xer)
> @@ -32,5 +39,13 @@ void cpu_write_xer(CPUPPCState *env, target_ulong xer)
>      env->so = (xer >> XER_SO) & 1;
>      env->ov = (xer >> XER_OV) & 1;
>      env->ca = (xer >> XER_CA) & 1;
> -    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
> +    if (is_isa300(env)) {
> +        env->ov32 = (xer >> XER_OV32) & 1;
> +        env->ca32 = (xer >> XER_CA32) & 1;
> +        env->xer = xer & ~((1ul << XER_SO) |
> +                           (1ul << XER_OV) | (1ul << XER_CA) |
> +                           (1ul << XER_OV32) | (1ul << XER_CA32));
> +    } else {
> +        env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
> +    }
>  }
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b559b67..ee2eb45 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -965,6 +965,8 @@ struct CPUPPCState {
>      target_ulong so;
>      target_ulong ov;
>      target_ulong ca;
> +    target_ulong ov32;
> +    target_ulong ca32;
>      /* Reservation address */
>      target_ulong reserve_addr;
>      /* Reservation value */
> @@ -1372,11 +1374,15 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
>  #define XER_SO  31
>  #define XER_OV  30
>  #define XER_CA  29
> +#define XER_OV32  19
> +#define XER_CA32  18
>  #define XER_CMP  8
>  #define XER_BC   0
>  #define xer_so  (env->so)
>  #define xer_ov  (env->ov)
>  #define xer_ca  (env->ca)
> +#define xer_ov32  (env->ov)
> +#define xer_ca32  (env->ca)
>  #define xer_cmp ((env->xer >> XER_CMP) & 0xFF)
>  #define xer_bc  ((env->xer >> XER_BC)  & 0x7F)
>
> @@ -2343,6 +2349,7 @@ enum {
>
>  /*****************************************************************************/
>
> +#define is_isa300(ctx) (!!(ctx->insns_flags2 & PPC2_ISA300))
>  target_ulong cpu_read_xer(CPUPPCState *env);
>  void cpu_write_xer(CPUPPCState *env, target_ulong xer);
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b09e16f..c9f6768 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -71,7 +71,7 @@ static TCGv cpu_lr;
>  #if defined(TARGET_PPC64)
>  static TCGv cpu_cfar;
>  #endif
> -static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca;
> +static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>  static TCGv cpu_reserve;
>  static TCGv cpu_fpscr;
>  static TCGv_i32 cpu_access_type;
> @@ -173,6 +173,10 @@ void ppc_translate_init(void)
>                                  offsetof(CPUPPCState, ov), "OV");
>      cpu_ca = tcg_global_mem_new(cpu_env,
>                                  offsetof(CPUPPCState, ca), "CA");
> +    cpu_ov32 = tcg_global_mem_new(cpu_env,
> +                                  offsetof(CPUPPCState, ov32), "OV32");
> +    cpu_ca32 = tcg_global_mem_new(cpu_env,
> +                                  offsetof(CPUPPCState, ca32), "CA32");
>
>      cpu_reserve = tcg_global_mem_new(cpu_env,
>                                       offsetof(CPUPPCState, reserve_addr),
> @@ -3703,7 +3707,7 @@ static void gen_tdi(DisasContext *ctx)
>
>  /***                          Processor control                            ***/
>
> -static void gen_read_xer(TCGv dst)
> +static void gen_read_xer(DisasContext *ctx, TCGv dst)
>  {
>      TCGv t0 = tcg_temp_new();
>      TCGv t1 = tcg_temp_new();
> @@ -3715,15 +3719,30 @@ static void gen_read_xer(TCGv dst)
>      tcg_gen_or_tl(t0, t0, t1);
>      tcg_gen_or_tl(dst, dst, t2);
>      tcg_gen_or_tl(dst, dst, t0);
> +    if (is_isa300(ctx)) {
> +        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
> +        tcg_gen_or_tl(dst, dst, t0);
> +        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
> +        tcg_gen_or_tl(dst, dst, t0);
> +    }
>      tcg_temp_free(t0);
>      tcg_temp_free(t1);
>      tcg_temp_free(t2);
>  }
>
> -static void gen_write_xer(TCGv src)
> +static void gen_write_xer(DisasContext *ctx, TCGv src)
>  {
> -    tcg_gen_andi_tl(cpu_xer, src,
> -                    ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
> +    if (is_isa300(ctx)) {
> +        tcg_gen_andi_tl(cpu_xer, src,
> +                        ~((1u << XER_SO) |
> +                          (1u << XER_OV) | (1u << XER_OV32) |
> +                          (1u << XER_CA) | (1u << XER_CA32)));
> +        tcg_gen_extract_tl(cpu_ov32, src, XER_OV32, 1);
> +        tcg_gen_extract_tl(cpu_ca32, src, XER_CA32, 1);
> +    } else {
> +        tcg_gen_andi_tl(cpu_xer, src,
> +                        ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
> +    }

You just determined that power8 does not store all of the bits that are 
written.  We ought to clear more bits here.  Indeed I suspect that the ANDI 
will be able to be shared between these paths.


r~
