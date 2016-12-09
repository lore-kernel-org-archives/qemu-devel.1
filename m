Received: from eggs.gnu.org ([2001:4830:134:3::10]:37567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFAqs-0002Lv-DL
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 21:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cFAqo-0008Cs-C3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 21:23:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Dec 2016 13:23:09 +1100
Message-Id: <20161209022314.14399-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [for-2.9 0/5] Hash Page Table resizing for TCG pseries
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

This series implements the host side of the PAPR ACR to allow runtime
resizing of the Hashed Page Table (HPT) for pseries guests.
Exercising this feature requires a guest OS which is also aware of it.
Patches to implement the guest side in Linux have just been submitted
upstream:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-December/152164.html

Availability of the feature is controlled by a new 'resize-hpt'
machine option: it can be set to "disabled", "enabled" or "required".
The last means that qemu will refuse to boot a guest which is not
aware of the HPT resizing feature (it will instead quit during feature
negotiation).  This is potentially useful because guests which don't
support resizing will need an HPT sized for their maximum possible
RAM, which can be very wasteful of host resources.

So far this is only tested for TCG guests.  PR KVM guests should work
in theory, but I haven't been able to test yet due to (probably
unrelated) problems booting a suitable guest kernel.  HV KVM guests
will require substantial extra work in the host kernel; development is
in progress.

David Gibson (5):
  pseries: Add pseries-2.9 machine type
  pseries: Stubs for HPT resizing
  pseries: Implement HPT resizing
  pseries: Enable HPT resizing for 2.9
  pseries: Use smaller default hash page tables when guest can resize

 hw/ppc/spapr.c              | 117 +++++++++++--
 hw/ppc/spapr_hcall.c        | 408 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/trace-events         |   2 +
 include/hw/compat.h         |   3 +
 include/hw/ppc/spapr.h      |  19 +++
 include/hw/ppc/spapr_ovec.h |   1 +
 target-ppc/kvm.c            |  26 +++
 target-ppc/kvm_ppc.h        |   5 +
 target-ppc/mmu-hash64.h     |   4 +
 9 files changed, 575 insertions(+), 10 deletions(-)

-- 
2.9.3
