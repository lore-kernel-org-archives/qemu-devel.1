Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX3W-0003hD-0F
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX1n-0008Aj-Gu
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX1n-000896-8r
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:34:35 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 25 Apr 2019 07:34:36 +0200
Message-Id: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/13] tests: acpi: add UEFI (ARM) testing
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
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

Changelog:
  - from v2:
      * rebase on top current master (with UEFI blobs merged)
      * added a Makefile rule to include bios-tables-test to aarch64 test=
s by
        default into 11/13 (kept Reviewed-bys)
      * other trivial fixes and cleanups (see per patch changelogs)
  =20
  - from v1:
      * rebase on top
         (1) [PATCH for-4.1 v3 00/12] bundle edk2 platform firmware  with=
 QEMU
        let me to drop edk2 images and drop Makefile magic to unpack them=
,
        Laszlo's series conveniently does it all for me.
      * use new path/names for firmware images as supplied by [1]
      * reorder patches a bit so that UEFI parts would go after generic c=
hanges

Series adds support for ACPI tables located above 4G. It adds 64-bit hand=
ling
necessary for testing arm/virt board (i.e. might be not complete wrt spec=
) and
uses recently merged UEFI (AVMF) firmware/test disk image which provides
an entry point[1] for fetching ACPI tables (RSDP pointer).

Git tree for testing:
   https://github.com/imammedo/qemu.git acpi_arm_tests_v3

Ref to previos vesrsion:
   [Qemu-devel] [PATCH for 4.1 v2 00/13] tests: acpi: add UEFI (ARM) test=
ing support
   https://www.mail-archive.com/qemu-devel@nongnu.org/msg607564.html

CC: Laszlo Ersek <lersek@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Gonglei <arei.gonglei@huawei.com>
CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
CC: Shannon Zhao <shannon.zhaosl@gmail.com>
CC: Wei Yang <richardw.yang@linux.intel.com>
CC: Andrew Jones <drjones@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: Ben Warren <ben@skyportsystems.com>

Igor Mammedov (13):
  tests: acpi: make RSDT test routine handle XSDT
  tests: acpi: rename acpi_parse_rsdp_table() into
    acpi_fetch_rsdp_table()
  tests: acpi: make pointer to RSDP 64bit
  tests: acpi: fetch X_DSDT if pointer to DSDT is 0
  tests: acpi: skip FACS table if board uses hw reduced ACPI profile
  tests: acpi: move boot_sector_init() into x86 tests branch
  tests: acpi: add acpi_find_rsdp_address_uefi() helper
  tests: acpi: add a way to start tests with UEFI firmware
  tests: acpi: ignore SMBIOS tests when UEFI firmware is used
  tests: add expected ACPI tables for arm/virt board
  tests: acpi: add simple arm/virt testcase
  tests: acpi: refactor rebuild-expected-aml.sh to dump ACPI tables for
    a specified list of targets
  tests: acpi: print error unable to dump ACPI table during rebuild

 tests/acpi-utils.h                      |   5 +-
 tests/Makefile.include                  |   1 +
 tests/acpi-utils.c                      |  58 ++++++++++----
 tests/bios-tables-test.c                | 133 ++++++++++++++++++++++++--=
------
 tests/data/acpi/rebuild-expected-aml.sh |  23 +++---
 tests/data/acpi/virt/APIC               | Bin 0 -> 168 bytes
 tests/data/acpi/virt/DSDT               | Bin 0 -> 18476 bytes
 tests/data/acpi/virt/FACP               | Bin 0 -> 268 bytes
 tests/data/acpi/virt/GTDT               | Bin 0 -> 96 bytes
 tests/data/acpi/virt/MCFG               | Bin 0 -> 60 bytes
 tests/data/acpi/virt/SPCR               | Bin 0 -> 80 bytes
 tests/vmgenid-test.c                    |   2 +-
 12 files changed, 162 insertions(+), 60 deletions(-)
 create mode 100644 tests/data/acpi/virt/APIC
 create mode 100644 tests/data/acpi/virt/DSDT
 create mode 100644 tests/data/acpi/virt/FACP
 create mode 100644 tests/data/acpi/virt/GTDT
 create mode 100644 tests/data/acpi/virt/MCFG
 create mode 100644 tests/data/acpi/virt/SPCR

--=20
2.7.4
