Received: from eggs.gnu.org ([2001:4830:134:3::10]:37640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKGM-0004vk-Mg
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKGI-0000Jt-7a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:52:14 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKGI-0000Jd-2L
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:52:10 -0400
Received: by mail-qk0-x22d.google.com with SMTP id p186-v6so3831187qkd.1
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 07:52:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-16-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d69a9575-a382-d8c1-d223-4fa44d32295e@amsat.org>
Date: Thu, 17 May 2018 11:52:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-16-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/38] target-microblaze: Break out
 trap_userspace()
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
> Break out trap_userspace() to avoid open coding it everywhere.
> For privileged insns, we now always stop translation of the
> current insn for cores without exceptions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/microblaze/translate.c | 76 +++++++++++++++----------------------------
>  1 file changed, 27 insertions(+), 49 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 12cb345f64..8f72cf39fb 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -179,6 +179,22 @@ static void write_carryi(DisasContext *dc, bool carry)
>      tcg_temp_free_i32(t0);
>  }
>  
> +/*
> + * Returns true if the insn is illegal in userspace.
> + * If exceptions are enabled, an exception is raised.
> + */
> +static bool trap_userspace(DisasContext *dc, bool cond)
> +{
> +    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
> +    bool cond_user = cond && mem_index == MMU_USER_IDX;
> +
> +    if (cond_user && (dc->tb_flags & MSR_EE_FLAG)) {
> +        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> +        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    }
> +    return cond_user;
> +}
> +
>  /* True if ALU operand b is a small immediate that may deserve
>     faster treatment.  */
>  static inline int dec_alu_op_b_is_small_imm(DisasContext *dc)
> @@ -432,7 +448,6 @@ static void dec_msr(DisasContext *dc)
>      CPUState *cs = CPU(dc->cpu);
>      TCGv_i32 t0, t1;
>      unsigned int sr, to, rn;
> -    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
>  
>      sr = dc->imm & ((1 << 14) - 1);
>      to = dc->imm & (1 << 14);
> @@ -452,10 +467,7 @@ static void dec_msr(DisasContext *dc)
>              return;
>          }
>  
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -            && mem_index == MMU_USER_IDX && (dc->imm != 4 && dc->imm != 0)) {
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +        if (trap_userspace(dc, dc->imm != 4 && dc->imm != 0)) {
>              return;
>          }
>  
> @@ -480,13 +492,8 @@ static void dec_msr(DisasContext *dc)
>          return;
>      }
>  
> -    if (to) {
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -             && mem_index == MMU_USER_IDX) {
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -            return;
> -        }
> +    if (trap_userspace(dc, to)) {
> +        return;
>      }
>  
>  #if !defined(CONFIG_USER_ONLY)
> @@ -738,7 +745,6 @@ static void dec_bit(DisasContext *dc)
>      CPUState *cs = CPU(dc->cpu);
>      TCGv_i32 t0;
>      unsigned int op;
> -    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
>  
>      op = dc->ir & ((1 << 9) - 1);
>      switch (op) {
> @@ -784,22 +790,12 @@ static void dec_bit(DisasContext *dc)
>          case 0x76:
>              /* wdc.  */
>              LOG_DIS("wdc r%d\n", dc->ra);
> -            if ((dc->tb_flags & MSR_EE_FLAG)
> -                 && mem_index == MMU_USER_IDX) {
> -                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -                t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -                return;
> -            }
> +            trap_userspace(dc, true);
>              break;
>          case 0x68:
>              /* wic.  */
>              LOG_DIS("wic r%d\n", dc->ra);
> -            if ((dc->tb_flags & MSR_EE_FLAG)
> -                 && mem_index == MMU_USER_IDX) {
> -                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -                t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -                return;
> -            }
> +            trap_userspace(dc, true);
>              break;
>          case 0xe0:
>              if ((dc->tb_flags & MSR_EE_FLAG)
> @@ -1199,7 +1195,6 @@ static void dec_bcc(DisasContext *dc)
>  static void dec_br(DisasContext *dc)
>  {
>      unsigned int dslot, link, abs, mbar;
> -    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
>  
>      dslot = dc->ir & (1 << 20);
>      abs = dc->ir & (1 << 19);
> @@ -1254,9 +1249,7 @@ static void dec_br(DisasContext *dc)
>              if (!(dc->tb_flags & IMM_FLAG) && (dc->imm == 8 || dc->imm == 0x18))
>                  t_gen_raise_exception(dc, EXCP_BREAK);
>              if (dc->imm == 0) {
> -                if ((dc->tb_flags & MSR_EE_FLAG) && mem_index == MMU_USER_IDX) {
> -                    tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -                    t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +                if (trap_userspace(dc, true)) {
>                      return;
>                  }
>  
> @@ -1331,12 +1324,15 @@ static inline void do_rte(DisasContext *dc)
>  static void dec_rts(DisasContext *dc)
>  {
>      unsigned int b_bit, i_bit, e_bit;
> -    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
>  
>      i_bit = dc->ir & (1 << 21);
>      b_bit = dc->ir & (1 << 22);
>      e_bit = dc->ir & (1 << 23);
>  
> +    if (trap_userspace(dc, i_bit || b_bit || e_bit)) {
> +        return;
> +    }
> +
>      dc->delayed_branch = 2;
>      dc->tb_flags |= D_FLAG;
>      tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> @@ -1344,27 +1340,12 @@ static void dec_rts(DisasContext *dc)
>  
>      if (i_bit) {
>          LOG_DIS("rtid ir=%x\n", dc->ir);
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -             && mem_index == MMU_USER_IDX) {
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -        }
>          dc->tb_flags |= DRTI_FLAG;
>      } else if (b_bit) {
>          LOG_DIS("rtbd ir=%x\n", dc->ir);
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -             && mem_index == MMU_USER_IDX) {
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -        }
>          dc->tb_flags |= DRTB_FLAG;
>      } else if (e_bit) {
>          LOG_DIS("rted ir=%x\n", dc->ir);
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -             && mem_index == MMU_USER_IDX) {
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -        }
>          dc->tb_flags |= DRTE_FLAG;
>      } else
>          LOG_DIS("rts ir=%x\n", dc->ir);
> @@ -1503,16 +1484,13 @@ static void dec_null(DisasContext *dc)
>  /* Insns connected to FSL or AXI stream attached devices.  */
>  static void dec_stream(DisasContext *dc)
>  {
> -    int mem_index = cpu_mmu_index(&dc->cpu->env, false);
>      TCGv_i32 t_id, t_ctrl;
>      int ctrl;
>  
>      LOG_DIS("%s%s imm=%x\n", dc->rd ? "get" : "put",
>              dc->type_b ? "" : "d", dc->imm);
>  
> -    if ((dc->tb_flags & MSR_EE_FLAG) && (mem_index == MMU_USER_IDX)) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_PRIVINSN);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_userspace(dc, true)) {
>          return;
>      }
>  
> 
