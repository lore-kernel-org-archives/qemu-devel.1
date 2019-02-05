Received: from eggs.gnu.org ([209.51.188.92]:55679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gr92h-0005eN-6f
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gr92f-0000xg-AF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:18:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59010
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gr92e-0000wW-OF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:18:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x15M4jAU066052
	for <qemu-devel@nongnu.org>; Tue, 5 Feb 2019 17:18:04 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qfjyagka0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 17:18:04 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 5 Feb 2019 22:18:04 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  5 Feb 2019 17:17:57 -0500
Message-Id: <20190205221757.3623571-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-3.0.x/PATCH for-3.0.1] acpi: Make TPM 2.0
 with TIS available as MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, mdroth@linux.ibm.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Stefan Berger <stefanb@linux.ibm.com>

This is a backport of rev 24cf5413aa0 to 3.0.x and 3.1.x.

This patch makes the a TPM 2.0 with TIS interface available under the
HID 'MSF0101'. This is supported by Linux and also Windows now
recognizes the TPM 2.0 with TIS interface. Leave the TPM 1.2 as before.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae9e0..429d9b05e0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2134,8 +2134,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
             if (TPM_IS_TIS(tpm_find())) {
-                dev = aml_device("ISA.TPM");
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+                if (misc->tpm_version == TPM_VERSION_2_0) {
+                    dev = aml_device("TPM");
+                    aml_append(dev, aml_name_decl("_HID",
+                                                  aml_string("MSFT0101")));
+                } else {
+                    dev = aml_device("ISA.TPM");
+                    aml_append(dev, aml_name_decl("_HID",
+                                                  aml_eisaid("PNP0C31")));
+                }
+
                 aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
                 crs = aml_resource_template();
                 aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
-- 
2.20.1
