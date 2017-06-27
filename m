Received: from eggs.gnu.org ([2001:4830:134:3::10]:59239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPgPf-0007RD-VW
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPgPc-0002yf-Pj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:39:35 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPgPc-0002yL-K7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:39:32 -0400
Received: by mail-qt0-x22c.google.com with SMTP id f92so15271884qtb.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 19:39:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838119390.6497.17430428991952287717.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <171b9eb8-87c3-f70f-2a6a-f9dc2a0c5743@twiddle.net>
Date: Mon, 26 Jun 2017 19:39:28 -0700
MIME-Version: 1.0
In-Reply-To: <149838119390.6497.17430428991952287717.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/25/2017 01:59 AM, Lluís Vilanova wrote:
> +static inline void translate_block_tcg_check(const DisasContextBase *db)
> +{
> +    if (tcg_check_temp_count()) {
> +        error_report("warning: TCG temporary leaks before "TARGET_FMT_lx,
> +                     db->pc_next);
> +    }
> +}
> +
> +void translate_block(const TranslatorOps *ops, DisasContextBase *db,
> +                     CPUState *cpu, TCGv_env *tcg_cpu, TranslationBlock *tb)

tcg_cpu isn't the best name -- it doesn't reference a version of cpu.  Of 
course, you can always get at tcg_ctx.tcg_env, so there's no point in passing 
it anyway.

> +    /* Sanity-check ops */
> +    if (ops->disas_insn == NULL) {
> +        error_report("Missing ops->disas_insn");
> +        abort();
> +    }

Why?  Surely an immediate crash by calling to null is just as easy to debug.

And, bikeshedding, perhaps translate_insn is a better name.  On the first read 
through I assumed this was related to the disassembly log.

> +    while (true) {
> +        CPUBreakpoint *bp;
> +
> +        db->num_insns++;
> +        if (ops->insn_start) {
> +            ops->insn_start(db, cpu);
> +        }

This *must* be defined.  A target cannot skip emitting insn_start or unwinding 
won't work.

> +
> +        /* Early exit before breakpoint checks */
> +        if (unlikely(db->is_jmp != DJ_NEXT)) {
> +            break;
> +        }

This must be done at the end of the loop, not at the beginning of the next 
loop, after we've already emitted insn_start for the following insn.

That said, you already do have that check below, so what is this intended to do?

> +        /* Pass breakpoint hits to target for further processing */
> +        bp = NULL;
> +        do {
> +            bp = cpu_breakpoint_get(cpu, db->pc_next, bp);
> +            if (unlikely(bp) && ops->breakpoint_check) {
> +                BreakpointCheckType bp_check = ops->breakpoint_check(

Is there any point in any of these hooks being null?
An empty function in most cases, or here, one that returns BC_MISS.

> +                    db, cpu, bp);
> +                if (bp_check == BC_HIT_INSN) {
> +                    /* Hit, keep translating */
> +                    /*
> +                     * TODO: if we're never going to have more than one BP in a
> +                     *       single address, we can simply use a bool here.
> +                     */
> +                    break;
> +                } else if (bp_check == BC_HIT_TB) {
> +                    goto done_generating;
> +                } else {
> +                    error_report("Unexpected BreakpointCheckType %d", bp_check);
> +                    abort();

What happened to BC_MISS?  And surely better structured as a switch with

     default:
         g_assert_not_reached();

rather than custom logging.

> +#ifdef DEBUG_DISAS
> +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
> +        qemu_log_in_addr_range(db->pc_first)) {
> +        int flags;
> +        if (ops->disas_flags) {
> +            flags = ops->disas_flags(db);
> +        } else {
> +            flags = 0;
> +        }
> +        qemu_log_lock();
> +        qemu_log("----------------\n");
> +        qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
> +        log_target_disas(cpu, db->pc_first, db->pc_next - db->pc_first, flags);
> +        qemu_log("\n");
> +        qemu_log_unlock();

I think the hook shouldn't be just the flags, but the whole call to 
log_target_disas, at which point there isn't a reason to have a separate in a 
hook for the flags.  Consider the extra checks done for s390x and hppa.


r~
