Received: from eggs.gnu.org ([2001:4830:134:3::10]:38883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZJng-0005dt-Bw
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZJnc-0003rP-D6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:04:28 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZJnc-0003qi-6w
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:04:24 -0500
Received: by mail-pg0-x241.google.com with SMTP id m17so8927125pgd.8
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 09:04:24 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-6-git-send-email-mjc@sifive.com>
	<7b4c9965-d0c4-1b10-aa6d-553a3923d598@linaro.org>
	<CADJ6UvPdmyk8ewh6AN-mzici9DB3bLwb6ta0EMK6dDk4QhL+6w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a76929f5-925f-87c3-aa9d-6067210d6db5@linaro.org>
Date: Wed, 10 Jan 2018 09:04:19 -0800
MIME-Version: 1.0
In-Reply-To: <CADJ6UvPdmyk8ewh6AN-mzici9DB3bLwb6ta0EMK6dDk4QhL+6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan O'Rear <sorear2@gmail.com>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/10/2018 02:35 AM, Stefan O'Rear wrote:
> On Tue, Jan 2, 2018 at 11:12 PM, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>> +    case CSR_MISA: {
>>> +        if (!(val_to_write & (1L << ('F' - 'A')))) {
>>> +            val_to_write &= ~(1L << ('D' - 'A'));
>>> +        }
>>> +
>>> +        /* allow MAFDC bits in MISA to be modified */
>>> +        target_ulong mask = 0;
>>> +        mask |= 1L << ('M' - 'A');
>>> +        mask |= 1L << ('A' - 'A');
>>> +        mask |= 1L << ('F' - 'A');
>>> +        mask |= 1L << ('D' - 'A');
>>> +        mask |= 1L << ('C' - 'A');
>>> +        mask &= env->misa_mask;
>>> +
>>> +        env->misa = (val_to_write & mask) | (env->misa & ~mask);
>>
>> Does this not affect the set of instructions that are allowable?  If so, you'd
>> want something like
>>
>>     new_misa = (val_to_write & mask) | (env->misa & ~mask);
>>     if (env->misa != new_misa) {
>>         env->misa = new_misa;
>>         tb_flush(CPU(riscv_env_get_cpu(env)));
>>     }
>>
>> so that we start with all new translations, which would then check the new
>> value of misa, and would then raise INST_ADDR_MIS (or not).
> 
> This does not seem quite right.  misa can legally differ between
> cores/threads, but tb_flush is a global operation.  The way this is
> supposed to work is that the relevant misa bits are extracted into
> tb_flags:
> 
> static inline void cpu_riscv_set_tb_flags(CPURISCVState *env)
> {
>     env->tb_flags = 0;
>     if (env->misa & MISA_A) {
>        env->tb_flags |= RISCV_TF_MISA_A;
>     }
> 
>     if (env->misa & MISA_D) {
>        env->tb_flags |= RISCV_TF_MISA_D;
>     }
> 
>     if (env->misa & MISA_F) {
>         env->tb_flags |= RISCV_TF_MISA_F;
>     }
> 
>     if (env->misa & MISA_M) {
>         env->tb_flags |= RISCV_TF_MISA_M;
>     }
> 
>     if (env->misa & MISA_C) {
>         env->tb_flags |= RISCV_TF_MISA_C;
>     }
> 
>     env->tb_flags |= cpu_mmu_index(env, true) << RISCV_TF_IAT_SHIFT;
>     env->tb_flags |= cpu_mmu_index(env, false) << RISCV_TF_DAT_SHIFT;
> }
> 
> static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>                                         target_ulong *cs_base, uint32_t *flags)
> {
>     *pc = env->pc;
>     *cs_base = 0;
>     *flags = env->tb_flags;
> }
> 
> but this code appears to be missing in the tree submitted for upstreaming?

Ah hah.  Yes, this is another completely valid way to accomplish this.

I am also glad that you are thinking about the computational overhead of
cpu_get_tb_cpu_state.  With lookup_and_goto_ptr, it is in the hot path of
indirect branching.


r~
