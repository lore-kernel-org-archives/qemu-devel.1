Received: from eggs.gnu.org ([2001:4830:134:3::10]:55338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1eB5rY-0004FW-3K
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 17:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1eB5rU-0004Ai-Io
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 17:20:19 -0400
Date: Sun, 5 Nov 2017 06:20:11 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20171104212011.GK29237@lianli.shorne-pla.net>
References: <20171103202624.5956-1-laurent@vivier.eu>
	<20171103202624.5956-3-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103202624.5956-3-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH 2/4] openrisc: fix float32 and float64
 helper definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org

Hello,

On Fri, Nov 03, 2017 at 09:26:22PM +0100, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

There is no commit body here, do we need one?  I can see in your cover letter
its mentioned this was revealed after enabling "USE_SOFTFLOAT_STRUCT_TYPES".

However, I'm just being curious why is this an issue?  In softfloat I assume we
pack our own floats so having the type that goes into a uint32 register wouldnt
make much difference right?

-Stafford

> ---
>  target/openrisc/fpu_helper.c | 52 ++++++++++++++++++++++----------------------
>  target/openrisc/helper.h     | 20 ++++++++---------
>  2 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
> index 1375cea948..f84f8bf26a 100644
> --- a/target/openrisc/fpu_helper.c
> +++ b/target/openrisc/fpu_helper.c
> @@ -66,9 +66,9 @@ static inline void update_fpcsr(OpenRISCCPU *cpu)
>      }
>  }
>  
> -uint64_t HELPER(itofd)(CPUOpenRISCState *env, uint64_t val)
> +float64 HELPER(itofd)(CPUOpenRISCState *env, uint64_t val)
>  {
> -    uint64_t itofd;
> +    float64 itofd;
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
>  
>      set_float_exception_flags(0, &cpu->env.fp_status);
> @@ -78,9 +78,9 @@ uint64_t HELPER(itofd)(CPUOpenRISCState *env, uint64_t val)
>      return itofd;
>  }
>  
> -uint32_t HELPER(itofs)(CPUOpenRISCState *env, uint32_t val)
> +float32 HELPER(itofs)(CPUOpenRISCState *env, uint32_t val)
>  {
> -    uint32_t itofs;
> +    float32 itofs;
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
>  
>      set_float_exception_flags(0, &cpu->env.fp_status);
> @@ -90,7 +90,7 @@ uint32_t HELPER(itofs)(CPUOpenRISCState *env, uint32_t val)
>      return itofs;
>  }
>  
> -uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
> +uint64_t HELPER(ftoid)(CPUOpenRISCState *env, float32 val)
>  {
>      uint64_t ftoid;
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> @@ -102,7 +102,7 @@ uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
>      return ftoid;
>  }
>  
> -uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
> +uint32_t HELPER(ftois)(CPUOpenRISCState *env, float32 val)
>  {
>      uint32_t ftois;
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> @@ -117,10 +117,10 @@ uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
>  #define FLOAT_OP(name, p) void helper_float_##_##p(void)
>  
>  #define FLOAT_CALC(name)                                                  \
> -uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
> -                                     uint64_t fdt0, uint64_t fdt1)        \
> +float64 helper_float_ ## name ## _d(CPUOpenRISCState *env,                \
> +                                    float64 fdt0, float64 fdt1)          \
>  {                                                                         \
> -    uint64_t result;                                                      \
> +    float64 result;                                                       \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
>      set_float_exception_flags(0, &cpu->env.fp_status);                    \
>      result = float64_ ## name(fdt0, fdt1, &cpu->env.fp_status);           \
> @@ -128,10 +128,10 @@ uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
>      return result;                                                        \
>  }                                                                         \
>                                                                            \
> -uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
> -                                     uint32_t fdt0, uint32_t fdt1)        \
> +float32 helper_float_ ## name ## _s(CPUOpenRISCState *env,                \
> +                                    float32 fdt0, float32 fdt1)           \
>  {                                                                         \
> -    uint32_t result;                                                      \
> +    float32 result;                                                       \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
>      set_float_exception_flags(0, &cpu->env.fp_status);                    \
>      result = float32_ ## name(fdt0, fdt1, &cpu->env.fp_status);           \
> @@ -147,11 +147,11 @@ FLOAT_CALC(rem)
>  #undef FLOAT_CALC
>  
>  
> -uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
> -                             uint64_t b, uint64_t c)
> +float64 helper_float_madd_d(CPUOpenRISCState *env, float64 a,
> +                             float64 b, float64 c)
>  {
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> -    uint64_t result;
> +    float64 result;
>      set_float_exception_flags(0, &cpu->env.fp_status);
>      /* Note that or1ksim doesn't use merged operation.  */
>      result = float64_mul(b, c, &cpu->env.fp_status);
> @@ -160,11 +160,11 @@ uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
>      return result;
>  }
>  
> -uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
> -                             uint32_t b, uint32_t c)
> +float32 helper_float_madd_s(CPUOpenRISCState *env, float32 a,
> +                             float32 b, float32 c)
>  {
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
> -    uint32_t result;
> +    float32 result;
>      set_float_exception_flags(0, &cpu->env.fp_status);
>      /* Note that or1ksim doesn't use merged operation.  */
>      result = float32_mul(b, c, &cpu->env.fp_status);
> @@ -176,7 +176,7 @@ uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
>  
>  #define FLOAT_CMP(name)                                                   \
>  uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
> -                                     uint64_t fdt0, uint64_t fdt1)        \
> +                                    float64 fdt0, float64 fdt1)           \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -187,7 +187,7 @@ uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
>  }                                                                         \
>                                                                            \
>  uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
> -                                             uint32_t fdt0, uint32_t fdt1)\
> +                                    float32 fdt0, float32 fdt1)           \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -205,7 +205,7 @@ FLOAT_CMP(lt)
>  
>  #define FLOAT_CMPNE(name)                                                 \
>  uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
> -                                     uint64_t fdt0, uint64_t fdt1)        \
> +                                     float64 fdt0, float64 fdt1)          \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -216,7 +216,7 @@ uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
>  }                                                                         \
>                                                                            \
>  uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
> -                                     uint32_t fdt0, uint32_t fdt1)        \
> +                                     float32 fdt0, float32 fdt1)          \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -231,7 +231,7 @@ FLOAT_CMPNE(ne)
>  
>  #define FLOAT_CMPGT(name)                                                 \
>  uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
> -                                     uint64_t fdt0, uint64_t fdt1)        \
> +                                     float64 fdt0, float64 fdt1)          \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -242,7 +242,7 @@ uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
>  }                                                                         \
>                                                                            \
>  uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
> -                                     uint32_t fdt0, uint32_t fdt1)        \
> +                                     float32 fdt0, float32 fdt1)          \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -256,7 +256,7 @@ FLOAT_CMPGT(gt)
>  
>  #define FLOAT_CMPGE(name)                                                 \
>  uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
> -                                     uint64_t fdt0, uint64_t fdt1)        \
> +                                     float64 fdt0, float64 fdt1)          \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> @@ -267,7 +267,7 @@ uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
>  }                                                                         \
>                                                                            \
>  uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
> -                                     uint32_t fdt0, uint32_t fdt1)        \
> +                                     float32 fdt0, float32 fdt1)          \
>  {                                                                         \
>      int res;                                                              \
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
> diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
> index 4fd1a6bb8e..081606527b 100644
> --- a/target/openrisc/helper.h
> +++ b/target/openrisc/helper.h
> @@ -24,17 +24,17 @@ DEF_HELPER_FLAGS_1(ove_ov, TCG_CALL_NO_WG, void, env)
>  DEF_HELPER_FLAGS_1(ove_cyov, TCG_CALL_NO_WG, void, env)
>  
>  /* float */
> -DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_WG, i64, env, i64)
> -DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_WG, i32, env, i32)
> -DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_WG, i64, env, i64)
> -DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_WG, i32, env, i32)
> +DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_WG, f64, env, i64)
> +DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_WG, f32, env, i32)
> +DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_WG, i64, env, f32)
> +DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_WG, i32, env, f32)
>  
> -DEF_HELPER_FLAGS_4(float_madd_s, TCG_CALL_NO_WG, i32, env, i32, i32, i32)
> -DEF_HELPER_FLAGS_4(float_madd_d, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
> +DEF_HELPER_FLAGS_4(float_madd_s, TCG_CALL_NO_WG, f32, env, f32, f32, f32)
> +DEF_HELPER_FLAGS_4(float_madd_d, TCG_CALL_NO_WG, f64, env, f64, f64, f64)
>  
>  #define FOP_CALC(op)                                            \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, f32, env, f32, f32) \
> +DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, f64, env, f64, f64)
>  FOP_CALC(add)
>  FOP_CALC(sub)
>  FOP_CALC(mul)
> @@ -43,8 +43,8 @@ FOP_CALC(rem)
>  #undef FOP_CALC
>  
>  #define FOP_CMP(op)                                              \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
> -DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
> +DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, f32, f32) \
> +DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, f64, f64)
>  FOP_CMP(eq)
>  FOP_CMP(lt)
>  FOP_CMP(le)
> -- 
> 2.13.6
> 
