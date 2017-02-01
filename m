Received: from eggs.gnu.org ([2001:4830:134:3::10]:37062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYwTw-00071w-VU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYwTq-0008B1-PO
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:06:00 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cYwTq-0008Am-Fs
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:05:54 -0500
Received: by mail-wm0-x230.google.com with SMTP id c85so43193936wmi.1
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 07:05:53 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  1 Feb 2017 15:05:28 +0000
Message-Id: <20170201150553.9381-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 00/25] MTTCG Base enabling patches with ARM
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
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is a quick update to the series I posted at the end of last week.
It mostly adds a bunch of review tags. There are two changes of note:

  cputlb and arm/sparc targets: convert mmuidx flushes...

  This has been updated to reduce the churn of the previous iteration
  by doing all the MMUIdx shifting in-situ for the tlb_flush calls.

And:

  tcg: enable MTTCG by default for ARM on x86 hosts

  Mostly cosmetic tweaks but I have clarified the semantics of the
  TCG_MO_foo declarations with a tweak to the TCG_TARGET_DEFAULT_MO on
  x86 to be (TCG_MO_ALL & ~TCG_MO_ST_LD).

>From v8 rth said:

  "As far as I'm concerned, I'm done with my review and this can go in."

So this is really your last chance to raise any concerns or questions
before the merge (although of course bug fixes can go in later ;-).

Peter,

The patches that touch ARM and that could do with maintainer sign-off are:

  tcg: enable MTTCG by default for ARM on x86 hosts
  target-arm: ensure all cross vCPUs TLB flushes complete
  target-arm: introduce ARM_CP_EXIT_PC
  target-arm/cpu.h: make ARM_CP defined consistent
  target-arm: don't generate WFE/YIELD calls for MTTCG
  target-arm/powerctl: defer cpu reset work to CPU context
  cputlb and arm/sparc targets: convert mmuidx flushes from varg to bitmap
  tcg: drop global lock during TCG code execution

Cheers,

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
 target/arm/cpu.h           |  32 ++--
 target/arm/helper.c        | 275 ++++++++++++++-------------
 target/arm/op_helper.c     |  50 ++++-
 target/arm/translate-a64.c |  12 +-
 target/arm/translate.c     |  24 ++-
 target/i386/smm_helper.c   |   7 +
 target/s390x/misc_helper.c |   5 +-
 target/sparc/ldst_helper.c |   8 +-
 tcg/i386/tcg-target.h      |  11 ++
 tcg/tcg-mo.h               |  48 +++++
 tcg/tcg.h                  |  27 +--
 translate-all.c            |  66 ++-----
 translate-common.c         |  21 +-
 vl.c                       |  49 ++++-
 34 files changed, 1731 insertions(+), 479 deletions(-)
 create mode 100644 docs/multi-thread-tcg.txt
 create mode 100644 tcg/tcg-mo.h

-- 
2.11.0
