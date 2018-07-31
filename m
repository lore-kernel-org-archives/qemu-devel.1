Received: from eggs.gnu.org ([2001:4830:134:3::10]:54501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZil-0002aY-9u
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkZii-00008m-5V
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:50:11 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:33861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkZih-000085-SJ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:50:08 -0400
Received: by mail-ua0-x242.google.com with SMTP id r10-v6so10985097uao.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 11:50:07 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-42-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7e97b93-0f29-ce6f-f5a2-a5dc963c211f@linaro.org>
Date: Tue, 31 Jul 2018 14:50:02 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-42-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 41/76] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 4
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
 +static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
> +                                          int ret, int v1, int v2)
> +{
> +    TCGv t0;
> +    TCGv t1;
> +
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
> +    gen_load_gpr(v1_t, v1);
> +
> +    switch (opc) {
> +    case NM_POOL32AXF_2_0_7:
> +        switch (extract32(ctx->opcode, 9, 3)) {
> +        case NM_DPA_W_PH:
> +        case NM_DPAQ_S_W_PH:
> +        case NM_DPS_W_PH:
> +        case NM_DPSQ_S_W_PH:
> +            gen_pool32axf_2_multiply(ctx, opc, ret, v1, v2);

This structure, in which you have loaded gpr values, then discard them only to
load them up again in a different helper function, could use some improvement.

> +        case NM_BALIGN:
> +            gen_load_gpr(t0, v1);
> +            v2 &= 3;
> +            if (v2 != 0 && v2 != 2) {
> +                tcg_gen_shli_tl(cpu_gpr[ret], cpu_gpr[ret], 8 * v2);

More unprotected uses of cpu_gpr[0].


r~
