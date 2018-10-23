Received: from eggs.gnu.org ([2001:4830:134:3::10]:51592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JK-0003G8-Al
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008BY-2R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:05 -0400
Received: from [185.30.24.106] (port=13462
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JD-00088q-0L
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:41:59 -0400
Date: Tue, 23 Oct 2018 19:41:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-14-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/28] i386: acpi: add IVHD device entry for
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Igor Mammedov <imammedo@redhat.com>

From: "Singh, Brijesh" <brijesh.singh@amd.com>

When interrupt remapping is enabled, add a special IVHD device
(type IOAPIC).

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Acked-by: Peter Xu <peterx@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1599caa7c5..1ef396ddbb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2467,9 +2467,12 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker)
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
 
@@ -2491,8 +2494,16 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
                              (1UL << 6) | /* PrefSup      */
                              (1UL << 7),  /* PPRSup       */
                              1);
+
+    /*
+     * When interrupt remapping is supported, we add a special IVHD device
+     * for type IO-APIC.
+     */
+    if (x86_iommu_get_default()->intr_supported) {
+        ivhd_table_len += 8;
+    }
     /* IVHD length */
-    build_append_int_noprefix(table_data, 28, 2);
+    build_append_int_noprefix(table_data, ivhd_table_len, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data, s->devid, 2);
     /* Capability offset */
@@ -2516,6 +2527,21 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
      */
     build_append_int_noprefix(table_data, 0x0000001, 4);
 
+    /*
+     * Add a special IVHD device type.
+     * Refer to spec - Table 95: IVHD device entry type codes
+     *
+     * Linux IOMMU driver checks for the special IVHD device (type IO-APIC).
+     * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
+     */
+    if (x86_iommu_get_default()->intr_supported) {
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
MST
