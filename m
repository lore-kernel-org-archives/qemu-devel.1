Received: from eggs.gnu.org ([2001:4830:134:3::10]:47587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5XI2-0006j3-1T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5XHx-0006U0-A7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:52:26 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5XHx-0006Rh-5b
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:52:21 -0400
Received: by mail-qk0-x241.google.com with SMTP id u68so5751279qkd.2
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:52:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170501221046.9369-1-aurelien@aurel32.net>
	<20170501221046.9369-14-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e043e03e-3799-ab7a-121a-b6c7d1a27e15@amsat.org>
Date: Tue, 2 May 2017 09:52:14 -0300
MIME-Version: 1.0
In-Reply-To: <20170501221046.9369-14-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/14] target/sh4: movua.l is an SH4-A only
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/01/2017 07:10 PM, Aurelien Jarno wrote:
> At the same time change the comment describing the instruction the same
> way than other instruction, so that the code is easier to read and search.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/translate.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index a158b0e480..bc70166602 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1502,17 +1502,21 @@ static void _decode_opc(DisasContext * ctx)
>          }
>          ctx->has_movcal = 1;
>  	return;
> -    case 0x40a9:
> -	/* MOVUA.L @Rm,R0 (Rm) -> R0
> -	   Load non-boundary-aligned data */
> -        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
> -	return;
> -    case 0x40e9:
> -	/* MOVUA.L @Rm+,R0   (Rm) -> R0, Rm + 4 -> Rm
> -	   Load non-boundary-aligned data */
> -        tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
> -	tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
> -	return;
> +    case 0x40a9:                /* movua.l @Rm,R0 */
> +        /* Load non-boundary-aligned data */
> +        if (ctx->features & SH_FEATURE_SH4A) {
> +            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
> +            return;
> +        }
> +        break;
> +    case 0x40e9:                /* movua.l @Rm+,R0 */
> +        /* Load non-boundary-aligned data */
> +        if (ctx->features & SH_FEATURE_SH4A) {
> +            tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
> +            tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
> +            return;
> +        }
> +        break;
>      case 0x0029:		/* movt Rn */
>          tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
>  	return;
>
