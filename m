Received: from eggs.gnu.org ([2001:4830:134:3::10]:49236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNzYI-0004mX-9y
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNzYH-00059u-7q
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:46:02 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 30 May 2018 13:45:33 +0200
Message-Id: <1527680741-2725-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v3 0/8] KVM/ARM: Relax the max 123 vcpus
 limitation along with KVM GICv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: zhaoshenglong@huawei.com, christoffer.dall@arm.com, marc.zyngier@arm.com, drjones@redhat.com, wei@redhat.com

Currently the max number of VCPUs usable along with the KVM GICv3
device is limited to 123. The rationale is a single redistributor
region was supported and this latter was set to [0x80A0000, 0x9000000]
within the guest physical address space, surrounded with DIST and UART
MMIO regions.

[1] now allows to register several redistributor regions.
So this series overcomes the max 123 vcpu limitation by registering
a new redistributor region located just after the VIRT_MEM RAM region.
This second redistributor region has a capacity of 512 redistributors.

The max supported VCPUs in non accelerated mode is not modified.

Best Regards

Eric

Host Kernel dependencies:
[1] [PATCH v6 00/12] KVM: arm/arm64: Allow multiple GICv3 redistributor
    regions
https://github.com/eauger/linux/tree/v4.17-rc2-rdist-regions-v6

This QEMU series can be found at:
https://github.com/eauger/qemu/tree/v2.12.0-rdist_regions-rfc-v3
Previous version:
https://github.com/eauger/qemu/tree/v2.12.0-rdist_regions-rfc-v2

History:
v2 -> v3:
- Added the last patch defining 3.0 machine type and setting
  max_cpus to 512
- redistributor region total count exactly matching the number
  of requested vcpus
- added missing return in arm_gic_realize
- checked redist region capacity versus #vcpus earlier in
  gicv3_init_irqs_and_mmio
- use GICV3_REDIST_SIZE
- Changed the 2d region size to 64MB

v1 -> v2:
- Do not use KVM_MAX_VCPUS anymore
- In case the multiple redistributor region capability is not
  supported by the host kernel, the GICv3 device realize() fails
  with a hint for the end-user.
- use properties to set the redistributor region count
- sysbus_mmio_map is kept in virt and machine init done notifier
  mechanism is used with an address fixup addition.
- I have not yet extended the second redist region as Peter suggested.
  We can easily add another 3th region later on if requested. But
  if mandated, I will fix that in next release.


Eric Auger (8):
  linux-headers: Partial update for KVM/ARM multiple redistributor
    region registration
  target/arm: Allow KVM device address overwriting
  hw/intc/arm_gicv3: Introduce redist-region-count array property
  hw/intc/arm_gicv3_kvm: Get prepared to handle multiple redist regions
  hw/arm/virt: GICv3 DT node with one or two redistributor regions
  hw/arm/virt-acpi-build: Advertise one or two GICR structures
  hw/arm/virt: Register two redistributor regions when necessary
  hw/arm/virt: Add virt-3.0 machine type supporting up to 512 vcpus

 hw/arm/virt-acpi-build.c           |  9 ++++
 hw/arm/virt.c                      | 88 ++++++++++++++++++++++++++++++++------
 hw/intc/arm_gic_kvm.c              |  4 +-
 hw/intc/arm_gicv3.c                | 12 +++++-
 hw/intc/arm_gicv3_common.c         | 38 +++++++++++++---
 hw/intc/arm_gicv3_its_kvm.c        |  2 +-
 hw/intc/arm_gicv3_kvm.c            | 40 +++++++++++++++--
 include/hw/arm/virt.h              | 14 ++++++
 include/hw/intc/arm_gicv3_common.h |  8 +++-
 linux-headers/asm-arm/kvm.h        |  1 +
 linux-headers/asm-arm64/kvm.h      |  1 +
 target/arm/kvm.c                   | 10 ++++-
 target/arm/kvm_arm.h               |  3 +-
 13 files changed, 200 insertions(+), 30 deletions(-)

-- 
2.5.5
