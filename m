Received: from eggs.gnu.org ([2001:4830:134:3::10]:54914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJC5-0007EQ-Nz
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJC1-0000rA-Cs
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:52 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJBv-0000gZ-7O
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:05:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:03:40 -0500
Message-Id: <20181213050453.9677-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 00/73] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v4: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05624.html

Changes since v4:

- Add R-b's -- thanks everyone!

- Rebase on v3.1.0
  + Add an additional conversion to cpu_interrupt_request in target/arm
    due to 89430fc6f8 ("target/arm: Correctly implement handling of
    HCR_EL2.{VI, VF}", 2018-11-13)

- s390x: add comment on why we explicitly acquire the cpu
  lock around cpu_halted and cpu_halted_set, as suggested
  by Alex and Cornelia.

- Drop the patch that reworked exclusive work.

- Add a couple of patches to finish the conversion of qom/cpu
  to cpu_halted and cpu_interrupt_request. I did this to try
  to reduce the diff of the main patch in this series (the
  one that converts the CPU loops to use per-CPU locks), but
  it's still pretty large.

- Rename all_cpu_threads_idle to qemu_tcg_rr_all_cpu_threads_idle.

- Upgrade from RFC to PATCH series. This series used to be an RFC because
  I was concerned about 3 issues:

  1. pause_all_vcpus() and start_exclusive() running at the same
  time, both called from vCPU threads. It turns out that
  pause_all_vcpus() is only called from a vCPU thread in KVM, and
  in KVM we don't use start/end_exclusive. So this should work fine,
  and in fact my concern is not new (we probably want to remove
  calls to pause_all_vcpus() from vCPU threads, but that is a
  fix that is orthogonal to this series).

  2. Possible deadlock if hotplug CPUs are added while
  pause_all_vcpus() executes, since after this series the latter
  function waits on the CPUs that are being shut down without the
  BQL held. I added a final check to pause_all_vcpus() to make sure
  that if such a race occurs, we detect it and redo the shut down
  for all vCPUs.

  3. TCG rr. Having a single condvar/mutex to wait on is very useful,
  since that way we can be woken up whenever _any_ CPU is kicked (via
  cpu->halt_cond). I managed to keep this logic by making the BQL recursive
  under the hood and pointing cpu->lock to the BQL. Note that the
  public interface of the BQL remains non-recursive (i.e. if we call
  qemu_mutex_lock_iothread() twice in a row, we'll hit an assert.);
  it is only in TCG rr mode where we use the BQL recursively.

I've tested all patches with `make check-qtest -j 30' for all targets.
The series is checkpatch-clean (just some warnings about __COVERITY__).

You can fetch it from:
  https://github.com/cota/qemu/tree/cpu-lock-v5

Thanks,

		Emilio
---
 accel/tcg/cpu-exec.c            |  40 ++--
 accel/tcg/cputlb.c              |  10 +-
 accel/tcg/tcg-all.c             |  12 +-
 accel/tcg/tcg-runtime.c         |   7 +
 accel/tcg/tcg-runtime.h         |   2 +
 accel/tcg/translate-all.c       |   2 +-
 cpus-common.c                   | 129 ++++++++----
 cpus.c                          | 422 ++++++++++++++++++++++++++++++++--------
 exec.c                          |   2 +-
 gdbstub.c                       |   2 +-
 hw/arm/omap1.c                  |   4 +-
 hw/arm/pxa2xx_gpio.c            |   2 +-
 hw/arm/pxa2xx_pic.c             |   2 +-
 hw/intc/s390_flic.c             |   4 +-
 hw/mips/cps.c                   |   2 +-
 hw/misc/mips_itu.c              |   4 +-
 hw/openrisc/cputimer.c          |   2 +-
 hw/ppc/e500.c                   |   4 +-
 hw/ppc/ppc.c                    |  12 +-
 hw/ppc/ppce500_spin.c           |   6 +-
 hw/ppc/spapr_cpu_core.c         |   4 +-
 hw/ppc/spapr_hcall.c            |   4 +-
 hw/ppc/spapr_rtas.c             |   6 +-
 hw/sparc/leon3.c                |   2 +-
 hw/sparc/sun4m.c                |   8 +-
 hw/sparc64/sparc64.c            |   8 +-
 include/qom/cpu.h               | 189 +++++++++++++++---
 qom/cpu.c                       |  25 ++-
 stubs/Makefile.objs             |   1 +
 stubs/cpu-lock.c                |  28 +++
 target/alpha/cpu.c              |   8 +-
 target/alpha/translate.c        |   6 +-
 target/arm/arm-powerctl.c       |   4 +-
 target/arm/cpu.c                |   8 +-
 target/arm/helper.c             |  16 +-
 target/arm/op_helper.c          |   2 +-
 target/cris/cpu.c               |   2 +-
 target/cris/helper.c            |   6 +-
 target/cris/translate.c         |   5 +-
 target/hppa/cpu.c               |   2 +-
 target/hppa/translate.c         |   3 +-
 target/i386/cpu.c               |   4 +-
 target/i386/cpu.h               |   2 +-
 target/i386/hax-all.c           |  36 ++--
 target/i386/helper.c            |   8 +-
 target/i386/hvf/hvf.c           |  16 +-
 target/i386/hvf/x86hvf.c        |  38 ++--
 target/i386/kvm.c               |  78 ++++----
 target/i386/misc_helper.c       |   2 +-
 target/i386/seg_helper.c        |  13 +-
 target/i386/svm_helper.c        |   6 +-
 target/i386/whpx-all.c          |  57 +++---
 target/lm32/cpu.c               |   2 +-
 target/lm32/op_helper.c         |   4 +-
 target/m68k/cpu.c               |   2 +-
 target/m68k/op_helper.c         |   2 +-
 target/m68k/translate.c         |   9 +-
 target/microblaze/cpu.c         |   2 +-
 target/microblaze/translate.c   |   4 +-
 target/mips/cpu.c               |  11 +-
 target/mips/kvm.c               |   4 +-
 target/mips/op_helper.c         |   8 +-
 target/mips/translate.c         |   4 +-
 target/moxie/cpu.c              |   2 +-
 target/nios2/cpu.c              |   2 +-
 target/openrisc/cpu.c           |   4 +-
 target/openrisc/sys_helper.c    |   4 +-
 target/ppc/excp_helper.c        |   8 +-
 target/ppc/helper_regs.h        |   2 +-
 target/ppc/kvm.c                |   8 +-
 target/ppc/translate.c          |   6 +-
 target/ppc/translate_init.inc.c |  36 ++--
 target/riscv/cpu.c              |   5 +-
 target/riscv/op_helper.c        |   2 +-
 target/s390x/cpu.c              |  28 ++-
 target/s390x/excp_helper.c      |   4 +-
 target/s390x/kvm.c              |   2 +-
 target/s390x/sigp.c             |   8 +-
 target/sh4/cpu.c                |   2 +-
 target/sh4/helper.c             |   2 +-
 target/sh4/op_helper.c          |   2 +-
 target/sparc/cpu.c              |   6 +-
 target/sparc/helper.c           |   2 +-
 target/unicore32/cpu.c          |   2 +-
 target/unicore32/softmmu.c      |   2 +-
 target/xtensa/cpu.c             |   6 +-
 target/xtensa/helper.c          |   2 +-
 target/xtensa/op_helper.c       |   2 +-
 88 files changed, 1015 insertions(+), 453 deletions(-)
