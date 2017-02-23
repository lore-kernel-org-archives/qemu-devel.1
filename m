Received: from eggs.gnu.org ([2001:4830:134:3::10]:44206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgy91-0004Ew-Sl
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgy8y-0006Lb-O4
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:35 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgy8y-0006Ix-Ew
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:32 -0500
Received: by mail-wm0-x232.google.com with SMTP id v77so37499283wmv.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:29:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 23 Feb 2017 18:29:03 +0000
Message-Id: <20170223182927.7166-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 00/24] MTTCG Base enabling patches with ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Richard/Peter,

Well obviously it was expecting a bit much for v13 to pass with flying
colours. A merge failure which didn't affect ARM caused the
regressions on other platforms resulting in the iothread not being
released during cpu_handle_interrupt. This fix has been merged into
Jan's drop global lock patch. I also fixed a whitespace issue on the
error_report/printf for the memory order check.

The rest of this message is as with the v13 post:

I'm hoping this is the final version and we are ready to submit a
pull-request to merge MTTCG upstream. Apart from the final set of
architecture reviewed-by's the following patches have had minor
tweaks:

  tcg: handle EXCP_ATOMIC exception for system emulation

  Fixed to handle yet another corner case of tb-flush being triggered
  during an EXCP_ATOMIC exceptions. Also the mmap_lock is now correctly
  taken (as EXCP_ATOMIC can be taken for linux-user).

  tcg: remove global exit_request

  In the single threaded round robin we also check for
  cpu->queued_work_first and bail the loop if needed. Otherwise we run
  into strangeness when the "target-arm: ensure all cross vCPUs TLB
  flushes complete" runs in single-threaded mode. The tail end of the
  commit message has been tweaked to explain this.

  tcg: enable thread-per-vCPU

  Pranith found a regression running linux-user tests/atomic_bench
  which was due to the fact we previously removed a setting of
  cpu->exit_request to 0 in cpu_handle_interrupt. Because the
  linux-user loop doesn't have the outer loop of system emulation this
  caused it to hang - always exiting the TB. There was a knock on
  effect w.r.t to safe work for single-threaded execution but this was
  fixed in commit above.

So if you are happy are you going to be able to submit the pull
request before the soft-freeze kicks in?

Regards,

Alex.

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
  cputlb and arm/sparc targets: convert mmuidx flushes from varg to
    bitmap
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
