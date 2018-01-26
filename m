Received: from eggs.gnu.org ([2001:4830:134:3::10]:42869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef5f9-00023p-68
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef5f8-0004xk-7j
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:11:31 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bdbbbd8-d504-e565-30a0-4ce79c8121ac@amsat.org>
Date: Fri, 26 Jan 2018 10:41:13 -0300
MIME-Version: 1.0
In-Reply-To: <20171218172425.18200-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 06/11] target/arm: Decode
 aa32 armv8.1 two reg and a scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org

On 12/18/2017 02:24 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index a9587ae242..1a0b0eaced 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6973,11 +6973,43 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>                          }
>                          neon_store_reg64(cpu_V0, rd + pass);
>                      }
> +                    break;
> +                case 14: /* VQRDMLAH scalar */
> +                case 15: /* VQRDMLSH scalar */
> +                    if (!arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
> +                        return 1;
> +                    }
> +                    if (u && ((rd | rn) & 1)) {
> +                        return 1;
> +                    }
> +                    tmp2 = neon_get_scalar(size, rm);
> +                    for (pass = 0; pass < (u ? 4 : 2); pass++) {
> +                        void (*fn)(TCGv_i32, TCGv_env, TCGv_i32,
> +                                   TCGv_i32, TCGv_i32);
>  
> -
> +                        tmp = neon_load_reg(rn, pass);
> +                        tmp3 = neon_load_reg(rd, pass);
> +                        if (op == 14) {
> +                            if (size == 1) {
> +                                fn = gen_helper_neon_qrdmlah_s16;
> +                            } else {
> +                                fn = gen_helper_neon_qrdmlah_s32;
> +                            }
> +                        } else {
> +                            if (size == 1) {
> +                                fn = gen_helper_neon_qrdmlsh_s16;
> +                            } else {
> +                                fn = gen_helper_neon_qrdmlsh_s32;
> +                            }
> +                        }
> +                        fn(tmp, cpu_env, tmp, tmp2, tmp3);
> +                        tcg_temp_free_i32(tmp3);
> +                        neon_store_reg(rd, pass, tmp);
> +                    }
> +                    tcg_temp_free_i32(tmp2);
>                      break;
> -                default: /* 14 and 15 are RESERVED */
> -                    return 1;
> +                default:
> +                    g_assert_not_reached();
>                  }
>              }
>          } else { /* size == 3 */
> 
