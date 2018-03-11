Received: from eggs.gnu.org ([2001:4830:134:3::10]:58576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFj-0004CN-Vt
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurFf-00023Y-2X
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:02:28 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Sun, 11 Mar 2018 11:02:10 +0800
Message-Id: <20180311030215.11488-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v6 0/5] hw/acpi-build: build SRAT memory
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
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, dgilbert@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org

(Patch 5 is only for reviewers to run test cases in patch 4)

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
one SRAT memory affinity structure for each DIMM device present at
boot time, including both PC-DIMM and NVDIMM, with the proximity
domain specified in '-device pc-dimm' or '-device nvdimm'.

The remaining hot-pluggable address space is covered by one or multiple
SRAT memory affinity structures with the proximity domain of the last
node as before.

Changes in v6:
 * (Patch 2) Fix the commit message.

Changes in v5:
 * (Patch 2) Inline qmp nvdimm info in MemoryDeviceInfo.

Changes in v4:
 * (Patch 1) Update the commit message and add R-b from Igor Mammedov.
 * (Patch 2) Rebase on misc.json and update the commit message.
 * (Patch 3) Directly use di-addr and di-node.
 * (Patch 4) Drop the previous v3 patch 3 and add '-machine nvdimm=on'
   to parameters of test_acpi_one().
 * (Patch 4) Put PC-DIMM and NVDIMM to different numa nodes.
 * (Patch 4&5) Move binary blobs of ACPI tables to DO-NOT-APPLY patch 5.

Changes in v3:
 * (Patch 1&2) Use qmp_pc_dimm_device_list to get information of DIMM
   devices and move it to separate patches.
 * (Patch 3) Replace while loop by a more readable for loop.
 * (Patch 3) Refactor the flag setting code.
 * (Patch 3) s/'static-plugged'/'present at boot time' in commit message.

Changes in v2:
 * Build SRAT memory affinity structures of PC-DIMM devices as well.
 * Add test cases.

Haozhong Zhang (5):
  pc-dimm: make qmp_pc_dimm_device_list() sort devices by address
  qmp: distinguish PC-DIMM and NVDIMM in MemoryDeviceInfoList
  hw/acpi-build: build SRAT memory affinity structures for DIMM devices
  tests/bios-tables-test: add test cases for DIMM proximity
  test/acpi-test-data: add ACPI tables for dimmpxm test

 hmp.c                                 |  14 ++++--
 hw/i386/acpi-build.c                  |  56 +++++++++++++++++++--
 hw/mem/pc-dimm.c                      |  91 +++++++++++++++++++---------------
 hw/ppc/spapr.c                        |   3 +-
 include/hw/mem/pc-dimm.h              |   2 +-
 numa.c                                |  23 +++++----
 qapi/misc.json                        |   6 ++-
 qmp.c                                 |   7 +--
 stubs/qmp_pc_dimm.c                   |   4 +-
 tests/acpi-test-data/pc/APIC.dimmpxm  | Bin 0 -> 144 bytes
 tests/acpi-test-data/pc/DSDT.dimmpxm  | Bin 0 -> 6803 bytes
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 0 -> 224 bytes
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 0 -> 472 bytes
 tests/acpi-test-data/pc/SSDT.dimmpxm  | Bin 0 -> 685 bytes
 tests/acpi-test-data/q35/APIC.dimmpxm | Bin 0 -> 144 bytes
 tests/acpi-test-data/q35/DSDT.dimmpxm | Bin 0 -> 9487 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 0 -> 472 bytes
 tests/acpi-test-data/q35/SSDT.dimmpxm | Bin 0 -> 685 bytes
 tests/bios-tables-test.c              |  38 ++++++++++++++
 20 files changed, 177 insertions(+), 67 deletions(-)
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
