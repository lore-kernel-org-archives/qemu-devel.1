Received: from eggs.gnu.org ([2001:4830:134:3::10]:47698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1esk3y-0004pS-CK
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1esk3u-0004ac-GM
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:57:34 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon,  5 Mar 2018 14:57:05 +0800
Message-Id: <20180305065710.25876-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/5] hw/acpi-build: build SRAT memory
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
  pc-dimm: refactor qmp_pc_dimm_device_list
  qmp: distinguish PC-DIMM and NVDIMM in MemoryDeviceInfoList
  hw/acpi-build: build SRAT memory affinity structures for DIMM devices
  tests/bios-tables-test: allow setting extra machine options
  tests/bios-tables-test: add test cases for DIMM proximity

 hmp.c                                 |  14 +++--
 hw/i386/acpi-build.c                  |  60 +++++++++++++++++++--
 hw/mem/pc-dimm.c                      |  99 ++++++++++++++++++++--------------
 hw/ppc/spapr.c                        |   3 +-
 include/hw/mem/pc-dimm.h              |   2 +-
 numa.c                                |  23 ++++----
 qapi-schema.json                      |  18 ++++++-
 qmp.c                                 |   7 +--
 stubs/qmp_pc_dimm.c                   |   4 +-
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
 tests/bios-tables-test.c              |  78 +++++++++++++++++++++------
 20 files changed, 225 insertions(+), 83 deletions(-)
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
