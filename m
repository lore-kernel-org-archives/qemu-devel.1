Received: from eggs.gnu.org ([2001:4830:134:3::10]:51783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BRD-0006XD-VN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BR8-0001zp-OA
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:35 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g0BR8-0001zR-FC
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:08:30 -0400
Received: by mail-pg1-x541.google.com with SMTP id i190-v6so1597185pgc.6
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 13:08:29 -0700 (PDT)
References: <20180830193019.20104-1-jancraig@amazon.com>
	<20180830193019.20104-5-jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88450751-a770-acda-9e25-4b9407970699@linaro.org>
Date: Wed, 12 Sep 2018 13:08:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180830193019.20104-5-jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/9] target/mips: Add MXU instructions
 S32I2M and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/30/2018 12:30 PM, Craig Janeczek via Qemu-devel wrote:
> +/* S32I2M XRa, rb - Register move from GRF to XRF */
> +static void gen_mxu_s32i2m(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0;
> +    uint32_t xra, rb;
> +
> +    t0 = tcg_temp_new();
> +
> +    xra = extract32(ctx->opcode, 6, 5);
> +    rb = extract32(ctx->opcode, 16, 5);
> +
> +    gen_load_gpr(t0, rb);
> +    if (xra <= 15) {
> +        gen_store_mxu_gpr(t0, xra);
> +    } else if (xra == 16) {
> +        gen_store_mxu_cr(t0);
> +    }

else...?  Illegal instruction / reserved operand fault?
Surely it is not treated as a nop (although stranger things happen).

> +static void gen_mxu_s32m2i(DisasContext *ctx, uint32_t opc)
> +{
> +    TCGv t0;
> +    uint32_t xra, rb;
> +
> +    t0 = tcg_temp_new();
> +
> +    xra = extract32(ctx->opcode, 6, 5);
> +    rb = extract32(ctx->opcode, 16, 5);
> +
> +    if (xra <= 15) {
> +        gen_load_mxu_gpr(t0, xra);
> +    } else if (xra == 16) {
> +        gen_load_mxu_cr(t0);
> +    }
> +
> +    gen_store_gpr(t0, rb);

Likewise.  Although this one will crash qemu, because t0 will be used by
gen_store_gpr without being initialized.

> @@ -17909,6 +17991,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
>          check_insn(ctx, INSN_LOONGSON2F);
>          gen_loongson_integer(ctx, op1, rd, rs, rt);
>          break;
> +
>      case OPC_CLO:

Avoid random whitespace changes.


r~
