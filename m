Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPr-0000yh-H0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0005At-Io
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPp-0004w9-BM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPg-0003A1-Db
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:37 +0000
Message-Id: <1484834995-26826-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/36] hw/arm/virt-acpi - reserve ECAM space as
 PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Linux for arm64 v4.10 and later will complain if the ECAM config space is
not reserved in the ACPI namespace:

  acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0x3f000000-0x3fffffff] not reserved in ACPI namespace

The rationale is that OSes that don't consume the MCFG table should still
be able to infer that the PCI config space MMIO region is occupied.

So update the ACPI table generation routine to add this reservation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-id: 1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 085a611..50d52f6 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -310,6 +310,13 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     Aml *dev_rp0 = aml_device("%s", "RP0");
     aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
     aml_append(dev, dev_rp0);
+
+    Aml *dev_res0 = aml_device("%s", "RES0");
+    aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
+    crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(base_ecam, size_ecam, AML_READ_WRITE));
+    aml_append(dev_res0, aml_name_decl("_CRS", crs));
+    aml_append(dev, dev_res0);
     aml_append(scope, dev);
 }
 
-- 
2.7.4
