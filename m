Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cS4q9-0004j1-SX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cS4q5-0006uW-18
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:36:33 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cS4q4-0006uN-Qu
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:36:28 -0500
Received: by mail-wm0-x22a.google.com with SMTP id r144so78534129wme.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 08:36:28 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 13 Jan 2017 16:36:18 +0000
Message-Id: <1484325378-28402-1-git-send-email-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/virt-acpi - reserve ECAM space as
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
Cc: peter.maydell@linaro.org, graeme.gregory@linaro.org, al.stone@linaro.org, leif.lindholm@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Linux for arm64 v4.10 and later will complain if the ECAM config space is
not reserved in the ACPI namespace:

  acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0x3f000000-0x3fffffff] not reserved in ACPI namespace

The rationale is that OSes that don't consume the MCFG table should still
be able to infer that the PCI config space MMIO region is occupied.

So update the ACPI table generation routine to add this reservation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 hw/arm/virt-acpi-build.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 085a61117378..e8769dc6288f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -310,6 +310,12 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     Aml *dev_rp0 = aml_device("%s", "RP0");
     aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
     aml_append(dev, dev_rp0);
+
+    Aml *dev_res0 = aml_device("%s", "RES0");
+    crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(base_ecam, size_ecam, AML_READ_WRITE));
+    aml_append(dev_res0, aml_name_decl("_CRS", crs));
+    aml_append(dev, dev_res0);
     aml_append(scope, dev);
 }
 
-- 
2.7.4
