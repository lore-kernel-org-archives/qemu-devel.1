Received: from eggs.gnu.org ([2001:4830:134:3::10]:57612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB9Hc-0002dt-16
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB9HX-0003ql-43
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:31:44 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB9HW-0003ps-V8
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 21:31:39 -0400
Received: by mail-qk0-x243.google.com with SMTP id b131so17063961qkg.2
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 18:31:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a361df8b-953e-bb2f-75d8-8729f3e27eb7@amsat.org>
Date: Tue, 24 Apr 2018 22:31:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180425012300.14698-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Implement FMOV (general)
 for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Hi Richard,

On 04/24/2018 10:22 PM, Richard Henderson wrote:
> Adding the fp16 moves to/from general registers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index f2241d8174..36bb5f6f08 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -5375,6 +5375,15 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
>              tcg_gen_st_i64(tcg_rn, cpu_env, fp_reg_hi_offset(s, rd));
>              clear_vec_high(s, true, rd);
>              break;
> +        case 3:
> +            /* 16 bit */
> +            tmp = tcg_temp_new_i64();
> +            tcg_gen_ext16u_i64(tmp, tcg_rn);
> +            write_fp_dreg(s, rd, tmp);
> +            tcg_temp_free_i64(tmp);
> +            break;
> +        default:
> +            g_assert_not_reached();
>          }
>      } else {
>          TCGv_i64 tcg_rd = cpu_reg(s, rd);
> @@ -5392,6 +5401,12 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
>              /* 64 bits from top half */
>              tcg_gen_ld_i64(tcg_rd, cpu_env, fp_reg_hi_offset(s, rn));
>              break;
> +        case 3:
> +            /* 16 bit */
> +            tcg_gen_ld16u_i64(tcg_rd, cpu_env, fp_reg_offset(s, rn, MO_16));
> +            break;
> +        default:
> +            g_assert_not_reached();
>          }
>      }
>  }
> @@ -5431,10 +5446,15 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
>          case 0xa: /* 64 bit */
>          case 0xd: /* 64 bit to top half of quad */
>              break;
> +        case 0x6: /* 16-bit */
> +            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                break;
> +            }
> +            /* fallthru */
>          default:
>              /* all other sf/type/rmode combinations are invalid */
>              unallocated_encoding(s);
> -            break;
> +            return;

Agreed with this change, however shouldn't this be in a separate patch?

>          }
>  
>          if (!fp_access_check(s)) {
> 
