Received: from eggs.gnu.org ([2001:4830:134:3::10]:41652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4Fru-0008Pz-L9
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4Frp-0000rK-9T
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:36:26 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:52841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4Frp-0000qo-3o
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:36:21 -0400
Received: by mail-pg0-x231.google.com with SMTP id a192so50217pge.9
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 17:36:20 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c2bca19-b11d-141f-4c9c-c02c673d3950@linaro.org>
Date: Mon, 16 Oct 2017 17:36:17 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 21/30] target/arm/translate-a64: add
 FP16 2-reg misc compare (zero)
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
> @@ -7792,7 +7793,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
>              swap = true;
>              /* fall through */
>          case 0x2c: /* FCMGT (zero) */
> -            genfn = gen_helper_neon_cgt_f32;
> +            genfn = hp ? gen_helper_advsimd_cgt_f16 : gen_helper_neon_cgt_f32;
>              break;
>          case 0x2d: /* FCMEQ (zero) */
>              genfn = gen_helper_neon_ceq_f32;
> @@ -7814,7 +7815,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
>          }
>  
>          for (pass = 0; pass < maxpasses; pass++) {
> -            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
> +            read_vec_element_i32(s, tcg_op, rn, pass, hp ? MO_16 : MO_32);
>              if (swap) {
>                  genfn(tcg_res, tcg_zero, tcg_op, fpst);
>              } else {

I don't see a change to maxpasses here.


>          case 0x2: /* FADD */
>              gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
>              break;
> +        case 0x6: /* FMAX */
> +            gen_helper_advsimd_maxh(tcg_res, tcg_op1, tcg_op2, fpst);
> +            break;
>          case 0x23: /* FMUL */
>              gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
>              break;

Belongs in another patch?


r~
