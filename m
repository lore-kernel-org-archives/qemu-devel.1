Received: from eggs.gnu.org ([2001:4830:134:3::10]:59545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTTI-00040I-IY
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTT8-0000if-OO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:29 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTT3-0000Xr-8a
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:49:18 -0400
Received: by mail-pg1-x52b.google.com with SMTP id c10-v6so11202807pgq.4
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:49:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 10:48:50 -0700
Message-Id: <20181016174911.9052-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] tcg patch queue
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

The following changes since commit ff56877e911782dedc9a424233fd3f62369c258c:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20181015-pull-request' into staging (2018-10-15 15:03:45 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20181016

for you to fetch changes up to e3e9d1ea20c75718ce7c528c588a0a497f12f750:

  cputlb: read CPUTLBEntry.addr_write atomically (2018-10-16 10:04:27 -0700)

----------------------------------------------------------------
Queued tcg patches

----------------------------------------------------------------
Emilio G. Cota (10):
      tcg: access cpu->icount_decr.u16.high with atomics
      tcg: fix use of uninitialized variable under CONFIG_PROFILER
      tcg: plug holes in struct TCGProfile
      tcg: distribute tcg_time into TCG contexts
      target/alpha: remove tlb_flush from alpha_cpu_initfn
      target/unicore32: remove tlb_flush from uc32_init_fn
      exec: introduce tlb_init
      cputlb: fix assert_cpu_is_self macro
      cputlb: serialize tlb updates with env->tlb_lock
      cputlb: read CPUTLBEntry.addr_write atomically

Richard Henderson (11):
      tcg: Implement CPU_LOG_TB_NOCHAIN during expansion
      tcg: Add tlb_index and tlb_entry helpers
      tcg: Split CONFIG_ATOMIC128
      target/i386: Convert to HAVE_CMPXCHG128
      target/arm: Convert to HAVE_CMPXCHG128
      target/arm: Check HAVE_CMPXCHG128 at translate time
      target/ppc: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
      target/s390x: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
      target/s390x: Split do_cdsg, do_lpq, do_stpq
      target/s390x: Skip wout, cout helpers if op helper does not return
      target/s390x: Check HAVE_ATOMIC128 and HAVE_CMPXCHG128 at translate

 accel/tcg/atomic_template.h      |  20 +++-
 accel/tcg/softmmu_template.h     |  64 +++++-----
 include/exec/cpu-defs.h          |   3 +
 include/exec/cpu_ldst.h          |  30 ++++-
 include/exec/cpu_ldst_template.h |  25 ++--
 include/exec/exec-all.h          |   8 ++
 include/qemu/atomic128.h         | 155 ++++++++++++++++++++++++
 include/qemu/timer.h             |   1 -
 target/ppc/helper.h              |   2 +-
 tcg/tcg.h                        |  20 ++--
 accel/tcg/cpu-exec.c             |   2 +-
 accel/tcg/cputlb.c               | 235 +++++++++++++++++++-----------------
 accel/tcg/tcg-all.c              |   2 +-
 accel/tcg/translate-all.c        |   2 +-
 accel/tcg/user-exec.c            |   5 +-
 cpus.c                           |   3 +-
 exec.c                           |   1 +
 monitor.c                        |  13 +-
 qom/cpu.c                        |   2 +-
 target/alpha/cpu.c               |   1 -
 target/arm/helper-a64.c          | 251 +++++++++++++++++++--------------------
 target/arm/translate-a64.c       |  38 +++---
 target/i386/mem_helper.c         |   9 +-
 target/ppc/mem_helper.c          |  33 ++++-
 target/ppc/translate.c           | 115 +++++++++---------
 target/s390x/mem_helper.c        | 202 +++++++++++++++----------------
 target/s390x/translate.c         |  45 +++++--
 target/unicore32/cpu.c           |   2 -
 tcg/tcg-op.c                     |   9 +-
 tcg/tcg.c                        |  25 +++-
 configure                        |  19 +++
 31 files changed, 830 insertions(+), 512 deletions(-)
 create mode 100644 include/qemu/atomic128.h
