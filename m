Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPSHN-0002ue-0p
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPSHJ-0005E1-TZ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:34:05 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPSHJ-0005Do-Jy
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:34:01 -0400
Received: by mail-wr0-x233.google.com with SMTP id c11so143117055wrc.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 04:34:01 -0700 (PDT)
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
Date: Mon, 26 Jun 2017 12:34:50 +0100
Message-ID: <87bmpbx9r9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v9 00/26] translate: [tcg] Generic
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> This series proposes a generic (target-agnostic) instruction translation
> framework.
>
> It basically provides a generic main loop for instruction disassembly, which
> calls target-specific functions when necessary. This generalization makes
> inserting new code in the main loop easier, and helps in keeping all targets in
> synch as to the contents of it.
>
> This series also paves the way towards adding events to trace guest code
> execution (BBLs and instructions).
>
> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits in the
> current organization, but will port the rest when this series gets
> merged.

I started going through this but I found a number of problems. There are
some merge failures against master due to recent changes (moving tcg
into accel, the UPDATE/JUMP lockup fixes in ARM). I also ran into a
number of compile failures which I've sent some fixup patches to.

However the series does need to complete a clean compile on all arches
(SoftMMU & linux-user) even though the porting to the new framework is
partial.

FWIW you can find my tree with fixups and other attempts to fixup
compilation @ :

  https://github.com/stsquad/qemu/tree/review/generic-tcg-v9

>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
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
> Lluís Vilanova (26):
>       Pass generic CPUState to gen_intermediate_code()
>       queue: Add macro for incremental traversal
>       cpu-exec: Avoid global variables in icount-related functions
>       target: [tcg] Add generic translation framework
>       target: [tcg] Redefine DISAS_* onto the generic translation framework (DJ_*)
>       target: [tcg,i386] Port to DisasContextBase
>       target: [tcg,i386] Refactor init_disas_context
>       target: [tcg,i386] Refactor init_globals
>       target: [tcg,i386] Refactor insn_start
>       target: [tcg,i386] Refactor breakpoint_check
>       target: [tcg,i386] Refactor disas_insn
>       target: [tcg,i386] Refactor tb_stop
>       target: [tcg,i386] Refactor disas_flags
>       target: [tcg,i386] Replace DISAS_* with DJ_*
>       target: [tcg,i386] Port to generic translation framework
>       target: [tcg,arm] Replace DISAS_* with DJ_*
>       target: [tcg,arm] Port to DisasContextBase
>       target: [tcg,arm] Port to init_disas_context
>       target: [tcg,arm] Port to init_globals
>       target: [tcg,arm] Port to tb_start
>       target: [tcg,arm] Port to insn_start
>       target: [tcg,arm] Port to breakpoint_check
>       target: [tcg,arm] Port to disas_insn
>       target: [tcg,arm] Port to tb_stop
>       target: [tcg,arm] Port to disas_flags
>       target: [tcg,arm] Port to generic translation framework
>
>
>  Makefile.target                |    1
>  include/exec/exec-all.h        |   13 +
>  include/exec/gen-icount.h      |    8 -
>  include/exec/translate-block.h |  125 ++++++++++
>  include/qemu/queue.h           |   12 +
>  include/qom/cpu.h              |   22 ++
>  target/alpha/translate.c       |   25 +-
>  target/arm/translate-a64.c     |  312 ++++++++++++-------------
>  target/arm/translate.c         |  503 ++++++++++++++++++++++------------------
>  target/arm/translate.h         |   38 ++-
>  target/cris/translate.c        |   26 +-
>  target/hppa/translate.c        |    6
>  target/i386/translate.c        |  353 +++++++++++++++-------------
>  target/lm32/translate.c        |   36 +--
>  target/m68k/translate.c        |   24 +-
>  target/microblaze/translate.c  |   28 +-
>  target/mips/translate.c        |   41 ++-
>  target/moxie/translate.c       |   16 +
>  target/nios2/translate.c       |    6
>  target/openrisc/translate.c    |   25 +-
>  target/ppc/translate.c         |   21 +-
>  target/ppc/translate_init.c    |   32 +--
>  target/s390x/translate.c       |   22 +-
>  target/sh4/translate.c         |   21 +-
>  target/sparc/translate.c       |   17 +
>  target/tilegx/translate.c      |    9 -
>  target/tricore/translate.c     |   11 -
>  target/unicore32/translate.c   |   26 +-
>  target/xtensa/translate.c      |   39 ++-
>  translate-all.c                |    2
>  translate-block.c              |  185 +++++++++++++++
>  31 files changed, 1212 insertions(+), 793 deletions(-)
>  create mode 100644 include/exec/translate-block.h
>  create mode 100644 translate-block.c
>
>
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Alex Bennée <alex.bennee@linaro.org>


--
Alex Bennée
