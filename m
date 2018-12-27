Received: from eggs.gnu.org ([208.118.235.92]:47822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gcWZv-0001iA-GY
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gcWZq-0002K2-Ij
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gcWZq-0002Hu-Ci
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:23:58 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 27 Dec 2018 15:13:26 +0100
Message-Id: <1545920014-114011-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/8] tests: apci: consolidate and cleanup
 ACPI test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, wainersm@redhat.com

Changes since v1:
  * rebase on top of current master due to a lots of conflicts with
    'qtest global' removal being merged first
  * drop explicit cast to uint8_t* as sdt->aml is uint8_t* now
  * drop not comment explaining strange offsets as offsets are
    now follow ACPI spec

While working on adding tests for virt/arm board (uefi/XSDT/64-bit table pointers),
I found it's rather difficult to deal with mixed ACPI testing code that we've
collected so far. So instead of just adding a pile of XSDT hacks on top, here
goes small refactoring series:
   * that removes dead code
   * replaces reading tables with a fetch per table everywhere instead of
     mix of field by field and whole table
   * consolidates the way tables are read (reduces code duplication)
   * test no longer depends on ACPI structures from QEMU (i.e. doesn't affected
     by mistakes there) 
   * fixes FACS not being compared against reference tables
Overall test is reduced on ~160LOC and hopefully it makes easier to follow and
add more stuff on top.

PS:
arm/virt test patches fill follow up a separate series on top of this one
for not to mix things up

Git tree for testing:
  https://github.com/imammedo/qemu acpi_tests_cleanup_v2

CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Laurent Vivier <lvivier@redhat.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
CC: wainersm@redhat.com


Igor Mammedov (8):
  tests: acpi: use AcpiSdtTable::aml in consistent way
  tests: acpi: make sure FADT is fetched only once
  tests: acpi: simplify rsdt handling
  tests: acpi: reuse fetch_table() for fetching FACS and DSDT
  tests: acpi: reuse fetch_table() in vmgenid-test
  tests: smbios: fetch whole table in one step instead of reading it
    step by step
  tests: acpi: squash sanitize_fadt_ptrs() into test_acpi_fadt_table()
  tests: acpi: use AcpiSdtTable::aml instead of
    AcpiSdtTable::header::signature

 tests/acpi-utils.h       |  44 ++------
 tests/acpi-utils.c       |  35 +++++--
 tests/bios-tables-test.c | 259 ++++++++++++-----------------------------------
 tests/vmgenid-test.c     |  64 ++++--------
 4 files changed, 121 insertions(+), 281 deletions(-)

-- 
2.7.4
