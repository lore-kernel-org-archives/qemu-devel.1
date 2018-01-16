Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPUw-00059V-FH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPUv-0004kZ-F5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:33:46 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebPUv-0004k1-A7
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:33:45 -0500
Received: by mail-ot0-x242.google.com with SMTP id s3so13300306otc.9
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:33:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116034503.31926-2-richard.henderson@linaro.org>
References: <20180116034503.31926-1-richard.henderson@linaro.org>
	<20180116034503.31926-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 11:33:24 +0000
Message-ID: <CAFEAcA-4exmbQqx+f9OYcGwsnDyKNJRnd=d2mPLTfshG6UJNiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 16 January 2018 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The code sequence we were generating was only good for unsigned
> comparisons.  For signed comparisions, use the sequence from gcc.
>
> Fixes booting of ppc64 firmware, with a patch changing the code
> sequence for ppc comparisons.
>
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/arm/tcg-target.inc.c | 97 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 65 insertions(+), 32 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 98a12535a5..0ff283d84f 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -239,10 +239,10 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
>      }
>  }
>
> -#define TCG_CT_CONST_ARM  0x100
> -#define TCG_CT_CONST_INV  0x200
> -#define TCG_CT_CONST_NEG  0x400
> -#define TCG_CT_CONST_ZERO 0x800
> +#define TCG_CT_CONST_ARM     0x0100
> +#define TCG_CT_CONST_INV     0x0200
> +#define TCG_CT_CONST_NEG     0x0400
> +#define TCG_CT_CONST_ZERO    0x1000

You might as well just drop this hunk now you're not adding a new entry.

>  /* parse target specific constraints */
>  static const char *target_parse_constraint(TCGArgConstraint *ct,
> @@ -351,8 +351,7 @@ static inline int check_fit_imm(uint32_t imm)
>  static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
>                                           const TCGArgConstraint *arg_ct)
>  {
> -    int ct;
> -    ct = arg_ct->ct;
> +    int ct = arg_ct->ct;
>      if (ct & TCG_CT_CONST) {
>          return 1;
>      } else if ((ct & TCG_CT_CONST_ARM) && check_fit_imm(val)) {

Ditto.


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
