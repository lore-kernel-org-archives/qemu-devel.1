Received: from eggs.gnu.org ([2001:4830:134:3::10]:44876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN713-0001hG-Kd
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN710-0003GI-G2
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:32:05 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN710-0003Fy-Bm
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:32:02 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so13224665qtn.3
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 18:32:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff7e23a2-ab8a-27fc-5267-8ec1fef0b58c@amsat.org>
Date: Sun, 27 May 2018 22:31:57 -0300
MIME-Version: 1.0
In-Reply-To: <20180527141324.11937-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/20] target/openrisc: Form the spr index
 from tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

On 05/27/2018 11:13 AM, Richard Henderson wrote:
> Rather than pass base+offset to the helper, pass the full index.
> In most cases the base is r0 and optimization yields a constant.

and while here you use generic TCGv instead of 32bit version.

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/helper.h     |  4 ++--
>  target/openrisc/sys_helper.c |  9 +++------
>  target/openrisc/translate.c  | 16 +++++++++-------
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
> index e37dabc77a..9db9bf3963 100644
> --- a/target/openrisc/helper.h
> +++ b/target/openrisc/helper.h
> @@ -56,5 +56,5 @@ FOP_CMP(le)
>  DEF_HELPER_FLAGS_1(rfe, 0, void, env)
>  
>  /* sys */
> -DEF_HELPER_FLAGS_4(mtspr, 0, void, env, tl, tl, tl)
> -DEF_HELPER_FLAGS_4(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl, tl)
> +DEF_HELPER_FLAGS_3(mtspr, 0, void, env, tl, tl)
> +DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl)
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index b284064381..a8d287d6ef 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -27,13 +27,11 @@
>  
>  #define TO_SPR(group, number) (((group) << 11) + (number))
>  
> -void HELPER(mtspr)(CPUOpenRISCState *env,
> -                   target_ulong ra, target_ulong rb, target_ulong offset)
> +void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>  {
>  #ifndef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
> -    int spr = (ra | offset);
>      int idx;
>  
>      switch (spr) {
> @@ -201,13 +199,12 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
>  #endif
>  }
>  
> -target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
> -                           target_ulong rd, target_ulong ra, uint32_t offset)
> +target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
> +                           target_ulong spr)
>  {
>  #ifndef CONFIG_USER_ONLY
>      OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
>      CPUState *cs = CPU(cpu);
> -    int spr = (ra | offset);
>      int idx;
>  
>      switch (spr) {
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index c7bfb395b0..b26c473870 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -926,9 +926,10 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
>      if (is_user(dc)) {
>          gen_illegal_exception(dc);
>      } else {
> -        TCGv_i32 ti = tcg_const_i32(a->k);
> -        gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], cpu_R[a->a], ti);
> -        tcg_temp_free_i32(ti);
> +        TCGv spr = tcg_temp_new();
> +        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
> +        gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], spr);
> +        tcg_temp_free(spr);
>      }
>      return true;
>  }
> @@ -940,7 +941,7 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
>      if (is_user(dc)) {
>          gen_illegal_exception(dc);
>      } else {
> -        TCGv_i32 ti;
> +        TCGv spr;
>  
>          /* For SR, we will need to exit the TB to recognize the new
>           * exception state.  For NPC, in theory this counts as a branch
> @@ -953,9 +954,10 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
>          tcg_gen_movi_tl(cpu_ppc, dc->base.pc_next);
>          tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
>  
> -        ti = tcg_const_i32(a->k);
> -        gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
> -        tcg_temp_free_i32(ti);
> +        spr = tcg_temp_new();
> +        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
> +        gen_helper_mtspr(cpu_env, spr, cpu_R[a->b]);
> +        tcg_temp_free(spr);
>  
>          /* For PPC, we want the value that was just written and not
>             the generic update that we'd get from DISAS_EXIT.  */
> 
