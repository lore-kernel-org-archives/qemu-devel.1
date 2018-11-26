Received: from eggs.gnu.org ([2001:4830:134:3::10]:37674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmR-0000m1-J9
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRJmM-0004PW-MA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:30:39 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 26 Nov 2018 17:29:33 +0100
Message-Id: <20181126162942.21258-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] hw: acpi: RSDP fixes and refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This patch serie fixes a couple of RSDP checksum related issues:

- On RSDP rev2, we are not adding the extended checksum and computing
  the checksum on the full table instead of the first 20 bytes.
- On RSDP rev1, we are computing the checksum on 36 bytes instead of 20.
  We're lucky enough that this is only adding zeroes to the checksum.

A guest Linux kernel does not seem to care about RSDP checksums, so
those 2 fixes are mostly for correctness sake.
Any machine type that generates rev2 RSDP will see its RSDP table
modified but since x86 builds RSDP v1 and all ACPI tests only run on
either pc or q35, the ACPI tests tables are not affected by this fix.

The serie also extends the ARM virt ACPI RSDP build routine to support
both RSDP v1 and v2, in order to share this code between x86 and
aarch64. While extending, we also convert the routine to the latest
build_append_foo() API. The new implementation is a closer reflection of
the ACPI spec itself, is endian agnostic and allows for getting rid of the
AcpiRsdpDescriptor structure.

Igor Mammedov (2):
  hw: arm: acpi: Fix incorrect checksums in RSDP
  hw: i386: Use correct RSDT length for checksum

Samuel Ortiz (6):
  hw: acpi: The RSDP build API can return void
  hw: arm: Carry RSDP specific data through AcpiRsdpData
  hw: arm: Convert the RSDP build to the buid_append_foo() API
  hw: arm: Support both legacy and current RSDP build
  hw: acpi: Export and share the ARM RSDP build
  hw: acpi: Remove AcpiRsdpDescriptor and fix tests

 include/hw/acpi/acpi-defs.h | 44 ++++++++++++++------
 include/hw/acpi/aml-build.h |  5 +++
 tests/acpi-utils.h          |  5 ++-
 hw/acpi/aml-build.c         | 81 +++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 35 ++--------------
 hw/i386/acpi-build.c        | 31 ++------------
 tests/acpi-utils.c          | 48 +++++++++++++++++-----
 tests/bios-tables-test.c    | 27 +++++++++----
 tests/vmgenid-test.c        |  8 ++--
 9 files changed, 193 insertions(+), 91 deletions(-)

-- 
2.19.1
