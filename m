Received: from eggs.gnu.org ([2001:4830:134:3::10]:54371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgEHY-00034X-Di
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgEHU-0002XA-54
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:08:08 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgEHT-0002Wj-U3
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:08:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id g2-v6so4592635pgs.6
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:08:03 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-14-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e3660db-6022-5a6a-1c4f-691ed065c4d6@linaro.org>
Date: Thu, 19 Jul 2018 12:08:00 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-14-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/40] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32a0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Add emulation of nanoMIPS instructions that are situated in pool32a0.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 2c7f62e..81c2950 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -16588,6 +16588,186 @@ static void gen_pool16c_nanomips_insn(DisasContext *ctx)
>      }
>  }
>  
> +static void gen_pool32a0_nanomips_insn(DisasContext *ctx)
> +{
> +    int rt = (ctx->opcode >> 21) & 0x1f;
> +    int rs = (ctx->opcode >> 16) & 0x1f;
> +    int rd = (ctx->opcode >> 11) & 0x1f;

extract32.

> +    case NM_SOV:
> +    {
> +        TCGv t0 = tcg_temp_local_new();
> +        TCGv t1 = tcg_temp_new();
> +        TCGv t2 = tcg_temp_new();
> +        TCGLabel *l1 = gen_new_label();
> +
> +        gen_load_gpr(t1, rs);
> +        gen_load_gpr(t2, rt);
> +        tcg_gen_add_tl(t0, t1, t2);
> +        tcg_gen_ext32s_tl(t0, t0);
> +        tcg_gen_xor_tl(t1, t1, t2);
> +        tcg_gen_xor_tl(t2, t0, t2);
> +        tcg_gen_andc_tl(t1, t2, t1);
> +
> +        tcg_gen_movi_tl(t0, 0);
> +        tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);

tcg_gen_setcondi_tl.


r~
