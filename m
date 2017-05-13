Received: from eggs.gnu.org ([2001:4830:134:3::10]:56847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KbZ-00040T-6i
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KbY-0007Ge-8C
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:08:17 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KbY-0007GK-4N
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:08:16 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so9884107qka.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 17:08:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-7-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <16f76ae2-4cc2-ac89-065c-5158539ca2e6@twiddle.net>
Date: Fri, 12 May 2017 17:08:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170512233843.27713-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 6/6] target/sparc: optimize various
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 05/12/2017 04:38 PM, Philippe Mathieu-Daudé wrote:
> Patch created mechanically using Coccinelle script via:
> 
>      $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>          --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   target/sparc/translate.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index aa6734d54e..67a83b77cc 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -380,29 +380,25 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num,
>   static inline void gen_mov_reg_N(TCGv reg, TCGv_i32 src)
>   {
>       tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_NEG_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_NEG_SHIFT, 1);
>   }
>   
>   static inline void gen_mov_reg_Z(TCGv reg, TCGv_i32 src)
>   {
>       tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_ZERO_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_ZERO_SHIFT, 1);
>   }
>   
>   static inline void gen_mov_reg_V(TCGv reg, TCGv_i32 src)
>   {
>       tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_OVF_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_OVF_SHIFT, 1);
>   }
>   
>   static inline void gen_mov_reg_C(TCGv reg, TCGv_i32 src)
>   {
>       tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_CARRY_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_CARRY_SHIFT, 1);
>   }
>   

These ones get a

Reviewed-by: Richard Henderson <rth@twiddle.net>

>   static inline void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
> @@ -638,8 +634,7 @@ static inline void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
>       // env->y = (b2 << 31) | (env->y >> 1);
>       tcg_gen_andi_tl(r_temp, cpu_cc_src, 0x1);
>       tcg_gen_shli_tl(r_temp, r_temp, 31);
> -    tcg_gen_shri_tl(t0, cpu_y, 1);
> -    tcg_gen_andi_tl(t0, t0, 0x7fffffff);
> +    tcg_gen_extract_tl(t0, cpu_y, 1, 31);
>       tcg_gen_or_tl(t0, t0, r_temp);
>       tcg_gen_andi_tl(cpu_y, t0, 0xffffffff);

But this should use

   tcg_gen_extract_tl(cpu_y, cpu_y, 1, 31);
   tcg_gen_deposit_tl(cpu_y, cpu_y, cpu_cc_src, 31, 1);


r~
