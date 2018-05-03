Received: from eggs.gnu.org ([2001:4830:134:3::10]:54248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKoR-0000kv-Tf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKoQ-0000Ik-1d
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:26:47 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKoP-0000IP-Hc
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:26:45 -0400
Received: by mail-lf0-x244.google.com with SMTP id m18-v6so27874447lfb.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-14-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-14-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:26:18 +0000
Message-ID: <CAKmqyKPS8FzGP3wmfXbh9tGPHeup_ECCHGpH+FWp=TaFj3Mvpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 13/29] target-microblaze: Use TCGv for
 load/store addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:26 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Use TCGv for load/store addresses, allowing for future
> computation of 64-bit load/store address.

> No functional change.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/cpu.h       |  2 +-
>   target/microblaze/helper.h    |  4 +--
>   target/microblaze/op_helper.c | 11 +++---
>   target/microblaze/translate.c | 78
++++++++++++++++++++++++-------------------
>   4 files changed, 53 insertions(+), 42 deletions(-)

> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 2304c24b7d..1593496997 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -250,7 +250,7 @@ struct CPUMBState {

>       /* lwx/swx reserved address */
>   #define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no
reservation */
> -    uint32_t res_addr;
> +    target_ulong res_addr;
>       uint32_t res_val;

>       /* Internal flags.  */
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index 71a6c0858d..ce70353936 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -29,8 +29,8 @@ DEF_HELPER_2(mmu_read, i32, env, i32)
>   DEF_HELPER_3(mmu_write, void, env, i32, i32)
>   #endif

> -DEF_HELPER_5(memalign, void, env, i32, i32, i32, i32)
> -DEF_HELPER_2(stackprot, void, env, i32)
> +DEF_HELPER_5(memalign, void, env, tl, i32, i32, i32)
> +DEF_HELPER_2(stackprot, void, env, tl)

>   DEF_HELPER_2(get, i32, i32, i32)
>   DEF_HELPER_3(put, void, i32, i32, i32)
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 1b4fe796e7..f5e851e38d 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -439,12 +439,14 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
>       return 0;
>   }

