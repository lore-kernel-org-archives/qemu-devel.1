Received: from eggs.gnu.org ([2001:4830:134:3::10]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekeF-0007aJ-6u
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eekeA-0001IU-Up
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:45:11 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:47003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eekeA-0001ID-OU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:45:06 -0500
Received: by mail-ot0-x241.google.com with SMTP id t35so7233994otd.13
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:45:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117161435.28981-13-richard.henderson@linaro.org>
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 16:44:45 +0000
Message-ID: <CAFEAcA9Nqc_bz=QY7F0RuCMvBX1m=JCDWjyoF37SOS0A+8CFLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10.5 12/20] target/arm: Use vector
 infrastructure for aa64 add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 January 2018 at 16:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 207 +++++++++++++++++++++++++++++----------=
------
>  1 file changed, 134 insertions(+), 73 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 70c1e08a36..b97bc9b83c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -21,6 +21,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "tcg-op.h"
> +#include "tcg-op-gvec.h"
>  #include "qemu/log.h"
>  #include "arm_ldst.h"
>  #include "translate.h"
> @@ -83,6 +84,10 @@ typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
>  typedef void CryptoTwoOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32);
>  typedef void CryptoThreeOpEnvFn(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
>
> +/* Note that the gvec expanders operate on offsets + sizes.  */
> +typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
> +                        uint32_t, uint32_t, uint32_t);
> +
>  /* initialize TCG globals.  */
>  void a64_translate_init(void)
>  {
> @@ -535,6 +540,21 @@ static inline int vec_reg_offset(DisasContext *s, in=
t regno,
>      return offs;
>  }
>
> +/* Return the offset info CPUARMState of the "whole" vector register Qn.=
  */
> +static inline int vec_full_reg_offset(DisasContext *s, int regno)
> +{
> +    assert_fp_access_checked(s);
> +    return offsetof(CPUARMState, vfp.regs[regno * 2]);
> +}

This function is already in the preparatory SVE code in target-arm.next,
so it should go away on rebase...

> +
> +/* Return the byte size of the "whole" vector register, VL / 8.  */
> +static inline int vec_full_reg_size(DisasContext *s)
> +{
> +    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->fla=
gs.
> +       In the meantime this is just the AdvSIMD length of 128.  */
> +    return 128 / 8;
> +}

...and this is fixed in your other patchset with the leftovers from
that preparatory set, right? What's the plan for what sequence we
put these into master?

Have you done risu-testing on this patchset?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
