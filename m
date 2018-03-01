Received: from eggs.gnu.org ([2001:4830:134:3::10]:54748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOs3-00019C-Tz
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erOs2-0002pq-Pa
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:07:43 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erOs2-0002pZ-Jm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:07:42 -0500
Received: by mail-oi0-x242.google.com with SMTP id x10so4535704oig.2
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 06:07:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-16-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 14:07:21 +0000
Message-ID: <CAFEAcA_K6caDuE0FBGZKsENHJ--DZoe_w-38CJ+RXE=574MrHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/16] target/arm: Decode t32 simd 3reg
 and 2reg_scalar extension
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

On 28 February 2018 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Happily, the bits are in the same places compared to a32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 3ad8b4031c..ba6ab7d287 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10774,7 +10774,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                                 default_exception_el(s));
>              break;
>          }
> -        if (((insn >> 24) & 3) == 3) {
> +        if ((insn & 0xfe000a00) == 0xfc000800
> +            && arm_dc_feature(s, ARM_FEATURE_V8)) {
> +            /* The Thumb2 and ARM encodings are identical.  */
> +            if (disas_neon_insn_3same_ext(s, insn)) {
> +                goto illegal_op;
> +            }
> +        } else if ((insn & 0xff000a00) == 0xfe000800
> +                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
> +            /* The Thumb2 and ARM encodings are identical.  */
> +            if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
> +                goto illegal_op;
> +            }
> +        } else if (((insn >> 24) & 3) == 3) {
>              /* Translate into the equivalent ARM encoding.  */
>              insn = (insn & 0xe2ffffff) | ((insn & (1 << 28)) >> 4) | (1 << 28);
>              if (disas_neon_data_insn(s, insn)) {
> --
> 2.14.3

Oh, here they are. If you mention "Thumb decode will be added in
a subsequent commit" in a commit message it helps to avoid confusing
reviewers...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
