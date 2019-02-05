Received: from eggs.gnu.org ([209.51.188.92]:46408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gr4bE-0008BA-NV
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gr4bC-0003tM-Ne
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:33:32 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue,  5 Feb 2019 18:32:48 +0100
Message-Id: <20190205173306.20483-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/18] ARM virt: Initial RAM expansion and
 PCDIMM/NVDIMM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

This series aims to bump the 255GB RAM limit in machvirt and to
support device memory in general, and especially PCDIMM/NVDIMM.

In machvirt versions < 4.0, the initial RAM starts at 1GB and can
grow up to 255GB. From 256GB onwards we find IO regions such as the
additional GICv3 RDIST region, high PCIe ECAM region and high PCIe
MMIO region. The address map was 1TB large. This corresponded to
the max IPA capacity KVM was able to manage.

Since 4.20, the host kernel is able to support a larger and dynamic
IPA range. So the guest physical address can go beyond the 1TB. The
max GPA size depends on the host kernel configuration and physical CPUs.

In this series we use this feature and allow the RAM to grow without
any other limit than the one put by the host.

The RAM still starts at 1GB. First comes the initial ram (-m) of size
ram_size and then comes the device memory (,maxmem) of size
maxram_size - ram_size. The device memory is potentially hotpluggable
depending on the instantiated memory objects.

IO regions previously located between 256GB and 1TB are moved after
the RAM. Their offset is dynamically computed, depends on ram_size
and maxram_size. Size alignment is enforced.

In case maxmem value is inferior to 255GB, the legacy memory map
still is used. The change of memory map becomes effective from 4.0
onwards.

As we keep the initial RAM at 1GB base address, we do not need to do
invasive changes in the EDK2 FW. It seems nobody is eager to do
that job at the moment.

Device memory being put just after the initial RAM, it is possible
to get access to this feature while keeping a 1TB address map.

This series reuses/rebases patches initially submitted by Shameer
in [1] and Kwangwoo in [2] for the PC-DIMM and NV-DIMM parts.

Functionally, the series is split into 3 parts:
1) bump of the initial RAM limit [1 - 10] and change in
   the memory map
2) Support of PC-DIMM [11 - 14]
3) Support of NV-DIMM [15 - 18]

1) can be upstreamed before 2 and 2 can be upstreamed before 3.

Work is ongoing to transform the whole memory as device memory.
However this move is not trivial and to me, is independent on
the improvements brought by this series:
- if we were to use DIMM for initial RAM, those DIMMs would use
  use slots. Although they would not be part of the ones provided
  using the ",slots" options, they are ACPI limited resources.
- DT and ACPI description needs to be reworked
- NUMA integration needs special care
- a special device memory object may be required to avoid consuming
  slots and easing the FW description.

So I preferred to separate the concerns. This new implementation
based on device memory could be candidate for another virt
version.

Best Regards

Eric

References:

