Received: from eggs.gnu.org ([2001:4830:134:3::10]:44183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4DoL-00034X-Hp
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4DoG-00030S-Je
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:24:37 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:45037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4DoG-0002zi-CV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:24:32 -0400
Received: by mail-pf0-x231.google.com with SMTP id x7so16854473pfa.1
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 15:24:32 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60365412-0554-1a29-3331-a0de913a5443@linaro.org>
Date: Mon, 16 Oct 2017 15:24:27 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 17/30] target/arm/translate-a64.c: add
 FP16 FMULX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10648,7 +10648,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>          }
>          /* fall through */
>      case 0x9: /* FMUL, FMULX */
> -        if (!extract32(size, 1, 1)) {
> +        if (!extract32(size, 1, 1) && !arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
>              unallocated_encoding(s);
>              return;
>          }

This isn't quite right --

  00 = fp16
  10 = fp32
  11 = fp64

You still need to diagnose 01.

> @@ -10805,10 +10817,23 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>                  gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
>                  break;
>              case 0x9: /* FMUL, FMULX */
> -                if (u) {
> -                    gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
> -                } else {
> -                    gen_helper_vfp_muls(tcg_res, tcg_op, tcg_idx, fpst);
> +                switch (size) {
> +                case 1:

MO_* here, since you converted to them above.


r~
