Received: from eggs.gnu.org ([2001:4830:134:3::10]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftc2F-0006GT-FV
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ftc2A-0006gy-Cl
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:07:39 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ftc2A-0006fv-6j
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:07:34 -0400
Received: by mail-io0-x243.google.com with SMTP id c22-v6so9601828iob.1
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 10:07:34 -0700 (PDT)
References: <cover.1535133088.git.jancraig@amazon.com>
	<f1e92127959ffb3df713a06452328a71170bda93.1535133089.git.jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <231c38e4-8ad4-0f73-69ab-7a66d20716d3@linaro.org>
Date: Sat, 25 Aug 2018 10:07:29 -0700
MIME-Version: 1.0
In-Reply-To: <f1e92127959ffb3df713a06452328a71170bda93.1535133089.git.jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/mips: Add MXU instructions
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

On 08/24/2018 12:44 PM, Craig Janeczek via Qemu-devel wrote:
> Adds support for emulating the S32I2M and S32M2I MXU instructions.
> 
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  target/mips/translate.c | 55 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 50f0cb558f..381dfad36e 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -364,6 +364,9 @@ enum {
>      OPC_CLO      = 0x21 | OPC_SPECIAL2,
>      OPC_DCLZ     = 0x24 | OPC_SPECIAL2,
>      OPC_DCLO     = 0x25 | OPC_SPECIAL2,
> +    /* MXU */
> +    OPC_MXU_S32I2M = 0x2F | OPC_SPECIAL2,
> +    OPC_MXU_S32M2I = 0x2E | OPC_SPECIAL2,

I haven't been able to find any documentation of the bit
layout of these instructions.  Any pointers?

> +typedef union {
> +    struct {
> +        uint32_t op:6;
> +        uint32_t xra:5;
> +        uint32_t:5;
> +        uint32_t rb:5;
> +        uint32_t:5;
> +        uint32_t special2:6;
> +    } S32I2M;
> +
> +    struct {
> +        uint32_t op:6;
> +        uint32_t xra:5;
> +        uint32_t:5;
> +        uint32_t rb:5;
> +        uint32_t:5;
> +        uint32_t special2:6;
> +    } S32M2I;
> +} MXU_OPCODE;

Do not use bitfields.  The layout differs by host compiler.
Use extract32(input, pos, len).


> +
> +/* MXU Instructions */
> +static void gen_mxu(DisasContext *ctx, uint32_t opc)
> +{
> +#ifndef TARGET_MIPS64 /* Only works in 32 bit mode */
> +    TCGv t0;
> +    t0 = tcg_temp_new();
> +    MXU_OPCODE *opcode = (MXU_OPCODE *)&ctx->opcode;
> +
> +    switch (opc) {
> +    case OPC_MXU_S32I2M:
> +        gen_load_gpr(t0, opcode->S32I2M.rb);
> +        gen_store_mxu_gpr(t0, opcode->S32I2M.xra);
> +        break;
> +
> +    case OPC_MXU_S32M2I:
> +        gen_load_mxu_gpr(t0, opcode->S32M2I.xra);
> +        gen_store_gpr(t0, opcode->S32M2I.rb);
> +        break;
> +    }
> +
> +    tcg_temp_free(t0);
> +#else
> +    generate_exception_end(ctx, EXCP_RI);
> +#endif
> +}

There's nothing here (yet, I suppose) that won't compile for MIPS64.
I'd suggest avoiding ifdefs as much as possible.


r~
