Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clk0I-0006R0-JR
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 17:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clk0F-0006Yy-E2
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 17:24:18 -0500
Received: from mail-by2nam01on0066.outbound.protection.outlook.com
	([104.47.34.66]:40204
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clk0E-0006Yr-U0
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 17:24:15 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:51:07 -0500
Message-ID: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 00/20] x86: Secure Encrypted
 Virtualization (AMD)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

This RFC series provides support for AMD's new Secure Encrypted 
Virtualization (SEV) feature. This RFC is based KVM RFC [1].

SEV is an extension to the AMD-V architecture which supports running
multiple VMs under the control of a hypervisor. The SEV feature allows
the memory contents of a virtual machine (VM) to be transparently encrypted
with a key unique to the guest VM. The memory controller contains a
high performance encryption engine which can be programmed with multiple
keys for use by a different VMs in the system. The programming and
management of these keys is handled by the AMD Secure Processor firmware
which exposes a commands for these tasks.

The KVM RFC introduced a new ioctl (KVM_MEMORY_ENCRYPTION_OP) which can be
used by qemu to issue the SEV commands to assist performing common hypervisor
activities such as a launching, running, snapshooting, migration and debugging
guests.

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

[1] http://marc.info/?l=linux-mm&m=148846752931115&w=2

Video of the KVM Forum Talk:
https://www.youtube.com/watch?v=RcvQ1xN55Ew

---

The patch series implements booting SEV guest from unencrypted boot images.
In this series we do not expose object properties to use guest owners specific
PDH certificates or session data. We let the firmware auto generate the VM
encryption keys and ignore the measurements. Passing guest specific certificate
blobs will be added after the first part is reviewed and merged.

The series is tested using OVMF BIOS. I have been working to integerate SEV
support into OVMF tree [2]

[2] https://lists.01.org/pipermail/edk2-devel/2017-March/008213.html

The patches are based on commit 43c227f (disas/arm: Avoid unintended sign
extension)

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

TODO:
- 'info mem' runs very slow in SEV enable guest. 
  
  info mem command does a guest pagetable walk, which reads 8 bytes of data
  at a time. When SEV is enabled then we need to call into kernel (which will
  invoke SEV DEBUG DECRYPT command) to read the guest memory for debug purposes.
  I am thinking that inside the SEV debug callback handler we can cache a full
  page to reduce number of kernel calls to improve the performance.

- integrate SEV SEND_* command in vmsave code path.
- integerate SEV RECEIVE_* command in vm restore code path.
- virtio support in SEV guest.
- Integrate SEV SEND and RECEIVE command in live migration.

Brijesh Singh (20):
      kvm: update kvm.h header file
      memattrs: add debug attribute
      exec: add guest RAM read and write ops
      exec: add debug version of physical memory read and write api
      monitor/i386: use debug apis when accessing guest memory
      core: add new security-policy object
      kvm: add memory encryption api support
      sev: add Secure Encrypted Virtulization (SEV) support
      hmp: display memory encryption support in 'info kvm'
      vl: add memory encryption support
      sev: add LAUNCH_START command
      SEV: add GUEST_STATUS command
      sev: add LAUNCH_UPDATE_DATA command
      sev: add LAUNCH_FINISH command
      sev: add DEBUG_DECRYPT command
      sev: add DEBUG_ENCRYPT command
      target/i386: encrypt bios rom when memory encryption is enabled
      target/i386: add cpuid Fn8000_001f
      target/i386: clear memory encryption bit when walking SEV guest page table
      migration: disable save/restore and migration when SEV is active


 Makefile.target                  |    2 
 cpus.c                           |    2 
 disas.c                          |    2 
 docs/amd-memory-encryption.txt   |  121 +++++++++
 exec.c                           |   94 ++++++-
 hmp.c                            |    2 
 hw/core/Makefile.objs            |    1 
 hw/core/machine.c                |   22 ++
 hw/core/security-policy.c        |  165 +++++++++++++
 hw/i386/pc.c                     |    7 +
 hw/i386/pc_sysfw.c               |   30 ++
 include/exec/cpu-common.h        |   15 +
 include/exec/memattrs.h          |    4 
 include/exec/memory.h            |   25 ++
 include/hw/boards.h              |    1 
 include/sysemu/kvm.h             |    7 +
 include/sysemu/security-policy.h |   75 ++++++
 include/sysemu/sev.h             |  102 ++++++++
 kvm-all.c                        |   77 ++++++
 kvm-stub.c                       |   36 +++
 linux-headers/linux/kvm.h        |  100 ++++++++
 migration/migration.c            |    7 +
 migration/savevm.c               |   11 +
 monitor.c                        |    2 
 qapi-schema.json                 |    5 
 qemu-options.hx                  |   48 ++++
 qmp.c                            |    1 
 sev.c                            |  489 ++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.c                |    6 
 target/i386/helper.c             |   39 ++-
 target/i386/monitor.c            |  159 +++++++++---
 vl.c                             |   15 +
 32 files changed, 1596 insertions(+), 76 deletions(-)
 create mode 100644 docs/amd-memory-encryption.txt
 create mode 100644 hw/core/security-policy.c
 create mode 100644 include/sysemu/security-policy.h
 create mode 100644 include/sysemu/sev.h
 create mode 100644 sev.c

-- 

Brijesh Singh
