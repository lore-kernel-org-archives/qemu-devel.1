Received: from eggs.gnu.org ([2001:4830:134:3::10]:45376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chDw5-00077I-54
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chDw1-00006A-4u
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:21:17 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chDw0-00005K-Tg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:21:13 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v77so11952870wmv.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 03:21:12 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 24 Feb 2017 11:20:45 +0000
Message-Id: <20170224112109.3147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/24] MTTCG Base enabling patches with ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 2d896b454a0e19ec4c1ddbb0e0b65b7e54fcedf3:

  Revert "hw/mips: MIPS Boston board support" (2017-02-23 18:04:45 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-mttcg-240217-1

for you to fetch changes up to ca759f9e387db87e1719911f019bc60c74be9ed8:

  tcg: enable MTTCG by default for ARM on x86 hosts (2017-02-24 10:32:46 +0000)

----------------------------------------------------------------
This is the MTTCG pull-request as posted yesterday.

----------------------------------------------------------------
Alex Bennée (18):
      docs: new design document multi-thread-tcg.txt
      tcg: move TCG_MO/BAR types into own file
      tcg: add kick timer for single-threaded vCPU emulation
      tcg: rename tcg_current_cpu to tcg_current_rr_cpu
      tcg: remove global exit_request
      tcg: enable tb_lock() for SoftMMU
      tcg: enable thread-per-vCPU
      cputlb: add assert_cpu_is_self checks
      cputlb: tweak qemu_ram_addr_from_host_nofail reporting
      cputlb and arm/sparc targets: convert mmuidx flushes from varg to bitmap
      cputlb: add tlb_flush_by_mmuidx async routines
      cputlb: atomically update tlb fields used by tlb_reset_dirty
      cputlb: introduce tlb_flush_*_all_cpus[_synced]
      target-arm/powerctl: defer cpu reset work to CPU context
      target-arm: don't generate WFE/YIELD calls for MTTCG
      target-arm: ensure all cross vCPUs TLB flushes complete
      hw/misc/imx6_src: defer clearing of SRC_SCR reset bits
      tcg: enable MTTCG by default for ARM on x86 hosts

Jan Kiszka (1):
      tcg: drop global lock during TCG code execution

KONRAD Frederic (2):
      tcg: add options for enabling MTTCG
      cputlb: introduce tlb_flush_* async work.

Pranith Kumar (3):
      mttcg: translate-all: Enable locking debug in a debug build
      mttcg: Add missing tb_lock/unlock() in cpu_exec_step()
      tcg: handle EXCP_ATOMIC exception for system emulation

 configure                  |   6 +
 cpu-exec-common.c          |   3 -
 cpu-exec.c                 |  89 ++++++---
 cpus.c                     | 345 ++++++++++++++++++++++++++-------
 cputlb.c                   | 463 +++++++++++++++++++++++++++++++++++++--------
 docs/multi-thread-tcg.txt  | 350 ++++++++++++++++++++++++++++++++++
 exec.c                     |  12 +-
 hw/core/irq.c              |   1 +
 hw/i386/kvmvapic.c         |   4 +-
 hw/intc/arm_gicv3_cpuif.c  |   3 +
 hw/misc/imx6_src.c         |  58 +++++-
 hw/ppc/ppc.c               |  16 +-
 hw/ppc/spapr.c             |   3 +
 include/exec/cputlb.h      |   2 -
 include/exec/exec-all.h    | 132 +++++++++++--
 include/qom/cpu.h          |  16 ++
 include/sysemu/cpus.h      |   2 +
 memory.c                   |   2 +
 qemu-options.hx            |  20 ++
 qom/cpu.c                  |  10 +
 target/arm/arm-powerctl.c  | 202 +++++++++++++-------
 target/arm/arm-powerctl.h  |   2 +
 target/arm/cpu.c           |   4 +-
 target/arm/cpu.h           |  18 +-
 target/arm/helper.c        | 219 ++++++++++-----------
 target/arm/kvm.c           |   7 +-
 target/arm/machine.c       |  41 +++-
 target/arm/op_helper.c     |  50 ++++-
 target/arm/psci.c          |   4 +-
 target/arm/translate-a64.c |   8 +-
 target/arm/translate.c     |  20 +-
 target/i386/smm_helper.c   |   7 +
 target/s390x/misc_helper.c |   5 +-
 target/sparc/ldst_helper.c |   8 +-
 tcg/i386/tcg-target.h      |  11 ++
 tcg/tcg-mo.h               |  48 +++++
 tcg/tcg.h                  |  27 +--
 translate-all.c            |  66 ++-----
 translate-common.c         |  21 +-
 vl.c                       |  49 ++++-
 40 files changed, 1878 insertions(+), 476 deletions(-)
 create mode 100644 docs/multi-thread-tcg.txt
 create mode 100644 tcg/tcg-mo.h


-- 
2.11.0
