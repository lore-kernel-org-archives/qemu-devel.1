Received: from eggs.gnu.org ([2001:4830:134:3::10]:52565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZXM-0007ua-Lx
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZXI-0006aU-Mo
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:38:24 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:44844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkZXI-0006a8-Fq
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:38:20 -0400
Received: by mail-vk0-x241.google.com with SMTP id 125-v6so8010005vke.11
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 11:38:20 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-41-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1054001a-d81f-5b48-4c61-2113cae81171@linaro.org>
Date: Tue, 31 Jul 2018 14:38:14 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-41-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 40/76] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add emulation of DSP ASE instructions for nanoMIPS - part 3.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 180 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 055be7e..e597b35 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16872,13 +16872,191 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
>      }
>  }
>  
> +/* dsp */
> +static void gen_pool32axf_1_5_nanomips_insn(DisasContext *ctx, uint32_t opc,
> +                                            int ret, int v1, int v2)
> +{
> +    TCGv_i32 t0;
> +    TCGv v0_t;
> +    TCGv v1_t;
> +
> +    t0 = tcg_temp_new_i32();
> +
> +    v0_t = tcg_temp_new();
> +    v1_t = tcg_temp_new();
> +
> +    tcg_gen_movi_i32(t0, v2 >> 3);
> +
> +    gen_load_gpr(v0_t, ret);
> +    gen_load_gpr(v1_t, v1);
> +
> +    switch (opc) {
> +    case NM_MAQ_S_W_PHR:
> +        check_dsp(ctx);
> +        gen_helper_maq_s_w_phr(t0, v1_t, v0_t, cpu_env);
> +        break;
> +    case NM_MAQ_S_W_PHL:
> +        check_dsp(ctx);
> +        gen_helper_maq_s_w_phl(t0, v1_t, v0_t, cpu_env);
> +        break;
> +    case NM_MAQ_SA_W_PHR:
> +        check_dsp(ctx);
> +        gen_helper_maq_sa_w_phr(t0, v1_t, v0_t, cpu_env);
> +        break;
> +    case NM_MAQ_SA_W_PHL:
> +        check_dsp(ctx);
> +        gen_helper_maq_sa_w_phl(t0, v1_t, v0_t, cpu_env);
> +        break;
> +    default:
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +
> +    tcg_temp_free_i32(t0);
> +
> +    tcg_temp_free(v0_t);
> +    tcg_temp_free(v1_t);
> +}
> +
> +
> +static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
> +                                    int ret, int v1, int v2)
> +{
> +    int16_t imm;
> +
> +    TCGv t0;
> +    TCGv t1;
> +    TCGv v0_t;
> +    TCGv v1_t;
> +
> +    t0 = tcg_temp_new();
> +    t1 = tcg_temp_new();
> +
> +    v0_t = tcg_temp_new();
> +    v1_t = tcg_temp_new();
> +
> +    gen_load_gpr(v0_t, ret);

Did you really mean to load the result?

> +    gen_load_gpr(v1_t, v1);
> +
> +    switch (opc) {
> +    case NM_POOL32AXF_1_0:
> +        switch (extract32(ctx->opcode, 12, 2)) {
> +        case NM_MFHI:
> +            gen_HILO(ctx, OPC_MFHI, v2 >> 3, ret);
> +            break;
> +        case NM_MFLO:
> +            gen_HILO(ctx, OPC_MFLO, v2 >> 3, ret);
> +            break;

The result isn't stored.

> +    case NM_POOL32AXF_1_3:
> +        imm = extract32(ctx->opcode, 14, 7);
> +        switch (extract32(ctx->opcode, 12, 2)) {
> +        case NM_RDDSP:
> +            tcg_gen_movi_tl(t0, imm);
> +            gen_helper_rddsp(cpu_gpr[ret], t0, cpu_env);
> +            break;

Unprotected use of cpu_gpr[0].
And many others.


r~
