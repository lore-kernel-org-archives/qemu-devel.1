Received: from eggs.gnu.org ([209.51.188.92]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aI-0008Nn-R6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aH-00066a-Gs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:26 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:44935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aH-0005yZ-8n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:25 -0400
Received: by mail-pg1-x531.google.com with SMTP id z16so1922467pgv.11
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:06 -0700
Message-Id: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/15] tcg patch queue
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

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190426

for you to fetch changes up to ef5dae6805cce7b59d129d801bdc5db71bcbd60d:

  cputlb: Fix io_readx() to respect the access_type (2019-04-25 10:40:06 -0700)

----------------------------------------------------------------
Add tcg_gen_extract2_*.
Deal with overflow of TranslationBlocks.
Respect access_type in io_readx.

----------------------------------------------------------------
David Hildenbrand (1):
      tcg: Implement tcg_gen_extract2_{i32,i64}

Richard Henderson (13):
      tcg: Add INDEX_op_extract2_{i32,i64}
      tcg: Use deposit and extract2 in tcg_gen_shifti_i64
      tcg: Use extract2 in tcg_gen_deposit_{i32,i64}
      tcg/i386: Support INDEX_op_extract2_{i32,i64}
      tcg/arm: Support INDEX_op_extract2_i32
      tcg/aarch64: Support INDEX_op_extract2_{i32,i64}
      tcg: Hoist max_insns computation to tb_gen_code
      tcg: Restart after TB code generation overflow
      tcg: Restart TB generation after relocation overflow
      tcg: Restart TB generation after constant pool overflow
      tcg: Restart TB generation after out-of-line ldst overflow
      tcg/ppc: Allow the constant pool to overflow at 32k
      tcg/arm: Restrict constant pool displacement to 12 bits

Shahab Vahedi (1):
      cputlb: Fix io_readx() to respect the access_type

 include/exec/exec-all.h       |   4 +-
 include/exec/translator.h     |   3 +-
 tcg/aarch64/tcg-target.h      |   2 +
 tcg/arm/tcg-target.h          |   1 +
 tcg/i386/tcg-target.h         |   2 +
 tcg/mips/tcg-target.h         |   2 +
 tcg/ppc/tcg-target.h          |   2 +
 tcg/riscv/tcg-target.h        |   2 +
 tcg/s390/tcg-target.h         |   2 +
 tcg/sparc/tcg-target.h        |   2 +
 tcg/tcg-op.h                  |   6 ++
 tcg/tcg-opc.h                 |   2 +
 tcg/tcg.h                     |  16 +++---
 tcg/tci/tcg-target.h          |   2 +
 accel/tcg/cputlb.c            |   5 +-
 accel/tcg/translate-all.c     |  53 ++++++++++++++---
 accel/tcg/translator.c        |  15 +----
 target/alpha/translate.c      |   4 +-
 target/arm/translate.c        |   4 +-
 target/cris/translate.c       |  10 +---
 target/hppa/translate.c       |   5 +-
 target/i386/translate.c       |   4 +-
 target/lm32/translate.c       |  10 +---
 target/m68k/translate.c       |   4 +-
 target/microblaze/translate.c |  10 +---
 target/mips/translate.c       |   4 +-
 target/moxie/translate.c      |  11 +---
 target/nios2/translate.c      |  14 +----
 target/openrisc/translate.c   |   4 +-
 target/ppc/translate.c        |   4 +-
 target/riscv/translate.c      |   4 +-
 target/s390x/translate.c      |   4 +-
 target/sh4/translate.c        |   4 +-
 target/sparc/translate.c      |   4 +-
 target/tilegx/translate.c     |  12 +---
 target/tricore/translate.c    |  16 +-----
 target/unicore32/translate.c  |  10 +---
 target/xtensa/translate.c     |   4 +-
 tcg/aarch64/tcg-target.inc.c  |  27 +++++++--
 tcg/arm/tcg-target.inc.c      |  98 ++++++++++++++++++--------------
 tcg/i386/tcg-target.inc.c     |  17 +++++-
 tcg/mips/tcg-target.inc.c     |   6 +-
 tcg/optimize.c                |  16 ++++++
 tcg/ppc/tcg-target.inc.c      |  42 +++++++-------
 tcg/riscv/tcg-target.inc.c    |  16 ++++--
 tcg/s390/tcg-target.inc.c     |  20 ++++---
 tcg/tcg-ldst.inc.c            |  18 +++---
 tcg/tcg-op.c                  | 129 +++++++++++++++++++++++++++++++++---------
 tcg/tcg-pool.inc.c            |  12 ++--
 tcg/tcg.c                     |  85 +++++++++++++++-------------
 tcg/README                    |   7 +++
 51 files changed, 451 insertions(+), 309 deletions(-)
