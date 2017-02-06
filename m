Received: from eggs.gnu.org ([2001:4830:134:3::10]:37180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1calG2-0005iq-8r
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1calFz-0008RT-3W
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:31:10 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1calFy-0008R5-S3
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 10:31:07 -0500
Received: by mail-wm0-x22e.google.com with SMTP id b65so125306888wmf.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 07:31:06 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  6 Feb 2017 15:30:50 +0000
Message-Id: <20170206153113.27729-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v10 00/23] MTTCG Base enabling patches with ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Richard/Peter,

This is a mostly ARM focused update to last weeks v9.

It has necessitated one change to the cputlb API. It was pointed out
that translators often have to special case a bunch of things if you
longjmp() out of a helper. As a result the cputlb _synched() calls are
no longer QEMU_NORETURN but do document the importance of the guest to
exit the block as soon as synchronisation is required. In ARM's case
this is already done as the TLB flushes are treated as CP write
operation which ends the block by default. This means I was able to
drop the two patches that dealt with ARM_CP_PC, simplifying the code.

The other moderate change was fixing up target-arm/powerctl to
properly model the ON_PENDING powerstate which is key to vCPUs
handling otherwise race-prone start-up sequences. The power off and
reset methods where also updated to update the CPUState structures in
the targets context.

Otherwise there is the usual array of review tags and a few minor
fixes documented as normal bellow the --- line.

A version of the tree can be found at:

  https://github.com/stsquad/qemu/tree/mttcg/base-patches-v10

Cheers,

Alex

Alex Bennée (17):
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
 cpu-exec.c                 |  41 ++--
 cpus.c                     | 343 ++++++++++++++++++++++++++-------
 cputlb.c                   | 463 +++++++++++++++++++++++++++++++++++++--------
 docs/multi-thread-tcg.txt  | 350 ++++++++++++++++++++++++++++++++++
 exec.c                     |  12 +-
 hw/core/irq.c              |   1 +
 hw/i386/kvmvapic.c         |   4 +-
 hw/intc/arm_gicv3_cpuif.c  |   3 +
 hw/ppc/ppc.c               |  16 +-
 hw/ppc/spapr.c             |   3 +
 include/exec/cputlb.h      |   2 -
 include/exec/exec-all.h    | 132 +++++++++++--
 include/qom/cpu.h          |  16 ++
 include/sysemu/cpus.h      |   2 +
 memory.c                   |   2 +
 qemu-options.hx            |  20 ++
 qom/cpu.c                  |  10 +
 target/arm/arm-powerctl.c  | 192 ++++++++++++-------
 target/arm/arm-powerctl.h  |   2 +
 target/arm/cpu.h           |  13 +-
 target/arm/helper.c        | 219 ++++++++++-----------
 target/arm/op_helper.c     |  50 ++++-
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
 35 files changed, 1730 insertions(+), 445 deletions(-)
 create mode 100644 docs/multi-thread-tcg.txt
 create mode 100644 tcg/tcg-mo.h

-- 
2.11.0
