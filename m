Received: from eggs.gnu.org ([2001:4830:134:3::10]:60457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQf-0007sS-BZ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQc-00034K-ES
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQa-0002z5-9u
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:46 -0500
Date: Mon, 5 Nov 2018 13:16:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-20-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 19/33] x86_iommu/amd: Enable Guest virtual APIC
 support
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

Now that amd-iommu support interrupt remapping, enable the GASup in IVRS
table and GASup in extended feature register to indicate that IOMMU
support guest virtual APIC mode. GASup provides option to guest OS to
make use of 128-bit IRTE.

Note that the GAMSup is set to zero to indicate that amd-iommu does not
support guest virtual APIC mode (aka AVIC) which would be used for the
nested VMs.

See Table 21 from IOMMU spec for interrupt virtualization controls

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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
 hw/i386/amd_iommu.h  | 12 ++++++------
 hw/i386/acpi-build.c |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8061e9c49c..c52886f3ed 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -176,7 +176,7 @@
 /* extended feature support */
 #define AMDVI_EXT_FEATURES (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
-        AMDVI_GATS_MODE | AMDVI_HATS_MODE)
+        AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
@@ -242,11 +242,11 @@
 #define AMDVI_IOAPIC_INT_TYPE_EINT           0x7
 
 /* Pass through interrupt */
-#define AMDVI_DEV_INT_PASS_MASK         (1UL << 56)
-#define AMDVI_DEV_EINT_PASS_MASK        (1UL << 57)
-#define AMDVI_DEV_NMI_PASS_MASK         (1UL << 58)
-#define AMDVI_DEV_LINT0_PASS_MASK       (1UL << 62)
-#define AMDVI_DEV_LINT1_PASS_MASK       (1UL << 63)
+#define AMDVI_DEV_INT_PASS_MASK         (1ULL << 56)
+#define AMDVI_DEV_EINT_PASS_MASK        (1ULL << 57)
+#define AMDVI_DEV_NMI_PASS_MASK         (1ULL << 58)
+#define AMDVI_DEV_LINT0_PASS_MASK       (1ULL << 62)
+#define AMDVI_DEV_LINT1_PASS_MASK       (1ULL << 63)
 
 /* Interrupt remapping table fields (Guest VAPIC not enabled) */
 union irte {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1ef396ddbb..236a20eaa8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2518,7 +2518,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
     build_append_int_noprefix(table_data,
                              (48UL << 30) | /* HATS   */
                              (48UL << 28) | /* GATS   */
-                             (1UL << 2),    /* GTSup  */
+                             (1UL << 2)   | /* GTSup  */
+                             (1UL << 6),    /* GASup  */
                              4);
     /*
      *   Type 1 device entry reporting all devices
-- 
MST
