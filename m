Received: from eggs.gnu.org ([209.51.188.92]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYm-0001Ec-NR
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYd-0003Ls-C3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYW-00034N-0n
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:08:50 -0500
Received: by mail-wm1-x330.google.com with SMTP id e74so8738432wmg.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:08:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.08.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:08:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:19 +0000
Message-Id: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/16] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit adf2e451f357e993f173ba9b4176dbf3e65fee7e:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-26 19:04:47 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190228-1

for you to fetch changes up to 1c9af3a9e05c1607a36df4943f8f5393d7621a91:

  linux-user: Enable HWCAP_ASIMDFHM, HWCAP_JSCVT (2019-02-28 11:03:05 +0000)

----------------------------------------------------------------
target-arm queue:
 * add MHU and dual-core support to Musca boards
 * refactor some VFP insns to be gated by ID registers
 * Revert "arm: Allow system registers for KVM guests to be changed by QEMU code"
 * Implement ARMv8.2-FHM extension
 * Advertise JSCVT via HWCAP for linux-user

----------------------------------------------------------------
Peter Maydell (11):
      hw/misc/armsse-mhu.c: Model the SSE-200 Message Handling Unit
      hw/arm/armsse: Wire up the MHUs
      target/arm/cpu: Allow init-svtor property to be set after realize
      target/arm/arm-powerctl: Add new arm_set_cpu_on_and_reset()
      hw/misc/iotkit-sysctl: Correct typo in INITSVTOR0 register name
      hw/arm/iotkit-sysctl: Add SSE-200 registers
      hw/arm/iotkit-sysctl: Implement CPUWAIT and INITSVTOR*
      hw/arm/armsse: Unify init-svtor and cpuwait handling
      target/arm: Use MVFR1 feature bits to gate A32/T32 FP16 instructions
      target/arm: Gate "miscellaneous FP" insns by ID register field
      Revert "arm: Allow system registers for KVM guests to be changed by QEMU code"

Richard Henderson (5):
      target/arm: Add helpers for FMLAL
      target/arm: Implement FMLAL and FMLSL for aarch64
      target/arm: Implement VFMAL and VFMSL for aarch32
      target/arm: Enable ARMv8.2-FHM for -cpu max
      linux-user: Enable HWCAP_ASIMDFHM, HWCAP_JSCVT

 hw/misc/Makefile.objs           |   1 +
 include/hw/arm/armsse.h         |   3 +-
 include/hw/misc/armsse-mhu.h    |  44 ++++++
 include/hw/misc/iotkit-sysctl.h |  25 +++-
 target/arm/arm-powerctl.h       |  16 +++
 target/arm/cpu.h                |  76 +++++++++--
 target/arm/helper.h             |   9 ++
 hw/arm/armsse.c                 |  91 +++++++++----
 hw/misc/armsse-mhu.c            | 198 +++++++++++++++++++++++++++
 hw/misc/iotkit-sysctl.c         | 294 ++++++++++++++++++++++++++++++++++++++--
 linux-user/elfload.c            |   2 +
 target/arm/arm-powerctl.c       |  56 ++++++++
 target/arm/cpu.c                |  32 ++++-
 target/arm/cpu64.c              |   2 +
 target/arm/helper.c             |  27 +---
 target/arm/kvm32.c              |  23 +++-
 target/arm/kvm64.c              |   2 -
 target/arm/machine.c            |   2 +-
 target/arm/translate-a64.c      |  49 ++++++-
 target/arm/translate.c          | 180 ++++++++++++++++--------
 target/arm/vec_helper.c         | 148 ++++++++++++++++++++
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   4 +
 24 files changed, 1139 insertions(+), 148 deletions(-)
 create mode 100644 include/hw/misc/armsse-mhu.h
 create mode 100644 hw/misc/armsse-mhu.c
