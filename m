Received: from eggs.gnu.org ([2001:4830:134:3::10]:35045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCvw-0008E3-8k
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCvt-00056H-35
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:40:24 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:40151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWCvs-000561-RG
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:40:20 -0400
Received: by mail-pg0-x244.google.com with SMTP id w8-v6so2336029pgp.7
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 20:40:20 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-7-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3be3759f-a83f-3f05-97c0-cf356c8c8088@linaro.org>
Date: Thu, 21 Jun 2018 20:40:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-7-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/35] target/mips: Add nanoMIPS pool16c
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
> Add nanoMIPS pool16c instructions
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> ---
>  target/mips/translate.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

This is a good example of using a subroutine that should be used elsewhere.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f5b7e14..c1a98da 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16232,6 +16232,27 @@ static int mmreg4z_nanomips(int r)
>      return map[r & 0xf];
>  }
>  
> +static void gen_pool16c_nanomips_insn(DisasContext *ctx)
> +{
> +    int rt = mmreg_nanomips(uMIPS_RD(ctx->opcode));
> +    int rs = mmreg_nanomips(uMIPS_RS(ctx->opcode));
> +
> +    switch ((ctx->opcode >> 2) & 0x3) {
> +    case NM_NOT16:
> +        gen_logic(ctx, OPC_NOR, rt, rs, 0);
> +        break;
> +    case NM_AND16:
> +        gen_logic(ctx, OPC_AND, rt, rt, rs);
> +        break;
> +    case NM_XOR16:
> +        gen_logic(ctx, OPC_XOR, rt, rt, rs);
> +        break;
> +    case NM_OR16:
> +        gen_logic(ctx, OPC_OR, rt, rt, rs);
> +        break;
> +    }
> +}
> +
>  static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
>  {
>      uint32_t op;
> @@ -16302,6 +16323,7 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
>      case NM_P16C:
>          switch (ctx->opcode & 1) {
>          case NM_POOL16C_0:
> +            gen_pool16c_nanomips_insn(ctx);
>              break;
>          case NM_LWXS16:
>              gen_ldxs(ctx, rt, rs, rd);
> 
