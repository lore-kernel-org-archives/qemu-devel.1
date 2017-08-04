Received: from eggs.gnu.org ([2001:4830:134:3::10]:59350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPU-0003mF-Bd
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPR-0002wA-1z
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:32 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:33074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPQ-0002uG-Rc
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:28 -0400
Received: by mail-pg0-x22c.google.com with SMTP id u5so3860033pgn.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:28 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:03 -0700
Message-Id: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 00/23] tcg constant pools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

RISC machines often require many instructions in order to construct large
constants from the immediate values available to individual instructions.
Static compilers like GCC often place these large constants into read-only
memory and use one load instruction to fetch the constant instead; a
collection of these is known as a "constant pool".

TCG currently generates all constants from immediate values.  This can
require 4 insns for a full 64-bit value for AArch64, 4 insns for a
full 32-bit value for AArch32 v6.  s390x z9 needs 4, ppc64 and sparc64
need 5, mips64 needs 6.

Moreover, entries in the constant pool may be used more than once.  For
instance, if there are 3 consecutive guest stores, then we can enter the
host address of helper_le_ldul_mmu into the constant pool once for the 3
call invocations.  Depending on the host memory map, the result may be a
savings of (4*3*4) - (1*3*4+1*8) = 28 bytes.

This last is even true for the x86_64 host, where

    movq $helper_ld_ldul_mmu, %rax; call *%rax 

costs 10+6 bytes, but

    call *label(%rip); .quad helper_ld_ldul_mmu 

costs 6+8 bytes, plus the ability to share the 8 bytes for the entry.


r~


Richard Henderson (23):
  tcg: Move USE_DIRECT_JUMP discriminator to tcg/cpu/tcg-target.h
  tcg: Rearrange ldst label tracking
  tcg: Infrastructure for managing constant pools
  tcg/i386: Store out-of-range call targets in constant pool
  tcg/s390: Introduce TCG_REG_TB
  tcg/s390: Fix sign of patch_reloc addend
  tcg/s390: Use constant pool for movi
  tcg/s390: Use constant pool for andi
  tcg/s390: Use constant pool for ori
  tcg/s390: Use constant pool for xori
  tcg/s390: Use constant pool for cmpi
  tcg/aarch64: Use constant pool for movi
  tcg/sparc: Introduce TCG_REG_TB
  tcg/sparc: Use constant pool for movi
  tcg/arm: Improve tlb load for armv7
  tcg/arm: Tighten tlb indexing offset test
  tcg/arm: Code rearrangement
  tcg/arm: Extract INSN_NOP
  tcg/arm: Use constant pool for movi
  tcg/arm: Use constant pool for call
  tcg/ppc: Change TCG_REG_RA to TCG_REG_TB
  tcg/ppc: Look for shifted constants
  tcg/ppc: Use constant pool for movi

 include/elf.h                         |   3 +-
 include/exec/exec-all.h               |  95 +----
 tcg/aarch64/tcg-target.h              |   8 +
 tcg/arm/tcg-target.h                  |   9 +
 tcg/i386/tcg-target.h                 |  14 +
 tcg/ia64/tcg-target.h                 |   8 +
 tcg/mips/tcg-target.h                 |   7 +
 tcg/ppc/tcg-target.h                  |   7 +
 tcg/s390/tcg-target.h                 |  15 +
 tcg/sparc/tcg-target.h                |   5 +
 tcg/tcg-be-null.h                     |  44 --
 tcg/tcg.h                             |  14 +-
 tcg/tci/tcg-target.h                  |   9 +
 accel/tcg/cpu-exec.c                  |  35 ++
 accel/tcg/translate-all.c             |  36 +-
 tcg/aarch64/tcg-target.inc.c          |  78 ++--
 tcg/arm/tcg-target.inc.c              | 780 +++++++++++++++++++---------------
 tcg/i386/tcg-target.inc.c             |  20 +-
 tcg/ia64/tcg-target.inc.c             |  19 +-
 tcg/mips/tcg-target.inc.c             |   7 +-
 tcg/ppc/tcg-target.inc.c              | 320 +++++++-------
 tcg/s390/tcg-target.inc.c             | 527 +++++++++++++----------
 tcg/sparc/tcg-target.inc.c            | 240 ++++++++---
 tcg/{tcg-be-ldst.h => tcg-ldst.inc.c} |  27 +-
 tcg/tcg-pool.inc.c                    |  85 ++++
 tcg/tcg.c                             |  26 +-
 tcg/tci/tcg-target.inc.c              |   2 -
 27 files changed, 1422 insertions(+), 1018 deletions(-)
 delete mode 100644 tcg/tcg-be-null.h
 rename tcg/{tcg-be-ldst.h => tcg-ldst.inc.c} (85%)
 create mode 100644 tcg/tcg-pool.inc.c

-- 
2.13.3
