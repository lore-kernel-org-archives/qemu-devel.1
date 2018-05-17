Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJFxq-0000eU-89
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJFxl-0003Kb-8w
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:16:50 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJFxl-0003KN-3U
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:16:45 -0400
Received: by mail-ot0-x22d.google.com with SMTP id 77-v6so4425653otd.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 03:16:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516155243.16937-10-richard.henderson@linaro.org>
References: <20180516155243.16937-1-richard.henderson@linaro.org>
	<20180516155243.16937-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 11:16:23 +0100
Message-ID: <CAFEAcA-LJunrL8xeViCYujefSLxxx0kQXKM4zYHyw5xLka2vdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 09/28] target/arm: convert conversion
 helpers to fpst/ahp_flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 16 May 2018 at 16:52, Richard Henderson <richard.henderson@linaro.org> wrote:
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 731cf327a1..613598d090 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c

Just noticed, but in the 32-bit translator where the argument to
get_fpstatus_ptr() is "is this neon?" (ie "do we use the standard
FPSCR value"), shouldn't we be passing 'true' to get_fpstatus_ptr()
for the halfprec conversions in disas_neon_data_insn() ?

I haven't tested, but I imagine that otherwise you get the wrong
results if the input is a denormal and FPSCR.FZ is 0 or if the
output should be a NaN and FPSCR.DN is 0.

> @@ -7222,53 +7247,70 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>                      }
>                      break;
>                  case NEON_2RM_VCVT_F16_F32:
> +                {
> +                    TCGv_ptr fpst;
> +                    TCGv_i32 ahp;
> +
>                      if (!arm_dc_feature(s, ARM_FEATURE_VFP_FP16) ||
>                          q || (rm & 1)) {
>                          return 1;
>                      }
>                      tmp = tcg_temp_new_i32();
>                      tmp2 = tcg_temp_new_i32();
> +                    fpst = get_fpstatus_ptr(false);
> +                    ahp = get_ahp_flag();
>                      tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 0));
> -                    gen_helper_neon_fcvt_f32_to_f16(tmp, cpu_F0s, cpu_env);
> +                    gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
>                      tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 1));
> -                    gen_helper_neon_fcvt_f32_to_f16(tmp2, cpu_F0s, cpu_env);
> +                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
>                      tcg_gen_shli_i32(tmp2, tmp2, 16);
>                      tcg_gen_or_i32(tmp2, tmp2, tmp);
>                      tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 2));
> -                    gen_helper_neon_fcvt_f32_to_f16(tmp, cpu_F0s, cpu_env);
> +                    gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
>                      tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 3));
>                      neon_store_reg(rd, 0, tmp2);
>                      tmp2 = tcg_temp_new_i32();
> -                    gen_helper_neon_fcvt_f32_to_f16(tmp2, cpu_F0s, cpu_env);
> +                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
>                      tcg_gen_shli_i32(tmp2, tmp2, 16);
>                      tcg_gen_or_i32(tmp2, tmp2, tmp);
>                      neon_store_reg(rd, 1, tmp2);
>                      tcg_temp_free_i32(tmp);
> +                    tcg_temp_free_i32(ahp);
> +                    tcg_temp_free_ptr(fpst);
>                      break;
> +                }
>                  case NEON_2RM_VCVT_F32_F16:
> +                {
> +                    TCGv_ptr fpst;
> +                    TCGv_i32 ahp;
>                      if (!arm_dc_feature(s, ARM_FEATURE_VFP_FP16) ||
>                          q || (rd & 1)) {
>                          return 1;
>                      }
> +                    fpst = get_fpstatus_ptr(false);
> +                    ahp = get_ahp_flag();
>                      tmp3 = tcg_temp_new_i32();
>                      tmp = neon_load_reg(rm, 0);
>                      tmp2 = neon_load_reg(rm, 1);
>                      tcg_gen_ext16u_i32(tmp3, tmp);
> -                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
> +                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
>                      tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 0));
>                      tcg_gen_shri_i32(tmp3, tmp, 16);
> -                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
> +                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
>                      tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 1));
>                      tcg_temp_free_i32(tmp);
>                      tcg_gen_ext16u_i32(tmp3, tmp2);
> -                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
> +                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
>                      tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 2));
>                      tcg_gen_shri_i32(tmp3, tmp2, 16);
> -                    gen_helper_neon_fcvt_f16_to_f32(cpu_F0s, tmp3, cpu_env);
> +                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
>                      tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 3));
>                      tcg_temp_free_i32(tmp2);
>                      tcg_temp_free_i32(tmp3);
> +                    tcg_temp_free_i32(ahp);
> +                    tcg_temp_free_ptr(fpst);
>                      break;
> +                }
>                  case NEON_2RM_AESE: case NEON_2RM_AESMC:
>                      if (!arm_dc_feature(s, ARM_FEATURE_V8_AES)
>                          || ((rm | rd) & 1)) {
> --
> 2.17.0
>

thanks
-- PMM
