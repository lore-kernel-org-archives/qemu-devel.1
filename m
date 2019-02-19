Received: from eggs.gnu.org ([209.51.188.92]:53113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw4yV-0001fP-6O
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw4yU-0002mg-65
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:58:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw4yT-0002lm-Fb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:58:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so2730391wml.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:58:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 12:58:00 +0000
Message-Id: <20190219125808.25174-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] ARMSSE: Implement MHUs and dual-core
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset adds support for running dual-core guest images on
the boards using the SSE-200 (mps2-tz, musca-a, musca-b1):
 * it implements the Message Handling Units (MHUs), which dual-core
   guests typically use to signal interrupts to each other
 * it implements the handling in the sysctl register block of the
   CPUWAIT register, which is how a guest powers up the second core
 * it adds support for the INITSVTOR[01] registers in the sysctl
   block, which guests typically use to make the second core start
   with a different exception vector table from the first one

The support for the MHUs has not yet landed in the Zephyr RTOS,
but this has been tested with the code and test application
in this pending pull request:
https://github.com/zephyrproject-rtos/zephyr/pull/12722

$ qemu-system-arm -M musca-a -kernel zephyr.elf \
  -device loader,file=zephyr-ns.elf \
  -serial null -serial stdio -display none -d unimp,guest_errors
pl011_read: Bad offset 0x44
pl011_read: Bad offset 0x44
***** Booting Zephyr OS zephyr-v1.13.0-3378-g1a0632c8b0 *****
IPM MHU sample on musca_a
CPU 0, get MHU0 success!
pl011_read: Bad offset 0x44
pl011_read: Bad offset 0x44
***** Booting Zephyr OS zephyr-v1.13.0-3378-g1a0632c8b0 *****
IPM MHU sample on musca_a_nonsecure
CPU 1, get MHU0 success!
MHU ISR on CPU 0
MHU ISR on CPU 1
MHU Test Done.

(The pl011 messages are a Zephyr bug which I have reported to them.)


Based-on: 20190214125107.22178-1-peter.maydell@linaro.org
("Add model of the Arm Musca devboards")

thanks
-- PMM

Peter Maydell (8):
  hw/misc/armsse-mhu.c: Model the SSE-200 Message Handling Unit
  hw/arm/armsse: Wire up the MHUs
  target/arm/cpu: Allow init-svtor property to be set after realize
  target/arm/arm-powerctl: Add new arm_set_cpu_on_and_reset()
  hw/misc/iotkit-sysctl: Correct typo in INITSVTOR0 register name
  hw/arm/iotkit-sysctl: Add SSE-200 registers
  hw/arm/iotkit-sysctl: Implement CPUWAIT and INITSVTOR*
  hw/arm/armsse: Unify init-svtor and cpuwait handling

 hw/misc/Makefile.objs           |   1 +
 include/hw/arm/armsse.h         |   3 +-
 include/hw/misc/armsse-mhu.h    |  44 +++++
 include/hw/misc/iotkit-sysctl.h |  25 ++-
 target/arm/arm-powerctl.h       |  16 ++
 hw/arm/armsse.c                 |  91 +++++++---
 hw/misc/armsse-mhu.c            | 198 +++++++++++++++++++++
 hw/misc/iotkit-sysctl.c         | 294 ++++++++++++++++++++++++++++++--
 target/arm/arm-powerctl.c       |  56 ++++++
 target/arm/cpu.c                |  29 +++-
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   4 +
 13 files changed, 714 insertions(+), 50 deletions(-)
 create mode 100644 include/hw/misc/armsse-mhu.h
 create mode 100644 hw/misc/armsse-mhu.c

-- 
2.20.1
