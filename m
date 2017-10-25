Received: from eggs.gnu.org ([2001:4830:134:3::10]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6E-00084C-JX
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6A-0007iL-BM
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:46 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:51712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6A-0007gr-1n
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:42 -0400
Received: by mail-wr0-x22b.google.com with SMTP id j15so11168419wre.8
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:44 +0200
Message-Id: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/51] tcg queued patches
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

Primarily Emilio's work toward removing tb_lock, with fixes.
But there are some other tcg-related patches that are queued.


r~


The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20171025

for you to fetch changes up to cc689485ee3e9dca05765326ee8fd619a6ec48f0:

  translate-all: exit from tb_phys_invalidate if qht_remove fails (2017-10-24 13:53:42 -0700)

----------------------------------------------------------------
TCG patch queue

----------------------------------------------------------------
Emilio G. Cota (25):
      tcg: define CF_PARALLEL and use it for TB hashing along with CF_COUNT_MASK
      tcg: convert tb->cflags reads to tb_cflags(tb)
      target/arm: check CF_PARALLEL instead of parallel_cpus
      target/hppa: check CF_PARALLEL instead of parallel_cpus
      target/i386: check CF_PARALLEL instead of parallel_cpus
      target/m68k: check CF_PARALLEL instead of parallel_cpus
      target/s390x: check CF_PARALLEL instead of parallel_cpus
      target/sh4: check CF_PARALLEL instead of parallel_cpus
      target/sparc: check CF_PARALLEL instead of parallel_cpus
      tcg: check CF_PARALLEL instead of parallel_cpus
      cpu-exec: lookup/generate TB outside exclusive region during step_atomic
      translate-all: use a binary search tree to track TBs in TBContext
      exec-all: rename tb_free to tb_remove
      translate-all: report correct avg host TB size
      tcg: take tb_ctx out of TCGContext
      tcg: define tcg_init_ctx and make tcg_ctx a pointer
      gen-icount: fold exitreq_label into TCGContext
      tcg: introduce **tcg_ctxs to keep track of all TCGContext's
      tcg: distribute profiling counters across TCGContext's
      tcg: allocate optimizer temps with tcg_malloc
      osdep: introduce qemu_mprotect_rwx/none
      translate-all: use qemu_protect_rwx/none helpers
      tcg: introduce regions to split code_gen_buffer
      tcg: enable multiple TCG contexts in softmmu
      translate-all: exit from tb_phys_invalidate if qht_remove fails

