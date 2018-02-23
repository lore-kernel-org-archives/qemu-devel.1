Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBRh-0000VU-LK
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epBRg-0007rq-B5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:23:21 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epBRg-0007qo-1y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 06:23:20 -0500
Received: by mail-pl0-x241.google.com with SMTP id s13so4727882plq.6
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 03:23:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-9-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 11:22:58 +0000
Message-ID: <CAFEAcA-d6J8DLXiPqDPuMNt-MkjeG8Mu-LdTtFw7ma6TyrNaUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 08/67] target/arm: Implement
 SVE Predicate Misc Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |   3 +
>  target/arm/helper-sve.h    |   3 +
>  target/arm/sve_helper.c    |  86 +++++++++++++++++++++++-
>  target/arm/translate-sve.c | 163 ++++++++++++++++++++++++++++++++++++++++++++-
>  target/arm/sve.decode      |  41 ++++++++++++
>  5 files changed, 293 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8befe43a01..27f395183b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2915,4 +2915,7 @@ static inline uint64_t *aa64_vfp_qreg(CPUARMState *env, unsigned regno)
>      return &env->vfp.zregs[regno].d[0];
>  }
>
> +/* Shared between translate-sve.c and sve_helper.c.  */
> +extern const uint64_t pred_esz_masks[4];
> +
>  #endif
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 57adc4d912..0c04afff8c 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -20,6 +20,9 @@
>  DEF_HELPER_FLAGS_2(sve_predtest1, TCG_CALL_NO_WG, i32, i64, i64)
>  DEF_HELPER_FLAGS_3(sve_predtest, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
>
> +DEF_HELPER_FLAGS_3(sve_pfirst, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(sve_pnext, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index b63e7cc90e..cee7d9bcf6 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -39,7 +39,7 @@
>
>  static uint32_t iter_predtest_fwd(uint64_t d, uint64_t g, uint32_t flags)
>  {
> -    if (g) {
> +    if (likely(g)) {
>          /* Compute N from first D & G.
>             Use bit 2 to signal first G bit seen.  */
>          if (!(flags & 4)) {

Belongs in different patch ?

> @@ -114,3 +114,87 @@ LOGICAL_PPPP(sve_nand_pppp, DO_NAND)
>  #undef DO_NAND
>  #undef DO_SEL
>  #undef LOGICAL_PPPP
> +
> +/* Similar to the ARM LastActiveElement pseudocode function, except the
> +   result is multiplied by the element size.  This includes the not found
> +   indication; e.g. not found for esz=3 is -8.  */

Can we stick to the usual format for multiline comments, please?
(various examples here and elsewhere in the patchset). I know that
over the whole codebase we're a bit variable, but I think this is
the most common arrangement and it's definitely the one we use
in target/arm with perhaps the odd ancient comment as an exception.

/* line 1
 * line 2
 */


> +static void trans_PTRUE(DisasContext *s, arg_PTRUE *a, uint32_t insn)
> +{
> +    unsigned fullsz = vec_full_reg_size(s);
> +    unsigned ofs = pred_full_reg_offset(s, a->rd);
> +    unsigned numelem, setsz, i;
> +    uint64_t word, lastword;
> +    TCGv_i64 t;

A comment somewhere here about the way this code handles
the instructions that aren't PTRUE would be helpful I think
(specifically that a->pat is 32 for PFALSE and a->rd is
16 for SETFFR).

> +
> +    numelem = decode_pred_count(fullsz, a->pat, a->esz);
> +
> +    /* Determine what we must store into each bit, and how many.  */
> +    if (numelem == 0) {
> +        lastword = word = 0;
> +        setsz = fullsz;
> +    } else {
> +        setsz = numelem << a->esz;
> +        lastword = word = pred_esz_masks[a->esz];
> +        if (setsz % 64) {
> +            lastword &= ~(-1ull << (setsz % 64));
> +        }
> +    }
> +

>  ###########################################################################
>  # Named instruction formats.  These are generally used to
>  # reduce the amount of duplication between instruction patterns.
>
> +# Two operand with unused vector element size
> +@pd_pn_e0      ........ ........ ....... rn:4 . rd:4           &rr_esz esz=0
> +
> +# Two operand
> +@pd_pn         ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
> +
>  # Three operand with unused vector element size
>  @rd_rn_rm_e0   ........ ... rm:5 ... ... rn:5 rd:5             &rrr_esz esz=0
>
> @@ -77,6 +87,37 @@ NAND_pppp    00100101 1. 00 .... 01 .... 1 .... 1 ....       @pd_pg_pn_pm_s
>  # SVE predicate test
>  PTEST          00100101 01010000 11 pg:4 0 rn:4 00000
>
> +# SVE predicate initialize
> +PTRUE          00100101 esz:2 01100 s:1 111000 pat:5 0 rd:4    &ptrue
> +
> +# SVE initialize FFR (SETFFR)
> +PTRUE          00100101 0010 1100 1001 0000 0000 0000 \
> +               &ptrue rd=16 esz=0 pat=31 s=0

I found this very confusing at first, because the leftmost column
looks like it's the instruction name, and thus a copy-and-paste
error. I think it would be easier to read if we gave it a name
that indicates that it's dealing with a group of instructions
rather than only PTRUE.

> +
> +# SVE zero predicate register (PFALSE)
> +# Note that pat=32 is outside of the natural 0..31, and will
> +# always hit the default #uimm5 case of decode_pred_count.
> +PTRUE          00100101 0001 1000 1110 0100 0000 rd:4 \
> +               &ptrue esz=0 pat=32 s=0
> +
> +# SVE predicate read from FFR (predicated) (RDFFR)
> +ORR_pppp       00100101 0 s:1 0110001111000 pg:4 0 rd:4 \
> +               &rprr_s rn=16 rm=16
> +
> +# SVE predicate read from FFR (unpredicated) (RDFFR)
> +ORR_pppp       00100101 0001 1001 1111 0000 0000 rd:4 \
> +               &rprr_s rn=16 rm=16 pg=16 s=0
> +
> +# SVE FFR write from predicate (WRFFR)
> +ORR_pppp       00100101 0010 1000 1001 000 rn:4 00000 \
> +               &rprr_s rd=16 rm=%preg4_5 pg=%preg4_5 s=0

> +
> +# SVE predicate first active
> +PFIRST         00100101 01 011 000 11000 00 .... 0 ....        @pd_pn_e0
> +
> +# SVE predicate next active
> +PNEXT          00100101 .. 011 001 11000 10 .... 0 ....        @pd_pn
> +
>  ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
>
>  # SVE load predicate register
> --
> 2.14.3

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
