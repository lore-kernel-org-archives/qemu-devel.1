Received: from eggs.gnu.org ([2001:4830:134:3::10]:41502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPrQc-00025A-2g
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPrQa-0002UE-N5
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:29:50 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Jun 2018 16:29:28 +0100
Message-Id: <20180604152941.20374-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/13] iommu: support txattrs,
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
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>

Hi; this is v2 of my iommu patchset, which does:
 * support IOMMUs that are aware of memory transaction attributes and
   may generate different translations for different attributes
 * support TCG execution out of memory which is behind an IOMMU
 * implement the Arm TrustZone Memory Protection Controller
   (which needs both the above features in the IOMMU core code)
 * use the MPC in the mps2-an505 board

Patches 1-3 add the support for memory-transaction-aware
IOMMUs. The general approach is that we have the concept of an
IOMMU index (similar to the TCG MMU index), which selects which of
multiple possible translation tables in the IOMMU we're trying to use.
Most IOMMUs will support just a single index. When you register an
IOMMU notifier and when you call the translate method you have to
specify which IOMMU index you want. There's a method for getting the
index that applies for a particular set of transaction attributes.
All the current IOMMU implementations have just one iommu index, and
all the current users of the notify API assume that.

Patch 4 adds the support for TCG execution from memory that sits
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

Patches 5-8 implement the TrustZone Memory Protection Controller,
which is a fairly simple piece of hardware that just configurably
either allows or blocks transactions depending on attrs.secure.

Patch 9 deals with a limitation in our or-irq device, which
currently only allows 16 input lines (we need 17 for one of the OR
gates in the IoTKit object). The patch raisees the limit to 32, but
in a way that means we can easily raise it further in future without
migration compatibility problems.

Patches 10-13 add MPCs to the IoTKit SoC object and to the mps2-an505
board model, and wire them up appropriately.

Unreviewed patches: 4, 6, 7, 8, 9, 10

v1->v2 changes:
 * the initial "attribute plumbing" patches are now in master
 * the patch to add VMSTATE_BOOL_SUB_ARRAY is also in master now
 * minor rebase fixup to patch 4 for changes in hw/i386/intel_iommu.c
 * moved the num_indexes method definition to the right patch
 * dropped unused iommu_idx field from IOMMUTLBEntry struct
 * tcg_iommu_notifier_destroy now unconditionally unregisters the notifier
 * patch 4: switched from GSList to GArray
 * patch 6: fixed reset values for MPC CTRL and INT_EN registers
 * I have left iommu_idx as signed, because that follows what we've
   done for TCG mmu indexes (and using 'int' for this kind of
   thing is common C practice IMHO)


Peter Maydell (13):
  iommu: Add IOMMU index concept to IOMMU API
  iommu: Add IOMMU index argument to notifier APIs
  iommu: Add IOMMU index argument to translate method
  exec.c: Handle IOMMUs in address_space_translate_for_iotlb()
  hw/misc/tz-mpc.c: Implement the Arm TrustZone Memory Protection
    Controller
  hw/misc/tz-mpc.c: Implement registers
  hw/misc/tz-mpc.c: Implement correct blocked-access behaviour
  hw/misc/tz_mpc.c: Honour the BLK_LUT settings in translate
  hw/core/or-irq: Support more than 16 inputs to an OR gate
  hw/misc/iotkit-secctl.c: Implement SECMPCINTSTATUS
  hw/arm/iotkit: Instantiate MPC
  hw/arm/iotkit: Wire up MPC interrupt lines
  hw/arm/mps2-tz.c: Instantiate MPCs

 hw/misc/Makefile.objs           |   1 +
 include/exec/exec-all.h         |   3 +-
 include/exec/memory.h           |  65 +++-
 include/hw/arm/iotkit.h         |   8 +
 include/hw/misc/iotkit-secctl.h |   8 +
 include/hw/misc/tz-mpc.h        |  80 +++++
 include/hw/or-irq.h             |   5 +-
 include/qom/cpu.h               |   3 +
 accel/tcg/cputlb.c              |   3 +-
 exec.c                          | 146 +++++++-
 hw/alpha/typhoon.c              |   3 +-
 hw/arm/iotkit.c                 | 112 +++++-
 hw/arm/mps2-tz.c                |  71 ++--
 hw/arm/smmuv3.c                 |   2 +-
 hw/core/or-irq.c                |  39 ++-
 hw/dma/rc4030.c                 |   2 +-
 hw/i386/amd_iommu.c             |   2 +-
 hw/i386/intel_iommu.c           |   8 +-
 hw/misc/iotkit-secctl.c         |  38 +-
 hw/misc/tz-mpc.c                | 604 ++++++++++++++++++++++++++++++++
 hw/ppc/spapr_iommu.c            |   5 +-
 hw/s390x/s390-pci-bus.c         |   2 +-
 hw/s390x/s390-pci-inst.c        |   4 +-
 hw/sparc/sun4m_iommu.c          |   3 +-
 hw/sparc64/sun4u_iommu.c        |   2 +-
 hw/vfio/common.c                |   6 +-
 hw/virtio/vhost.c               |   7 +-
 memory.c                        |  33 +-
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   8 +
 31 files changed, 1206 insertions(+), 70 deletions(-)
 create mode 100644 include/hw/misc/tz-mpc.h
 create mode 100644 hw/misc/tz-mpc.c

-- 
2.17.1
