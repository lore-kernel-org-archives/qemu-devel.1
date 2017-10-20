Received: from eggs.gnu.org ([2001:4830:134:3::10]:44199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gae-0005ky-1L
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gaa-0007Tw-2A
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:32 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:53740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gaZ-0007TW-O6
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:20:27 -0400
Received: by mail-pf0-x235.google.com with SMTP id t188so13066741pfd.10
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:20:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:19:31 -0700
Message-Id: <20171020232023.15010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 00/52] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

A bit silly to keep calling this "tb_lock removal", since it
doesn't quite, and it has accumulated several additional patches.

Changes since v6:
  * Dropped unnecessary rename of "temps". (Patch 13)

  * Changed how I avoid 0 as a TCGv_{i32,i64,ptr} value.
    Instead of avoiding TCGTemp index 0, use the offset of
    the TCGTemp within TCGContext. (Patches 16-19,21)

  * Fixed icount wrt CF_HASH_MASK.  I strongly suspect this
    fixes any number of icount problems with MTTCG, since we
    relied on unlocked magic code generation. (Patch 24)

  * Merged removal of tb_tc.search from Emilio.  (Patch 38)
  * Added patch 52 from Emilio.


r~


Emilio G. Cota (25):
  tcg: define CF_PARALLEL and use it for TB hashing along with
    CF_COUNT_MASK
  tcg: convert tb->cflags reads to tb_cflags(tb)
  target/arm: check CF_PARALLEL instead of parallel_cpus
  target/hppa: check CF_PARALLEL instead of parallel_cpus
  target/i386: check CF_PARALLEL instead of parallel_cpus
  target/m68k: check CF_PARALLEL instead of parallel_cpus
  target/s390x: check CF_PARALLEL instead of parallel_cpus
  target/sh4: check CF_PARALLEL instead of parallel_cpus
  target/sparc: check CF_PARALLEL instead of parallel_cpus
  tcg: check CF_PARALLEL instead of parallel_cpus
  cpu-exec: lookup/generate TB outside exclusive region during
    step_atomic
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

Richard Henderson (27):
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
  tcg: Use pointers in TCGOp->args
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
 tcg/tcg.h                     |  287 ++++++-----
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
 80 files changed, 2280 insertions(+), 1811 deletions(-)

-- 
2.13.6
