Received: from eggs.gnu.org ([2001:4830:134:3::10]:59069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747a-0005FN-Sg
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747Y-00056y-VZ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:46 -0400
Received: from mail-co1nam03on0614.outbound.protection.outlook.com
	([2a01:111:f400:fe48::614]:8231
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747Y-00054U-O2
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:44 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:41 +0000
Message-ID: <1538423049-29524-8-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 7/9] i386: acpi: add IVHD device entry for
 IOAPIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>

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
---
 hw/i386/acpi-build.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1599caa..1ef396d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2467,9 +2467,12 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linke=
r)
  *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
  *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
  */
+#define IOAPIC_SB_DEVID   (uint64_t)PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
+
 static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker)
 {
+    int ivhd_table_len =3D 28;
     int iommu_start =3D table_data->len;
     AMDVIState *s =3D AMD_IOMMU_DEVICE(x86_iommu_get_default());
=20
@@ -2491,8 +2494,16 @@ build_amd_iommu(GArray *table_data, BIOSLinker *link=
er)
                              (1UL << 6) | /* PrefSup      */
                              (1UL << 7),  /* PPRSup       */
                              1);
+
+    /*
+     * When interrupt remapping is supported, we add a special IVHD device
+     * for type IO-APIC.
+     */
+    if (x86_iommu_get_default()->intr_supported) {
+        ivhd_table_len +=3D 8;
+    }
     /* IVHD length */
-    build_append_int_noprefix(table_data, 28, 2);
+    build_append_int_noprefix(table_data, ivhd_table_len, 2);
     /* DeviceID */
     build_append_int_noprefix(table_data, s->devid, 2);
     /* Capability offset */
@@ -2516,6 +2527,21 @@ build_amd_iommu(GArray *table_data, BIOSLinker *link=
er)
      */
     build_append_int_noprefix(table_data, 0x0000001, 4);
=20
+    /*
+     * Add a special IVHD device type.
+     * Refer to spec - Table 95: IVHD device entry type codes
+     *
+     * Linux IOMMU driver checks for the special IVHD device (type IO-APIC=
).
+     * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
+     */
+    if (x86_iommu_get_default()->intr_supported) {
+        build_append_int_noprefix(table_data,
+                                 (0x1ull << 56) |           /* type IOAPIC=
 */
+                                 (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devi=
d */
+                                 0x48,                      /* special dev=
ice */
+                                 8);
+    }
+
     build_header(linker, table_data, (void *)(table_data->data + iommu_sta=
rt),
                  "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
 }
--=20
2.7.4
