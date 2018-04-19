Received: from eggs.gnu.org ([2001:4830:134:3::10]:60530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934P-0005Ws-7D
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934O-0005QR-5x
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 19 Apr 2018 16:29:10 +1000
Message-Id: <20180419062917.31486-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

Currently the "pseries" machine type will (usually) advertise
different pagesizes to the guest when running under KVM and TCG, which
is not how things are supposed to work.

This comes from poor handling of hardware limitations which mean that
under KVM HV the guest is unable to use pagesizes larger than those
backing the guest's RAM on the host side.

The new scheme turns things around by having an explicit machine
parameter controlling the largest page size that the guest is allowed
to use.  This limitation applies regardless of accelerator.  When
we're running on KVM HV we ensure that our backing pages are adequate
to supply the requested guest page sizes, rather than adjusting the
guest page sizes based on what KVM can supply.

This means that in order to use hugepages in a PAPR guest it's
necessary to add a "cap-hpt-mps=24" machine parameter as well as
setting the mem-path correctly.  This is a bit more work on the user
and/or management side, but results in consistent behaviour so I think
it's worth it.

Longer term, we can also use this parameter to control IOMMU page
sizes.  However the restrictions here are even more complicated based
on an intersection of guest, host kernel and hardware capabilities.

This applies on top of my recent series cleaning up the PAPR mode
initialization, which in turn applies on top of my ppc-for-2.13 tree.

David Gibson (7):
  spapr: Maximum (HPT) pagesize property
  spapr: Use maximum page size capability to simplify memory backend
    checking
  target/ppc: Add ppc_hash64_filter_pagesizes()
  spapr: Add cpu_apply hook to capabilities
  spapr: Limit available pagesizes to provide a consistent guest
    environment
  spapr: Don't rewrite mmu capabilities in KVM mode
  spapr_pci: Remove unhelpful pagesize warning

 hw/ppc/spapr.c          |  18 +++---
 hw/ppc/spapr_caps.c     | 125 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_cpu_core.c |   4 ++
 hw/ppc/spapr_pci.c      |   7 ---
 include/hw/ppc/spapr.h  |   8 ++-
 target/ppc/kvm.c        | 149 ++++++++++++++++++++++++------------------------
 target/ppc/kvm_ppc.h    |  11 +++-
 target/ppc/mmu-hash64.c |  59 +++++++++++++++++++
 target/ppc/mmu-hash64.h |   3 +
 9 files changed, 287 insertions(+), 97 deletions(-)

-- 
2.14.3
