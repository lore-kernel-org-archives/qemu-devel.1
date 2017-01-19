Received: from eggs.gnu.org ([2001:4830:134:3::10]:38629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9E-0007P2-F1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9C-0007jb-LC
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:16 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9C-0007jH-CL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:14 -0500
Received: by mail-wm0-x236.google.com with SMTP id c85so2314032wmi.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:40 +0000
Message-Id: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 00/27] Remaining MTTCG Base patches and ARM
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

Here we go with another iteration of the MTTCG patches and I think it
is feature complete for at least ARMv7/v8 on x86 hosts.

One of the big changes was to address the concerns about TLB flush
semantics. We introduce a number of new tlb_flush_*_all helpers which
the guests can call instead of iterating through all the vCPUs
themselves. Crucially these helpers have a flag which indicates if the
flush is to complete with respect to the issuing vCPU. In this case
the run-loop is exited, all vCPUs halt and drain their work queues
before everything is restarted again. The calling vCPU needs to ensure
the PC will be correct for the restart which is done in ARMs case with
ARM_CP_EXIT_PC tags on the TLB flush helpers. I've added a new test
case (tlbflush-data) to my kvm-unit-tests which can demonstrate a race
condition if this is not the case.

I did consider optimising the flushes by deferring the completion
until the architecturally defined barrier operations but given the
flush only really shows up in my super aggressive micro-benchmarks it
seemed a lot of complexity for little gain. We can always revisit this
later.

There has been some more cleanup to the cputlb code which deals with
the atomic updating of flags. One consequence of the clean-up is we
explicitly disable MTTCG for 64bit guests on 32bit hosts. While the
most common host (x86) can have support for oversized atomics greater
than the natural word length it seemed a bit too fiddly to work around
so for now we just disable MTTCG for this combination.

Another change is to the default handling for turning on MTTCG. The
TARGET (guest) needs to set the TARGET_SUPPORTS_MTTCG once all the
requisite changes have been made to the model. As all the TCG_TARGETS
(host backends) support the appropriate barrier and atomic semantics
we know we can enable if the default memory model (i.e. the implicit
barriers in normal load/stores) is stronger than the guests. In this
case I've only declared the memory models for the ARM frontend and x86
backend as that is what I've tested but once we have tested on other
architectures the changes are fairly minor. In the meantime you can
still force MTTCG on at the command line.

Pranith sent a number of small fixes to debugging, cpu_exec_step and
EXCP_ATOMIC handling which I've folded into the series.

The rest of the changes are documented as usual bellow --- in each
patch.

The series applies to origin/master as of today and you can find my
tree at:

  https://github.com/stsquad/qemu/tree/mttcg/base-patches-v7

As usual review comments, testing and question welcome. I'm hoping we
are in good shape to get this merged this development cycle.

Cheers,

Alex

Alex Bennée (21):
  docs: new design document multi-thread-tcg.txt
  tcg: move TCG_MO/BAR types into own file
  tcg: add kick timer for single-threaded vCPU emulation
  tcg: rename tcg_current_cpu to tcg_current_rr_cpu
  tcg: remove global exit_request
  tcg: enable tb_lock() for SoftMMU
  tcg: enable thread-per-vCPU
  cputlb: add assert_cpu_is_self checks
  cputlb: tweak qemu_ram_addr_from_host_nofail reporting
  cputlb: add tlb_flush_by_mmuidx async routines
  cputlb: atomically update tlb fields used by tlb_reset_dirty
  cputlb: introduce tlb_flush_*_all_cpus
  target-arm/powerctl: defer cpu reset work to CPU context
  target-arm: ensure BQL taken for ARM_CP_IO register access
  target-arm: helpers which may affect global state need the BQL
  target-arm: don't generate WFE/YIELD calls for MTTCG
  target-arm/cpu.h: make ARM_CP defined consistent
  target-arm: introduce ARM_CP_EXIT_PC
  target-arm: ensure all cross vCPUs TLB flushes complete
  tcg: enable MTTCG by default for ARM on x86 hosts
  target-ppc: take global mutex for set_irq

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
 cpus.c                     | 342 ++++++++++++++++++++++++-------
 cputlb.c                   | 487 ++++++++++++++++++++++++++++++++++++++-------
 docs/multi-thread-tcg.txt  | 350 ++++++++++++++++++++++++++++++++
 exec.c                     |  12 +-
 hw/core/irq.c              |   1 +
 hw/i386/kvmvapic.c         |   4 +-
 hw/intc/arm_gicv3_cpuif.c  |   3 +
 hw/ppc/ppc.c               |  16 +-
 hw/ppc/spapr.c             |   3 +
 include/exec/cputlb.h      |   2 -
 include/exec/exec-all.h    |  68 ++++++-
 include/qom/cpu.h          |  16 ++
 include/sysemu/cpus.h      |   2 +
 memory.c                   |   2 +
 qemu-options.hx            |  20 ++
 qom/cpu.c                  |  10 +
 target/arm/arm-powerctl.c  | 146 ++++++++------
 target/arm/cpu.h           |  32 +--
 target/arm/helper.c        | 200 +++++++++----------
 target/arm/op_helper.c     |  50 ++++-
 target/arm/translate-a64.c |  12 +-
 target/arm/translate.c     |  24 ++-
 target/i386/smm_helper.c   |   7 +
 target/s390x/misc_helper.c |   5 +-
 tcg/i386/tcg-target.h      |  16 ++
 tcg/tcg-mo.h               |  45 +++++
 tcg/tcg.h                  |  27 +--
 translate-all.c            |  66 ++----
 translate-common.c         |  21 +-
 vl.c                       |  49 ++++-
 33 files changed, 1645 insertions(+), 443 deletions(-)
 create mode 100644 docs/multi-thread-tcg.txt
 create mode 100644 tcg/tcg-mo.h

-- 
2.11.0
