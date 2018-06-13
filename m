Received: from eggs.gnu.org ([2001:4830:134:3::10]:56355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fT1Sf-00027i-8A
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fT1Sd-0003qR-QS
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:49:01 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 13 Jun 2018 10:48:34 +0200
Message-Id: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] KVM/ARM: virt-3.0: Multiple redistributor
 regions and 256MB ECAM region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com

This series increases the number of vcpus usable in accelerated mode
along with GICv3 and allows up to 256 PCIe busses.

It is a combination of 2 series:
[1] [RFC v3 0/8] KVM/ARM: Relax the max 123 vcpus limitation along
    with KVM GICv3
[2] [PATCH 0/2] ARM virt: Support up to 256 PCIe buses

Both add features to the 3.0 virt machine.

VCPU changes:
-------------

Currently the max number of VCPUs usable along with the KVM GICv3
device is limited to 123. The rationale is a single redistributor
region was supported and this latter was set to [0x80A0000, 0x9000000]
within the guest physical address space, surrounded with DIST and UART
MMIO regions.

The 4.18 host kernel now allows to register several redistributor regions.
So this series overcomes the max 123 vcpu limitation by registering
a new redistributor region located just after the VIRT_MEM RAM region.
This second redistributor region has a capacity of 512 redistributors.

The max supported VCPUs in non accelerated mode is not modified.

PCIe BUS changes:
-----------------

Current Machvirt PCI host controller's ECAM region is 16MB large.
This limits the number of PCIe buses to 16.

PC/Q35 machines have a 256MB region allowing up to 256 buses.
This series tries to bridge the gap.

It declares a new ECAM region located beyond 256GB, of size 256MB
The new ECAM region is used if:
- highmem option is set (default) and,
- either FW is not loaded or we are run an aarch64 guest
- machine type >= 3.0.

aarch32 FW does not support this highmem ECAM region. For guests
without LPAE support the highmem option must be turned off.

Best Regards

Eric

This QEMU series can be found at:
Previous version:
https://github.com/eauger/qemu/tree/v2.12.0-virt3.0-v1

Eric Auger (9):
  linux-headers: Update to 4.18-rc0
  target/arm: Allow KVM device address overwriting
  hw/intc/arm_gicv3: Introduce redist-region-count array property
  hw/intc/arm_gicv3_kvm: Get prepared to handle multiple redist regions
  hw/arm/virt: GICv3 DT node with one or two redistributor regions
  hw/arm/virt-acpi-build: Advertise one or two GICR structures
  hw/arm/virt: Register two redistributor regions when necessary
  hw/arm/virt: Add a new 256MB ECAM region
  hw/arm/virt: Add virt-3.0 machine type

 hw/arm/virt-acpi-build.c                           |  30 ++++--
 hw/arm/virt.c                                      | 104 +++++++++++++++++----
 hw/intc/arm_gic_kvm.c                              |   4 +-
 hw/intc/arm_gicv3.c                                |  12 ++-
 hw/intc/arm_gicv3_common.c                         |  38 +++++++-
 hw/intc/arm_gicv3_its_kvm.c                        |   2 +-
 hw/intc/arm_gicv3_kvm.c                            |  40 +++++++-
 include/hw/arm/virt.h                              |  17 ++++
 include/hw/intc/arm_gicv3_common.h                 |   8 +-
 include/standard-headers/linux/pci_regs.h          |   8 ++
 include/standard-headers/linux/virtio_gpu.h        |   1 +
 include/standard-headers/linux/virtio_net.h        |   3 +
 .../LICENSES/exceptions/Linux-syscall-note         |   2 +-
 linux-headers/LICENSES/preferred/GPL-2.0           |   6 ++
 linux-headers/asm-arm/kvm.h                        |   1 +
 linux-headers/asm-arm/unistd-common.h              |   1 +
 linux-headers/asm-arm64/kvm.h                      |   1 +
 linux-headers/asm-generic/unistd.h                 |   4 +-
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/unistd_32.h                  |   2 +
 linux-headers/asm-x86/unistd_64.h                  |   2 +
 linux-headers/asm-x86/unistd_x32.h                 |   2 +
 linux-headers/linux/kvm.h                          |   5 +-
 linux-headers/linux/psp-sev.h                      |  12 +++
 target/arm/kvm.c                                   |  10 +-
 target/arm/kvm_arm.h                               |   3 +-
 26 files changed, 274 insertions(+), 45 deletions(-)

-- 
2.5.5
