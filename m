Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnf6U-0001Qa-HH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnf6Q-0002iC-JR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:34:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 16:34:17 +1100
Message-Id: <20170314053422.10922-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 for-2.10 0/5] HPT resizing for PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

These patches implement a PAPR extension to allow 'pseries' machine
type guests to resize their hashed page table (HPT).  This allows for
more flexible memory hotplug, because we don't need to size the
initial HPT for the maximum memory size.  That's particularly valuable
with (HV) KVM, since the HPT has to be host physically contiguous.

I believe this is ready to be staged for qemu-2.10 now, and assuming
there are no objections or changes suggested, I'll merge this to my
ppc-for-2.10 branch.

Since the last post this has been rebased (not trivial, due to the HPT
handling cleanups which went in recently).  I've also removed an
assert which I suspect could be triggered by the guest.

Changes since v1:
  * Fixed some bisect breakage due to some hunks not being in quite
    the right patch of the series.
  * Use pc_existing_dimms_capacity() instead of an open-coded equivalent

David Gibson (5):
  pseries: Stubs for HPT resizing
  pseries: Implement HPT resizing
  pseries: Enable HPT resizing for 2.10
  pseries: Use smaller default hash page tables when guest can resize
  pseries: Allow HPT resizing with KVM

 hw/ppc/spapr.c              | 103 ++++++++++-
 hw/ppc/spapr_hcall.c        | 430 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events         |   2 +
 include/hw/ppc/spapr.h      |  19 ++
 include/hw/ppc/spapr_ovec.h |   1 +
 target/ppc/kvm.c            |  75 ++++++++
 target/ppc/kvm_ppc.h        |  26 +++
 target/ppc/mmu-hash64.h     |   4 +
 8 files changed, 652 insertions(+), 8 deletions(-)

-- 
2.9.3
