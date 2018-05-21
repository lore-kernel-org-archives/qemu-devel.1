Received: from eggs.gnu.org ([2001:4830:134:3::10]:42898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQO-0002wB-9y
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQM-00015L-Ci
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:32 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:35 +0100
Message-Id: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/27] iommu: support txattrs,
 support TCG execution, implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This patchset is a rather large one, but the first half is all
fairly simple plumbing. It does four things:
 * support IOMMUs that are aware of memory transaction attributes and
   may generate different translations for different attributes
 * support TCG execution out of memory which is behind an IOMMU
 * implement the Arm TrustZone Memory Protection Controller
   (which needs both the above features in the IOMMU core code)
 * use the MPC in the mps2-an505 board

I'm happy to split this up (eg taking the IOMMU core code
changes through Paolo's tree and then the MPS stuff via
target-arm), but I figured it would be useful to see the
reason and the user of the new APIs in the same series.


Patch 1 is my "improve the IOMMU API documentation" patch (included
here because otherwise the added API documentation for new methods
would conflict).

Patches 2-13 are the boring plumbing: we pass down MemTxAttrs
through enough of the memory subsystem that we have access to
them at the point where we call the IOMMU translate method.
(A previous version of these was posted separately; I've rebased
them and updated to account for new changes in the code since then,
but the general principles remain the same.)

Patches 14, 15 and 16 add the support for memory-transaction-aware
IOMMUs. The general approach is that we have the concept of an
IOMMU index (similar to the TCG MMU index), which selects which of
multiple possible translation tables in the IOMMU we're trying to use.
Most IOMMUs will support just a single index. When you register an
IOMMU notifier and when you call the translate method you have to
specify which IOMMU index you want. There's a method for getting the
index that applies for a particular set of transaction attributes.
All the current IOMMU implementations have just one iommu index, and
all the current users of the notify API assume that.

Patch 17 adds the support for TCG execution from memory that sits
behind an IOMMU. We do this in a fairly simple way on the assumption
that changes to the IOMMU config at runtime will be fairly uncommon:
we just flush the CPU TLB so it forgets about any cached results
when we get an IOMMU unmap notification. (This is similar to how
we handle reconfigurations of the memory map done by mapping or
unmapping MemoryRegions.) NB: I'm not completely sure that calling
tlb_flush() here is sufficient to be non-racy in the case where CPU A
has triggered the IOMMU unmap notify by changing the IOMMU config
while CPU B is executing from memory behind the IOMMU, but tlb_flush()
is what tcg_commit() uses so I guess it's OK. I think the idea here
is that any delay in flushing B's TLB is just equivalent to B having
executed a little bit further before A got to changing the config?

Patches 18-21 implement the TrustZone Memory Protection Controller,
which is a fairly simple piece of hardware that just configurably
either allows or blocks transactions depending on attrs.secure.

Patches 22 and 23 deal with a limitation in our or-irq device, which
currently only allows 16 input lines (we need 17 for one of the OR
gates in the IoTKit object). The patches raise the limit to 32, but
in a way that means we can easily raise it further in future without
migration compatibility problems.

Patches 24-27 add MPCs to the IoTKit SoC object and to the mps2-an505
board model, and wire them up appropriately.

Based-on: 20180518153157.14899-1-peter.maydell@linaro.org
[MAINTAINERS: Add entries for newer MPS2 boards and devices]
purely to avoid the textual conflict when we add MAINTAINERS entries




Peter Maydell (27):
  memory.h: Improve IOMMU related documentation
  Make tb_invalidate_phys_addr() take a MemTxAttrs argument
  Make address_space_translate{,_cached}() take a MemTxAttrs argument
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
  iommu: Add IOMMU index concept to IOMMU API
  iommu: Add IOMMU index argument to notifier APIs
  iommu: Add IOMMU index argument to translate method
  exec.c: Handle IOMMUs in address_space_translate_for_iotlb()
  hw/misc/tz-mpc.c: Implement the Arm TrustZone Memory Protection
    Controller
  hw/misc/tz-mpc.c: Implement registers
  hw/misc/tz-mpc.c: Implement correct blocked-access behaviour
  hw/misc/tz_mpc.c: Honour the BLK_LUT settings in translate
  vmstate.h: Provide VMSTATE_BOOL_SUB_ARRAY
  hw/core/or-irq: Support more than 16 inputs to an OR gate
  hw/misc/iotkit-secctl.c: Implement SECMPCINTSTATUS
  hw/arm/iotkit: Instantiate MPC
  hw/arm/iotkit: Wire up MPC interrupt lines
  hw/arm/mps2-tz.c: Instantiate MPCs

 hw/misc/Makefile.objs           |   1 +
 include/exec/exec-all.h         |   8 +-
 include/exec/memory-internal.h  |   3 +-
 include/exec/memory.h           | 194 ++++++++--
 include/hw/arm/iotkit.h         |   8 +
 include/hw/misc/iotkit-secctl.h |   8 +
 include/hw/misc/tz-mpc.h        |  80 +++++
 include/hw/or-irq.h             |   5 +-
 include/migration/vmstate.h     |   3 +
 include/qom/cpu.h               |   3 +
 include/sysemu/dma.h            |   6 +-
 accel/tcg/cputlb.c              |   3 +-
 accel/tcg/translate-all.c       |   4 +-
 exec.c                          | 254 +++++++++++---
 hw/alpha/typhoon.c              |   3 +-
 hw/arm/iotkit.c                 | 112 +++++-
 hw/arm/mps2-tz.c                |  71 ++--
 hw/arm/smmuv3.c                 |   2 +-
 hw/core/or-irq.c                |  39 ++-
 hw/dma/rc4030.c                 |   2 +-
 hw/hppa/dino.c                  |   3 +-
 hw/i386/amd_iommu.c             |   2 +-
 hw/i386/intel_iommu.c           |   6 +-
 hw/misc/iotkit-secctl.c         |  38 +-
 hw/misc/tz-mpc.c                | 604 ++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c               |  12 +-
 hw/ppc/spapr_iommu.c            |   5 +-
 hw/s390x/s390-pci-bus.c         |   2 +-
 hw/s390x/s390-pci-inst.c        |   7 +-
 hw/scsi/esp.c                   |   3 +-
 hw/sparc/sun4m_iommu.c          |   3 +-
 hw/sparc64/sun4u_iommu.c        |   2 +-
 hw/vfio/common.c                |   9 +-
 hw/virtio/vhost.c               |  10 +-
 hw/xen/xen_pt_msi.c             |   3 +-
 memory.c                        |  45 ++-
 memory_ldst.inc.c               |  18 +-
 target/ppc/mmu-hash64.c         |   3 +-
 target/riscv/helper.c           |   2 +-
 target/s390x/diag.c             |   6 +-
 target/s390x/excp_helper.c      |   3 +-
 target/s390x/mmu_helper.c       |   3 +-
 target/s390x/sigp.c             |   3 +-
 target/xtensa/op_helper.c       |   3 +-
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   8 +
 47 files changed, 1452 insertions(+), 163 deletions(-)
 create mode 100644 include/hw/misc/tz-mpc.h
 create mode 100644 hw/misc/tz-mpc.c

-- 
2.17.0
