Received: from eggs.gnu.org ([209.51.188.92]:33705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR1h-0001QA-E8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR1e-0006H1-RB
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR1e-0006GH-AC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:53:14 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:40:52 +0100
Message-Id: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 00/14] tests: acpi: add UEFI (ARM) testing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

Series adds support for ACPI tables located above 4G. It only adds 64-bit
handling necessary for testing arm/virt board (i.e. might be not complete
wrt spec) and a test build of UEFI (AVMF) firmware that provides an entry
point[1] for fetching ACPI tables (RSDP pointer).

Series depends on:
   [PATCH v2 0/8] tests: apci: consolidate and cleanup  ACPI test code
   it's queued on PCI tree git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git pci
and requires following EDK2 patches to enable testing feature:
   1) https://github.com/lersek/edk2/commits/acpi_test_support

Git tree for testing:
   https://github.com/imammedo/qemu.git acpi_arm_tests_v1

Igor Mammedov (14):
  tests: acpi: add uefi_find_rsdp_addr() helper
  tests: acpi: make RSDT test routine handle XSDT
  tests: acpi: rename acpi_parse_rsdp_table() into
    acpi_fetch_rsdp_table()
  tests: acpi: make pointer to RSDP 64bit
  tests: acpi: fetch X_DSDT if pointer to DSDT is 0
  tests: acpi: add reference blobs arm/virt board testcase
  tests: acpi: skip FACS table if board uses hw reduced ACPI profile
  tests: acpi: introduce an abilty start tests with UEFI firmware
  tests: acpi: move boot_sector_init() into x86 tests branch
  tests: acpi: ignore SMBIOS tests when UEFI firmware is used
  tests: acpi: add AVMF firmware blobs
  tests: acpi: prepare AVMF firmware blobs to be used by
    bios-tables-test
  tests: acpi: add simple arm/virt testcase
  tests: acpi: refactor rebuild-expected-aml.sh to dump ACPI tables for
    a specified list of targets

 tests/acpi-utils.h                      |   4 +-
 Makefile                                |   3 +-
 pc-bios/avmf.img                        | Bin 0 -> 2097152 bytes
 pc-bios/avmf_vars.img                   | Bin 0 -> 786432 bytes
 tests/Makefile.include                  |  19 +++++-
 tests/acpi-utils.c                      |  57 ++++++++++++----
 tests/bios-tables-test.c                | 113 +++++++++++++++++++++++---------
 tests/data/acpi/rebuild-expected-aml.sh |  23 ++++---
 tests/data/acpi/virt/APIC               | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT               | Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP               | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT               | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG               | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR               | Bin 0 -> 80 bytes
 tests/vmgenid-test.c                    |   2 +-
 15 files changed, 160 insertions(+), 61 deletions(-)
 create mode 100644 pc-bios/avmf.img
 create mode 100644 pc-bios/avmf_vars.img
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR

-- 
2.7.4
