Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8i4-0000ro-9T
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb8i3-000591-DL
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:38:12 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb8i3-00058B-8B
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:38:11 -0500
Received: by mail-ot0-x242.google.com with SMTP id 53so11294318otj.2
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 09:38:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-6-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 17:37:50 +0000
Message-ID: <CAFEAcA8tbTBk9Wjx3OJoXPgZsOdrOE8tQO4nK4NhLrRm4ny6Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 05/11] target/arm: Decode aa32 armv8.1
 three same
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

On 18 December 2017 at 17:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 85 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index c690658493..a9587ae242 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -25,6 +25,7 @@
>  #include "disas/disas.h"
>  #include "exec/exec-all.h"
>  #include "tcg-op.h"
> +#include "tcg-op-gvec.h"
>  #include "qemu/log.h"
>  #include "qemu/bitops.h"
>  #include "arm_ldst.h"
> @@ -5364,9 +5365,9 @@ static void gen_neon_narrow_op(int op, int u, int size,
>  #define NEON_3R_VPMAX 20
>  #define NEON_3R_VPMIN 21
>  #define NEON_3R_VQDMULH_VQRDMULH 22
> -#define NEON_3R_VPADD 23
> +#define NEON_3R_VPADD_VQRDMLAH 23
>  #define NEON_3R_SHA 24 /* SHA1C,SHA1P,SHA1M,SHA1SU0,SHA256H{2},SHA256SU1 */
> -#define NEON_3R_VFM 25 /* VFMA, VFMS : float fused multiply-add */
> +#define NEON_3R_VFM_VQRDMLSH 25 /* VFMA, VFMS : float fused multiply-add */

If this case includes VQRDLMSH as well now, then the comment needs updating.
I would suggest just /* VFMA, VFMS, VQRDMLSH */

>  #define NEON_3R_FLOAT_ARITH 26 /* float VADD, VSUB, VPADD, VABD */
>  #define NEON_3R_FLOAT_MULTIPLY 27 /* float VMLA, VMLS, VMUL */
>  #define NEON_3R_FLOAT_CMP 28 /* float VCEQ, VCGE, VCGT */

> @@ -5630,12 +5647,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>          if (q && ((rd | rn | rm) & 1)) {
>              return 1;
>          }
> -        /*
> -         * The SHA-1/SHA-256 3-register instructions require special treatment
> -         * here, as their size field is overloaded as an op type selector, and
> -         * they all consume their input in a single pass.
> -         */
> -        if (op == NEON_3R_SHA) {
> +        switch (op) {
> +        case NEON_3R_SHA:
> +            /* The SHA-1/SHA-256 3-register instructions require special
> +             * treatment here, as their size field is overloaded as an
> +             * op type selector, and they all consume their input in a
> +             * single pass.  */

You've lost the newline before the '*/' here.

>              if (!q) {
>                  return 1;
>              }
> @@ -5672,6 +5689,40 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>              tcg_temp_free_i32(tmp2);
>              tcg_temp_free_i32(tmp3);
>              return 0;
> +
> +        case NEON_3R_VPADD_VQRDMLAH:
> +            if (!u) {
> +                break;  /* VPADD */
> +            }
> +            /* VQRDMLAH */
> +            switch (size) {
> +            case 1:
> +                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s16,
> +                                     q, rd, rn, rm);
> +            case 2:
> +                return do_v81_helper(s, gen_helper_gvec_qrdmlah_s32,
> +                                     q, rd, rn, rm);
> +            }
> +            return 1;
> +
> +        case NEON_3R_VFM_VQRDMLSH:
> +            if (!u) {
> +                /* VFM, VFMS */
> +                if ((5 & (1 << size)) == 0) {

You could write this 'if (size == 1)' (since the neon_e3r_sizes[]
check has already ruled out bit 3 being set)...

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
