Received: from eggs.gnu.org ([2001:4830:134:3::10]:43145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNs-0001fE-RZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNr-0002xD-Kk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:20 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cilNr-0002wj-CT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:19 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNp-0003Om-JH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:16:17 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:15:55 +0000
Message-Id: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
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

Second lot of ARM changes to sneak in before freeze:
 * fixed version of the raspi2 sd controller patches
 * GICv3 save/restore
 * v7M QOMify

I've also included the Linux header update patches stolen
from Paolo's pullreq since it hasn't quite hit master yet.

thanks
-- PMM

The following changes since commit 1bbe5dc66b770d7bedd1d51d7935da948a510dd6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170228' into staging (2017-02-28 14:50:17 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170228-1

for you to fetch changes up to 1eeb5c7deacbfb4d4cad17590a16a99f3d85eabb:

  bcm2835: add sdhost and gpio controllers (2017-02-28 17:10:00 +0000)

----------------------------------------------------------------
target-arm queue:
 * raspi2: add gpio controller and sdhost controller, with
   the wiring so the guest can switch which controller the
   SD card is attached to
   (this is sufficient to get raspbian kernels to boot)
 * GICv3: support state save/restore from KVM
 * update Linux headers to 4.11
 * refactor and QOMify the ARMv7M container object

----------------------------------------------------------------
Clement Deschamps (3):
      hw/sd: add card-reparenting function
      bcm2835_gpio: add bcm2835 gpio controller
      bcm2835: add sdhost and gpio controllers

Paolo Bonzini (2):
      update-linux-headers: update for 4.11
      update Linux headers to 4.11

Peter Maydell (12):
      armv7m: Abstract out the "load kernel" code
      armv7m: Move NVICState struct definition into header
      armv7m: QOMify the armv7m container
      armv7m: Use QOMified armv7m object in armv7m_init()
      armv7m: Make ARMv7M object take memory region link
      armv7m: Make NVIC expose a memory region rather than mapping itself
      armv7m: Make bitband device take the address space to access
      armv7m: Don't put core v7M devices under CONFIG_STELLARIS
      armv7m: Split systick out from NVIC
      stm32f205: Create armv7m object without using armv7m_init()
      stm32f205: Rename 'nvic' local to 'armv7m'
      qdev: Have qdev_set_parent_bus() handle devices already on a bus

Vijaya Kumar K (4):
      hw/intc/arm_gicv3_kvm: Add ICC_SRE_EL1 register to vmstate
      hw/intc/arm_gicv3_kvm: Implement get/put functions
      target-arm: Add GICv3CPUState in CPUARMState struct
      hw/intc/arm_gicv3_kvm: Reset GICv3 cpu interface registers

 hw/gpio/Makefile.objs                              |   1 +
 hw/intc/Makefile.objs                              |   2 +-
 hw/timer/Makefile.objs                             |   1 +
 hw/intc/gicv3_internal.h                           |   3 +
 include/hw/arm/arm.h                               |  12 +
 include/hw/arm/armv7m.h                            |  63 +++
 include/hw/arm/armv7m_nvic.h                       |  62 ++
 include/hw/arm/bcm2835_peripherals.h               |   4 +
 include/hw/arm/stm32f205_soc.h                     |   4 +-
 include/hw/gpio/bcm2835_gpio.h                     |  39 ++
 include/hw/intc/arm_gicv3_common.h                 |   1 +
 include/hw/sd/sd.h                                 |  11 +
 include/hw/timer/armv7m_systick.h                  |  34 ++
 include/standard-headers/asm-x86/hyperv.h          |   8 +
 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |  25 +
 include/standard-headers/linux/virtio_ids.h        |   1 +
 linux-headers/asm-arm/kvm.h                        |  15 +
 linux-headers/asm-arm/unistd-common.h              | 357 ++++++++++++
 linux-headers/asm-arm/unistd-eabi.h                |   5 +
 linux-headers/asm-arm/unistd-oabi.h                |  17 +
 linux-headers/asm-arm/unistd.h                     | 419 +-------------
 linux-headers/asm-arm64/kvm.h                      |  13 +
 linux-headers/asm-powerpc/kvm.h                    |  27 +
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/kvm_para.h                   |  13 +-
 linux-headers/linux/kvm.h                          |  24 +-
 linux-headers/linux/kvm_para.h                     |   2 +
 linux-headers/linux/userfaultfd.h                  |  67 ++-
 linux-headers/linux/vfio.h                         |  10 +
 target/arm/cpu.h                                   |   2 +
 hw/arm/armv7m.c                                    | 379 ++++++++-----
 hw/arm/bcm2835_peripherals.c                       |  43 +-
 hw/arm/netduino2.c                                 |   7 +-
 hw/arm/stm32f205_soc.c                             |  28 +-
 hw/core/qdev.c                                     |  14 +
 hw/gpio/bcm2835_gpio.c                             | 353 ++++++++++++
 hw/intc/arm_gicv3_common.c                         |  38 ++
 hw/intc/arm_gicv3_cpuif.c                          |   8 +
 hw/intc/arm_gicv3_kvm.c                            | 629 ++++++++++++++++++++-
 hw/intc/armv7m_nvic.c                              | 214 ++-----
 hw/sd/core.c                                       |  27 +
 hw/timer/armv7m_systick.c                          | 240 ++++++++
 default-configs/arm-softmmu.mak                    |   2 +
 hw/timer/trace-events                              |   6 +
 scripts/update-linux-headers.sh                    |  13 +-
 46 files changed, 2479 insertions(+), 767 deletions(-)
 create mode 100644 include/hw/arm/armv7m.h
 create mode 100644 include/hw/arm/armv7m_nvic.h
 create mode 100644 include/hw/gpio/bcm2835_gpio.h
 create mode 100644 include/hw/timer/armv7m_systick.h
 create mode 100644 linux-headers/asm-arm/unistd-common.h
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h
 create mode 100644 hw/gpio/bcm2835_gpio.c
 create mode 100644 hw/timer/armv7m_systick.c
