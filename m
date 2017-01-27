Received: from eggs.gnu.org ([2001:4830:134:3::10]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wG-0003H7-8Q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wD-0003TX-6R
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:28 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3wC-0003TR-Td
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:25 -0500
Received: by mail-wm0-x22d.google.com with SMTP id c206so130174185wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:39:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:38:57 +0000
Message-Id: <20170127103922.19658-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 00/25] Remaining MTTCG Base patches and ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

All of the changes in this revision are addressing comments from v7
posted last week. A new pre-cursor patch was added:

  cputlb and arm/sparc targets: convert mmuidx flushes from varg to
    bitmap

To change the cputlb API to use a bitmap instead of vargs. This has
generated quite a bit of churn in the ARM target but it is pretty
mechanical.

I also folded the BQL irq protection patches from v7 into:

  tcg: drop global lock during TCG code execution

This is required to keep the series bisectable although the BQL safety
is only really relevant to guests using MTTCG. I didn't think it was
worth making the asserts conditional on parallel_cpus although it does
mean this patch gets a little bigger.

The other big change was to:

  cputlb: introduce tlb_flush_*_all_cpus[_synced]

Where I replaced the wait flag with an expanded set of API calls. The
*_synced variants which are marked as QEMU_NORETURN to make their
behaviour clear.

The series applies to origin/master as of today and you can find my
tree at:

  https://github.com/stsquad/qemu/tree/mttcg/base-patches-v8

There is the usual collection of r-b tags and minor merge/re-base
fixes all documented in the --- sections of the commit messages.

In terms of merging strategy I would appreciate some thoughts. While I
think the series is ready to go I appreciate it is quite a chunk to
merge in one go. That said an early merge gives us plenty of time to
shake out any lingering issues before feature freeze.

I guess the key decider is that we are happy the design provides for
solutions for any other things we come across?

Cheers,

Alex

Alex Bennée (19):
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
  target-arm/cpu.h: make ARM_CP defined consistent
  target-arm: introduce ARM_CP_EXIT_PC
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
 cputlb.c                   | 465 +++++++++++++++++++++++++++++++++++++--------
 docs/multi-thread-tcg.txt  | 350 ++++++++++++++++++++++++++++++++++
 exec.c                     |  12 +-
 hw/core/irq.c              |   1 +
 hw/i386/kvmvapic.c         |   4 +-
 hw/intc/arm_gicv3_cpuif.c  |   3 +
 hw/ppc/ppc.c               |  16 +-
 hw/ppc/spapr.c             |   3 +
 include/exec/cputlb.h      |   2 -
 include/exec/exec-all.h    | 130 +++++++++++--
 include/qom/cpu.h          |  16 ++
 include/sysemu/cpus.h      |   2 +
 memory.c                   |   2 +
 qemu-options.hx            |  20 ++
 qom/cpu.c                  |  10 +
 target/arm/arm-powerctl.c  | 146 ++++++++------
 target/arm/cpu.h           |  73 ++++---
 target/arm/helper.c        | 385 ++++++++++++++++++-------------------
 target/arm/op_helper.c     |  50 ++++-
 target/arm/translate-a64.c |  26 ++-
 target/arm/translate.c     |  46 +++--
 target/arm/translate.h     |   4 +-
 target/i386/smm_helper.c   |   7 +
 target/s390x/misc_helper.c |   5 +-
 target/sparc/ldst_helper.c |   8 +-
 tcg/i386/tcg-target.h      |  16 ++
 tcg/tcg-mo.h               |  45 +++++
 tcg/tcg.h                  |  27 +--
 translate-all.c            |  66 ++-----
 translate-common.c         |  21 +-
 vl.c                       |  49 ++++-
 35 files changed, 1818 insertions(+), 585 deletions(-)
 create mode 100644 docs/multi-thread-tcg.txt
 create mode 100644 tcg/tcg-mo.h

-- 
2.11.0
