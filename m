Received: from eggs.gnu.org ([209.51.188.92]:60600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gn8bI-0000vt-5M
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gn8bH-0002Ui-5y
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:01:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gn8bF-0002PG-0C
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 16:01:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PKtg9r106867
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:01:08 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q89x0g5je-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:01:08 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Fri, 25 Jan 2019 21:01:07 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 25 Jan 2019 16:00:58 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190125210058.1092551-1-stefanb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] acpi: Make TPM 2.0 with TIS available as
 MSFT0101
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, Stefan Berger <stefanb@linux.ibm.com>

This patch makes the a TPM 2.0 with TIS interface available under the
HID 'MSF0101'. This is supported by Linux and also Windows now
recognizes the TPM 2.0 with TIS interface. Leave the TPM 1.2 as before.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/i386/acpi-build.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e21a31f82..f51225b4a7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2141,8 +2141,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
 
             if (TPM_IS_TIS(tpm)) {
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
