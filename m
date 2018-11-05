Received: from eggs.gnu.org ([2001:4830:134:3::10]:60652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQq-000820-41
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQp-0003LR-49
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQo-0003Jx-QK
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:59 -0500
Date: Mon, 5 Nov 2018 13:16:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-26-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 25/33] tests/bios-tables-test: add 64-bit PCI
 MMIO aperture round-up test on Q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

In commit 9fa99d2519cb ("hw/pci-host: Fix x86 Host Bridges 64bit PCI
hole", 2017-11-16), we meant to expose such a 64-bit PCI MMIO aperture in
the ACPI DSDT that would be at least as large as the new "pci-hole64-size"
property (2GB on i440fx, 32GB on q35). The goal was to offer "enough"
64-bit MMIO aperture to the guest OS for hotplug purposes.

Previous patch fixed the issue that the aperture is extended relative to
a possibly incorrect base.  This may result in an aperture size that is
smaller than the intent of commit 9fa99d2519cb.

This patch adds a test to make sure it won't happen again.

In the test case being added:
- use 128 MB initial RAM size,
- ask for one DIMM hotplug slot,
- ask for 2 GB maximum RAM size,
- use a pci-testdev with a 64-bit BAR of 2 GB size.

Consequences:

(1) In pc_memory_init() [hw/i386/pc.c], the DIMM hotplug area size is
    initially set to 2048-128 = 1920 MB. (Maximum RAM size minus initial
    RAM size.)

(2) The DIMM area base is set to 4096 MB (because the initial RAM is only
    128 MB -- there is no initial "high RAM").

(3) Due to commit 085f8e88ba73 ("pc: count in 1Gb hugepage alignment when
    sizing hotplug-memory container", 2014-11-24), we add 1 GB for the one
    DIMM hotplug slot that was specified. This sets the DIMM area size to
    1920+1024 = 2944 MB.

(4) The reserved-memory-end address (exclusive) is set to 4096 + 2944 =
    7040 MB (DIMM area base plus DIMM area size).

(5) The reserved-memory-end address is rounded up to GB alignment,
    yielding 7 GB (7168 MB).

(6) Given the 2 GB BAR size of pci-testdev, SeaBIOS allocates said 64-bit
    BAR in 64-bit address space.

(7) Because reserved-memory-end is at 7 GB, it is unaligned for the 2 GB
    BAR. Therefore SeaBIOS allocates the BAR at 8 GB. QEMU then
    (correctly) assigns the root bridge aperture base this BAR address, to
    be exposed in \_SB.PCI0._CRS.

(8) The intent of commit 9fa99d2519cb dictates that QEMU extend the
    aperture size to 32 GB, implying a 40 GB end address. However, QEMU
    performs the extension relative to reserved-memory-end (7 GB), not
    relative to the bridge aperture base that was correctly deduced from
    SeaBIOS's BAR programming (8 GB). Therefore we see 39 GB as the
    aperture end address in \_SB.PCI0._CRS:

> QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
>     0x0000000000000000, // Granularity
>     0x0000000200000000, // Range Minimum
>     0x00000009BFFFFFFF, // Range Maximum
>     0x0000000000000000, // Translation Offset
>     0x00000007C0000000, // Length
>     ,, , AddressRangeMemory, TypeStatic)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index b14c8eaa17..d661d9be62 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -708,6 +708,21 @@ static void test_acpi_q35_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_mmio64(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".mmio64",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types)
+    };
+
+    test_acpi_one("-m 128M,slots=1,maxmem=2G "
+                  "-device pci-testdev,membar=2G",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_piix4_tcg_cphp(void)
 {
     test_data data;
@@ -875,6 +890,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
+        qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
         qtest_add_func("acpi/piix4/ipmi", test_acpi_piix4_tcg_ipmi);
         qtest_add_func("acpi/q35/ipmi", test_acpi_q35_tcg_ipmi);
         qtest_add_func("acpi/piix4/cpuhp", test_acpi_piix4_tcg_cphp);
-- 
MST
