Received: from eggs.gnu.org ([2001:4830:134:3::10]:38913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKL2-0000j0-5c
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKKy-0002Lg-9L
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:57:04 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJKKy-0002KP-4k
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:57:00 -0400
Received: by mail-qt0-x243.google.com with SMTP id q13-v6so6128879qtp.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 07:56:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-17-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c9f52ba-3d53-14c2-db24-0085b8a25022@amsat.org>
Date: Thu, 17 May 2018 11:56:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-17-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/38] target-microblaze: Break out
 trap_illegal()
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
> Break out trap_illegal() to handle illegal operation traps.
> We now generally stop translation of the current insn if
> it's not valid.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 75 ++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 48 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 8f72cf39fb..b0a76fb23b 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -179,6 +179,20 @@ static void write_carryi(DisasContext *dc, bool carry)
>      tcg_temp_free_i32(t0);
>  }
>  
> +/*
> + * Returns true if the insn an illegal operation.
> + * If exceptions are enabled, an exception is raised.
> + */
> +static bool trap_illegal(DisasContext *dc, bool cond)
> +{
> +    if (cond && (dc->tb_flags & MSR_EE_FLAG)
> +        && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
> +        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> +        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    }
> +    return cond;
> +}
> +
>  /*
>   * Returns true if the insn is illegal in userspace.
>   * If exceptions are enabled, an exception is raised.
> @@ -344,11 +358,8 @@ static void dec_pattern(DisasContext *dc)
>  {
>      unsigned int mode;
>  
> -    if ((dc->tb_flags & MSR_EE_FLAG)
> -          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && !dc->cpu->cfg.use_pcmp_instr) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
> +        return;
>      }
>  
>      mode = dc->opcode & 3;
> @@ -602,11 +613,7 @@ static void dec_mul(DisasContext *dc)
>      TCGv_i32 tmp;
>      unsigned int subcode;
>  
> -    if ((dc->tb_flags & MSR_EE_FLAG)
> -         && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -         && !dc->cpu->cfg.use_hw_mul) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, !dc->cpu->cfg.use_hw_mul)) {
>          return;
>      }
>  
> @@ -658,10 +665,8 @@ static void dec_div(DisasContext *dc)
>      u = dc->imm & 2; 
>      LOG_DIS("div\n");
>  
> -    if ((dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && !dc->cpu->cfg.use_div) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, !dc->cpu->cfg.use_div)) {
> +        return;
>      }
>  
>      if (u)
> @@ -680,11 +685,7 @@ static void dec_barrel(DisasContext *dc)
>      unsigned int imm_w, imm_s;
>      bool s, t, e = false, i = false;
>  
> -    if ((dc->tb_flags & MSR_EE_FLAG)
> -          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && !dc->cpu->cfg.use_barrel) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, !dc->cpu->cfg.use_barrel)) {
>          return;
>      }
>  
> @@ -798,11 +799,8 @@ static void dec_bit(DisasContext *dc)
>              trap_userspace(dc, true);
>              break;
>          case 0xe0:
> -            if ((dc->tb_flags & MSR_EE_FLAG)
> -                && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -                && !dc->cpu->cfg.use_pcmp_instr) {
> -                tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -                t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +            if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
> +                return;
>              }
>              if (dc->cpu->cfg.use_pcmp_instr) {
>                  tcg_gen_clzi_i32(cpu_R[dc->rd], cpu_R[dc->ra], 32);
> @@ -921,10 +919,7 @@ static void dec_load(DisasContext *dc)
>          mop ^= MO_BSWAP;
>      }
>  
> -    if (size > 4 && (dc->tb_flags & MSR_EE_FLAG)
> -          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, size > 4)) {
>          return;
>      }
>  
> @@ -1031,10 +1026,7 @@ static void dec_store(DisasContext *dc)
>          mop ^= MO_BSWAP;
>      }
>  
> -    if (size > 4 && (dc->tb_flags & MSR_EE_FLAG)
> -          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, size > 4)) {
>          return;
>      }
>  
> @@ -1368,11 +1360,7 @@ static void dec_fpu(DisasContext *dc)
>  {
>      unsigned int fpu_insn;
>  
> -    if ((dc->tb_flags & MSR_EE_FLAG)
> -          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && !dc->cpu->cfg.use_fpu) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, !dc->cpu->cfg.use_fpu)) {
>          return;
>      }
>  
> @@ -1471,10 +1459,7 @@ static void dec_fpu(DisasContext *dc)
>  
>  static void dec_null(DisasContext *dc)
>  {
> -    if ((dc->tb_flags & MSR_EE_FLAG)
> -          && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)) {
> -        tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -        t_gen_raise_exception(dc, EXCP_HW_EXCP);
> +    if (trap_illegal(dc, true)) {
>          return;
>      }
>      qemu_log_mask(LOG_GUEST_ERROR, "unknown insn pc=%x opc=%x\n", dc->pc, dc->opcode);
> @@ -1552,13 +1537,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
>      if (dc->ir)
>          dc->nr_nops = 0;
>      else {
> -        if ((dc->tb_flags & MSR_EE_FLAG)
> -              && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -              && (dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK)) {
> -            tcg_gen_movi_i32(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
> -            t_gen_raise_exception(dc, EXCP_HW_EXCP);
> -            return;
> -        }
> +        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
>  
>          LOG_DIS("nr_nops=%d\t", dc->nr_nops);
>          dc->nr_nops++;
> 

Nice cleanup too :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
