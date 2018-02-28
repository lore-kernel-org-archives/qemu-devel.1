Received: from eggs.gnu.org ([2001:4830:134:3::10]:54590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqsxc-0004W6-1I
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqsxY-0002LC-Ul
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:4239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqsxY-0002IW-LO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:16 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 28 Feb 2018 12:02:57 +0800
Message-Id: <20180228040300.8914-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/3] hw/acpi-build: build SRAT memory
 affinity structures for DIMM devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
domain of a NVDIMM SPA range must match with corresponding entry in
SRAT table.

The address ranges of vNVDIMM in QEMU are allocated from the
hot-pluggable address space, which is entirely covered by one SRAT
memory affinity structure. However, users can set the vNVDIMM
proximity domain in NFIT SPA range structure by the 'node' property of
'-device nvdimm' to a value different than the one in the above SRAT
memory affinity structure.

In order to solve such proximity domain mismatch, this patch builds
one SRAT memory affinity structure for each static-plugged DIMM device,
including both PC-DIMM and NVDIMM, with the proximity domain specified
in '-device pc-dimm' or '-device nvdimm'.

The remaining hot-pluggable address space is covered by one or multiple
SRAT memory affinity structures with the proximity domain of the last
node as before.


Changes in v2:
 * Build SRAT memory affinity structures of PC-DIMM devices as well.
 * Add test cases.


Haozhong Zhang (3):
  hw/acpi-build: build SRAT memory affinity structures for DIMM devices
  tests/bios-tables-test: allow setting extra machine options
  tests/bios-tables-test: add test cases for DIMM proximity

 hw/i386/acpi-build.c                  |  50 ++++++++++++++++++++--
 hw/mem/pc-dimm.c                      |   8 ++++
 include/hw/mem/pc-dimm.h              |  10 +++++
 tests/acpi-test-data/pc/APIC.dimmpxm  | Bin 0 -> 136 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm  | Bin 0 -> 6710 bytes
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 0 -> 224 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 0 -> 416 bytes
 tests/acpi-test-data/pc/SSDT.dimmpxm  | Bin 0 -> 685 bytes
 tests/acpi-test-data/q35/APIC.dimmpxm | Bin 0 -> 136 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm | Bin 0 -> 9394 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 0 -> 416 bytes
 tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 0 -> 685 bytes
 tests/bios-tables-test.c              |  78 +++++++++++++++++++++++++++-------
 14 files changed, 126 insertions(+), 20 deletions(-)
 create mode 100644 tests/acpi-test-data/pc/APIC.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/DSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/NFIT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/SRAT.dimmpxm
 create mode 100644 tests/acpi-test-data/pc/SSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/APIC.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/DSDT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/NFIT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/SRAT.dimmpxm
 create mode 100644 tests/acpi-test-data/q35/SSDT.dimmpxm

-- 
2.14.1
