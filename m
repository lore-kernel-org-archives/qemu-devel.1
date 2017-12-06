Received: from eggs.gnu.org ([2001:4830:134:3::10]:49485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvW-0005ev-AO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvT-0002La-1q
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:18 -0500
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com
	([104.47.41.65]:9584
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvS-0002L0-NL
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:14 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:23 -0600
Message-Id: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 00/23] x86: Secure Encrypted Virtualization
 (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

This patch series provides support for AMD's new Secure Encrypted 
Virtualization (SEV) feature.

SEV is an extension to the AMD-V architecture which supports running
multiple VMs under the control of a hypervisor. The SEV feature allows
the memory contents of a virtual machine (VM) to be transparently encrypted
with a key unique to the guest VM. The memory controller contains a
high performance encryption engine which can be programmed with multiple
keys for use by a different VMs in the system. The programming and
management of these keys is handled by the AMD Secure Processor firmware
which exposes a commands for these tasks.

The KVM SEV patch series [1] introduced a new ioctl (KVM_MEMORY_ENCRYPTION_OP)
which is used by qemu to issue the SEV commands to assist performing
common hypervisor activities such as a launching, running, snapshooting,
migration and debugging guests.

The following links provide additional details:

AMD Memory Encryption whitepaper:
 
http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf

AMD64 Architecture Programmer's Manual:
    http://support.amd.com/TechDocs/24593.pdf
    SME is section 7.10
    SEV is section 15.34

Secure Encrypted Virutualization Key Management:
http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf

KVM Forum slides:
http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf

KVM RFC link:

[1] https://marc.info/?l=linux-kernel&m=151243663119420&w=2

Video of the KVM Forum Talk:
https://www.youtube.com/watch?v=RcvQ1xN55Ew

---

Using these patches we have succesfully booted and tested a guest both with and
without SEV enabled.

TODO:

* Add SEV guest migration support
* Add SEV guest snapshot and restore support

Changes since v4:
 - extend sev-guest object to add new properties 'dh-cert-file', 'session-file' etc.
 - emit SEV_MEASUREMENT event when measurement is available
 - add migration blocker
 - add memory encryption cpuid support
 - rebase the series with recent qemu tree

Changes since v3:
 - update to newer SEV spec (0.12 -> 0.14)
 - update to newer KVM RFC and use KVM_MEMORY_ENCRYPTION_OP ioctl instead
   of KVM_ISSUE_SEV.
 - add support to encrypt plfash

Changes since v2:
- rename ram_ops to ram_debug_ops
- use '-' rather than '_' when adding new member in KvmInfo struct
- update sev object to use link properties when referencing other objects
- use ldq_phys_debug in tlb_info_64 and mem_info_64.
- remove sev-guest-policy object, we will revisit it after basic SEV
  guest support is merged.
- remove kernel API from doc and add SEV guest LAUNCH model. The doc will
  be updated as we integerate the remaining SEV APIs.

Changes since v1:
- Added Documentation
- Added security-policy object.
- Drop sev config parsing support and create new objects to get/set SEV
  specific parameters
- Added sev-guest-info object.
- Added sev-launch-info object.
- Added kvm_memory_encrytion_* APIs. The idea behind this was to allow adding
  a non SEV memory encrytion object without modifying interfaces.
- Drop patch to load OS image at fixed location.
- updated LAUNCH_FINISH command structure. Now the structure contains
  just 'measurement' field. Other fields are not used and will also be removed
  from newer SEV firmware API spec.


Brijesh Singh (23):
  memattrs: add debug attribute
  exec: add ram_debug_ops support
  exec: add debug version of physical memory read and write API
  monitor/i386: use debug APIs when accessing guest memory
  target/i386: define memory encryption cpuid support
  machine: add -memory-encryption property
  kvm: update kvm.h to include memory encryption ioctls
  docs: add AMD Secure Encrypted Virtualization (SEV)
  accel: add Secure Encrypted Virtulization (SEV) object
  sev: add command to initialize the memory encryption context
  sev: register the guest memory range which may contain encrypted data
  kvm: introduce memory encryption APIs
  hmp: display memory encryption support in 'info kvm'
  sev: add command to create launch memory encryption context
  sev: add command to encrypt guest memory region
  target/i386: encrypt bios rom
  qapi: add SEV_MEASUREMENT event
  sev: emit the SEV_MEASUREMENT event
  sev: Finalize the SEV guest launch flow
  hw: i386: set ram_debug_ops when memory encryption is enabled
  sev: add debug encrypt and decrypt commands
  target/i386: clear C-bit when walking SEV guest page table
  sev: add migration blocker

 accel/kvm/Makefile.objs        |   2 +-
 accel/kvm/kvm-all.c            |  48 +++
 accel/kvm/sev.c                | 641 +++++++++++++++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c         |  14 +
 cpus.c                         |   2 +-
 disas.c                        |   2 +-
 docs/amd-memory-encryption.txt | 109 +++++++
 exec.c                         |  96 +++++-
 hmp.c                          |   2 +
 hw/core/machine.c              |  22 ++
 hw/i386/pc.c                   |   9 +
 hw/i386/pc_sysfw.c             |  19 ++
 include/exec/cpu-common.h      |  15 +
 include/exec/memattrs.h        |   4 +
 include/exec/memory.h          |  27 ++
 include/hw/boards.h            |   1 +
 include/sysemu/kvm.h           |  25 ++
 include/sysemu/sev.h           |  77 +++++
 linux-headers/linux/kvm.h      |  90 ++++++
 monitor.c                      |   2 +-
 qapi-schema.json               |  18 +-
 qemu-options.hx                |  36 +++
 qmp.c                          |   1 +
 target/i386/cpu.c              |  38 ++-
 target/i386/cpu.h              |   6 +
 target/i386/helper.c           |  46 ++-
 target/i386/monitor.c          | 145 ++++++----
 27 files changed, 1409 insertions(+), 88 deletions(-)
 create mode 100644 accel/kvm/sev.c
 create mode 100644 docs/amd-memory-encryption.txt
 create mode 100644 include/sysemu/sev.h

-- 
2.9.5
