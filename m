Received: from eggs.gnu.org ([2001:4830:134:3::10]:54702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzm6z-0008Po-0v
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzlrg-0002j5-Tf
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:17 -0400
Received: from mail-eopbgr730047.outbound.protection.outlook.com
	([40.107.73.47]:60256
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1fzlrg-0002ht-MW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:12 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Tue, 11 Sep 2018 11:49:47 -0500
Message-Id: <1536684589-11718-5-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/6] i386: acpi: add IVHD device entry for
 IOAPIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

When interrupt remapping is enabled, add a special IVHD device
(type IOAPIC) -- which is typically PCI device 14:0.0. Linux IOMMU driver
checks for this special device.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/acpi-build.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae..5c2c638 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2519,6 +2519,7 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 {
+    int ivhd_table_len = 28;
     int iommu_start = table_data->len;
     AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
 
@@ -2540,8 +2541,16 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                              (1UL << 6) | /* PrefSup      */
                              (1UL << 7),  /* PPRSup       */
                              1);
+
+    /*
+     * When interrupt remapping is enabled, we add a special IVHD device
+     * for type IO-APIC.
+     */
+    if (s->intr_enabled) {
+        ivhd_table_len += 8;
+    }
     /* IVHD length */
-    build_append_int_noprefix(table_data, 28, 2);
+    build_append_int_noprefix(table_data, ivhd_table_len, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data, s->devid, 2);
     /* Capability offset */
@@ -2565,6 +2574,15 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
      */
     build_append_int_noprefix(table_data, 0x0000001, 4);
 
+    /*
+     * When interrupt remapping is enabled, Linux IOMMU driver also checks
+     * for special IVHD device (type IO-APIC), which is typically presented
+     * as PCI device 14:00.0.
+     */
+    if (s->intr_enabled) {
+        build_append_int_noprefix(table_data, 0x0100a00000000048, 8);
+    }
+
     build_header(linker, table_data, (void *)(table_data->data + iommu_start),
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
-- 
2.7.4
