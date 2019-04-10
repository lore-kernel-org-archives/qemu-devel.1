Received: from eggs.gnu.org ([209.51.188.92]:33343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0sJ-0003Od-2r
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0sI-0002qD-0D
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghook@redhat.com>) id 1hE0sH-0002gy-NQ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:13:57 -0400
From: Gary R Hook <ghook@redhat.com>
Date: Tue,  9 Apr 2019 20:08:01 -0400
Message-Id: <20190410000803.1744-1-ghook@redhat.com>
Subject: [Qemu-devel] [RHEL-8.1 virt 0/2] Enable SEV VM to boot with
 assigned PCI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rhvirt-patches@redhat.com
Cc: ghook@redhat.com, "Danilo C. L. de Paula" <ddepaula@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1667249

On an AMD SEV enabled host with an SEV enabled guest, attaching an
assigned device to the VM results in a failure to start the VM:

qemu-kvm: -device vfio-pci,host=01:00.0,id=hostdev0,bus=pci.2,addr=0x0: sev_ram_block_added: failed to register region (0x7fd96e6bb000+0x20000) error 'Cannot allocate memory'

In this example the assigned device is a simple Intel 82574L NIC:

01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
	Subsystem: Intel Corporation Gigabit CT Desktop Adapter
	Flags: bus master, fast devsel, latency 0, IRQ 89, NUMA node 0
	Memory at fb9c0000 (32-bit, non-prefetchable) [size=128K]
	Memory at fb900000 (32-bit, non-prefetchable) [size=512K]

Note that the error indicates the region as (base+size) where a size
of 0x20000 is 128K, which matches that of BAR0 for the device.
dmesg on the host also reports:

SVM: SEV: Failure locking 32 pages.

SEV guests make use of the RAMBlock notifier in QEMU to add page
pinnings for SEV; the kernel side of the call only knows how to pin
pages with get_user_pages(), and this currently faults on non-page
backed mappings (e.g. the mmap of an MMIO BAR).

To resolve this failure, change the order of the memory region type
assignment and avoid pinning device memory regions.

Cc: "Danilo C. L. de Paula" <ddepaula@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Danilo C. L. de Paula (2):
  redhat: branching qemu-kvm to rhel-8.1.0
  redhat: renaming branch to rhel-8.1.0

Gary R Hook (2):
  Subject: memory: Fix the memory region type assignment order
  Subject: target/i386: sev: Do not pin the ram device memory region

 .gitpublish       |  6 +++---
 memory.c          |  9 ++++++++-
 target/i386/sev.c | 11 +++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.18.1
