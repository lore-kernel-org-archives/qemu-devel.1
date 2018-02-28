Received: from eggs.gnu.org ([2001:4830:134:3::10]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er2fg-0004gP-4R
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er2ff-0001uN-1X
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:25:28 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 28 Feb 2018 15:23:45 +0100
Message-Id: <1519827835-239519-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/10] generalize build_fadt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org


v2:
  * fix typo in "acpi: remove unused acpi-dsdt.aml"
  * split ACPI_PORT_SMI_CMD into separate cleanup patch
  * s/pm1_/pm1a_/, s/c2_latency/plvl2_lat/, s/c3_latency/plvl3_lat/
    and fix conflicts in followup patches caused by renaming
  * conditional FIRMWARE_CTRL, DSDT patching is introduced in
    the patch that makes build_fadt() generic instead of earlier
    "pc: acpi: isolate FADT specific data into AcpiFadtData structure"
  * update comment to mention that build_fadt() supports 5.1 revision
 =20


Series first cleanups ACPI code around build_fadt() and then
converts current packed structure approach to a build_append_FOO()
API, getting rid of error prone explicit endianness conversions
in code and making build_fadt() look more like APCI table declaration
from spec, which should be easier to read/maintain. After that
build_fadt() becomes generic enough that we could drop ARM specific
implementation and reuse generic build_fadt(), reducing code
duplication.

PS: tested only x86 which has make check coverage,
    ARM was only slightly tested.=20

git tree for testing:
  https://github.com/imammedo/qemu.git fadt_refactoring_v2

CC: "Michael S. Tsirkin" <mst@redhat.com>=20
CC: Shannon Zhao <zhaoshenglong@huawei.com>=20
CC: Auger Eric <eric.auger@redhat.com>
CC: qemu-devel@nongnu.org=20
CC: qemu-arm@nongnu.org=20

Igor Mammedov (10):
  acpi: remove unused acpi-dsdt.aml
  pc: replace pm object initialization with one-liner in
    acpi_get_pm_info()
  acpi: reuse AcpiGenericAddress instead of Acpi20GenericAddress
  acpi: add build_append_gas() helper for Generic Address Structure
  acpi: move ACPI_PORT_SMI_CMD define to header it belongs to
  pc: acpi: isolate FADT specific data into AcpiFadtData structure
  pc: acpi: use build_append_foo() API to construct FADT
  acpi: move build_fadt() from i386 specific to generic ACPI source
  virt_arm: acpi: reuse common build_fadt()
  tests: acpi: don't read all fields in test_acpi_fadt_table()

 include/hw/acpi/acpi-defs.h | 136 ++++++++----------------------
 include/hw/acpi/aml-build.h |  23 ++++++
 include/hw/isa/apm.h        |   3 +
 Makefile                    |   1 -
 hw/acpi/aml-build.c         | 140 +++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |  39 ++++-----
 hw/i386/acpi-build.c        | 196 ++++++++++++++------------------------=
------
 hw/isa/apm.c                |   1 -
 pc-bios/acpi-dsdt.aml       | Bin 4405 -> 0 bytes
 tests/bios-tables-test.c    |  82 ++++--------------
 10 files changed, 294 insertions(+), 327 deletions(-)
 delete mode 100644 pc-bios/acpi-dsdt.aml

--=20
2.7.4