Richard Henderson (26):
      tcg: Merge opcode arguments into TCGOp
      tcg: Propagate args to op->args in optimizer
      tcg: Propagate args to op->args in tcg.c
      tcg: Propagate TCGOp down to allocators
      tcg: Introduce arg_temp
      tcg: Add temp_global bit to TCGTemp
      tcg: Return NULL temp for TCG_CALL_DUMMY_ARG
      tcg: Introduce temp_arg, export temp_idx
      tcg: Use per-temp state data in liveness
      tcg: Avoid loops against variable bounds
      tcg: Change temp_allocate_frame arg to TCGTemp
      tcg: Remove unused TCG_CALL_DUMMY_TCGV
      tcg: Use per-temp state data in optimize
      tcg: Push tcg_ctx into generator functions
      tcg: Push tcg_ctx into tcg_gen_callN
      tcg: Introduce tcgv_{i32,i64,ptr}_{arg,temp}
      tcg: Introduce temp_tcgv_{i32,i64,ptr}
      tcg: Remove GET_TCGV_* and MAKE_TCGV_*
      tcg: Remove TCGV_EQUAL*
      qom: Introduce CPUClass.tcg_initialize
      tcg: Use offsets not indices for TCGv_*
      tcg: Add CPUState cflags_next_tb
      tcg: Include CF_COUNT_MASK in CF_HASH_MASK
      tcg: Add CF_LAST_IO + CF_USE_ICOUNT to CF_HASH_MASK
      tcg: Remove CF_IGNORE_ICOUNT
      tcg: Initialize cpu_env generically

 include/exec/exec-all.h       |   42 +-
 include/exec/gen-icount.h     |   27 +-
 include/exec/helper-gen.h     |   22 +-
 include/exec/helper-head.h    |   16 +-
 include/exec/tb-context.h     |    6 +-
 include/exec/tb-hash-xx.h     |    9 +-
 include/exec/tb-hash.h        |    4 +-
 include/exec/tb-lookup.h      |    6 +-
 include/qemu/osdep.h          |    2 +
 include/qom/cpu.h             |    9 +-
 target/arm/helper-a64.h       |    4 +
 target/arm/translate.h        |    1 -
 target/hppa/helper.h          |    2 +
 target/m68k/helper.h          |    1 +
 target/s390x/helper.h         |    4 +
 target/sparc/cpu.h            |    2 +-
 tcg/tcg-op.h                  |  140 +++---
 tcg/tcg.h                     |  294 ++++++-----
 accel/tcg/cpu-exec.c          |  100 ++--
 accel/tcg/tcg-runtime.c       |    4 +-
 accel/tcg/translate-all.c     |  533 +++++++++-----------
 accel/tcg/translator.c        |    4 +-
 bsd-user/main.c               |    3 +-
 cpus.c                        |   14 +
 exec.c                        |   14 +-
 linux-user/main.c             |    9 +-
 linux-user/syscall.c          |    1 +
 qom/cpu.c                     |    1 +
 target/alpha/cpu.c            |    3 +-
 target/alpha/translate.c      |   14 +-
 target/arm/cpu.c              |    6 +-
 target/arm/helper-a64.c       |   38 +-
 target/arm/op_helper.c        |    7 -
 target/arm/translate-a64.c    |   38 +-
 target/arm/translate.c        |   19 +-
 target/cris/cpu.c             |   16 +-
 target/cris/translate.c       |   15 +-
 target/cris/translate_v10.c   |    2 -
 target/hppa/cpu.c             |    3 +-
 target/hppa/op_helper.c       |   32 +-
 target/hppa/translate.c       |   24 +-
 target/i386/cpu.c             |    5 +-
 target/i386/translate.c       |   67 ++-
 target/lm32/cpu.c             |    7 +-
 target/lm32/translate.c       |   18 +-
 target/m68k/cpu.c             |    7 +-
 target/m68k/op_helper.c       |   33 +-
 target/m68k/translate.c       |   25 +-
 target/microblaze/cpu.c       |    7 +-
 target/microblaze/translate.c |   10 +-
 target/mips/cpu.c             |    5 +-
 target/mips/translate.c       |   37 +-
 target/moxie/cpu.c            |    7 +-
 target/moxie/translate.c      |   11 +-
 target/nios2/cpu.c            |    7 +-
 target/nios2/translate.c      |   10 +-
 target/openrisc/cpu.c         |    7 +-
 target/openrisc/translate.c   |    9 +-
 target/ppc/translate.c        |   20 +-
 target/ppc/translate_init.c   |   37 +-
 target/s390x/cpu.c            |    7 +-
 target/s390x/mem_helper.c     |   80 ++-
 target/s390x/translate.c      |   40 +-
 target/sh4/cpu.c              |    5 +-
 target/sh4/translate.c        |   19 +-
 target/sparc/cpu.c            |    5 +-
 target/sparc/translate.c      |   36 +-
 target/tilegx/cpu.c           |    7 +-
 target/tilegx/translate.c     |    5 +-
 target/tricore/cpu.c          |    5 +-
 target/tricore/translate.c    |   11 +-
 target/unicore32/cpu.c        |    7 +-
 target/unicore32/translate.c  |   10 +-
 target/xtensa/cpu.c           |    7 +-
 target/xtensa/translate.c     |   31 +-
 tcg/optimize.c                |  654 +++++++++++++-----------
 tcg/tcg-op.c                  |  190 +++----
 tcg/tcg.c                     | 1116 +++++++++++++++++++++++++++--------------
 tests/qht-bench.c             |    2 +-
 util/osdep.c                  |   41 ++
 80 files changed, 2285 insertions(+), 1813 deletions(-)
