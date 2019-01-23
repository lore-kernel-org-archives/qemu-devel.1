Received: from eggs.gnu.org ([209.51.188.92]:36088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFei-0005qF-To
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFeh-0001fD-Iw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:21:12 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:40 +0100
Message-Id: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/18] ARM virt: Initial RAM expansion and
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

This is a respin of [RFC v4 00/16] ARM virt: PCDIMM/NVDIMM at 2TB

This series aims to bump the 255GB RAM limit in machvirt and to
support device memory in general, and especially PCDIMM/NVDIMM.

Compared to v4, we now put all the memory at 1GB: first comes the
initial ram (-m) of size ram_size and then comes the device memory
(,maxmem) of size maxram_size - ram_size. The device memory is
potentially hotpluggable depending on the instantiated memory
objects.

IO regions currently located between 256GB and 1TB are moved after
the RAM. The IO offset obviously depends on ram_size/maxram_size
values. So this is a change of memory map that would become effective
from 4.0 onwards.

An enabler for this series is the support of dynamic IPA range at
KVM/ARM level. The RAM capacity then depends on pCPU and host kernel.

As we keep the initial RAM at 1GB base address, we do not need to do
invasive changes in the EDK2 FW. It seems nobody is eager to do
that job at the moment.

This series reuses/rebases patches initially submitted by Shameer
in [1] and Kwangwoo in [2] for the PC-DIMM and NV-DIMM parts.

Functionally the series could be split into 3 parts:
1) bump of the initial RAM limit [1 - 10] and change in
   the memory map
2) Support of PC-DIMM [11 - 14]
3) Support of NV-DIMM [15 - 18]

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
https://github.com/eauger/qemu/tree/v3.1.0-dimm-v5

History:

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

Alexey Kardashevskiy (1):
  update-linux-headers.sh: Copy new headers

Eric Auger (12):
  linux-headers: Update to v5.0-rc2
  hw/arm/virt: Split the memory map description
  hw/arm/virt: Move memory map initialization into machvirt_init
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
 hw/arm/virt-acpi-build.c                      |   22 +-
 hw/arm/virt.c                                 |  278 ++++-
 hw/i386/pc_piix.c                             |    8 +-
 hw/i386/pc_q35.c                              |    8 +-
 hw/ppc/mac_newworld.c                         |    3 +-
 hw/ppc/mac_oldworld.c                         |    2 +-
 hw/ppc/spapr.c                                |    2 +-
 include/hw/arm/virt.h                         |   20 +-
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
 target/arm/kvm.c                              |    8 +
 target/arm/kvm_arm.h                          |   16 +
 vl.c                                          |    6 +-
 43 files changed, 2764 insertions(+), 1670 deletions(-)
 create mode 100644 linux-headers/asm-mips/unistd_n32.h
 create mode 100644 linux-headers/asm-mips/unistd_n64.h
 create mode 100644 linux-headers/asm-mips/unistd_o32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_32.h
 create mode 100644 linux-headers/asm-powerpc/unistd_64.h
 create mode 100644 linux-headers/linux/vhost_types.h

--=20
2.20.1
