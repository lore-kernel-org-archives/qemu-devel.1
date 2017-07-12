Received: from eggs.gnu.org ([2001:4830:134:3::10]:45093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVEGO-00033P-CZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVEGK-0005T4-3T
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:48:56 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVEGJ-0005Se-PW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:48:52 -0400
Received: by mail-wr0-f169.google.com with SMTP id 77so26108505wrb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:48:51 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149942760788.8972.474351671751194003.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:47:48 +0100
Message-ID: <87shi27zqz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 00/27] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> This series proposes a generic (target-agnostic) instruction translation
> framework.
>
> It basically provides a generic main loop for instruction disassembly, which
> calls target-specific functions when necessary. This generalization makes
> inserting new code in the main loop easier, and helps in keeping all targets in
> synch as to the contents of it.

As has been mentioned elsewhere I think we need to spend a little time
making sure we have well defined common semantics for the as many of the
translation exit conditions as possible so the others really are just
special conditions for each architecture.

> This series also paves the way towards adding events to trace guest code
> execution (BBLs and instructions).

I'm looking forward to it, it is certainly going in the right direction
and will make instrumentation a lot easier ;-)

> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits in the
> current organization, but will port the rest when this series gets
> merged.

Are you confident the other architectures will be as amenable to this
port? I guess we want to avoid being in a position of having a partial
port in progress for too long.

Anyway I'm done with my review pass for now, I look forward to future
revisions ;-)


