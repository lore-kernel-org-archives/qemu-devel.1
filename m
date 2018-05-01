Received: from eggs.gnu.org ([2001:4830:134:3::10]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8T-0003T5-1D
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fDR8R-0007ni-Rn
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:45 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fDR8R-0007mW-Kh
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:59:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  1 May 2018 09:59:27 +0100
Message-Id: <20180501085939.6201-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC PATCH v2 00/12] iommu: add MemTxAttrs argument to
 IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

This is an RFC patchset because it's a little bit unmotivated
and only lightly tested, but in principle it could be
committed, so half-RFC-half-not :-)

The Arm SMMU wants to know if the transaction it is handling
is secure/nonsecure and user/privileged, because the iommu
page tables can be configured by the guest to only allow
transactions which satisfy those criteria. At the moment
Eric's implementation ignores all that, because we don't
provide the IOMMUMemoryRegion translate function with any
memory transaction attribute information. This patchset fixes
that by plumbing through transaction attributes.

Most of the patchset is just starting at the leaves of the calltree
rooted at "flatview_do_translate()" and making callsites provide
attributes where appropriate or plumbing through existing attribute
information where it exists.  General principles of when I made a
caller pass MEMTXATTRS_UNSPECIFIED and when I had it take an
attrs value from further up:
 * dma_memory_* functions all assume UNSPECIFIED (matching
   the read/write/rw functions that already do that)
 * cpu_physical_memory_* also all assume UNSPECIFIED,
   following the pattern of existing functions in that family
 * address_space_* take an attributes argument, by analogy
   with existing functions in that family
 * endpoints like target-specific code or vhost has to
   provide attributes, but for all the targets affected here
   they don't care about attributes and can use UNSPECIFIED

As well as the SMMU, I'm also thinking about using the IOMMU
infrastructure for the v8M Memory Protection Controller
(though that is a bit trickier as I also need it to support
TCG execution in an IOMMU-controlled region, which is an
orthogonal bit of work to attribute support).

Based-on: <20180430122404.10741-1-peter.maydell@linaro.org>
("memory.h: Improve IOMMU related documentation") but
only for textual reasons.

v1->v2 changes: only adding the patch 1/12 that I forgot
to include in the v1 posting...

thanks
-- PMM

Peter Maydell (12):
  Make tb_invalidate_phys_addr() take a MemTxAttrs argument
  Make address_space_translate() take a MemTxAttrs argument
  Make address_space_map() take a MemTxAttrs argument
  Make address_space_access_valid() take a MemTxAttrs argument
  Make flatview_extend_translation() take a MemTxAttrs argument
  Make memory_region_access_valid() take a MemTxAttrs argument
  Make MemoryRegion valid.accepts callback take a MemTxAttrs argument
  Make flatview_access_valid() take a MemTxAttrs argument
  Make flatview_translate() take a MemTxAttrs argument
  Make address_space_get_iotlb_entry() take a MemTxAttrs argument
  Make flatview_do_translate() take a MemTxAttrs argument
  Add MemTxAttrs argument to IOMMU translate function

 include/exec/exec-all.h        |  5 ++-
 include/exec/memory-internal.h |  3 +-
 include/exec/memory.h          | 26 ++++++++----
 include/sysemu/dma.h           |  6 ++-
 accel/tcg/translate-all.c      |  4 +-
 exec.c                         | 75 ++++++++++++++++++++--------------
 hw/alpha/typhoon.c             |  3 +-
 hw/dma/rc4030.c                |  3 +-
 hw/hppa/dino.c                 |  3 +-
 hw/i386/amd_iommu.c            |  3 +-
 hw/i386/intel_iommu.c          |  3 +-
 hw/nvram/fw_cfg.c              | 12 ++++--
 hw/ppc/spapr_iommu.c           |  3 +-
 hw/s390x/s390-pci-bus.c        |  3 +-
 hw/s390x/s390-pci-inst.c       |  3 +-
 hw/scsi/esp.c                  |  3 +-
 hw/sparc/sun4m_iommu.c         |  3 +-
 hw/sparc64/sun4u_iommu.c       |  3 +-
 hw/vfio/common.c               |  3 +-
 hw/virtio/vhost.c              |  3 +-
 hw/xen/xen_pt_msi.c            |  3 +-
 memory.c                       | 15 ++++---
 memory_ldst.inc.c              | 18 ++++----
 target/ppc/mmu-hash64.c        |  3 +-
 target/riscv/helper.c          |  2 +-
 target/s390x/diag.c            |  6 ++-
 target/s390x/excp_helper.c     |  3 +-
 target/s390x/mmu_helper.c      |  3 +-
 target/s390x/sigp.c            |  3 +-
 target/xtensa/op_helper.c      |  3 +-
 30 files changed, 141 insertions(+), 88 deletions(-)

-- 
2.17.0
