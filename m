Received: from eggs.gnu.org ([2001:4830:134:3::10]:58964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTYDN-0003rL-N7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTYDK-000641-J6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:42:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTYDK-00063m-Eb
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:42:50 -0400
Received: by mail-qt0-x243.google.com with SMTP id v31so5294236qtb.3
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 11:42:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942859571.8972.4761014660099212028.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <65f59b75-08c3-3872-6906-20060b5b4a28@twiddle.net>
Date: Fri, 7 Jul 2017 08:42:41 -1000
MIME-Version: 1.0
In-Reply-To: <149942859571.8972.4761014660099212028.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 04/27] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/07/2017 01:56 AM, Lluís Vilanova wrote:
> +void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
> +                     CPUState *cpu, TranslationBlock *tb)
> +{
> +    int max_insns;
> +
> +    /* Initialize DisasContext */
> +    db->tb = tb;
> +    db->pc_first = tb->pc;
> +    db->pc_next = db->pc_first;
> +    db->is_jmp = DISAS_NEXT;
> +    db->num_insns = 0;
> +    db->singlestep_enabled = cpu->singlestep_enabled;
> +    ops->init_disas_context(db, cpu);
> +
> +    /* Initialize globals */
> +    tcg_clear_temp_count();

The comment is out of date.  But perhaps just expand a bit,

   Now that globals are created, reset the temp count so that
   we can identify leaks.

> +
> +    /* Instruction counting */
> +    max_insns = db->tb->cflags & CF_COUNT_MASK;
> +    if (max_insns == 0) {
> +        max_insns = CF_COUNT_MASK;
> +    }
> +    if (max_insns > TCG_MAX_INSNS) {
> +        max_insns = TCG_MAX_INSNS;
> +    }
> +    if (db->singlestep_enabled || singlestep) {
> +        max_insns = 1;
> +    }
> +
> +    /* Start translating */
> +    gen_tb_start(db->tb);
> +    ops->tb_start(db, cpu);

As I mentioned, we need some way to modify max_insns before the loop start.

(For the ultimate in max_insns modifying needs, see the sh4 patch set I posted 
this morning, wherein I may *extend* max_insns in order to force it to cover a 
region to be executed atomically within one TB, within the lock held by 
cpu_exec_step_atomic.)

Based on that, I recommend

     DisasJumpType status;
     status = ops->tb_start(db, cpu, &max_insns);

Because in my sh4 case, tb_start might itself decide that the only way to 
handle the code is to raise the EXCP_ATOMIC exception and try again within 
cpu_exec_step_atomic.  Which means that we would not enter the while loop at 
all.  Thus,

> +    while (true) {

     while (status == DISAS_NEXT) {

> +        db->num_insns++;
> +        ops->insn_start(db, cpu);
> +
> +        /* Early exit before breakpoint checks */

Better comment maybe?  "The insn_start hook may request early exit..."

And, indeed, perhaps

     status = ops->insn_start(db, cpu);
     if (unlikely(status != DISAS_NEXT)) {
         break;
     }

> +        if (unlikely(db->is_jmp != DISAS_NEXT)) {
> +            break;
> +        }
> +
> +        /* Pass breakpoint hits to target for further processing */
> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
> +            CPUBreakpoint *bp;
> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
> +                if (bp->pc == db->pc_next) {
> +                    BreakpointCheckType bp_check =
> +                        ops->breakpoint_check(db, cpu, bp);
> +                    switch (bp_check) {
> +                    case BC_MISS:
> +                        /* Target ignored this breakpoint, go to next */
> +                        break;
> +                    case BC_HIT_INSN:
> +                        /* Hit, keep translating */
> +                        /*
> +                         * TODO: if we're never going to have more than one
> +                         *       BP in a single address, we can simply use a
> +                         *       bool here.
> +                         */
> +                        goto done_breakpoints;
> +                    case BC_HIT_TB:
> +                        /* Hit, end TB */
> +                        goto done_generating;
> +                    default:
> +                        g_assert_not_reached();
> +                    }
> +                }
> +            }
> +        }
> +    done_breakpoints:
> +
> +        /* Accept I/O on last instruction */
> +        if (db->num_insns == max_insns && (db->tb->cflags & CF_LAST_IO)) {
> +            gen_io_start();
> +        }
> +
> +        /* Disassemble one instruction */
> +        db->pc_next = ops->translate_insn(db, cpu);

I think it would be better to assign to pc_next within the hook.  We don't use 
the value otherwise within the rest of the loop.

But we do use is_jmp, immediately.  So maybe better to follow the changes to 
tb_start and insn_start above.

> +    }
> +
> +    ops->tb_stop(db, cpu);
> +
> +    if (db->tb->cflags & CF_LAST_IO) {
> +        gen_io_end();
> +    }

You can't place this after tb_stop, as it'll never be executed.  We will have 
for certain emitted the exit_tb for all paths by now.

Just place it before tb_stop where it usually resides.  In the case where some 
is_jmp value implies unreached code, and we're using icount, we'll accept the 
dead code.  But in all other cases it will get executed.


r~
