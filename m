Received: from eggs.gnu.org ([2001:4830:134:3::10]:37997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbC-0003XJ-ON
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJb9-0003AM-LR
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:42:54 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJb9-0003AB-CL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:42:51 -0400
Received: by mail-pf0-x243.google.com with SMTP id z6so13725658pfk.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:42:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:09 -1000
Message-Id: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 00/34] Generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

This is my take on Lluis' v13.  I've also written patches for
Alpha, SH4, and HPPA as examples of more complicated cases.
I have not included them here, but for the record:

  git://github.com/rth7680/qemu.git tgt-axp-2 tgt-sh4-2 tgt-pa

have the patches.  In the case of Alpha and SH4, there were
other dependencies not in tree.

Changes to the generic loop include

  * Move adjustment of max_insns from tb_start to init_disas_context.

  * Removed pc_next return from translate_insn.
    Just assign to that field from within the hook.

  * Removed tcg_check_temp_count from generic loop.

    It turns out that HPPA is not ameanable to this at all.
    There is in fact a temp that may be live between
    tb_start -> translate_insn and translate_insn -> tb_stop.

    I've added the check back to arm specifically, added a
    common function that can log the error, and use qem_log
    instead of error_report.

  * Moved gen_io_end to exactly match gen_io_start.
    I'm pretty sure this is what we always intended anyway.
    
  * Moved TB size/icount assignments before disas_log.

Changes to the ARM and i386 targets include

  * Tidy DisasJumpType usage wrt DISAS_NORETURN.

Changes to the ARM target include

  * Move the kernel magic page check after breakpoint checks.
    There's no reason why gdb couldn't attach in the magic page.
    This movement allows the insn_start hook to not be so weird
    generically.

  * Split out a separate thum translate_insn hook.
    There's a lot that T32 needs to do that A32 doesn't.

  * Reduce the number of end-of-TB checks in translate_insn.
    For A64 and A32, this means page crossing checks moved to
    init_disas_context.  Even T32 can have its single-step
    check moved.


r~


Lluís Vilanova (25):
  Pass generic CPUState to gen_intermediate_code()
  target: [tcg] Use a generic enum for DISAS_ values
  tcg: Add generic translation framework
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
  target/arm: [tcg,a64] Port to breakpoint_check
  target/arm: [tcg] Port to translate_insn
  target/arm: [tcg,a64] Port to translate_insn
  target/arm: [tcg] Port to tb_stop
  target/arm: [tcg,a64] Port to tb_stop
  target/arm: [tcg] Port to disas_log
  target/arm: [tcg,a64] Port to disas_log
  target/arm: [tcg] Port to generic translation framework

Richard Henderson (9):
  tcg: Add generic DISAS_NORETURN
  target/i386: Use generic DISAS_* enumerators
  target/arm: Use DISAS_NORETURN
  target/arm: Delay check for magic kernel page
  target/arm: Set is_jmp properly after single-stepping
  target/arm: [a64] Move page and ss checks to init_disas_context
  target/arm: Move ss check to init_disas_context
  target/arm: Split out thumb_tr_translate_insn
  target/arm: Perform per-insn cross-page check only for Thumb

 include/exec/exec-all.h       |   8 +-
 include/exec/translator.h     | 141 +++++++++++++
 target/arm/translate.h        |  39 ++--
 accel/tcg/translate-all.c     |   2 +-
 accel/tcg/translator.c        | 133 ++++++++++++
 target/alpha/translate.c      |   5 +-
 target/arm/translate-a64.c    | 288 +++++++++++++------------
 target/arm/translate.c        | 481 +++++++++++++++++++++++-------------------
 target/cris/translate.c       |  14 +-
 target/hppa/translate.c       |   5 +-
 target/i386/translate.c       | 299 +++++++++++++-------------
 target/lm32/translate.c       |  10 +-
 target/m68k/translate.c       |  12 +-
 target/microblaze/translate.c |  10 +-
 target/mips/translate.c       |   5 +-
 target/moxie/translate.c      |   4 +-
 target/nios2/translate.c      |  11 +-
 target/openrisc/translate.c   |  10 +-
 target/ppc/translate.c        |   5 +-
 target/s390x/translate.c      |   8 +-
 target/sh4/translate.c        |   5 +-
 target/sparc/translate.c      |   5 +-
 target/tilegx/translate.c     |   5 +-
 target/tricore/translate.c    |   5 +-
 target/unicore32/translate.c  |  12 +-
 target/xtensa/translate.c     |   9 +-
 accel/tcg/Makefile.objs       |   1 +
 27 files changed, 936 insertions(+), 596 deletions(-)
 create mode 100644 include/exec/translator.h
 create mode 100644 accel/tcg/translator.c

-- 
2.9.4