[0] [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
http://patchwork.ozlabs.org/cover/914694/

[1] [RFC PATCH 0/3] add nvdimm support on AArch64 virt platform
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04599.html

This series can be found at:
https://github.com/eauger/qemu/tree/v3.1.0-dimm-v6

Tests:
- On HPE system, allocated a VM with 300GB initial RAM and 220 vcpus
- tested on kernel versions not supporting variable IPA range
- tested with different virt versions

History:

v5 -> v6:
- mingw compilation issue fix
- kvm_arm_get_max_vm_phys_shift always returns the number of supported
  IPA bits
- new patch "hw/arm/virt: Rename highmem IO regions" that eases the revie=
w
  of "hw/arm/virt: Split the memory map description"
- "hw/arm/virt: Move memory map initialization into machvirt_init"
  squashed into the previous patch
- change alignment of IO regions beyond the RAM so that it matches their
  size

v4 -> v5:
- change in the memory map
- see individual logs

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

Alexey Kardashevskiy (1):
  update-linux-headers.sh: Copy new headers

Eric Auger (12):
  linux-headers: Update to v5.0-rc2
  hw/arm/virt: Rename highmem IO regions
  hw/arm/virt: Split the memory map description
  hw/boards: Add a MachineState parameter to kvm_type callback
  kvm: add kvm_arm_get_max_vm_phys_shift
  vl: Set machine ram_size, maxram_size and ram_slots earlier
  hw/arm/virt: Implement kvm_type function for 4.0 machine
  hw/arm/virt: Bump the 255GB initial RAM limit
  hw/arm/virt: Add memory hotplug framework
  hw/arm/virt: Allocate device_memory
  hw/arm/boot: Expose the pmem nodes in the DT
  hw/arm/virt: Add nvdimm and nvdimm-persistence options

Kwangwoo Lee (2):
  nvdimm: use configurable ACPI IO base and size
  hw/arm/virt: Add nvdimm hot-plug infrastructure

Shameer Kolothum (3):
  hw/arm/boot: introduce fdt_add_memory_node helper
  hw/arm/boot: Expose the PC-DIMM nodes in the DT
  hw/arm/virt-acpi-build: Add PC-DIMM in SRAT

 accel/kvm/kvm-all.c                           |    2 +-
 default-configs/arm-softmmu.mak               |    4 +
 hw/acpi/nvdimm.c                              |   28 +-
 hw/arm/boot.c                                 |  120 +-
 hw/arm/virt-acpi-build.c                      |   23 +-
 hw/arm/virt.c                                 |  311 ++++-
 hw/i386/pc_piix.c                             |    8 +-
 hw/i386/pc_q35.c                              |    8 +-
 hw/ppc/mac_newworld.c                         |    3 +-
 hw/ppc/mac_oldworld.c                         |    2 +-
 hw/ppc/spapr.c                                |    2 +-
 include/hw/arm/virt.h                         |   21 +-
 include/hw/boards.h                           |    2 +-
 include/hw/mem/nvdimm.h                       |   12 +
 include/standard-headers/drm/drm_fourcc.h     |   63 +
 include/standard-headers/linux/ethtool.h      |   19 +-
 .../linux/input-event-codes.h                 |   19 +
 include/standard-headers/linux/pci_regs.h     |    1 +
 .../standard-headers/linux/virtio_balloon.h   |    8 +
 include/standard-headers/linux/virtio_blk.h   |   54 +
 .../standard-headers/linux/virtio_config.h    |    3 +
 include/standard-headers/linux/virtio_gpu.h   |   18 +
 include/standard-headers/linux/virtio_ring.h  |   52 +
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |    1 +
 linux-headers/asm-arm/unistd-common.h         |    1 +
 linux-headers/asm-arm64/unistd.h              |    1 +
 linux-headers/asm-generic/unistd.h            |   10 +-
 linux-headers/asm-mips/sgidefs.h              |    8 -
 linux-headers/asm-mips/unistd.h               | 1074 +----------------
 linux-headers/asm-mips/unistd_n32.h           |  338 ++++++
 linux-headers/asm-mips/unistd_n64.h           |  334 +++++
 linux-headers/asm-mips/unistd_o32.h           |  374 ++++++
 linux-headers/asm-powerpc/unistd.h            |  389 +-----
 linux-headers/asm-powerpc/unistd_32.h         |  381 ++++++
 linux-headers/asm-powerpc/unistd_64.h         |  372 ++++++
 linux-headers/linux/kvm.h                     |   29 +
 linux-headers/linux/vfio.h                    |   92 ++
 linux-headers/linux/vhost.h                   |  113 +-
 linux-headers/linux/vhost_types.h             |  128 ++
 scripts/update-linux-headers.sh               |   11 +-
 target/arm/kvm.c                              |   10 +
 target/arm/kvm_arm.h                          |   13 +
 vl.c                                          |    6 +-
 43 files changed, 2797 insertions(+), 1671 deletions(-)
 create mode 100644 linux-headers/asm-mips/unistd_n32.h
 create mode 100644 linux-headers/asm-mips/unistd_n64.h
 create mode 100644 linux-headers/asm-mips/unistd_o32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_64.h
 create mode 100644 linux-headers/linux/vhost_types.h

--=20
2.20.1
