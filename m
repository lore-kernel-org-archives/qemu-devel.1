Received: from eggs.gnu.org ([2001:4830:134:3::10]:35971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Ke-0005cO-43
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9KT-0006eC-DA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:19 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:26 +0200
Message-Id: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 00/16] ARM virt: PCDIMM/NVDIMM at 2TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

This series aims at supporting PCDIMM/NVDIMM intantiation in
mach-virt at 2TB guest physical address.

This is not material for 3.1.

Although there is another implementation alternative under
discussion on the ML, consisting in having a single device memory
region with a floating base, I continue to maintain this series
until all dependencies get resolved and this other solution gets
fully prototyped.

Here we consider that the top of the address map is the top of
the device memory starting at 2TB and whose size is defined
by maxram_size - ram_size.

We create a KVM machine with an IPA range including the top of
the device memory. Suzuki's kernel series [0] allows that settings.
In can be found on kvmarm/next branch and this branch was used for
testing.

Then the series adds the device memory framework to mach-virt
and brings support for PC-DIMM and NV-DIMM frontend devices.

This series reuses/rebases patches initially submitted by Shameer
in [1] and Kwangwoo in [2] for the PC-DIMM and NV-DIMM parts.

Notes:
- The EDK2 FW still hardcodes the max PA size to 40 bits
- The TCG machine limits the PA according to the id_aa64mmfr0 register
  PARange field. At the moment the PARange is hardcoded to 40bits for
  the A53 CPU and to 44 bits for the A57. So only an A57 based machine
  would be able to expose device memory. This consisteny check is not
  yet handled. We could think about adding the support for the phys-bit
  CPU option to set the id_aa64mmfr0.parange.

The series includes "hw/arm/boot: introduce fdt_add_memory_node
helper" which was sent separately.

Best Regards

Eric

References:

[0] [PATCH v6 00/18] arm64: Dynamic & 52bit IPA support
https://lkml.org/lkml/2018/9/26/936
kvmarm next branch can be used for testing

[1] [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
http://patchwork.ozlabs.org/cover/914694/

[2] [RFC PATCH 0/3] add nvdimm support on AArch64 virt platform
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04599.html

Tests:
- On Cavium Gigabyte, a 48b KVM accelerated VM was created.
- PC-DIMM was tested with memtester
- NV-DIMM was tested with ndctl and an ext4 DAX FS was installed on
  guest

This series can be found at:
https://github.com/eauger/qemu/tree/v3.0.0-dimm-2tb-v4

History:

v3 -> v4:
- rebase on David's "pc-dimm: next bunch of cleanups" and
  "pc-dimm: pre_plug "slot" and "addr" assignment"
- kvm-type option not used anymore. We directly use
  maxram_size and ram_size machine fields to compute the
  MAX IPA range. Migration is naturally handled as CLI
  option are kept between source and destination. This was
  suggested by David.
- device_memory_start and device_memory_size not stored
  anymore in vms->bootinfo
- I did not take into account 2 Igor's comments: the one
  related to the refactoring of arm_load_dtb and the one
  related to the generation of the dtb after system_reset
  which would contain nodes of hotplugged devices (we do
  not support hotplug at this stage)
- check the end-user does not attempt to hotplug a device
- addition of "vl: Set machine ram_size, maxram_size and
  ram_slots earlier"

v2 -> v3:
- fix pc_q35 and pc_piix compilation error
- kwangwoo's email being not valid anymore, remove his address

v1 -> v2:
- kvm_get_max_vm_phys_shift moved in arch specific file
- addition of NVDIMM part
- single series
- rebase on David's refactoring

v1:
- was "[RFC 0/6] KVM/ARM: Dynamic and larger GPA size"
- was "[RFC 0/5] ARM virt: Support PC-DIMM at 2TB"

Best Regards

Eric

Eric Auger (10):
  linux-headers: header update for KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
  hw/boards: Add a MachineState parameter to kvm_type callback
  kvm: add kvm_arm_get_max_vm_phys_shift
  vl: Set machine ram_size, maxram_size and ram_slots earlier
  hw/arm/virt: Add virt-3.2 machine type
  hw/arm/virt: Implement kvm_type function for 3.2 machine
  hw/arm/virt: Allocate device_memory
  acpi: move build_srat_hotpluggable_memory to generic ACPI source
  hw/arm/boot: Expose the pmem nodes in the DT
  hw/arm/virt: Add nvdimm and nvdimm-persistence options

Kwangwoo Lee (2):
  nvdimm: use configurable ACPI IO base and size
  hw/arm/virt: Add nvdimm hot-plug infrastructure

Shameer Kolothum (4):
  hw/arm/boot: introduce fdt_add_memory_node helper
  hw/arm/virt: Add memory hotplug framework
  hw/arm/boot: Expose the PC-DIMM nodes in the DT
  hw/arm/virt-acpi-build: Add PC-DIMM in SRAT

 accel/kvm/kvm-all.c             |   2 +-
 default-configs/arm-softmmu.mak |   4 +
 hw/acpi/aml-build.c             |  51 ++++++
 hw/acpi/nvdimm.c                |  28 ++-
 hw/arm/boot.c                   | 120 ++++++++++---
 hw/arm/virt-acpi-build.c        |  10 ++
 hw/arm/virt.c                   | 302 ++++++++++++++++++++++++++++----
 hw/i386/pc_piix.c               |   8 +-
 hw/i386/pc_q35.c                |   8 +-
 hw/ppc/mac_newworld.c           |   3 +-
 hw/ppc/mac_oldworld.c           |   2 +-
 hw/ppc/spapr.c                  |   2 +-
 include/hw/acpi/aml-build.h     |   3 +
 include/hw/arm/virt.h           |   5 +
 include/hw/boards.h             |   2 +-
 include/hw/mem/nvdimm.h         |  12 ++
 linux-headers/linux/kvm.h       |  10 ++
 target/arm/kvm.c                |   8 +
 target/arm/kvm_arm.h            |  16 ++
 vl.c                            |   6 +-
 20 files changed, 530 insertions(+), 72 deletions(-)

-- 
2.17.1
