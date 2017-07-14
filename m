Received: from eggs.gnu.org ([2001:4830:134:3::10]:40719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVvjT-0007a7-DV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVvjQ-0005wB-6I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:13:51 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:48832 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVvjP-0005vB-L8
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:13:48 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 11:13:32 +0300
Message-Id: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 00/26] translate: [tcg] Generic translation
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This series proposes a generic (target-agnostic) instruction translation
framework.

It basically provides a generic main loop for instruction disassembly, wh=
ich
calls target-specific functions when necessary. This generalization makes
inserting new code in the main loop easier, and helps in keeping all targ=
ets in
synch as to the contents of it.

This series also paves the way towards adding events to trace guest code
execution (BBLs and instructions).

I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits =
in the
current organization, but will port the rest when this series gets merged.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---

Changes in v13
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on aa916e409c.
* Pass DisasContext whenever possible.
* Ensure DisasContextBase::is_jmp is set only in proper target hooks.
* Add generic value DISAS_NORETURN and handle it accordingly.
* Change breakpoint_check() hook to use a bool return + optional DISAS_NO=
RETURN.
* Let targets set max_insns in generic loop through the tb_stop() hook.
* Move gen_io_end() before the tb_stop() hook.


Changes in v12
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Do not rename cs -> cpu when using CPUState arg in gen_intermediate_cod=
e().
* Avoid merge conflicts with queued patches.
* Fix documentation typos.
* Rename translate_block -> translator_loop.
* Fix misplaced changes (wrong patch).
* Rename _trblock_ -> _tr_.
* Drop DISAS_SS and DISAS_PAGE_CROSS from arm targets.
* Refactor calculation of TranslatorOps in arm targets.
* Merge init_globals() into init_disas_context().
* Minor cosmetic changes.


Changes in v11
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Convert gen_intermediate_code_a64 [Emilio G. Cota].
* Replace "cpu_env" argument in icount functions with "tcg_ctx.cpu_env"
  [Emilio G. Cota].
* Drop QTAILQ_FOREACH_CONTINUE and cpu_breakpoint_get in favour of an exp=
licit
  breakpoint traversal [Richard Henderson].
* Rename translate-block.[ch] into translator.[ch] [Emilio G. Cota].
* Revert DJ_* names into DISAS_*, and provide generic DISAS_TARGET_* enum=
 values
  instead of defining them as integers on each target.
* Do not use DisasContextBase directly in target code (helps the compiler=
's
  alias analysis) [Richard Henderson].
* Make all generic translator hooks mandatory [Richard Henderson].
* Rename TranslatorOps::disas_insn as TranslatorOps::translate_insn
  [Richard Henderson].
* Generalize TranslatorOps::disas_flags into TranslatorOps::disas_log to =
support
  future targets [Richard Henderson].
* Split arm and aarch64 changes in different patches [Emilio G. Cota].
* Make translator op structs constant [Richard Henderson].
* Write a single entry point for both arm and aarch64 translation
  [Richard Henderson].
* Change format of commit titles [Emilio G. Cota].
* Remove cross-page check from generic code (it's already embedded in mor=
e
  complex, and mandatory, checks in most targets).


Changes in v10
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 931892e8a6.
* Fix build errors for hppa, nios2 and openrisc.


Changes in v9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Further increase inter-mail sleep time during sending.


Changes in v8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Increase inter-mail sleep time during sending (list keeps refusing some=
 emails
  due to an excessive send rate).


Changes in v7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Change BreakpointHitType (BH_*) for BreakpointCheckType (BC_*).
* Move target-specific translation functions to a struct (TranslatorOps).
* Split target-specific changes into multiple patches.
* Rebase on edf8bc9842.


Changes in v6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on upstream master (64175afc69).
* Reorder fields in DisasContextBase to minimize padding [Richard Henders=
on].


Changes in v5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Remove stray uses of "restrict" keyword.


Changes in v4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Document new macro QTAILQ_FOREACH_CONTINUE [Peter Maydell].
* Fix coding style errors reported by checkpatch.
* Remove use of "restrict" in added functions; it makes older gcc version=
s barf
  about compilation errors.


Changes in v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Rebase on 0737f32daf.


Changes in v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Port ARM and AARCH64 targets.
* Fold single-stepping checks into "max_insns" [Richard Henderson].
* Move instruction start marks to target code [Richard Henderson].
* Add target hook for TB start.
* Check for TCG temporary leaks.
* Move instruction disassembly into a target hook.
* Make breakpoint_hit() return an enum to accomodate target's needs (ARM).


Llu=C3=ADs Vilanova (26):
      Pass generic CPUState to gen_intermediate_code()
      target: [tcg] Use a generic enum for DISAS_ values
      target: [tcg] Add generic translation framework
      target/i386: [tcg] Port to DisasContextBase
      target/i386: [tcg] Port to init_disas_context
      target/i386: [tcg] Port to insn_start
      target/i386: [tcg] Port to breakpoint_check
      target/i386: [tcg] Port to translate_insn
      target/i386: [tcg] Port to tb_stop
      target/i386: [tcg] Port to disas_log
      target/i386: [tcg] Port to generic translation framework
      target/arm: [tcg] Port to DisasContextBase
      target/arm: [tcg] Port to init_disas_context
      target/arm: [tcg,a64] Port to init_disas_context
      target/arm: [tcg] Port to tb_start
      target/arm: [tcg] Port to insn_start
      target/arm: [tcg,a64] Port to insn_start
      target/arm: [tcg] Port to breakpoint_check
      target/arm: [tcg,a64] Port to breakpoint_check
      target/arm: [tcg] Port to translate_insn
      target/arm: [tcg,a64] Port to translate_insn
      target/arm: [tcg] Port to tb_stop
      target/arm: [tcg,a64] Port to tb_stop
      target/arm: [tcg] Port to disas_log
      target/arm: [tcg,a64] Port to disas_log
      target/arm: [tcg] Port to generic translation framework


 accel/tcg/Makefile.objs       |    1=20
 accel/tcg/translate-all.c     |    2=20
 accel/tcg/translator.c        |  141 ++++++++++++++
 include/exec/exec-all.h       |    8 -
 include/exec/translator.h     |  134 +++++++++++++
 target/alpha/translate.c      |    5=20
 target/arm/translate-a64.c    |  271 +++++++++++++-------------
 target/arm/translate.c        |  420 +++++++++++++++++++++--------------=
------
 target/arm/translate.h        |   38 ++--
 target/cris/translate.c       |   14 +
 target/hppa/translate.c       |    5=20
 target/i386/translate.c       |  300 +++++++++++++++--------------
 target/lm32/translate.c       |   10 +
 target/m68k/translate.c       |   12 +
 target/microblaze/translate.c |   10 +
 target/mips/translate.c       |    5=20
 target/moxie/translate.c      |    4=20
 target/nios2/translate.c      |   11 +
 target/openrisc/translate.c   |   10 +
 target/ppc/translate.c        |    5=20
 target/s390x/translate.c      |    8 -
 target/sh4/translate.c        |    5=20
 target/sparc/translate.c      |    5=20
 target/tilegx/translate.c     |    5=20
 target/tricore/translate.c    |    5=20
 target/unicore32/translate.c  |   12 +
 target/xtensa/translate.c     |    9 +
 27 files changed, 876 insertions(+), 579 deletions(-)
 create mode 100644 accel/tcg/translator.c
 create mode 100644 include/exec/translator.h


To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Emilio G. Cota <cota@braap.org>
