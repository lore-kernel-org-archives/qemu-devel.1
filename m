Received: from eggs.gnu.org ([2001:4830:134:3::10]:40343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSn-0008G5-Ed
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cgmSk-0001ce-B5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48524
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cgmSk-0001cJ-4r
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:01:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N5s4ro135825
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28sjf0f7jb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:01:08 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 23 Feb 2017 16:01:05 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 23 Feb 2017 16:59:53 +1100
Message-Id: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 00/12] ISA 3.00 KVM guest support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com


Update notes:

Since the last version, there has been a change to specification of the values
used during client architecture support, regarding the bits in option vector 5,
so some bits and other processing have changed a bit.

This version has not been as well tested as the last. Testing is ongoing.

General intro:

Because KVM will soon provide the necessary infrastructure for KVM guests to
run on POWER9 CPUs, we can now start exploiting this new functionality from
QEMU. See:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-January/153433.html

This work is not yet complete but it is functional and is presented for early
review. It overlaps in some places with current work supporting the same guests
under full emulation.

This set aims to support only the following scenarios:
* A POWER9 host running in radix mode, running a guest in radix mode.
* A POWER9 host running in hash mode, running a guest in hash mode.
* A POWER9 host running in hash mode, running a guest in legacy(+) mode.
(+) Where legacy means that the guest does not support ISA 3.00.

Hash or radix mode for the host is controlled via the "disable_radix" kernel
command line parameter: the host will use radix unless disable_radix is given.
For the guest it should be automatically selected to match the host.

Bad legacy guests: There are some recent kernels (e.g. 4.9) that will, when run
as a KVM guest and if the ibm,pa-features entry in the device tree has the
Radix MMU bit set, attempt to initialize the MMU as if they were a host (which
will cause them to crash). To avoid exposing this problem, the Radix MMU bit
is removed from ibm,pa-features when a legacy guest is detected.

Final Notes:
* Migration/snapshots are not yet investigated.
* This set is based on the ppc-for-2.9 branch of David Gibson's tree
at https://github.com/dgibson/qemu.git
* It also relies on some work already posted here:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02527.html
Specifically patches 1..4 which set up the new CPU and MMU models.

Changes v1 -> v2:
Patch 1/12: scripts/update-linux-headers.sh: refactor extra files

I've factored the script to make it easier to add new files.

Patch 2/12: scripts/update-linux-headers.sh: add new files for ARM

* Added the two new arm headers.

Patch 3/12: Move virtio_mmio.h to fix update-linux-headers.sh
* FWIW, here's one way of fixing it.

Patch 4/12: Update headers using update-linux-headers.sh

* Added information about where the headers came from.

Patch 5/12: spapr: Add ibm,processor-radix-AP-encodings to the device tree

* ppc_radix_page_info now kept in native format, conversion to BE done when adding to the device tree.
* radix_page_info moved into the CPU class, cleaning up some code.

Patch 6/12: target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3

* cap_mmu_hash renamed to cap_mmu_hash_v3.

Patch 7/12: spapr: Only setup HTP if necessary.

* This patch has been mostly rewritten to move the late HPT allocation to CAS.
This allows a guest to start in radix mode (when it's in real mode) and then
change to hash, even if it is a legacy guest and will not call
h_register_process_table().
* Added an exported function to spapr.c to perform HPT allocation and adjust
the vrma if necessary. This makes it possible to allocate the HPT from
h_client_architecture_support() in spapr_hcall.c.

Patch 8/12: spapr: Add h_register_process_table() hypercall

* I haven't addressed review comments for this patch because it overlaps with
Suraj's implementation of the same function and we'll work together to
integrate them.

Patch 10/12: spapr: Enable ISA 3.0 MMU mode selection via CAS

* Unused bits removed.
* Logic and bit definitions changed due to architectural change.
* Cleanly terminate QEMU if the guest requests an unavailable mode (as required
  by the new architecture).
* Legacy guest workaround moved to it's own patch.
* I'm sorry for the bitfield constants in spapr_dt_ov5_platform_support() but
  there don't seem to be convienent macros for converting an option vector
  specifier (OV_BIT(x,y)) into a byte-mask. I'm open to suggestions.


Sam Bobroff (12):
  spapr: Small cleanup of PPC MMU enums
  scripts/update-linux-headers.sh: refactor extra files
  scripts/update-linux-headers.sh: add new files for ARM
  Move virtio_mmio.h to fix update-linux-headers.sh
  Update headers using update-linux-headers.sh
  spapr: Add ibm,processor-radix-AP-encodings to the device tree
  target-ppc: support KVM_CAP_PPC_MMU_RADIX, KVM_CAP_PPC_MMU_HASH_V3
  spapr: Only setup HTP if necessary.
  spapr: Add h_register_process_table() hypercall
  spapr: move spapr_populate_pa_features()
  spapr: Enable ISA 3.0 MMU mode selection via CAS
  spapr: Workaround for broken radix guests

 hw/ppc/spapr.c                                     | 190 +++++++---
 hw/ppc/spapr_hcall.c                               |  84 ++++-
 hw/virtio/virtio-mmio.c                            |   2 +-
 include/hw/ppc/spapr.h                             |   3 +
 include/hw/ppc/spapr_ovec.h                        |   8 +
 .../linux/virtio_mmio.h                            |   0
 include/standard-headers/linux/input-event-codes.h |   2 +-
 include/standard-headers/linux/pci_regs.h          |   8 +
 include/standard-headers/linux/virtio_ids.h        |   1 +
 include/sysemu/kvm.h                               |   1 +
 linux-headers/asm-arm/kvm.h                        |   2 +
 linux-headers/asm-arm/unistd-eabi.h                |   5 +
 linux-headers/asm-arm/unistd-oabi.h                |  17 +
 linux-headers/asm-arm/unistd.h                     | 419 +--------------------
 linux-headers/asm-powerpc/kvm.h                    |  27 ++
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/kvm_para.h                   |   4 +-
 linux-headers/linux/kvm.h                          |  20 +-
 linux-headers/linux/vfio.h                         |  10 +
 scripts/update-linux-headers.sh                    |  26 +-
 target/ppc/cpu-qom.h                               |  13 +-
 target/ppc/cpu.h                                   |   4 +
 target/ppc/kvm.c                                   |  61 ++-
 target/ppc/kvm_ppc.h                               |  13 +
 target/ppc/mmu-hash64.c                            |  10 +-
 target/ppc/mmu_helper.c                            |  67 ++--
 target/ppc/translate.c                             |  12 +-
 27 files changed, 457 insertions(+), 553 deletions(-)
 rename include/{standard-headers => kernel-headers}/linux/virtio_mmio.h (100%)
 create mode 100644 linux-headers/asm-arm/unistd-eabi.h
 create mode 100644 linux-headers/asm-arm/unistd-oabi.h

-- 
2.11.0
