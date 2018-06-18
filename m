Received: from eggs.gnu.org ([2001:4830:134:3::10]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnlz-0008Lu-78
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnly-0001Np-7r
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 16:35:57 +1000
Message-Id: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/9] spapr: Clean up pagesize handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

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
necessary to add a "cap-hpt-max-page-size=16m" machine parameter as
well as setting the mem-path correctly.  This is a bit more work on
the user and/or management side, but results in consistent behaviour
so I think it's worth it.

Longer term, we might also use this parameter to control IOMMU page
sizes.  But, I'm still working out how restrictions deriving from the
guest kernel, host kernel and hardware capabilities all interact here.

This applies on top of my ppc-for-3.0 tree.

Changes since RFC:
 * Add preliminary cleanups to allow us to evaluate effective
   capabilities levels earlier.
 * Don't try to remove double resetting of cpus.  It doesn't quite
   work, and is no longer necessary with the above.
 * Some user-friendliness improvements: use "hpt-max-page-size"
   instead of the cryptic "hpt-mps", and take an actual page size
   (allowing k/m/g suffixies) instead of a shift

David Gibson (9):
  target/ppc: Allow cpu compatiblity checks based on type, not instance
  spapr: Compute effective capability values earlier
  spapr: Add cpu_apply hook to capabilities
  target/ppc: Add kvmppc_hpt_needs_host_contiguous_pages() helper
  spapr: Maximum (HPT) pagesize property
  spapr: Use maximum page size capability to simplify memory backend
    checking
  target/ppc: Add ppc_hash64_filter_pagesizes()
  spapr: Limit available pagesizes to provide a consistent guest
    environment
  spapr: Don't rewrite mmu capabilities in KVM mode

 hw/ppc/spapr.c          |  45 +++++++-----
 hw/ppc/spapr_caps.c     | 156 ++++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_cpu_core.c |   4 ++
 include/hw/ppc/spapr.h  |  11 ++-
 target/ppc/compat.c     |  27 +++++--
 target/ppc/cpu.h        |   4 ++
 target/ppc/kvm.c        | 146 ++++++++++++++++++-------------------
 target/ppc/kvm_ppc.h    |  11 ++-
 target/ppc/mmu-hash64.c |  59 +++++++++++++++
 target/ppc/mmu-hash64.h |   3 +
 10 files changed, 349 insertions(+), 117 deletions(-)

-- 
2.17.1
