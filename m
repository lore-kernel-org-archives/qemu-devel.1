Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eoqEd-0005W6-RZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eoqEc-0004zU-Oa
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:44:27 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 22 Feb 2018 13:42:47 +0100
Message-Id: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] generalize build_fadt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org

Series first cleanups ACPI code around build_fadt() and then
converts current packed structure approach to a build_append_FOO()
API, getting rid of error prone explicit endianness conversions
in code and making build_fadt() look more like APCI table declaration
from spec, which should be easier to read/maintain. After that
build_fadt() becomes generic enough that we could drop ARM specific
implementation and reuse generic build_fadt(), reducing code
duplication.

PS: tested only x86 which has make check coverage,
    ARM was only slightly tested. 

git tree for testing:
  https://github.com/imammedo/qemu.git fadt_refactoring_v1

CC: "Michael S. Tsirkin" <mst@redhat.com> 
CC: Shannon Zhao <zhaoshenglong@huawei.com> 
CC: Peter Maydell <peter.maydell@linaro.org> 
CC: Andrew Jones <drjones@redhat.com>
CC: qemu-devel@nongnu.org 
CC: qemu-arm@nongnu.org 

Igor Mammedov (9):
  acpi: remove unused acpi-dsdt.aml
  pc: replace pm object initialization with one-liner in
    acpi_get_pm_info()
  acpi: reuse AcpiGenericAddress instead of Acpi20GenericAddress
  acpi: add build_append_gas() helper for Generic Address Structure
  pc: acpi: isolate FADT specific data into AcpiFadtData structure
  pc: acpi: use build_append_foo() API to construct FADT
  acpi: move build_fadt() from i386 specific to generic ACPI source
  virt_arm: acpi: reuse common build_fadt()
  tests: acpi: don't read all fields in test_acpi_fadt_table()

 include/hw/acpi/acpi-defs.h | 136 +++++++-----------------------
 include/hw/acpi/aml-build.h |  23 ++++++
 Makefile                    |   1 -
 hw/acpi/aml-build.c         | 140 +++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |  39 ++++-----
 hw/i386/acpi-build.c        | 197 ++++++++++++++------------------------------
 pc-bios/acpi-dsdt.aml       | Bin 4405 -> 0 bytes
 tests/bios-tables-test.c    |  82 ++++--------------
 8 files changed, 292 insertions(+), 326 deletions(-)
 delete mode 100644 pc-bios/acpi-dsdt.aml

-- 
2.7.4
