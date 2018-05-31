Received: from eggs.gnu.org ([2001:4830:134:3::10]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOQ0J-000133-Tj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOQ0I-0000j7-Ol
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:00:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOQ0I-0000hF-GH
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:00:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOQ0G-00034F-Ow
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:00:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 17:00:39 +0100
Message-Id: <20180531160039.29304-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue. This has the "plumb txattrs through various
bits of exec.c" patches, and a collection of bug fixes from
various people.

v2: fix compile error on arm hosts...

thanks
-- PMM


The following changes since commit a3ac12fba028df90f7b3dbec924995c126c41022:

  Merge remote-tracking branch 'remotes/ehabkost/tags/numa-next-pull-request' into staging (2018-05-31 11:12:36 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180531-1

for you to fetch changes up to 2f15b79280cf71b7991dfd3f0312a1797630e376:

  KVM: GIC: Fix memory leak due to calling kvm_init_irq_routing twice (2018-05-31 16:32:35 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Honour FPCR.FZ in FRECPX
 * MAINTAINERS: Add entries for newer MPS2 boards and devices
 * hw/intc/arm_gicv3: Fix APxR<n> register dispatching
 * arm_gicv3_kvm: fix bug in writing zero bits back to the in-kernel
   GIC state
 * tcg: Fix helper function vs host abi for float16
 * arm: fix qemu crash on startup with -bios option
 * arm: fix malloc type mismatch
 * xlnx-zdma: Correct mem leaks and memset to zero on desc unaligned errors
 * Correct CPACR reset value for v7 cores
 * memory.h: Improve IOMMU related documentation
 * exec: Plumb transaction attributes through various functions in
   preparation for allowing IOMMUs to see them
 * vmstate.h: Provide VMSTATE_BOOL_SUB_ARRAY
 * ARM: ACPI: Fix use-after-free due to memory realloc
 * KVM: GIC: Fix memory leak due to calling kvm_init_irq_routing twice

----------------------------------------------------------------
Francisco Iglesias (1):
      xlnx-zdma: Correct mem leaks and memset to zero on desc unaligned errors

Igor Mammedov (1):
      arm: fix qemu crash on startup with -bios option

Jan Kiszka (1):
      hw/intc/arm_gicv3: Fix APxR<n> register dispatching

Paolo Bonzini (1):
      arm: fix malloc type mismatch

Peter Maydell (17):
      target/arm: Honour FPCR.FZ in FRECPX
      MAINTAINERS: Add entries for newer MPS2 boards and devices
      Correct CPACR reset value for v7 cores
      memory.h: Improve IOMMU related documentation
      Make tb_invalidate_phys_addr() take a MemTxAttrs argument
      Make address_space_translate{, _cached}() take a MemTxAttrs argument
      Make address_space_map() take a MemTxAttrs argument
      Make address_space_access_valid() take a MemTxAttrs argument
      Make flatview_extend_translation() take a MemTxAttrs argument
      Make memory_region_access_valid() take a MemTxAttrs argument
      Make MemoryRegion valid.accepts callback take a MemTxAttrs argument
      Make flatview_access_valid() take a MemTxAttrs argument
      Make flatview_translate() take a MemTxAttrs argument
      Make address_space_get_iotlb_entry() take a MemTxAttrs argument
      Make flatview_do_translate() take a MemTxAttrs argument
      Make address_space_translate_iommu take a MemTxAttrs argument
      vmstate.h: Provide VMSTATE_BOOL_SUB_ARRAY

Richard Henderson (1):
      tcg: Fix helper function vs host abi for float16

Shannon Zhao (3):
      arm_gicv3_kvm: increase clroffset accordingly
      ARM: ACPI: Fix use-after-free due to memory realloc
      KVM: GIC: Fix memory leak due to calling kvm_init_irq_routing twice

 include/exec/exec-all.h        |   5 +-
 include/exec/helper-head.h     |   2 +-
 include/exec/memory-internal.h |   3 +-
 include/exec/memory.h          | 128 +++++++++++++++++++++++++++++++++++------
 include/migration/vmstate.h    |   3 +
 include/sysemu/dma.h           |   6 +-
 accel/tcg/translate-all.c      |   4 +-
 exec.c                         |  95 ++++++++++++++++++------------
 hw/arm/boot.c                  |  18 +++---
 hw/arm/virt-acpi-build.c       |  20 +++++--
 hw/dma/xlnx-zdma.c             |  10 +++-
 hw/hppa/dino.c                 |   3 +-
 hw/intc/arm_gic_kvm.c          |   1 -
 hw/intc/arm_gicv3_cpuif.c      |  12 ++--
 hw/intc/arm_gicv3_kvm.c        |   2 +-
 hw/nvram/fw_cfg.c              |  12 ++--
 hw/s390x/s390-pci-inst.c       |   3 +-
 hw/scsi/esp.c                  |   3 +-
 hw/vfio/common.c               |   3 +-
 hw/virtio/vhost.c              |   3 +-
 hw/xen/xen_pt_msi.c            |   3 +-
 memory.c                       |  12 ++--
 memory_ldst.inc.c              |  18 +++---
 target/arm/gdbstub.c           |   3 +-
 target/arm/helper-a64.c        |  41 +++++++------
 target/arm/helper.c            |  90 ++++++++++++++++-------------
 target/arm/kvm.c               |   3 +-
 target/ppc/mmu-hash64.c        |   3 +-
 target/riscv/helper.c          |   2 +-
 target/s390x/diag.c            |   6 +-
 target/s390x/excp_helper.c     |   3 +-
 target/s390x/mmu_helper.c      |   3 +-
 target/s390x/sigp.c            |   3 +-
 target/xtensa/op_helper.c      |   3 +-
 MAINTAINERS                    |   9 ++-
 35 files changed, 355 insertions(+), 183 deletions(-)
