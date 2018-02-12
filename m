Received: from eggs.gnu.org ([2001:4830:134:3::10]:55562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBI-0003CY-4q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBB-0003f9-LG
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:12 -0500
Received: from mail-by2nam01on0040.outbound.protection.outlook.com
	([104.47.34.40]:4832
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elGBB-0003cq-0a
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:05 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 12 Feb 2018 09:36:47 -0600
Message-ID: <20180212153715.87555-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 00/28] x86: Secure Encrypted Virtualization
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

This patch series provides support for AMD's new Secure Encrypted=20
Virtualization (SEV) feature.

SEV is an extension to the AMD-V architecture which supports running
multiple VMs under the control of a hypervisor. The SEV feature allows
the memory contents of a virtual machine (VM) to be transparently encrypted
with a key unique to the guest VM. The memory controller contains a
high performance encryption engine which can be programmed with multiple
keys for use by a different VMs in the system. The programming and
management of these keys is handled by the AMD Secure Processor firmware
which exposes a commands for these tasks.

The KVM SEV patch series introduced a new ioctl (KVM_MEMORY_ENCRYPTION_OP)
which is used by qemu to issue the SEV commands to assist performing
common hypervisor activities such as a launching, running, snapshooting,
migration and debugging guests.

The following links provide additional details:

AMD Memory Encryption whitepaper:
=20
http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_E=
ncryption_Whitepaper_v7-Public.pdf

AMD64 Architecture Programmer's Manual:
http://support.amd.com/TechDocs/24593.pdf
SME is section 7.10
SEV is section 15.34

Secure Encrypted Virutualization Key Management:
http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf

KVM Forum slides:
http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualiza=
toin_Memory_Encryption_Technology.pdf

Video of the KVM Forum Talk:
https://www.youtube.com/watch?v=3DRcvQ1xN55Ew

---

The complete patch series is available :
https://github.com/codomania/qemu/tree/v8

Using these patches we have succesfully booted and tested a guest both with=
 and
without SEV enabled.

TODO:

* Add SEV guest migration support
* Add SEV guest snapshot and restore support

Changes since v8:
- move sev.c from accel/kvm to target/i386
- update query-sev-launch-measure to return error when measurement is not a=
vailable
- update flatview_read to use slow path when attrs.debug=3D1 is set
- fix the buffer overflow
- use '-' when adding new member in SevInfo QMP structure

Changes since v6:
- add support to specify cbitpos in sev-guest object
- add 'info sev' HMP command
- add 'query-sev' and 'query-launch-measure' QMP commands
- rework the logic to query the memory encryption mask when walking
  guest pagetable for debug

Changes since v5:
- drop MEMTXTATTRS_DEBUG macro, caller now specify attrs.debug=3D1 when nee=
ded.
- drop DPRINTF and use trace points to output the debug messages

Changes since v4:
- extend sev-guest object to add new properties 'dh-cert-file', 'session-fi=
le' etc.
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
- Added kvm_memory_encrytion_* APIs. The idea behind this was to allow addi=
ng
a non SEV memory encrytion object without modifying interfaces.
- Drop patch to load OS image at fixed location.
- updated LAUNCH_FINISH command structure. Now the structure contains
just 'measurement' field. Other fields are not used and will also be remove=
d
from newer SEV firmware API spec.


Brijesh Singh (28):
  memattrs: add debug attribute
  exec: add ram_debug_ops support
  exec: add debug version of physical memory read and write API
  monitor/i386: use debug APIs when accessing guest memory
  target/i386: add memory encryption feature cpuid support
  machine: add -memory-encryption property
  kvm: update kvm.h to include memory encryption ioctls
  docs: add AMD Secure Encrypted Virtualization (SEV)
  target/i386: add Secure Encrypted Virtulization (SEV) object
  sev/i386: add command to initialize the memory encryption context
  sev/i386: register the guest memory range which may contain encrypted
    data
  kvm: introduce memory encryption APIs
  qmp: add query-sev command
  hmp: add 'info sev' command
  sev/i386: add command to create launch memory encryption context
  sev/i386: add command to encrypt guest memory region
  target/i386: encrypt bios rom
  sev/i386: add support to LAUNCH_MEASURE command
  sev/i386: finalize the SEV guest launch flow
  hw/i386: set ram_debug_ops when memory encryption is enabled
  sev/i386: add debug encrypt and decrypt commands
  target/i386: clear C-bit when walking SEV guest page table
  include: add psp-sev.h header file
  sev/i386: add support to query PLATFORM_STATUS command
  sev/i386: add support to KVM_SEV_GUEST_STATUS
  qmp: add query-sev-launch-measure command
  tests/qmp-test: blacklist query-sev-launch-measure command
  sev/i386: add migration blocker

 accel/kvm/kvm-all.c            |  48 +++
 accel/stubs/kvm-stub.c         |  14 +
 cpus.c                         |   2 +-
 disas.c                        |   2 +-
 docs/amd-memory-encryption.txt | 109 ++++++
 exec.c                         |  83 ++++-
 hmp-commands-info.hx           |  14 +
 hmp.c                          |  19 +
 hmp.h                          |   1 +
 hw/core/machine.c              |  22 ++
 hw/i386/pc.c                   |   9 +
 hw/i386/pc_sysfw.c             |  19 +
 include/exec/cpu-common.h      |  15 +
 include/exec/memattrs.h        |   2 +
 include/exec/memory.h          |  30 +-
 include/hw/boards.h            |   1 +
 include/sysemu/kvm.h           |  25 ++
 include/sysemu/sev.h           |  84 +++++
 linux-headers/linux/kvm.h      |  90 +++++
 linux-headers/linux/psp-sev.h  | 142 ++++++++
 monitor.c                      |   6 +-
 qapi-schema.json               |  76 ++++
 qemu-options.hx                |  38 ++
 qmp.c                          |  33 ++
 stubs/Makefile.objs            |   1 +
 stubs/sev.c                    |  57 +++
 target/i386/Makefile.objs      |   2 +-
 target/i386/cpu.c              |  36 ++
 target/i386/cpu.h              |   3 +
 target/i386/helper.c           |  31 +-
 target/i386/monitor.c          | 129 ++++---
 target/i386/sev.c              | 795 +++++++++++++++++++++++++++++++++++++=
++++
 target/i386/trace-events       |  11 +
 tests/qmp-test.c               |   2 +
 34 files changed, 1868 insertions(+), 83 deletions(-)
 create mode 100644 docs/amd-memory-encryption.txt
 create mode 100644 include/sysemu/sev.h
 create mode 100644 linux-headers/linux/psp-sev.h
 create mode 100644 stubs/sev.c
 create mode 100644 target/i386/sev.c

--=20
2.14.3
