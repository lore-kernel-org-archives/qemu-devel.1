Received: from eggs.gnu.org ([2001:4830:134:3::10]:48360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd5-0004vo-NT
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd4-0000lx-Jg
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpd4-0000lQ-5I
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpd2-0003Sv-29
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:44:58 +0100
Message-Id: <20180510174519.11264-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180510

for you to fetch changes up to 9a9f1f59521f46e8ff4527d9a2b52f83577e2aa3:

  target/arm: Clear SVE high bits for FMOV (2018-05-10 18:10:58 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/iotkit.c: fix minor memory leak
 * softfloat: fix wrong-exception-flags bug for multiply-add corner case
 * arm: isolate and clean up DTB generation
 * implement Arm v8.1-Atomics extension
 * Fix some bugs and missing instructions in the v8.2-FP16 extension

----------------------------------------------------------------
Igor Mammedov (4):
      pc: simplify MachineClass::get_hotplug_handler handling
      platform-bus-device: use device plug callback instead of machine_done notifier
      arm/boot: split load_dtb() from arm_load_kernel()
      make sure that we aren't overwriting mc->get_hotplug_handler by accident

Peter Maydell (3):
      hw/arm/iotkit.c: fix minor memory leak
      softfloat: Handle default NaN mode after pickNaNMulAdd, not before
      atomic.h: Work around gcc spurious "unused value" warning

Richard Henderson (14):
      tcg: Introduce helpers for integer min/max
      target/arm: Use new min/max expanders
      target/xtensa: Use new min/max expanders
      tcg: Introduce atomic helpers for integer min/max
      tcg: Use GEN_ATOMIC_HELPER_FN for opposite endian atomic add
      target/riscv: Use new atomic min/max expanders
      target/arm: Introduce ARM_FEATURE_V8_ATOMICS and initial decode
      target/arm: Fill in disas_ldst_atomic
      target/arm: Implement CAS and CASP
      target/arm: Enable ARM_FEATURE_V8_ATOMICS for user-only
      target/arm: Implement vector shifted SCVF/UCVF for fp16
      target/arm: Implement vector shifted FCVT for fp16
      target/arm: Fix float16 to/from int16
      target/arm: Clear SVE high bits for FMOV

 accel/tcg/atomic_template.h | 112 ++++++----
 accel/tcg/tcg-runtime.h     |   8 +
 hw/ppc/e500.h               |   5 +
 include/hw/arm/arm.h        |  45 +++-
 include/hw/arm/sysbus-fdt.h |  37 +---
 include/hw/arm/virt.h       |   1 +
 include/hw/i386/pc.h        |   8 -
 include/hw/platform-bus.h   |   4 +-
 include/qemu/atomic.h       |   2 +-
 target/arm/cpu.h            |   1 +
 target/arm/helper-a64.h     |   2 +
 target/arm/helper.h         |   4 +-
 tcg/tcg-op.h                |  50 +++++
 tcg/tcg.h                   |   8 +
 fpu/softfloat.c             |  52 +++--
 hw/arm/boot.c               |  72 ++-----
 hw/arm/iotkit.c             |   1 +
 hw/arm/sysbus-fdt.c         |  64 +-----
 hw/arm/virt.c               |  96 ++++++---
 hw/core/platform-bus.c      |  29 +--
 hw/i386/pc.c                |   7 +-
 hw/ppc/e500.c               |  38 ++--
 hw/ppc/e500plat.c           |  32 +++
 hw/ppc/spapr.c              |   1 +
 hw/s390x/s390-virtio-ccw.c  |   1 +
 linux-user/elfload.c        |   1 +
 target/arm/cpu64.c          |   1 +
 target/arm/helper-a64.c     |  43 ++++
 target/arm/helper.c         |  53 ++++-
 target/arm/translate-a64.c  | 490 +++++++++++++++++++++++++++++++++-----------
 target/riscv/translate.c    |  72 ++-----
 target/xtensa/translate.c   |  50 +++--
 tcg/tcg-op.c                |  48 +++++
 33 files changed, 934 insertions(+), 504 deletions(-)
