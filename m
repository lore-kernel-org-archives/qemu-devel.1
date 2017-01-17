Received: from eggs.gnu.org ([2001:4830:134:3::10]:50827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkd-00036P-Hd
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkY-0003pV-Fa
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:23 -0500
Received: from bran.ispras.ru ([83.149.199.196]:49822 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkY-0003n2-1R
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:18 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:40 +0300
Message-Id: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 00/18] Emulate guest vector operations with
 host vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

The goal of these patch series is to set up an infrastructure to emulate
guest vector operations using host vector operations. Preliminary
experiments show that simply translating loads and stores increases
performance of x264 video codec by 10%. The performance of a gcc vectorized
for loop increased 2x.

To be able to emulate guest vector operations using host vector operations,
several things need to be done.

1. Corresponding vector types should be added to TCG. These series add
TCG_v128 and TCG_v64. I've made TCG_v64 a different type than TCG_i64
because it usually needs to be allocated to different registers and
supports different operations.

2. Load/store operations for these new types need to be implemented.

3. For seamless transition from current model to a new one we need to
handle cases where memory occupied by global variable can be accessed via
pointer to the CPUArchState structure. A very simple conservative alias
analysis has been added to do it. This analysis tracks memory loads and
stores that overlap with fields of CPUArchState and provides this
information to the register allocator. The allocator then spills and
reloads affected globals when needed.

4. Allow overlapping globals. For scalar registers this is a rare case, and
overlapping registers can ba handled as a single one (ah, al, ax, eax,
rax). In ARM every Q-register consists of two D-register each consisting of
two S-registers. Handling 4 S-registers as one because they are parts of
the same Q-register is way too inefficient.

5. Add new memory addressing mode to MMU code for large accesses and create
needed helpers. Only 128-bit vectors have been handled for now.

6. Create TCG opcodes for vector operations. Only addition has beed handled
in these series. Each operation has a wrapper that checks if the backend
supports the corresponding operation or not. In one case the vector opcode
is generated, in the other the operation is emulated with scalar
operations. The emulation code is generated inline for performance reasons
(there is a huge performance difference between inline generation
and calling a helper). As a positive side effect this will eventually allow
 to merge similar emulation code for vector instructions from different
frontends to target-independent implementation.

7. Use new operations in the frontend (ARM was used in these series).

8. Support new operations in the backend (x86_64 was used in these series).

For experiments I have used ARM guest on x86_64 host. I wanted some pair of
different architectures with vector extensions both. ARM and x86_64 pair
fits well.

Kirill Batuzov (18):
  tcg: add support for 128bit vector type
  tcg: add support for 64bit vector type
  tcg: add ld_v128, ld_v64, st_v128 and st_v64 opcodes
  tcg: add simple alias analysis
  tcg: use results of alias analysis in liveness analysis
  tcg: allow globals to overlap
  tcg: add vector addition operations
  target/arm: support access to vector guest registers as globals
  target/arm: use vector opcode to handle vadd.<size> instruction
  tcg/i386: add support for vector opcodes
  tcg/i386: support 64-bit vector operations
  tcg/i386: support remaining vector addition operations
  tcg: do not relay on exact values of MO_BSWAP or MO_SIGN in backend
  tcg: introduce new TCGMemOp - MO_128
  tcg: introduce qemu_ld_v128 and qemu_st_v128 opcodes
  softmmu: create helpers for vector loads
  tcg/i386: add support for qemu_ld_v128/qemu_st_v128 ops
  target/arm: load two consecutive 64-bits vector regs as a 128-bit
    vector reg

 cputlb.c                     |   4 +
 softmmu_template_vector.h    | 266 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c       |  89 ++++++++++++++-
 tcg/aarch64/tcg-target.inc.c |   4 +-
 tcg/arm/tcg-target.inc.c     |   4 +-
 tcg/i386/tcg-target.h        |  35 +++++-
 tcg/i386/tcg-target.inc.c    | 245 ++++++++++++++++++++++++++++++++++++---
 tcg/mips/tcg-target.inc.c    |   4 +-
 tcg/optimize.c               | 146 ++++++++++++++++++++++++
 tcg/ppc/tcg-target.inc.c     |   4 +-
 tcg/s390/tcg-target.inc.c    |   4 +-
 tcg/sparc/tcg-target.inc.c   |  12 +-
 tcg/tcg-op.c                 |  20 +++-
 tcg/tcg-op.h                 | 262 ++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-opc.h                |  34 ++++++
 tcg/tcg.c                    | 146 ++++++++++++++++++++++++
 tcg/tcg.h                    | 147 +++++++++++++++++++++++-
 17 files changed, 1385 insertions(+), 41 deletions(-)
 create mode 100644 softmmu_template_vector.h

-- 
2.1.4
