Received: from eggs.gnu.org ([2001:4830:134:3::10]:49491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KJW-0000iI-Ez
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KJU-0003Ub-5v
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:49:38 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KJU-0003UD-2L
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:49:36 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so9836507qka.1
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:49:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-6-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f42cdca7-2b73-3235-143c-bb1a1a08310e@amsat.org>
Date: Fri, 12 May 2017 20:49:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170512033543.6789-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/sparc: optimize various
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

This patch is incorrect, please see v4.

On 05/12/2017 12:35 AM, Philippe Mathieu-Daudé wrote:
> Patch created mechanically using Coccinelle script via:
>
>     $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>         --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/sparc/translate.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index aa6734d54e..a92b5c425c 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -380,29 +380,25 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num,
>  static inline void gen_mov_reg_N(TCGv reg, TCGv_i32 src)
>  {
>      tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_NEG_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_NEG_SHIFT, 0x1);
>  }
>
>  static inline void gen_mov_reg_Z(TCGv reg, TCGv_i32 src)
>  {
>      tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_ZERO_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_ZERO_SHIFT, 0x1);
>  }
>
>  static inline void gen_mov_reg_V(TCGv reg, TCGv_i32 src)
>  {
>      tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_OVF_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_OVF_SHIFT, 0x1);
>  }
>
>  static inline void gen_mov_reg_C(TCGv reg, TCGv_i32 src)
>  {
>      tcg_gen_extu_i32_tl(reg, src);
> -    tcg_gen_shri_tl(reg, reg, PSR_CARRY_SHIFT);
> -    tcg_gen_andi_tl(reg, reg, 0x1);
> +    tcg_gen_extract_tl(reg, reg, PSR_CARRY_SHIFT, 0x1);
>  }
>
>  static inline void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
> @@ -638,8 +634,7 @@ static inline void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
>      // env->y = (b2 << 31) | (env->y >> 1);
>      tcg_gen_andi_tl(r_temp, cpu_cc_src, 0x1);
>      tcg_gen_shli_tl(r_temp, r_temp, 31);
> -    tcg_gen_shri_tl(t0, cpu_y, 1);
> -    tcg_gen_andi_tl(t0, t0, 0x7fffffff);
> +    tcg_gen_extract_tl(t0, cpu_y, 1, 0x7fffffff);

WRONG

>      tcg_gen_or_tl(t0, t0, r_temp);
>      tcg_gen_andi_tl(cpu_y, t0, 0xffffffff);
>
>