> -void helper_memalign(CPUMBState *env, uint32_t addr, uint32_t dr,
uint32_t wr,
> +void helper_memalign(CPUMBState *env, target_ulong addr,
> +                     uint32_t dr, uint32_t wr,
>                        uint32_t mask)
>   {
>       if (addr & mask) {
>               qemu_log_mask(CPU_LOG_INT,
> -                          "unaligned access addr=%x mask=%x, wr=%d
dr=r%d\n",
> +                          "unaligned access addr=" TARGET_FMT_lx
> +                          " mask=%x, wr=%d dr=r%d\n",
>                             addr, mask, wr, dr);
>               env->sregs[SR_EAR] = addr;
>               env->sregs[SR_ESR] = ESR_EC_UNALIGNED_DATA | (wr << 10) \
> @@ -459,10 +461,11 @@ void helper_memalign(CPUMBState *env, uint32_t
addr, uint32_t dr, uint32_t wr,
>       }
>   }

> -void helper_stackprot(CPUMBState *env, uint32_t addr)
> +void helper_stackprot(CPUMBState *env, target_ulong addr)
>   {
>       if (addr < env->slr || addr > env->shr) {
> -        qemu_log_mask(CPU_LOG_INT, "Stack protector violation at %x %x
%x\n",
> +        qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
> +                      TARGET_FMT_lx " %x %x\n",
>                         addr, env->slr, env->shr);
>           env->sregs[SR_EAR] = addr;
>           env->sregs[SR_ESR] = ESR_EC_STACKPROT;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 5cc53eb035..c971fe3b72 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -59,7 +59,7 @@ static TCGv_i32 env_imm;
>   static TCGv_i32 env_btaken;
>   static TCGv_i32 env_btarget;
>   static TCGv_i32 env_iflags;
> -static TCGv_i32 env_res_addr;
> +static TCGv env_res_addr;
>   static TCGv_i32 env_res_val;

>   #include "exec/gen-icount.h"
> @@ -848,11 +848,12 @@ static void dec_imm(DisasContext *dc)
>       dc->clear_imm = 0;
>   }

> -static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 t)
> +static inline void compute_ldst_addr(DisasContext *dc, TCGv t)
>   {
>       bool extimm = dc->tb_flags & IMM_FLAG;
>       /* Should be set to true if r1 is used by loadstores.  */
>       bool stackprot = false;
> +    TCGv_i32 t32;

>       /* All load/stores use ra.  */
>       if (dc->ra == 1 && dc->cpu->cfg.stackprot) {
> @@ -863,10 +864,10 @@ static inline void compute_ldst_addr(DisasContext
*dc, TCGv_i32 t)
>       if (!dc->type_b) {
>           /* If any of the regs is r0, return the value of the other reg.
  */
>           if (dc->ra == 0) {
> -            tcg_gen_mov_i32(t, cpu_R[dc->rb]);
> +            tcg_gen_extu_i32_tl(t, cpu_R[dc->rb]);
>               return;
>           } else if (dc->rb == 0) {
> -            tcg_gen_mov_i32(t, cpu_R[dc->ra]);
> +            tcg_gen_extu_i32_tl(t, cpu_R[dc->ra]);
>               return;
>           }

> @@ -874,7 +875,10 @@ static inline void compute_ldst_addr(DisasContext
*dc, TCGv_i32 t)
>               stackprot = true;
>           }

> -        tcg_gen_add_i32(t, cpu_R[dc->ra], cpu_R[dc->rb]);
> +        t32 = tcg_temp_new_i32();
> +        tcg_gen_add_i32(t32, cpu_R[dc->ra], cpu_R[dc->rb]);
> +        tcg_gen_extu_i32_tl(t, t32);
> +        tcg_temp_free_i32(t32);

>           if (stackprot) {
>               gen_helper_stackprot(cpu_env, t);
> @@ -882,16 +886,19 @@ static inline void compute_ldst_addr(DisasContext
*dc, TCGv_i32 t)
>           return;
>       }
>       /* Immediate.  */
> +    t32 = tcg_temp_new_i32();
>       if (!extimm) {
>           if (dc->imm == 0) {
> -            tcg_gen_mov_i32(t, cpu_R[dc->ra]);
> -            return;
> +            tcg_gen_mov_i32(t32, cpu_R[dc->ra]);
> +        } else {
> +            tcg_gen_movi_i32(t32, (int32_t)((int16_t)dc->imm));
> +            tcg_gen_add_i32(t32, cpu_R[dc->ra], t32);
>           }
> -        tcg_gen_movi_i32(t, (int32_t)((int16_t)dc->imm));
> -        tcg_gen_add_i32(t, cpu_R[dc->ra], t);
>       } else {
> -        tcg_gen_add_i32(t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
> +        tcg_gen_add_i32(t32, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
>       }
> +    tcg_gen_extu_i32_tl(t, t32);
> +    tcg_temp_free_i32(t32);

>       if (stackprot) {
>           gen_helper_stackprot(cpu_env, t);
> @@ -901,7 +908,8 @@ static inline void compute_ldst_addr(DisasContext
*dc, TCGv_i32 t)

>   static void dec_load(DisasContext *dc)
>   {
> -    TCGv_i32 v, addr;
> +    TCGv_i32 v;
> +    TCGv addr;
>       unsigned int size;
>       bool rev = false, ex = false;
>       TCGMemOp mop;
> @@ -928,7 +936,7 @@ static void dec_load(DisasContext *dc)
>                                                           ex ? "x" : "");

>       t_sync_flags(dc);
> -    addr = tcg_temp_new_i32();
> +    addr = tcg_temp_new();
>       compute_ldst_addr(dc, addr);

>       /*
> @@ -946,20 +954,20 @@ static void dec_load(DisasContext *dc)
>                      01 -> 10
>                      10 -> 10
>                      11 -> 00 */
> -                TCGv_i32 low = tcg_temp_new_i32();
> +                TCGv low = tcg_temp_new();

> -                tcg_gen_andi_i32(low, addr, 3);
> -                tcg_gen_sub_i32(low, tcg_const_i32(3), low);
> -                tcg_gen_andi_i32(addr, addr, ~3);
> -                tcg_gen_or_i32(addr, addr, low);
> -                tcg_temp_free_i32(low);
> +                tcg_gen_andi_tl(low, addr, 3);
> +                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_andi_tl(addr, addr, ~3);
> +                tcg_gen_or_tl(addr, addr, low);
> +                tcg_temp_free(low);
>                   break;
>               }

>               case 2:
>                   /* 00 -> 10
>                      10 -> 00.  */
> -                tcg_gen_xori_i32(addr, addr, 2);
> +                tcg_gen_xori_tl(addr, addr, 2);
>                   break;
>               default:
>                   cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
> @@ -969,7 +977,7 @@ static void dec_load(DisasContext *dc)

>       /* lwx does not throw unaligned access errors, so force alignment */
>       if (ex) {
> -        tcg_gen_andi_i32(addr, addr, ~3);
> +        tcg_gen_andi_tl(addr, addr, ~3);
>       }

>       /* If we get a fault on a dslot, the jmpstate better be in sync.  */
> @@ -992,7 +1000,7 @@ static void dec_load(DisasContext *dc)
>       }

>       if (ex) {
> -        tcg_gen_mov_i32(env_res_addr, addr);
> +        tcg_gen_mov_tl(env_res_addr, addr);
>           tcg_gen_mov_i32(env_res_val, v);
>       }
>       if (dc->rd) {
> @@ -1005,12 +1013,12 @@ static void dec_load(DisasContext *dc)
>           write_carryi(dc, 0);
>       }

> -    tcg_temp_free_i32(addr);
> +    tcg_temp_free(addr);
>   }

>   static void dec_store(DisasContext *dc)
>   {
> -    TCGv_i32 addr;
> +    TCGv addr;
>       TCGLabel *swx_skip = NULL;
>       unsigned int size;
>       bool rev = false, ex = false;
> @@ -1040,18 +1048,18 @@ static void dec_store(DisasContext *dc)
>       /* If we get a fault on a dslot, the jmpstate better be in sync.  */
>       sync_jmpstate(dc);
>       /* SWX needs a temp_local.  */
> -    addr = ex ? tcg_temp_local_new_i32() : tcg_temp_new_i32();
> +    addr = ex ? tcg_temp_local_new() : tcg_temp_new();
>       compute_ldst_addr(dc, addr);

>       if (ex) { /* swx */
>           TCGv_i32 tval;

>           /* swx does not throw unaligned access errors, so force
alignment */
> -        tcg_gen_andi_i32(addr, addr, ~3);
> +        tcg_gen_andi_tl(addr, addr, ~3);

>           write_carryi(dc, 1);
>           swx_skip = gen_new_label();
> -        tcg_gen_brcond_i32(TCG_COND_NE, env_res_addr, addr, swx_skip);
> +        tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);

>           /* Compare the value loaded at lwx with current contents of
>              the reserved location.
> @@ -1075,13 +1083,13 @@ static void dec_store(DisasContext *dc)
>                      01 -> 10
>                      10 -> 10
>                      11 -> 00 */
> -                TCGv_i32 low = tcg_temp_new_i32();
> +                TCGv low = tcg_temp_new();

> -                tcg_gen_andi_i32(low, addr, 3);
> -                tcg_gen_sub_i32(low, tcg_const_i32(3), low);
> -                tcg_gen_andi_i32(addr, addr, ~3);
> -                tcg_gen_or_i32(addr, addr, low);
> -                tcg_temp_free_i32(low);
> +                tcg_gen_andi_tl(low, addr, 3);
> +                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_andi_tl(addr, addr, ~3);
> +                tcg_gen_or_tl(addr, addr, low);
> +                tcg_temp_free(low);
>                   break;
>               }

> @@ -1089,7 +1097,7 @@ static void dec_store(DisasContext *dc)
>                   /* 00 -> 10
>                      10 -> 00.  */
>                   /* Force addr into the temp.  */
> -                tcg_gen_xori_i32(addr, addr, 2);
> +                tcg_gen_xori_tl(addr, addr, 2);
>                   break;
>               default:
>                   cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
> @@ -1116,7 +1124,7 @@ static void dec_store(DisasContext *dc)
>           gen_set_label(swx_skip);
>       }

> -    tcg_temp_free_i32(addr);
> +    tcg_temp_free(addr);
>   }

>   static inline void eval_cc(DisasContext *dc, unsigned int cc,
> @@ -1834,7 +1842,7 @@ void mb_tcg_init(void)
>       env_btaken = tcg_global_mem_new_i32(cpu_env,
>                        offsetof(CPUMBState, btaken),
>                        "btaken");
> -    env_res_addr = tcg_global_mem_new_i32(cpu_env,
> +    env_res_addr = tcg_global_mem_new(cpu_env,
>                        offsetof(CPUMBState, res_addr),
>                        "res_addr");
>       env_res_val = tcg_global_mem_new_i32(cpu_env,
> --
> 2.14.1
