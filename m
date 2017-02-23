Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgiqn-0004OW-0d
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgiqm-0007aQ-0x
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:09:44 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 23 Feb 2017 13:09:30 +1100
Message-Id: <20170223020936.29220-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 0/6] Cleanups to handling of hash MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>

This series has an assortment of cleanups to the handling of the hash
based MMU for 64-bit ppc machines.  In particular it better handles
the case of "external" hash table - this is used on the pseries
machine type, which being a paravirtualized platform has the hashed
page table - along with other hypervisor resources - outside the
direct reach of the guest OS.  This series integrates the handling of
the external HPT with the externalized handling of hypercalls via the
"virtual hypervisor" mechanism.

These cleanups are expected to make integrating the new MMU model for
POWER9 easier; in particular dealing with both the new POWER9 radix
MMU and also the POWER9 legacy hash compatibility mode.

This series is based on my current ppc-for-2.9 branch, which I've just
sent a pull request for.

David Gibson (6):
  pseries: Minor cleanups to HPT management hypercalls
  target/ppc: Merge cpu_ppc_set_vhyp() with cpu_ppc_set_papr()
  target/ppc: SDR1 is a hypervisor resource
  target/ppc: Cleanup HPTE accessors for 64-bit hash MMU
  target/ppc: Eliminate htab_base and htab_mask variables
  target/ppc: Manage external HPT via virtual hypervisor

 hw/ppc/spapr.c              |  58 +++++++++++++++
 hw/ppc/spapr_cpu_core.c     |  20 ++++-
 hw/ppc/spapr_hcall.c        |  89 +++++++++++-----------
 target/ppc/cpu.h            |  24 +++---
 target/ppc/kvm.c            |  27 +++----
 target/ppc/kvm_ppc.h        |  43 +++++------
 target/ppc/machine.c        |   5 +-
 target/ppc/misc_helper.c    |   8 +-
 target/ppc/mmu-hash32.c     |  14 ++--
 target/ppc/mmu-hash32.h     |  32 ++++----
 target/ppc/mmu-hash64.c     | 177 ++++++++++++++++++--------------------------
 target/ppc/mmu-hash64.h     |  66 +++++++++--------
 target/ppc/mmu_helper.c     |  34 +++++----
 target/ppc/translate_init.c |  30 +++++---
 14 files changed, 332 insertions(+), 295 deletions(-)

-- 
2.9.3
