Received: from eggs.gnu.org ([2001:4830:134:3::10]:51885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5To-0002x4-B3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq5Tj-0007xF-HG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:41:00 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:34447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq5Tj-0007wn-AU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 18:40:55 -0400
Received: by mail-pg0-x22b.google.com with SMTP id q68so1822983pgq.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 15:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 15:40:28 -0700
Message-Id: <20170907224051.21518-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 00/23] tcg constant pools and USE_DIRECT_JUMP
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Lots of cleanup for aarch32 and s390x.  Minor improvements for
aarch64, ppc, sparc, x86_64.  But we'll need this more when we
start generating host vector insns.


r~


The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:

  tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170907

for you to fetch changes up to 53c89efd02cef626040165cc8f06b5cf2c15355d:

  tcg/ppc: Use constant pool for movi (2017-09-07 11:57:35 -0700)

----------------------------------------------------------------
TCG constant pools

----------------------------------------------------------------
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
 tcg/aarch64/tcg-target.h              |  10 +-
 tcg/arm/tcg-target.h                  |  11 +-
 tcg/i386/tcg-target.h                 |  14 +
 tcg/mips/tcg-target.h                 |   9 +-
 tcg/ppc/tcg-target.h                  |   7 +
 tcg/s390/tcg-target.h                 |  15 +
 tcg/sparc/tcg-target.h                |   5 +
 tcg/tcg-be-null.h                     |  44 --
 tcg/tcg.h                             |  14 +-
 tcg/tci/tcg-target.h                  |  13 +
 accel/tcg/cpu-exec.c                  |  35 ++
 accel/tcg/translate-all.c             |  36 +-
 tcg/aarch64/tcg-target.inc.c          |  78 ++--
 tcg/arm/tcg-target.inc.c              | 780 +++++++++++++++++++---------------
 tcg/i386/tcg-target.inc.c             |  20 +-
 tcg/mips/tcg-target.inc.c             |   7 +-
 tcg/ppc/tcg-target.inc.c              | 345 ++++++++-------
 tcg/s390/tcg-target.inc.c             | 527 +++++++++++++----------
 tcg/sparc/tcg-target.inc.c            | 240 ++++++++---
 tcg/{tcg-be-ldst.h => tcg-ldst.inc.c} |  27 +-
 tcg/tcg-pool.inc.c                    |  85 ++++
 tcg/tcg.c                             |  26 +-
 tcg/tci/tcg-target.inc.c              |   2 -
 25 files changed, 1444 insertions(+), 1004 deletions(-)
 delete mode 100644 tcg/tcg-be-null.h
 rename tcg/{tcg-be-ldst.h => tcg-ldst.inc.c} (85%)
 create mode 100644 tcg/tcg-pool.inc.c
