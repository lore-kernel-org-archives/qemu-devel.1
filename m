Received: from eggs.gnu.org ([2001:4830:134:3::10]:35661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0sob-0008RG-QW
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soY-0003jX-GW
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:37 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com
	([40.107.69.78]:6062
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0soY-0003it-5t
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:34 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Fri, 14 Sep 2018 13:27:01 -0500
Message-Id: <1536949623-23564-7-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 6/8] i386: acpi: add IVHD device entry for
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
(type IOAPIC).

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/acpi-build.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae..0a19e25 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2516,9 +2516,12 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
  *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
  *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
  */
+#define IOAPIC_SB_DEVID   (uint64_t)PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 {
+    int ivhd_table_len = 28;
     int iommu_start = table_data->len;
     AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
 
@@ -2540,8 +2543,16 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
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
@@ -2565,6 +2576,22 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
      */
     build_append_int_noprefix(table_data, 0x0000001, 4);
 
+    /*
+     * Add a special IVHD device type.
+     * Refer to spec - Table 95: IVHD device entry type codes
+     *
+     * When interrupt remapping is enabled Linux IOMMU driver checks for
+     * the special IVHD device (type IO-APIC).
+     * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
+     */
+    if (s->intr_enabled) {
+        build_append_int_noprefix(table_data,
+                                 (0x1ull << 56) |           /* type IOAPIC */
+                                 (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
+                                 0x48,                      /* special device */
+                                 8);
+    }
+
     build_header(linker, table_data, (void *)(table_data->data + iommu_start),
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
-- 
2.7.4
