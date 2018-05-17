Received: from eggs.gnu.org ([2001:4830:134:3::10]:44462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJMTj-0000Fm-9K
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJMTe-0001xz-Rs
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:14:11 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJMTe-0001xc-M1
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:14:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id j42-v6so6706932qtj.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:14:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-12-edgar.iglesias@gmail.com>
	<53bfff10-2b12-e1db-d195-e4160e0aa9ff@amsat.org>
	<20180517164128.27mncjmnrszmfagc@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4dcc9bca-4ddb-eade-3622-e39a1f0736d7@amsat.org>
Date: Thu, 17 May 2018 14:14:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180517164128.27mncjmnrszmfagc@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/38] target-microblaze: Make
 compute_ldst_addr always use a temp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, qemu-devel@nongnu.org, frederic.konrad@adacore.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 05/17/2018 01:41 PM, Edgar E. Iglesias wrote:
> On Thu, May 17, 2018 at 11:39:41AM -0300, Philippe Mathieu-Daudé wrote:
>> On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
>>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>>
>>> Make compute_ldst_addr always use a temp. This simplifies
>>> the code a bit in preparation for adding support for
>>> 64bit addresses.
>>>
>>> No functional change.
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> ---
>>>  target/microblaze/translate.c | 111 ++++++++++++++----------------------------
>>>  1 file changed, 37 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
>>> index 2e9a286af6..3431a07b99 100644
>>> --- a/target/microblaze/translate.c
>>> +++ b/target/microblaze/translate.c
>>> @@ -848,7 +848,7 @@ static void dec_imm(DisasContext *dc)
>>>      dc->clear_imm = 0;
>>>  }
>>>  
>>> -static inline TCGv_i32 *compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
>>> +static inline void compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
>>>  {
>>>      bool extimm = dc->tb_flags & IMM_FLAG;
>>>      /* Should be set to true if r1 is used by loadstores.  */
>>> @@ -861,47 +861,47 @@ static inline TCGv_i32 *compute_ldst_addr(DisasContext *dc, TCGv_i32 *t)
>>
>> I never noticed that git diff show line/prototype of the previous patchset.
>>
>>>  
>>>      /* Treat the common cases first.  */
>>>      if (!dc->type_b) {
>>> -        /* If any of the regs is r0, return a ptr to the other.  */
>>> +        /* If any of the regs is r0, return the value of the other reg.  */
>>
>> Single nit here, this comment isn't true anymore since this function
>> doesn't return.
>>
>> No need to respin for this, but can you/Richard drop this comment when
>> pulling?
> 
> Hi,
> 
> The function returns a value in *t.
> I can change the comment to the following:
> /* If any of the regs is r0, set t to the value of the other reg.  */

This is clearer, thanks.

> 
> Cheers,
> Edgar
> 
>>
>>>          if (dc->ra == 0) {
>>> -            return &cpu_R[dc->rb];
>>> +            tcg_gen_mov_i32(*t, cpu_R[dc->rb]);
>>> +            return;
>>>          } else if (dc->rb == 0) {
>>> -            return &cpu_R[dc->ra];
>>> +            tcg_gen_mov_i32(*t, cpu_R[dc->ra]);
>>> +            return;
>>>          }
>>>  
>>>          if (dc->rb == 1 && dc->cpu->cfg.stackprot) {
>>>              stackprot = true;
>>>          }
>>>  
>>> -        *t = tcg_temp_new_i32();
>>>          tcg_gen_add_i32(*t, cpu_R[dc->ra], cpu_R[dc->rb]);
>>>  
>>>          if (stackprot) {
>>>              gen_helper_stackprot(cpu_env, *t);
>>>          }
>>> -        return t;
>>> +        return;
>>>      }
>>>      /* Immediate.  */
>>>      if (!extimm) {
>>>          if (dc->imm == 0) {
>>> -            return &cpu_R[dc->ra];
>>> +            tcg_gen_mov_i32(*t, cpu_R[dc->ra]);
>>> +            return;
>>>          }
>>> -        *t = tcg_temp_new_i32();
>>>          tcg_gen_movi_i32(*t, (int32_t)((int16_t)dc->imm));
>>>          tcg_gen_add_i32(*t, cpu_R[dc->ra], *t);
>>>      } else {
>>> -        *t = tcg_temp_new_i32();
>>>          tcg_gen_add_i32(*t, cpu_R[dc->ra], *(dec_alu_op_b(dc)));
>>>      }
>>>  
>>>      if (stackprot) {
>>>          gen_helper_stackprot(cpu_env, *t);
>>>      }
>>> -    return t;
>>> +    return;
>>>  }
>>>  
>>>  static void dec_load(DisasContext *dc)
>>>  {
>>> -    TCGv_i32 t, v, *addr;
>>> +    TCGv_i32 v, addr;
>>>      unsigned int size;
>>>      bool rev = false, ex = false;
>>>      TCGMemOp mop;
>>> @@ -928,7 +928,8 @@ static void dec_load(DisasContext *dc)
>>>                                                          ex ? "x" : "");
>>>  
>>>      t_sync_flags(dc);
>>> -    addr = compute_ldst_addr(dc, &t);
>>> +    addr = tcg_temp_new_i32();
>>> +    compute_ldst_addr(dc, &addr);
>>>  
>>>      /*
>>>       * When doing reverse accesses we need to do two things.
>>> @@ -947,17 +948,10 @@ static void dec_load(DisasContext *dc)
>>>                     11 -> 00 */
>>>                  TCGv_i32 low = tcg_temp_new_i32();
>>>  
>>> -                /* Force addr into the temp.  */
>>> -                if (addr != &t) {
>>> -                    t = tcg_temp_new_i32();
>>> -                    tcg_gen_mov_i32(t, *addr);
>>> -                    addr = &t;
>>> -                }
>>> -
>>> -                tcg_gen_andi_i32(low, t, 3);
>>> +                tcg_gen_andi_i32(low, addr, 3);
>>>                  tcg_gen_sub_i32(low, tcg_const_i32(3), low);
>>> -                tcg_gen_andi_i32(t, t, ~3);
>>> -                tcg_gen_or_i32(t, t, low);
>>> +                tcg_gen_andi_i32(addr, addr, ~3);
>>> +                tcg_gen_or_i32(addr, addr, low);
>>>                  tcg_temp_free_i32(low);
>>>                  break;
>>>              }
>>> @@ -965,14 +959,7 @@ static void dec_load(DisasContext *dc)
>>>              case 2:
>>>                  /* 00 -> 10
>>>                     10 -> 00.  */
>>> -                /* Force addr into the temp.  */
>>> -                if (addr != &t) {
>>> -                    t = tcg_temp_new_i32();
>>> -                    tcg_gen_xori_i32(t, *addr, 2);
>>> -                    addr = &t;
>>> -                } else {
>>> -                    tcg_gen_xori_i32(t, t, 2);
>>> -                }
>>> +                tcg_gen_xori_i32(addr, addr, 2);
>>>                  break;
>>>              default:
>>>                  cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
>>> @@ -982,13 +969,7 @@ static void dec_load(DisasContext *dc)
>>>  
>>>      /* lwx does not throw unaligned access errors, so force alignment */
>>>      if (ex) {
>>> -        /* Force addr into the temp.  */
>>> -        if (addr != &t) {
>>> -            t = tcg_temp_new_i32();
>>> -            tcg_gen_mov_i32(t, *addr);
>>> -            addr = &t;
>>> -        }
>>> -        tcg_gen_andi_i32(t, t, ~3);
>>> +        tcg_gen_andi_i32(addr, addr, ~3);
>>>      }
>>>  
>>>      /* If we get a fault on a dslot, the jmpstate better be in sync.  */
>>> @@ -1002,16 +983,16 @@ static void dec_load(DisasContext *dc)
>>>       * address and if that succeeds we write into the destination reg.
>>>       */
>>>      v = tcg_temp_new_i32();
>>> -    tcg_gen_qemu_ld_i32(v, *addr, cpu_mmu_index(&dc->cpu->env, false), mop);
>>> +    tcg_gen_qemu_ld_i32(v, addr, cpu_mmu_index(&dc->cpu->env, false), mop);
>>>  
>>>      if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
>>>          tcg_gen_movi_i32(cpu_SR[SR_PC], dc->pc);
>>> -        gen_helper_memalign(cpu_env, *addr, tcg_const_i32(dc->rd),
>>> +        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
>>>                              tcg_const_i32(0), tcg_const_i32(size - 1));
>>>      }
>>>  
>>>      if (ex) {
>>> -        tcg_gen_mov_i32(env_res_addr, *addr);
>>> +        tcg_gen_mov_i32(env_res_addr, addr);
>>>          tcg_gen_mov_i32(env_res_val, v);
>>>      }
>>>      if (dc->rd) {
>>> @@ -1024,13 +1005,12 @@ static void dec_load(DisasContext *dc)
>>>          write_carryi(dc, 0);
>>>      }
>>>  
>>> -    if (addr == &t)
>>> -        tcg_temp_free_i32(t);
>>> +    tcg_temp_free_i32(addr);
>>>  }
>>>  
>>>  static void dec_store(DisasContext *dc)
>>>  {
>>> -    TCGv_i32 t, *addr, swx_addr;
>>> +    TCGv_i32 addr;
>>>      TCGLabel *swx_skip = NULL;
>>>      unsigned int size;
>>>      bool rev = false, ex = false;
>>> @@ -1059,21 +1039,19 @@ static void dec_store(DisasContext *dc)
>>>      t_sync_flags(dc);
>>>      /* If we get a fault on a dslot, the jmpstate better be in sync.  */
>>>      sync_jmpstate(dc);
>>> -    addr = compute_ldst_addr(dc, &t);
>>> +    /* SWX needs a temp_local.  */
>>> +    addr = ex ? tcg_temp_local_new_i32() : tcg_temp_new_i32();
>>> +    compute_ldst_addr(dc, &addr);
>>>  
>>> -    swx_addr = tcg_temp_local_new_i32();
>>>      if (ex) { /* swx */
>>>          TCGv_i32 tval;
>>>  
>>> -        /* Force addr into the swx_addr. */
>>> -        tcg_gen_mov_i32(swx_addr, *addr);
>>> -        addr = &swx_addr;
>>>          /* swx does not throw unaligned access errors, so force alignment */
>>> -        tcg_gen_andi_i32(swx_addr, swx_addr, ~3);
>>> +        tcg_gen_andi_i32(addr, addr, ~3);
>>>  
>>>          write_carryi(dc, 1);
>>>          swx_skip = gen_new_label();
>>> -        tcg_gen_brcond_i32(TCG_COND_NE, env_res_addr, swx_addr, swx_skip);
>>> +        tcg_gen_brcond_i32(TCG_COND_NE, env_res_addr, addr, swx_skip);
>>>  
>>>          /* Compare the value loaded at lwx with current contents of
>>>             the reserved location.
>>> @@ -1081,8 +1059,8 @@ static void dec_store(DisasContext *dc)
>>>             this compare and the following write to be atomic. For user
>>>             emulation we need to add atomicity between threads.  */
>>>          tval = tcg_temp_new_i32();
>>> -        tcg_gen_qemu_ld_i32(tval, swx_addr, cpu_mmu_index(&dc->cpu->env, false),
>>> -                           MO_TEUL);
>>> +        tcg_gen_qemu_ld_i32(tval, addr, cpu_mmu_index(&dc->cpu->env, false),
>>> +                            MO_TEUL);
>>>          tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
>>>          write_carryi(dc, 0);
>>>          tcg_temp_free_i32(tval);
>>> @@ -1099,17 +1077,10 @@ static void dec_store(DisasContext *dc)
>>>                     11 -> 00 */
>>>                  TCGv_i32 low = tcg_temp_new_i32();
>>>  
>>> -                /* Force addr into the temp.  */
>>> -                if (addr != &t) {
>>> -                    t = tcg_temp_new_i32();
>>> -                    tcg_gen_mov_i32(t, *addr);
>>> -                    addr = &t;
>>> -                }
>>> -
>>> -                tcg_gen_andi_i32(low, t, 3);
>>> +                tcg_gen_andi_i32(low, addr, 3);
>>>                  tcg_gen_sub_i32(low, tcg_const_i32(3), low);
>>> -                tcg_gen_andi_i32(t, t, ~3);
>>> -                tcg_gen_or_i32(t, t, low);
>>> +                tcg_gen_andi_i32(addr, addr, ~3);
>>> +                tcg_gen_or_i32(addr, addr, low);
>>>                  tcg_temp_free_i32(low);
>>>                  break;
>>>              }
>>> @@ -1118,20 +1089,14 @@ static void dec_store(DisasContext *dc)
>>>                  /* 00 -> 10
>>>                     10 -> 00.  */
>>>                  /* Force addr into the temp.  */
>>> -                if (addr != &t) {
>>> -                    t = tcg_temp_new_i32();
>>> -                    tcg_gen_xori_i32(t, *addr, 2);
>>> -                    addr = &t;
>>> -                } else {
>>> -                    tcg_gen_xori_i32(t, t, 2);
>>> -                }
>>> +                tcg_gen_xori_i32(addr, addr, 2);
>>>                  break;
>>>              default:
>>>                  cpu_abort(CPU(dc->cpu), "Invalid reverse size\n");
>>>                  break;
>>>          }
>>>      }
>>> -    tcg_gen_qemu_st_i32(cpu_R[dc->rd], *addr,
>>> +    tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr,
>>>                          cpu_mmu_index(&dc->cpu->env, false), mop);
>>>  
>>>      /* Verify alignment if needed.  */
>>> @@ -1143,17 +1108,15 @@ static void dec_store(DisasContext *dc)
>>>           *        the alignment checks in between the probe and the mem
>>>           *        access.
>>>           */
>>> -        gen_helper_memalign(cpu_env, *addr, tcg_const_i32(dc->rd),
>>> +        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
>>>                              tcg_const_i32(1), tcg_const_i32(size - 1));
>>>      }
>>>  
>>>      if (ex) {
>>>          gen_set_label(swx_skip);
>>>      }
>>> -    tcg_temp_free_i32(swx_addr);
>>>  
>>> -    if (addr == &t)
>>> -        tcg_temp_free_i32(t);
>>> +    tcg_temp_free_i32(addr);
>>>  }
>>>  
>>>  static inline void eval_cc(DisasContext *dc, unsigned int cc,
>>>
>>
>> Nice cleanup!
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
