Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foMf2-0000gw-PK
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 01:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foMez-0001XE-Jx
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 01:42:00 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e]:41562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foMez-0001X7-Dc
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 01:41:57 -0400
Received: by mail-ua1-x92e.google.com with SMTP id h1-v6so4144731uao.8
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 22:41:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3b05025-b18e-2f39-07b6-011f705d28d6@amsat.org>
Date: Sat, 11 Aug 2018 02:41:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/20] target/arm: Split contiguous stores
 for endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

On 08/09/2018 01:22 AM, Richard Henderson wrote:
> We can choose the endianness at translation time, rather than
> re-computing it at execution time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper-sve.h    | 48 +++++++++++++++++--------
>  target/arm/sve_helper.c    | 11 ++++--
>  target/arm/translate-sve.c | 72 +++++++++++++++++++++++++++++---------
>  3 files changed, 96 insertions(+), 35 deletions(-)
> 
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 526caec8da..1ad043101a 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -1248,29 +1248,47 @@ DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_st4bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
> -DEF_HELPER_FLAGS_4(sve_st1hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st2hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st3hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st4hh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4hh_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
> -DEF_HELPER_FLAGS_4(sve_st1ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st2ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st3ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st4ss_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4hh_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
> -DEF_HELPER_FLAGS_4(sve_st1dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st2dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st3dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st4dd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4ss_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4ss_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +
> +DEF_HELPER_FLAGS_4(sve_st1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st2dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st3dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st4dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
>  DEF_HELPER_FLAGS_4(sve_st1bh_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_st1bs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  DEF_HELPER_FLAGS_4(sve_st1bd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
> -DEF_HELPER_FLAGS_4(sve_st1hs_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> -DEF_HELPER_FLAGS_4(sve_st1hd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hs_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hs_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
> -DEF_HELPER_FLAGS_4(sve_st1sd_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
> +DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
>  
>  DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
>                     void, env, ptr, ptr, ptr, tl, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 56e2f523c5..92c0e961a9 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4940,12 +4940,17 @@ void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)           \
>  }
>  
>  #define DO_STN_2(N, NAME, ESIZE, MSIZE) \
> -void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)             \
> +void __attribute__((flatten)) HELPER(sve_st##N##NAME##_le_r)          \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
>  {                                                                     \
>      sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
> -                  arm_cpu_data_is_big_endian(env)                     \
> -                  ? sve_st1##NAME##_be_tlb : sve_st1##NAME##_le_tlb); \
> +                  sve_st1##NAME##_le_tlb);                            \
> +}                                                                     \
> +void __attribute__((flatten)) HELPER(sve_st##N##NAME##_be_r)          \
> +    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
> +{                                                                     \
> +    sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
> +                  sve_st1##NAME##_be_tlb);                            \
>  }
>  
>  DO_STN_1(1, bb, 1)
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index de12c01e7d..acb85731f8 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -4953,32 +4953,70 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a, uint32_t insn)
>  static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
>                        int msz, int esz, int nreg)
>  {
> -    static gen_helper_gvec_mem * const fn_single[4][4] = {
> -        { gen_helper_sve_st1bb_r, gen_helper_sve_st1bh_r,
> -          gen_helper_sve_st1bs_r, gen_helper_sve_st1bd_r },
> -        { NULL,                   gen_helper_sve_st1hh_r,
> -          gen_helper_sve_st1hs_r, gen_helper_sve_st1hd_r },
> -        { NULL, NULL,
> -          gen_helper_sve_st1ss_r, gen_helper_sve_st1sd_r },
> -        { NULL, NULL, NULL, gen_helper_sve_st1dd_r },
> +    static gen_helper_gvec_mem * const fn_single[2][4][4] = {
> +        { { gen_helper_sve_st1bb_r,
> +            gen_helper_sve_st1bh_r,
> +            gen_helper_sve_st1bs_r,
> +            gen_helper_sve_st1bd_r },
> +          { NULL,
> +            gen_helper_sve_st1hh_le_r,
> +            gen_helper_sve_st1hs_le_r,
> +            gen_helper_sve_st1hd_le_r },
> +          { NULL, NULL,
> +            gen_helper_sve_st1ss_le_r,
> +            gen_helper_sve_st1sd_le_r },
> +          { NULL, NULL, NULL,
> +            gen_helper_sve_st1dd_le_r } },
> +        { { gen_helper_sve_st1bb_r,
> +            gen_helper_sve_st1bh_r,
> +            gen_helper_sve_st1bs_r,
> +            gen_helper_sve_st1bd_r },
> +          { NULL,
> +            gen_helper_sve_st1hh_be_r,
> +            gen_helper_sve_st1hs_be_r,
> +            gen_helper_sve_st1hd_be_r },
> +          { NULL, NULL,
> +            gen_helper_sve_st1ss_be_r,
> +            gen_helper_sve_st1sd_be_r },
> +          { NULL, NULL, NULL,
> +            gen_helper_sve_st1dd_be_r } },
>      };
> -    static gen_helper_gvec_mem * const fn_multiple[3][4] = {
> -        { gen_helper_sve_st2bb_r, gen_helper_sve_st2hh_r,
> -          gen_helper_sve_st2ss_r, gen_helper_sve_st2dd_r },
> -        { gen_helper_sve_st3bb_r, gen_helper_sve_st3hh_r,
> -          gen_helper_sve_st3ss_r, gen_helper_sve_st3dd_r },
> -        { gen_helper_sve_st4bb_r, gen_helper_sve_st4hh_r,
> -          gen_helper_sve_st4ss_r, gen_helper_sve_st4dd_r },
> +    static gen_helper_gvec_mem * const fn_multiple[2][3][4] = {
> +        { { gen_helper_sve_st2bb_r,
> +            gen_helper_sve_st2hh_le_r,
> +            gen_helper_sve_st2ss_le_r,
> +            gen_helper_sve_st2dd_le_r },
> +          { gen_helper_sve_st3bb_r,
> +            gen_helper_sve_st3hh_le_r,
> +            gen_helper_sve_st3ss_le_r,
> +            gen_helper_sve_st3dd_le_r },
> +          { gen_helper_sve_st4bb_r,
> +            gen_helper_sve_st4hh_le_r,
> +            gen_helper_sve_st4ss_le_r,
> +            gen_helper_sve_st4dd_le_r } },
> +        { { gen_helper_sve_st2bb_r,
> +            gen_helper_sve_st2hh_be_r,
> +            gen_helper_sve_st2ss_be_r,
> +            gen_helper_sve_st2dd_be_r },
> +          { gen_helper_sve_st3bb_r,
> +            gen_helper_sve_st3hh_be_r,
> +            gen_helper_sve_st3ss_be_r,
> +            gen_helper_sve_st3dd_be_r },
> +          { gen_helper_sve_st4bb_r,
> +            gen_helper_sve_st4hh_be_r,
> +            gen_helper_sve_st4ss_be_r,
> +            gen_helper_sve_st4dd_be_r } },
>      };
>      gen_helper_gvec_mem *fn;
> +    int be = s->be_data == MO_BE;
>  
>      if (nreg == 0) {
>          /* ST1 */
> -        fn = fn_single[msz][esz];
> +        fn = fn_single[be][msz][esz];
>      } else {
>          /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
>          assert(msz == esz);
> -        fn = fn_multiple[nreg - 1][msz];
> +        fn = fn_multiple[be][nreg - 1][msz];
>      }
>      assert(fn != NULL);
>      do_mem_zpa(s, zt, pg, addr, fn);
> 
