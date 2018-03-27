Received: from eggs.gnu.org ([2001:4830:134:3::10]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pO7-00032M-9w
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pO6-0006XI-4i
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:47 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:14 +0200
Message-Id: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 0/8] KVM/ARM: Relax the max 123 vcpus limitation
 along with KVM GICv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, marc.zyngier@arm.com, cdall@kernel.org, zhaoshenglong@huawei.com

Currently the max number of VCPUs usable along with the KVM GICv3
device is limited to 123. The rationale is a single redistributor
region was supported and this latter was set to [0x80A0000, 0x9000000]
within the guest physical address space, surrounded with DIST and UART
MMIO regions.

[1] now allows to register several redistributor regions.
So this series overcomes the max 123 vcpu limitation by registering
a new redistributor region located just after the VIRT_MEM RAM region.
The total redistributor region capacity is set to 512 vcpus.

The max supported VCPUs in non accelerated mode is not modified.

Best Regards

Eric

Host Kernel dependencies:
[1] [RFC v2 00/12] KVM: arm/arm64: Allow multiple GICv3 redistributor regions
https://github.com/eauger/linux/tree/4.16-rc7-rdist-regions-rfc-v2

This QEMU series can be found at:
https://github.com/eauger/qemu/tree/v2.12.0-rc0-rdist_regions-rfc

Eric Auger (8):
  linux-headers: Partial update for KVM/ARM multiple redistributor
    region registration
  hw/intc/arm_gicv3: Use an array of redistributor regions
  kvm: Expose kvm_max_vcpus()
  hw/intc/arm_gicv3: Implement register_redist_region API
  hw/intc/arm_gicv3_kvm: Allow multiple redistributor regions
  hw/arm/virt: Allow GICv3 DT node with multiple redistributor regions
  hw/arm/virt-acpi-build: Handle multiple GICR structures
  hw/arm/virt: Allow up to 512 vcpus along with KVM VGICv3

 accel/kvm/kvm-all.c                |  2 +-
 accel/stubs/kvm-stub.c             |  5 ++++
 hw/arm/virt-acpi-build.c           | 21 ++++++++++----
 hw/arm/virt.c                      | 55 +++++++++++++++++++++++++++++++-----
 hw/intc/arm_gicv3.c                | 21 ++++++++++++++
 hw/intc/arm_gicv3_common.c         |  9 ++++--
 hw/intc/arm_gicv3_kvm.c            | 57 ++++++++++++++++++++++++++++++++++++--
 include/hw/arm/virt.h              |  3 ++
 include/hw/intc/arm_gicv3_common.h | 14 +++++++++-
 include/sysemu/kvm.h               |  7 +++++
 linux-headers/asm-arm/kvm.h        |  7 +++--
 linux-headers/asm-arm64/kvm.h      |  7 +++--
 12 files changed, 182 insertions(+), 26 deletions(-)

-- 
2.5.5
