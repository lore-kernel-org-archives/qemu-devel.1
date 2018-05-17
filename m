Received: from eggs.gnu.org ([2001:4830:134:3::10]:59861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJtf-0006Wf-Jm
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJtb-0006De-7t
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:28:47 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:41556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJJtb-0006DU-2j
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:28:43 -0400
Received: by mail-qk0-x22b.google.com with SMTP id d125-v6so3737155qkb.8
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 07:28:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-36-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26aa4bed-4e5e-1dde-eb7c-cc003a39f501@amsat.org>
Date: Thu, 17 May 2018 11:28:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-36-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 35/38] target-microblaze: Convert
 env_btarget to i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Convert env_btarget to i64.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/cpu.h       |  2 +-
>  target/microblaze/op_helper.c |  2 +-
>  target/microblaze/translate.c | 36 +++++++++++++++++++++++-------------
>  3 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index e62c456ccf..e38580cd7f 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -239,7 +239,7 @@ typedef struct CPUMBState CPUMBState;
>  struct CPUMBState {
>      uint32_t debug;
>      uint32_t btaken;
> -    uint32_t btarget;
> +    uint64_t btarget;
>      uint32_t bimm;
>  
>      uint32_t imm;
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index ddc1f71d62..7cdbbcccae 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -99,7 +99,7 @@ void helper_debug(CPUMBState *env)
>               "debug[%x] imm=%x iflags=%x\n",
>               env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
>               env->debug, env->imm, env->iflags);
> -    qemu_log("btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
> +    qemu_log("btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) eip=%d ie=%d\n",
>               env->btaken, env->btarget,
>               (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
>               (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index a35683c8c9..a846797d9c 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -57,7 +57,7 @@ static TCGv_i32 cpu_R[32];
>  static TCGv_i64 cpu_SR[14];
>  static TCGv_i32 env_imm;
>  static TCGv_i32 env_btaken;
> -static TCGv_i32 env_btarget;
> +static TCGv_i64 env_btarget;
>  static TCGv_i32 env_iflags;
>  static TCGv env_res_addr;
>  static TCGv_i32 env_res_val;
> @@ -831,7 +831,7 @@ static inline void sync_jmpstate(DisasContext *dc)
>              tcg_gen_movi_i32(env_btaken, 1);
>          }
>          dc->jmp = JMP_INDIRECT;
> -        tcg_gen_movi_i32(env_btarget, dc->jmp_pc);
> +        tcg_gen_movi_i64(env_btarget, dc->jmp_pc);
>      }
>  }
>  
> @@ -1169,13 +1169,13 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
>      }
>  }
>  
> -static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i64 pc_false)
> +static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
>  {
>      TCGLabel *l1 = gen_new_label();
>      /* Conditional jmp.  */
>      tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
>      tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
> -    tcg_gen_extu_i32_i64(cpu_SR[SR_PC], pc_true);
> +    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_true);
>      gen_set_label(l1);
>  }
>  
> @@ -1199,13 +1199,14 @@ static void dec_bcc(DisasContext *dc)
>      if (dec_alu_op_b_is_small_imm(dc)) {
>          int32_t offset = (int32_t)((int16_t)dc->imm); /* sign-extend.  */
>  
> -        tcg_gen_movi_i32(env_btarget, dc->pc + offset);
> +        tcg_gen_movi_i64(env_btarget, dc->pc + offset);
>          dc->jmp = JMP_DIRECT_CC;
>          dc->jmp_pc = dc->pc + offset;
>      } else {
>          dc->jmp = JMP_INDIRECT;
> -        tcg_gen_movi_i32(env_btarget, dc->pc);
> -        tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
> +        tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
> +        tcg_gen_addi_i64(env_btarget, env_btarget, dc->pc);
> +        tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
>      }
>      eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
>  }
> @@ -1262,7 +1263,7 @@ static void dec_br(DisasContext *dc)
>      dc->jmp = JMP_INDIRECT;
>      if (abs) {
>          tcg_gen_movi_i32(env_btaken, 1);
> -        tcg_gen_mov_i32(env_btarget, *(dec_alu_op_b(dc)));
> +        tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
>          if (link && !dslot) {
>              if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
>                  t_gen_raise_exception(dc, EXCP_BREAK);
> @@ -1280,8 +1281,9 @@ static void dec_br(DisasContext *dc)
>              dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
>          } else {
>              tcg_gen_movi_i32(env_btaken, 1);
> -            tcg_gen_movi_i32(env_btarget, dc->pc);
> -            tcg_gen_add_i32(env_btarget, env_btarget, *(dec_alu_op_b(dc)));
> +            tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
> +            tcg_gen_addi_i64(env_btarget, env_btarget, dc->pc);
> +            tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
>          }
>      }
>  }
> @@ -1345,6 +1347,7 @@ static inline void do_rte(DisasContext *dc)
>  static void dec_rts(DisasContext *dc)
>  {
>      unsigned int b_bit, i_bit, e_bit;
> +    TCGv_i64 tmp64;
>  
>      i_bit = dc->ir & (1 << 21);
>      b_bit = dc->ir & (1 << 22);
> @@ -1373,7 +1376,13 @@ static void dec_rts(DisasContext *dc)
>  
>      dc->jmp = JMP_INDIRECT;
>      tcg_gen_movi_i32(env_btaken, 1);
> -    tcg_gen_add_i32(env_btarget, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
> +
> +    tmp64 = tcg_temp_new_i64();
> +    tcg_gen_extu_i32_i64(env_btarget, *(dec_alu_op_b(dc)));
> +    tcg_gen_extu_i32_i64(tmp64, cpu_R[dc->ra]);
> +    tcg_gen_add_i64(env_btarget, env_btarget, tmp64);
> +    tcg_gen_andi_i64(env_btarget, env_btarget, UINT32_MAX);
> +    tcg_temp_free_i64(tmp64);
>  }
>  
>  static int dec_check_fpuv2(DisasContext *dc)
> @@ -1795,7 +1804,8 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>                     "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
>               env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
>               env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
> -    cpu_fprintf(f, "btaken=%d btarget=%x mode=%s(saved=%s) eip=%d ie=%d\n",
> +    cpu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
> +                   "eip=%d ie=%d\n",
>               env->btaken, env->btarget,
>               (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
>               (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
> @@ -1823,7 +1833,7 @@ void mb_tcg_init(void)
>      env_imm = tcg_global_mem_new_i32(cpu_env,
>                      offsetof(CPUMBState, imm),
>                      "imm");
> -    env_btarget = tcg_global_mem_new_i32(cpu_env,
> +    env_btarget = tcg_global_mem_new_i64(cpu_env,
>                       offsetof(CPUMBState, btarget),
>                       "btarget");
>      env_btaken = tcg_global_mem_new_i32(cpu_env,
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
