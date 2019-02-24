Received: from eggs.gnu.org ([209.51.188.92]:41185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxz4n-0002Nq-52
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxz4m-00060s-5n
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:04:37 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxz4l-0005zO-LA
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:04:36 -0500
Received: by mail-pl1-x643.google.com with SMTP id d15so3428172plr.1
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 11:04:35 -0800 (PST)
References: <20190222162555.13764-1-amagdy.afifi@gmail.com>
	<20190222162555.13764-2-amagdy.afifi@gmail.com>
	<f782bdde-2a42-c612-5769-1cde42e7c2a4@linaro.org>
	<CAKV=O7mWBKQzVJRJT-bGW0Ojvb7eFraGniqG1-qPidZWHtp8Ew@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bf134899-fa0b-2a27-dffd-92369805fd50@linaro.org>
Date: Sun, 24 Feb 2019 11:04:30 -0800
MIME-Version: 1.0
In-Reply-To: <CAKV=O7mWBKQzVJRJT-bGW0Ojvb7eFraGniqG1-qPidZWHtp8Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] riscv: Add proper alignment check and
 pending 'C' extension upon misa writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amed Magdy <amagdy.afifi@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, Alistair.Francis@wdc.com

On 2/23/19 11:57 PM, Amed Magdy wrote:
> Thank you for your review and feedback, Richard.
> As Eric mentioned, this is the first time contribution. I have been exploring
> Qemu for some time and try to understand main flow, internals, ..etc.
> 
>>  You cannot manipulate env like this during translation.
> 
>>  Neither the write to env->pc_next nor the read from env->pending_rvc here will
>>  be in any synchronization with the execution of write_misa. 
>  
> Does this applies for translated code in a single translation block only or for
> different TBs also ?

All of the time this will not work.

> So should I manipulate "env" from translation context through helpers only ?
> for example:
> 
> TCGv temp;
> tcg_gen_movi_tl(temp, ctx->pc_succ_insn);
> gen_helper_next_pc(cpu_env, temp);
> 
> while the helper function definition like that:
> void helper_next_pc(CPURISCVState *env, target_ulong pc_next)
> {
>     env->pc_next = pc_next;
> }

This is a correct way to write pc_next.  (Although I still don't understand why
you need it.)

> and the same to read "env->pending_rvc"

No, you cannot read pending_rvc this way.  You would need to incorporate
pending_rvc into the flags set by cpu_get_tb_cpu_state.  (Although I still
don't understand why you need it.)

> I'm thinking of a way to add 'C' extension at run time through waiting the
> correct aligned instruction, which I believe it might be after branch something
> quite similar to switching between ARM and THUMB states in ARM, for misa 'RVC'
> enable to take effect since it will be no possibility to check alignment with
> 'C' extension.

It seems to me that the C extension can be enabled at any point, since if C is
off, you know that the next insn is aligned modulo 4.

It is only if the C extension is enabled, and you want to disable it, that is
when we must check to see if the next insn is aligned mod 4.  It is trivial to
arrange for a particular instruction to be aligned, via assembler directives.
So it seems silly to make the definition of the csr write to misa any more
complicated than it is.

You are right that the existing code is broken, in that it is checking the
alignment of the host PC and not the guest PC.  However, I see no reason to
introduce a new "pc_next" field when we already update the pc field ...

> static void gen_system(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>                        int csr)
> {
>     TCGv source1, csr_store, dest, rs1_pass, imm_rs1;
>     source1 = tcg_temp_new();
>     csr_store = tcg_temp_new();
>     dest = tcg_temp_new();
>     rs1_pass = tcg_temp_new();
>     imm_rs1 = tcg_temp_new();
>     gen_get_gpr(source1, rs1);
>     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);

... here.

So as far as I can see, the only thing that needs fixing is GETPC.


r~


diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 960d2b0aa9..8726ef802e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -370,10 +370,11 @@ static int write_misa(CPURISCVState *env, int csrno,
target_ulong val)
         val &= ~RVD;
     }

-    /* Suppress 'C' if next instruction is not aligned
-     * TODO: this should check next_pc
+    /*
+     * Suppress 'C' if next instruction is not aligned.
+     * We updated env->pc to the next insn in the translator.
      */
-    if ((val & RVC) && (GETPC() & ~3) != 0) {
+    if ((val & RVC) && (env->pc & ~3) != 0) {
         val &= ~RVC;
     }
