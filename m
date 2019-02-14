Received: from eggs.gnu.org ([209.51.188.92]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1guIhI-0002W1-66
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1guITF-0000DD-0M
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:58:41 -0500
MIME-Version: 1.0
References: <20190214034345.24722-1-richard.henderson@linaro.org>
	<20190214034345.24722-2-richard.henderson@linaro.org>
	<CABoDooPZMc8OD7h59B_9Q+Jv+B7cXbJFEqmZPawZJ7b1_Bdp5A@mail.gmail.com>
	<d6cfe7e8-0d5a-00f7-c2ff-5db201d19df7@linaro.org>
In-Reply-To: <d6cfe7e8-0d5a-00f7-c2ff-5db201d19df7@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 14 Feb 2019 15:58:10 +0100
Message-ID: <CABoDooP_7fWrWy27JWM9qzgYSKbyG0B7JapTHHqCuJx2MJ9qcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] target/arm: Add helpers for FMLAL and
 FMLSL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Feb 14, 2019 at 3:56 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/14/19 1:16 AM, Laurent Desnogues wrote:
> > Hello,
> >
> > On Thu, Feb 14, 2019 at 5:00 AM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Note that float16_to_float32 rightly squashes SNaN to QNaN.
> >> But of course pickNaNMulAdd, for ARM, selects SNaNs first.
> >> So we have to preserve SNaN long enough for the correct NaN
> >> to be selected.  Thus float16_to_float32_by_bits.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/helper.h     |   9 +++
> >>  target/arm/vec_helper.c | 154 ++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 163 insertions(+)
> >>
> >> diff --git a/target/arm/helper.h b/target/arm/helper.h
> >> index 53a38188c6..0302e13604 100644
> >> --- a/target/arm/helper.h
> >> +++ b/target/arm/helper.h
> >> @@ -653,6 +653,15 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
> >>  DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
> >>                     void, ptr, ptr, ptr, ptr, ptr, i32)
> >>
> >> +DEF_HELPER_FLAGS_5(gvec_fmlal_h, TCG_CALL_NO_RWG,
> >> +                   void, ptr, ptr, ptr, ptr, i32)
> >> +DEF_HELPER_FLAGS_5(gvec_fmlsl_h, TCG_CALL_NO_RWG,
> >> +                   void, ptr, ptr, ptr, ptr, i32)
> >> +DEF_HELPER_FLAGS_5(gvec_fmlal_idx_h, TCG_CALL_NO_RWG,
> >> +                   void, ptr, ptr, ptr, ptr, i32)
> >> +DEF_HELPER_FLAGS_5(gvec_fmlsl_idx_h, TCG_CALL_NO_RWG,
> >> +                   void, ptr, ptr, ptr, ptr, i32)
> >> +
> >>  #ifdef TARGET_AARCH64
> >>  #include "helper-a64.h"
> >>  #include "helper-sve.h"
> >> diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
> >> index 37f338732e..0c3b3de961 100644
> >> --- a/target/arm/vec_helper.c
> >> +++ b/target/arm/vec_helper.c
> >> @@ -766,3 +766,157 @@ DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4)
> >>  DO_FMLA_IDX(gvec_fmla_idx_d, float64, )
> >>
> >>  #undef DO_FMLA_IDX
> >> +
> >> +/*
> >> + * Convert float16 to float32, raising no exceptions and
> >> + * preserving exceptional values, including SNaN.
> >> + * This is effectively an unpack+repack operation.
> >> + */
> >> +static float32 float16_to_float32_by_bits(uint32_t f16)
> >> +{
> >> +    const int f16_bias = 15;
> >> +    const int f32_bias = 127;
> >> +    uint32_t sign = extract32(f16, 15, 1);
> >> +    uint32_t exp = extract32(f16, 10, 5);
> >> +    uint32_t frac = extract32(f16, 0, 10);
> >> +
> >> +    if (exp == 0x1f) {
> >> +        /* Inf or NaN */
> >> +        exp = 0xff;
> >> +    } else if (exp == 0) {
> >> +        /* Zero or denormal.  */
> >> +        if (frac != 0) {
> >> +            /*
> >> +             * Denormal; these are all normal float32.
> >> +             * Shift the fraction so that the msb is at bit 11,
> >> +             * then remove bit 11 as the implicit bit of the
> >> +             * normalized float32.  Note that we still go through
> >> +             * the shift for normal numbers below, to put the
> >> +             * float32 fraction at the right place.
> >> +             */
> >> +            int shift = clz32(frac) - 21;
> >> +            frac = (frac << shift) & 0x3ff;
> >> +            exp = f32_bias - f16_bias - shift + 1;
> >
> > If FZ16 is set, this should flush to zero.
>
> Ho, hum, yes it should.
>
> > This means you will have to use both fp_status (for the muladd) and
> > fp_status_f16 (for this function) and so you should pass cpu_env to
> > the helpers rather than the fp_status.
>
> It's not quite as simple as that, because aa32 mode would pass
> standard_fp_status.  I'll figure something out...

Ha yes, I only looked at AArch64... as usual :-(

Thanks,

Laurent

>
> r~