>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>
> Changes in v12
> ==============
>
> * Do not rename cs -> cpu when using CPUState arg in gen_intermediate_code().
> * Avoid merge conflicts with queued patches.
> * Fix documentation typos.
> * Rename translate_block -> translator_loop.
> * Fix misplaced changes (wrong patch).
> * Rename _trblock_ -> _tr_.
> * Drop DISAS_SS and DISAS_PAGE_CROSS from arm targets.
> * Refactor calculation of TranslatorOps in arm targets.
> * Merge init_globals() into init_disas_context().
> * Minor cosmetic changes.
>
>
> Changes in v11
> ==============
>
> * Convert gen_intermediate_code_a64 [Emilio G. Cota].
> * Replace "cpu_env" argument in icount functions with "tcg_ctx.cpu_env"
>   [Emilio G. Cota].
> * Drop QTAILQ_FOREACH_CONTINUE and cpu_breakpoint_get in favour of an explicit
>   breakpoint traversal [Richard Henderson].
> * Rename translate-block.[ch] into translator.[ch] [Emilio G. Cota].
> * Revert DJ_* names into DISAS_*, and provide generic DISAS_TARGET_* enum values
>   instead of defining them as integers on each target.
> * Do not use DisasContextBase directly in target code (helps the compiler's
>   alias analysis) [Richard Henderson].
> * Make all generic translator hooks mandatory [Richard Henderson].
> * Rename TranslatorOps::disas_insn as TranslatorOps::translate_insn
>   [Richard Henderson].
> * Generalize TranslatorOps::disas_flags into TranslatorOps::disas_log to support
>   future targets [Richard Henderson].
> * Split arm and aarch64 changes in different patches [Emilio G. Cota].
> * Make translator op structs constant [Richard Henderson].
> * Write a single entry point for both arm and aarch64 translation
>   [Richard Henderson].
> * Change format of commit titles [Emilio G. Cota].
> * Remove cross-page check from generic code (it's already embedded in more
>   complex, and mandatory, checks in most targets).
>
>
> Changes in v10
> ==============
>
> * Rebase on 931892e8a6.
> * Fix build errors for hppa, nios2 and openrisc.
>
>
> Changes in v9
> =============
>
> * Further increase inter-mail sleep time during sending.
>
>
> Changes in v8
> =============
>
> * Increase inter-mail sleep time during sending (list keeps refusing some emails
>   due to an excessive send rate).
>
>
> Changes in v7
> =============
>
> * Change BreakpointHitType (BH_*) for BreakpointCheckType (BC_*).
> * Move target-specific translation functions to a struct (TranslatorOps).
> * Split target-specific changes into multiple patches.
> * Rebase on edf8bc9842.
>
>
> Changes in v6
> =============
>
> * Rebase on upstream master (64175afc69).
> * Reorder fields in DisasContextBase to minimize padding [Richard Henderson].
>
>
> Changes in v5
> =============
>
> * Remove stray uses of "restrict" keyword.
>
>
> Changes in v4
> =============
>
> * Document new macro QTAILQ_FOREACH_CONTINUE [Peter Maydell].
> * Fix coding style errors reported by checkpatch.
> * Remove use of "restrict" in added functions; it makes older gcc versions barf
>   about compilation errors.
>
>
> Changes in v3
> =============
>
> * Rebase on 0737f32daf.
>
>
> Changes in v2
> =============
>
> * Port ARM and AARCH64 targets.
> * Fold single-stepping checks into "max_insns" [Richard Henderson].
> * Move instruction start marks to target code [Richard Henderson].
> * Add target hook for TB start.
> * Check for TCG temporary leaks.
> * Move instruction disassembly into a target hook.
> * Make breakpoint_hit() return an enum to accomodate target's needs (ARM).
>
>
> Lluís Vilanova (27):
>       Pass generic CPUState to gen_intermediate_code()
>       cpu-exec: Avoid global variables in icount-related functions
>       target: [tcg] Use a generic enum for DISAS_ values
>       target: [tcg] Add generic translation framework
>       target/i386: [tcg] Port to DisasContextBase
>       target/i386: [tcg] Port to init_disas_context
>       target/i386: [tcg] Port to insn_start
>       target/i386: [tcg] Port to breakpoint_check
>       target/i386: [tcg] Port to translate_insn
>       target/i386: [tcg] Port to tb_stop
>       target/i386: [tcg] Port to disas_log
>       target/i386: [tcg] Port to generic translation framework
>       target/arm: [tcg] Port to DisasContextBase
>       target/arm: [tcg] Port to init_disas_context
>       target/arm: [tcg,a64] Port to init_disas_context
>       target/arm: [tcg] Port to tb_start
>       target/arm: [tcg] Port to insn_start
>       target/arm: [tcg,a64] Port to insn_start
>       target/arm: [tcg] Port to breakpoint_check
>       target/arm: [tcg,a64] Port to breakpoint_check
>       target/arm: [tcg] Port to translate_insn
>       target/arm: [tcg,a64] Port to translate_insn
>       target/arm: [tcg] Port to tb_stop
>       target/arm: [tcg,a64] Port to tb_stop
>       target/arm: [tcg] Port to disas_log
>       target/arm: [tcg,a64] Port to disas_log
>       target/arm: [tcg] Port to generic translation framework
>
>
>  accel/tcg/Makefile.objs       |    1
>  accel/tcg/translate-all.c     |    2
>  accel/tcg/translator.c        |  152 +++++++++++++++
>  include/exec/exec-all.h       |    8 -
>  include/exec/gen-icount.h     |   12 +
>  include/exec/translator.h     |  138 +++++++++++++
>  target/alpha/translate.c      |    5
>  target/arm/translate-a64.c    |  275 +++++++++++++--------------
>  target/arm/translate.c        |  420 +++++++++++++++++++++--------------------
>  target/arm/translate.h        |   39 ++--
>  target/cris/translate.c       |   14 +
>  target/hppa/translate.c       |    5
>  target/i386/translate.c       |  300 +++++++++++++++--------------
>  target/lm32/translate.c       |   10 +
>  target/m68k/translate.c       |   12 +
>  target/microblaze/translate.c |   10 +
>  target/mips/translate.c       |    5
>  target/moxie/translate.c      |    4
>  target/nios2/translate.c      |   11 +
>  target/openrisc/translate.c   |   10 +
>  target/ppc/translate.c        |    5
>  target/s390x/translate.c      |    8 -
>  target/sh4/translate.c        |    5
>  target/sparc/translate.c      |    5
>  target/tilegx/translate.c     |    5
>  target/tricore/translate.c    |    5
>  target/unicore32/translate.c  |   12 +
>  target/xtensa/translate.c     |    9 +
>  28 files changed, 899 insertions(+), 588 deletions(-)
>  create mode 100644 accel/tcg/translator.c
>  create mode 100644 include/exec/translator.h
>
>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Emilio G. Cota <cota@braap.org>


--
Alex Bennée
