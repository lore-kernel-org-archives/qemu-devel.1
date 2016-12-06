Received: from eggs.gnu.org ([2001:4830:134:3::10]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEExj-0007vv-Eo
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEExf-0002b0-53
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:35:11 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEExe-0002ZT-Qs
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:35:07 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so123822947wmt.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 04:35:06 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-6-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-6-git-send-email-rth@twiddle.net>
Date: Tue, 06 Dec 2016 12:34:04 +0000
Message-ID: <87mvg9z16r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 05/64] tcg/arm: Move isa detection to
 tcg-target.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>

A slightly expanded commit message to mention why you are moving it
wouldn't go amiss. Otherwise:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tcg/arm/tcg-target.h     | 36 ++++++++++++++++++++++++++++++++----
>  tcg/arm/tcg-target.inc.c | 41 +----------------------------------------
>  2 files changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 8e724be..d1fe12b 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -26,6 +26,37 @@
>  #ifndef ARM_TCG_TARGET_H
>  #define ARM_TCG_TARGET_H
>
> +/* The __ARM_ARCH define is provided by gcc 4.8.  Construct it otherwise.  */
> +#ifndef __ARM_ARCH
> +# if defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7A__) \
> +     || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) \
> +     || defined(__ARM_ARCH_7EM__)
> +#  define __ARM_ARCH 7
> +# elif defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) \
> +       || defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6ZK__) \
> +       || defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6T2__)
> +#  define __ARM_ARCH 6
> +# elif defined(__ARM_ARCH_5__) || defined(__ARM_ARCH_5E__) \
> +       || defined(__ARM_ARCH_5T__) || defined(__ARM_ARCH_5TE__) \
> +       || defined(__ARM_ARCH_5TEJ__)
> +#  define __ARM_ARCH 5
> +# else
> +#  define __ARM_ARCH 4
> +# endif
> +#endif
> +
> +extern int arm_arch;
> +
> +#if defined(__ARM_ARCH_5T__) \
> +    || defined(__ARM_ARCH_5TE__) || defined(__ARM_ARCH_5TEJ__)
> +# define use_armv5t_instructions 1
> +#else
> +# define use_armv5t_instructions use_armv6_instructions
> +#endif
> +
> +#define use_armv6_instructions  (__ARM_ARCH >= 6 || arm_arch >= 6)
> +#define use_armv7_instructions  (__ARM_ARCH >= 7 || arm_arch >= 7)
> +
>  #undef TCG_TARGET_STACK_GROWSUP
>  #define TCG_TARGET_INSN_UNIT_SIZE 4
>  #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
> @@ -79,7 +110,7 @@ extern bool use_idiv_instructions;
>  #define TCG_TARGET_HAS_eqv_i32          0
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
> -#define TCG_TARGET_HAS_deposit_i32      1
> +#define TCG_TARGET_HAS_deposit_i32      use_armv7_instructions
>  #define TCG_TARGET_HAS_extract_i32      0
>  #define TCG_TARGET_HAS_sextract_i32     0
>  #define TCG_TARGET_HAS_movcond_i32      1
> @@ -90,9 +121,6 @@ extern bool use_idiv_instructions;
>  #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
>  #define TCG_TARGET_HAS_rem_i32          0
>
> -extern bool tcg_target_deposit_valid(int ofs, int len);
> -#define TCG_TARGET_deposit_i32_valid  tcg_target_deposit_valid
> -
>  enum {
>      TCG_AREG0 = TCG_REG_R6,
>  };
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index ffa0d40..1415c27 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -25,36 +25,7 @@
>  #include "elf.h"
>  #include "tcg-be-ldst.h"
>
> -/* The __ARM_ARCH define is provided by gcc 4.8.  Construct it otherwise.  */
> -#ifndef __ARM_ARCH
> -# if defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7A__) \
> -     || defined(__ARM_ARCH_7R__) || defined(__ARM_ARCH_7M__) \
> -     || defined(__ARM_ARCH_7EM__)
> -#  define __ARM_ARCH 7
> -# elif defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) \
> -       || defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6ZK__) \
> -       || defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6T2__)
> -#  define __ARM_ARCH 6
> -# elif defined(__ARM_ARCH_5__) || defined(__ARM_ARCH_5E__) \
> -       || defined(__ARM_ARCH_5T__) || defined(__ARM_ARCH_5TE__) \
> -       || defined(__ARM_ARCH_5TEJ__)
> -#  define __ARM_ARCH 5
> -# else
> -#  define __ARM_ARCH 4
> -# endif
> -#endif
> -
> -static int arm_arch = __ARM_ARCH;
> -
> -#if defined(__ARM_ARCH_5T__) \
> -    || defined(__ARM_ARCH_5TE__) || defined(__ARM_ARCH_5TEJ__)
> -# define use_armv5t_instructions 1
> -#else
> -# define use_armv5t_instructions use_armv6_instructions
> -#endif
> -
> -#define use_armv6_instructions  (__ARM_ARCH >= 6 || arm_arch >= 6)
> -#define use_armv7_instructions  (__ARM_ARCH >= 7 || arm_arch >= 7)
> +int arm_arch = __ARM_ARCH;
>
>  #ifndef use_idiv_instructions
>  bool use_idiv_instructions;
> @@ -730,16 +701,6 @@ static inline void tcg_out_bswap32(TCGContext *s, int cond, int rd, int rn)
>      }
>  }
>
> -bool tcg_target_deposit_valid(int ofs, int len)
> -{
> -    /* ??? Without bfi, we could improve over generic code by combining
> -       the right-shift from a non-zero ofs with the orr.  We do run into
> -       problems when rd == rs, and the mask generated from ofs+len doesn't
> -       fit into an immediate.  We would have to be careful not to pessimize
> -       wrt the optimizations performed on the expanded code.  */
> -    return use_armv7_instructions;
> -}
> -
>  static inline void tcg_out_deposit(TCGContext *s, int cond, TCGReg rd,
>                                     TCGArg a1, int ofs, int len, bool const_a1)
>  {


--
Alex Bennée
