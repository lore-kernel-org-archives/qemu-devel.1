Received: from eggs.gnu.org ([2001:4830:134:3::10]:52013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGB-0005FU-Ac
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtG8-00034i-76
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:34559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtG7-000330-UH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:28 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:02 +0800
Message-Id: <20171207101812.23602-1-haozhong.zhang@intel.com>
In-Reply-To: <20171207101030.22364-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 00/10] Implement vNVDIMM for Xen
 HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is the QEMU part patches that works with the associated Xen
patches to enable vNVDIMM support for Xen HVM domains. Xen relies on
QEMU to build guest NFIT and NVDIMM namespace devices, and allocate
guest address space for vNVDIMM devices.

All patches can also be found at
  Xen:  https://github.com/hzzhan9/xen.git nvdimm-rfc-v4
  QEMU: https://github.com/hzzhan9/qemu.git xen-nvdimm-rfc-v4

RFC v3 can be found at
  https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02406.html

Changes in v4:
  * The primary change in this version is to use the existing fw_cfg
    and BIOSLinkerLoader interface to pass ACPI to Xen guest, rather
    than introducing a Xen-specific mechanism. (Patch 5-10)

    Following Xen-specific are still left in ACPI code:
     (1) (Patch 6) xen_acpi_build() is called in acpi_build() to only
         build Xen guest required ACPI tables. The consequent code
         path in acpi_build() is bypassed.
     (2) (Patch 8) Add Xen-specific functions to access DSM memory,
         because the existing cpu_physical_memory_rw does not work on Xen.
     (3) (Patch 9) Implement a workaround for different AML integer
         widths between ACPI 1.0 (QEMU) and 2.0 (Xen).

Patch 1 is a trivial code cleanup.

Patch 2-3 add a memory backend dedicated for Xen usage and a hotplug
memory region for Xen guest, in order to make the existing nvdimm
device plugging path work on Xen.

Patch 4 is to avoid dereferencing the NULL pointer to non-existing
label data, as the Xen side support for labels is not implemented yet.

Patch 5-10 enable building ACPI tables and passing them to Xen HVM
domains.

Haozhong Zhang (10):
  [01/10] xen-hvm: remove a trailing space
  [02/10] xen-hvm: create the hotplug memory region on Xen
  [03/10] hostmem-xen: add a host memory backend for Xen
  [04/10] nvdimm: do not intiailize nvdimm->label_data if label size is zero
  [05/10] xen-hvm: initialize fw_cfg interface
  [06/10] hw/acpi-build, xen-hvm: introduce a Xen-specific ACPI builder
  [07/10] xen-hvm: add functions to copy data from/to HVM memory
  [08/10] nvdimm acpi: add functions to access DSM memory on Xen
  [09/10] nvdimm acpi: add compatibility for 64-bit integer in ACPI 2.0 and later
  [10/10] xen-hvm: enable building NFIT and SSDT of vNVDIMM for HVM domains

 backends/Makefile.objs      |   1 +
 backends/hostmem-xen.c      | 108 ++++++++++++++++++++++++++++++++++++++++++++
 backends/hostmem.c          |   9 ++++
 hw/acpi/nvdimm.c            |  51 +++++++++++++++++----
 hw/i386/acpi-build.c        |   9 +++-
 hw/i386/pc.c                |  86 +++++++++++++++++++----------------
 hw/i386/xen/xen-hvm.c       | 105 ++++++++++++++++++++++++++++++++++++++++--
 hw/mem/nvdimm.c             |  10 +++-
 hw/mem/pc-dimm.c            |   6 ++-
 include/hw/acpi/aml-build.h |   4 ++
 include/hw/i386/pc.h        |   1 +
 include/hw/xen/xen.h        |   7 +++
 stubs/xen-hvm.c             |  15 ++++++
 13 files changed, 359 insertions(+), 53 deletions(-)
 create mode 100644 backends/hostmem-xen.c

-- 
2.15.1
