Received: from eggs.gnu.org ([2001:4830:134:3::10]:32809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbVr-00077O-1j
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbVp-000424-Uv
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:14:11 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbVp-00041S-Oe
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:14:09 -0400
Date: Sat, 8 Jul 2017 00:14:07 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707221407.t5zmih6wc63lmia5@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-17-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-17-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 16/27] target/sh4: Load/store Dr as
 64-bit quantities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:21, Richard Henderson wrote:
> This enforces proper alignment and makes the register update
> more natural.  Note that there is a more serious bug fix for
> fmov {DX}Rn,@(R0,Rn) to use a store instead of a load.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 74 ++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 616e615..fcdabe8 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1044,18 +1038,20 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0xf00b: /* fmov {F,D,X}Rm,@-Rn - FPSCR: Nothing */
>  	CHECK_FPU_ENABLED
> -        TCGv addr = tcg_temp_new_i32();
> -        tcg_gen_subi_i32(addr, REG(B11_8), 4);
> -        if (ctx->tbflags & FPSCR_SZ) {
> -	    int fr = XHACK(B7_4);
> -            tcg_gen_qemu_st_i32(FREG(fr + 1), addr, ctx->memidx, MO_TEUL);
> -	    tcg_gen_subi_i32(addr, addr, 4);
> -            tcg_gen_qemu_st_i32(FREG(fr), addr, ctx->memidx, MO_TEUL);
> -	} else {
> -            tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
> -	}
> -        tcg_gen_mov_i32(REG(B11_8), addr);
> -        tcg_temp_free(addr);
> +        {
> +            TCGv addr = tcg_temp_new_i32();
> +            if (ctx->tbflags & FPSCR_SZ) {
> +                TCGv_i64 fp = tcg_temp_new_i64();
> +                gen_load_fpr64(ctx, fp, XHACK(B7_4));
> +                tcg_gen_qemu_st_i64(fp, addr, ctx->memidx, MO_TEQ);

addr is used without before being written. The following line is mising
before the load:

    tcg_gen_subi_i32(addr, REG(B11_8), 8);

> +                tcg_temp_free_i64(fp);
> +            } else {
> +                tcg_gen_subi_i32(addr, REG(B11_8), 4);
> +                tcg_gen_qemu_st_i32(FREG(B7_4), addr, ctx->memidx, MO_TEUL);
> +            }
> +            tcg_gen_mov_i32(REG(B11_8), addr);
> +            tcg_temp_free(addr);
> +        }
>  	return;
>      case 0xf006: /* fmov @(R0,Rm),{F,D,X}Rm - FPSCR: Nothing */
>  	CHECK_FPU_ENABLED

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
