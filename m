Received: from eggs.gnu.org ([2001:4830:134:3::10]:60293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAmM-0002iA-Cd
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAmL-0000Kd-Cv
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:22:38 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceAmL-0000KV-6w
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:22:37 -0500
Received: by mail-pf0-x243.google.com with SMTP id e4so267232pfg.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:22:37 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-10-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b48e79f7-1837-c4e0-ec16-2be2031343b9@twiddle.net>
Date: Thu, 16 Feb 2017 12:22:25 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-10-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/16] target-m68k: add fmovem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/fpu_helper.c |  6 +++
>  target/m68k/helper.h     |  1 +
>  target/m68k/translate.c  | 99 +++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 80 insertions(+), 26 deletions(-)
>
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 1e68c41..aadfc82 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -421,3 +421,9 @@ void HELPER(update_fpstatus)(CPUM68KState *env)
>
>      set_float_exception_flags(flags, &env->fp_status);
>  }
> +
> +void HELPER(fmovem)(CPUM68KState *env, uint32_t opsize,
> +                    uint32_t mode, uint32_t mask)
> +{
> +    fprintf(stderr, "MISSING HELPER fmovem\n");
> +}

Um... no.


> diff --git a/target/m68k/helper.h b/target/m68k/helper.h
> index 072a6d0..58bc273 100644
> --- a/target/m68k/helper.h
> +++ b/target/m68k/helper.h
> @@ -31,6 +31,7 @@ DEF_HELPER_1(cmp_FP0_FP1, void, env)
>  DEF_HELPER_2(set_fpcr, void, env, i32)
>  DEF_HELPER_1(tst_FP0, void, env)
>  DEF_HELPER_1(update_fpstatus, void, env)
> +DEF_HELPER_4(fmovem, void, env, i32, i32, i32)
>
>  DEF_HELPER_3(mac_move, void, env, i32, i32)
>  DEF_HELPER_3(macmulf, i64, env, i32, i32)
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index f9c64ff..ac60f1a 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -4483,13 +4483,79 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
>      tcg_temp_free_i32(addr);
>  }
>
> +static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
> +                          uint32_t insn, uint32_t ext)
> +{
> +    int opsize;
> +    uint16_t mask;
> +    int i;
> +    uint32_t mode;
> +    int32_t incr;
> +    TCGv addr, tmp;
> +    int is_load;
> +
> +    if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
> +        opsize = OS_EXTENDED;
> +    } else {
> +        opsize = OS_DOUBLE;  /* FIXME */
> +    }
> +
> +    mode = (ext >> 11) & 0x3;
> +    if ((mode & 0x1) == 1) {
> +        gen_helper_fmovem(cpu_env, tcg_const_i32(opsize),
> +                          tcg_const_i32(mode), DREG(ext, 0));

... why not just raise illegal opcode here instead of fprintf.
You should also add a comment about not supporting the dynamic set.

That said... it almost seems easier to support fmovem as a helper than it does 
inline.  So perhaps just always implement it out of line?


r~
