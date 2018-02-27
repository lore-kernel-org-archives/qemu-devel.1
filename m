Received: from eggs.gnu.org ([2001:4830:134:3::10]:50469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqikl-00039D-2J
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqikh-0003ru-Qq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:22 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:32907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqikh-0003rN-Jd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:19 -0500
Received: by mail-pg0-x244.google.com with SMTP id g12so7755314pgs.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:09:19 -0800 (PST)
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<20180227143852.11175-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19852743-3c93-9d0f-5ef6-8bf351a98ce7@linaro.org>
Date: Tue, 27 Feb 2018 09:09:15 -0800
MIME-Version: 1.0
In-Reply-To: <20180227143852.11175-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 14/31] arm/translate-a64: add FP16
 FMULX/MLS/FMLA to simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/27/2018 06:38 AM, Alex Bennée wrote:
> @@ -11244,7 +11245,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>          }
>          /* fall through */
>      case 0x9: /* FMUL, FMULX */
> -        if (!extract32(size, 1, 1)) {
> +        if (size == 1) {
>              unallocated_encoding(s);
>              return;
>          }

This is still redundant, since size == 1 is handled...

> @@ -11256,18 +11257,34 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
>      }
>  
>      if (is_fp) {
> -        /* low bit of size indicates single/double */
> -        size = extract32(size, 0, 1) ? 3 : 2;
> -        if (size == 2) {
> +        /* convert insn encoded size to TCGMemOp size */
> +        switch (size) {
> +        case 2: /* single precision */
> +            size = MO_32;
>              index = h << 1 | l;
> -        } else {
> +            rm |= (m << 4);
> +            break;
> +        case 3: /* double precision */
> +            size = MO_64;
>              if (l || !is_q) {
>                  unallocated_encoding(s);
>                  return;
>              }
>              index = h;
> +            rm |= (m << 4);
> +            break;
> +        case 0: /* half precision */
> +            size = MO_16;
> +            index = h << 2 | l << 1 | m;
> +            is_fp16 = true;
> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                break;
> +            }
> +            /* fallthru */
> +        default: /* unallocated */
> +            unallocated_encoding(s);
> +            return;
>          }

... here.  But it's not wrong and I can clean this up along with the additional
changes I need to make to this function for fcmla support.  So,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
