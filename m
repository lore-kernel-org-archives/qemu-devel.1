Received: from eggs.gnu.org ([2001:4830:134:3::10]:52131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499e-0001rQ-UO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e499b-0003Bk-NO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:18 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:55517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e499b-00039M-EV
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:15 -0400
Received: by mail-pg0-x22e.google.com with SMTP id b11so7344679pgn.12
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:19 -0700
Message-Id: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

I've fixed two bugs within v5 of Emilio's patch set:

 - The step_next_tb patch fixes the "rep movsb" bug that appeared
   when we included CF_COUNT_MASK into CF_HASH_MASK.  We had been
   relying on magic to single-step the next guest insn.

 - The original "allocate optimizer temps with tcg_malloc" patch
   failed testing on arm32 host.  I didn't really look into exactly
   what was wrong because I had an older patch set that touched the
   same portion of the optimizer.

   Thus, an extra 20 patches in the patch set rearranging how temps
   are referenced within the TCG backend.  Some of them have appeared
   on the list before, but it would have been last November.


r~


Emilio G. Cota (24):
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

Richard Henderson (26):
  tcg: Merge opcode arguments into TCGOp
  tcg: Propagate args to op->args in optimizer
  tcg: Propagate args to op->args in tcg.c
  tcg: Propagate TCGOp down to allocators
  tcg: Introduce arg_temp
  tcg: Add temp_global bit to TCGTemp
  tcg: Return NULL temp for TCG_CALL_DUMMY_ARG
  tcg: Introduce temp_arg
  tcg: Use per-temp state data in liveness
  tcg: Avoid loops against variable bounds
  tcg: Change temp_allocate_frame arg to TCGTemp
  tcg: Remove unused TCG_CALL_DUMMY_TCGV
  tcg: Export temp_idx
  tcg: Use per-temp state data in optimize
  tcg: Push tcg_ctx into generator functions
  tcg: Push tcg_ctx into tcg_gen_callN
  tcg: Introduce index_arg
  tcg: Reserve temporary index 0
  target/alpha: Avoid translate_init unless tcg_enabled
  qom: Introduce CPUClass.tcg_initialize
  tcg: Use pointers in TCGOp->args
  hack dump tb->flags and tb->cflags
  tcg: Add CPUState step_next_tb
  tcg: Include CF_COUNT_MASK in CF_HASH_MASK
  tcg: Add CF_LAST_IO + CF_USE_ICOUNT to CF_HASH_MASK
  tcg: Remove CF_IGNORE_ICOUNT

 include/exec/exec-all.h       |   41 +-
 include/exec/gen-icount.h     |   25 +-
 include/exec/helper-gen.h     |   12 +-
 include/exec/tb-context.h     |    6 +-
 include/exec/tb-hash-xx.h     |    9 +-
 include/exec/tb-hash.h        |    4 +-
 include/exec/tb-lookup.h      |    6 +-
 include/qemu/osdep.h          |    2 +
 include/qom/cpu.h             |    9 +-
 target/arm/helper-a64.h       |    4 +
 target/hppa/helper.h          |    2 +
 target/m68k/helper.h          |    1 +
 target/s390x/helper.h         |    4 +
 target/sparc/cpu.h            |    2 +-
 tcg/tcg-op.h                  |  132 +++---
 tcg/tcg.h                     |  184 +++++---
 accel/tcg/cpu-exec.c          |  102 ++--
 accel/tcg/tcg-runtime.c       |    4 +-
 accel/tcg/translate-all.c     |  511 ++++++++++----------
 accel/tcg/translator.c        |    4 +-
 bsd-user/main.c               |    3 +-
 cpus.c                        |   14 +
 exec.c                        |   13 +-
 linux-user/main.c             |    9 +-
 linux-user/syscall.c          |    1 +
 target/alpha/cpu.c            |    3 +-
 target/alpha/translate.c      |   12 +-
 target/arm/cpu.c              |    6 +-
 target/arm/helper-a64.c       |   38 +-
 target/arm/op_helper.c        |    7 -
 target/arm/translate-a64.c    |   38 +-
 target/arm/translate.c        |   17 +-
 target/cris/cpu.c             |   16 +-
 target/cris/translate.c       |    8 +-
 target/cris/translate_v10.c   |    2 +-
 target/hppa/cpu.c             |    3 +-
 target/hppa/op_helper.c       |   32 +-
 target/hppa/translate.c       |   22 +-
 target/i386/cpu.c             |    5 +-
 target/i386/translate.c       |   60 ++-
 target/lm32/cpu.c             |    7 +-
 target/lm32/translate.c       |   16 +-
 target/m68k/cpu.c             |    7 +-
 target/m68k/op_helper.c       |   33 +-
 target/m68k/translate.c       |   20 +-
 target/microblaze/cpu.c       |    7 +-
 target/microblaze/translate.c |    8 +-
 target/mips/cpu.c             |    5 +-
 target/mips/translate.c       |   35 +-
 target/moxie/cpu.c            |    7 +-
 target/moxie/translate.c      |   10 +-
 target/nios2/cpu.c            |    7 +-
 target/nios2/translate.c      |    6 +-
 target/openrisc/cpu.c         |    7 +-
 target/openrisc/translate.c   |    8 +-
 target/ppc/translate.c        |   14 +-
 target/ppc/translate_init.c   |   37 +-
 target/s390x/cpu.c            |    7 +-
 target/s390x/mem_helper.c     |   80 +++-
 target/s390x/translate.c      |   36 +-
 target/sh4/cpu.c              |    5 +-
 target/sh4/translate.c        |   17 +-
 target/sparc/cpu.c            |    5 +-
 target/sparc/translate.c      |   19 +-
 target/tilegx/cpu.c           |    7 +-
 target/tilegx/translate.c     |    4 +-
 target/tricore/cpu.c          |    5 +-
 target/tricore/translate.c    |    9 +-
 target/unicore32/cpu.c        |    7 +-
 target/unicore32/translate.c  |    8 +-
 target/xtensa/cpu.c           |    7 +-
 target/xtensa/translate.c     |   30 +-
 tcg/optimize.c                |  659 ++++++++++++++------------
 tcg/tcg-op.c                  |  186 ++++----
 tcg/tcg.c                     | 1030 ++++++++++++++++++++++++++++-------------
 tests/qht-bench.c             |    2 +-
 util/osdep.c                  |   41 ++
 77 files changed, 2194 insertions(+), 1577 deletions(-)

-- 
2.13.6
