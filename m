Received: from eggs.gnu.org ([2001:4830:134:3::10]:54537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzm6R-0008Oo-BM
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzlrs-0002vX-E7
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:27 -0400
Received: from mail-eopbgr730082.outbound.protection.outlook.com
	([40.107.73.82]:22781
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1fzlrr-0002ja-Lb
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:24 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Tue, 11 Sep 2018 11:49:49 -0500
Message-Id: <1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 6/6] x86_iommu/amd: Enable Guest virtual APIC
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Now that amd-iommu support interrupt remapping, enable the GASup in IVRS
table and GASup in extended feature register to indicate that IOMMU
support guest virtual APIC mode.

Note that the GAMSup is set to zero to indicate that  Guest Virtual
APIC does not support advanced interrupt features (i.e virtualized
interrupts using the guest virtual APIC).

See Table 21 from IOMMU spec for interrupt virtualization controls

IOMMU spec: https://support.amd.com/TechDocs/48882_IOMMU.pdf

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/acpi-build.c | 3 ++-
 hw/i386/amd_iommu.h  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5c2c638..1cbc8ba 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2565,7 +2565,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
     build_append_int_noprefix(table_data,
                              (48UL << 30) | /* HATS   */
                              (48UL << 28) | /* GATS   */
-                             (1UL << 2),    /* GTSup  */
+                             (1UL << 2)   | /* GTSup  */
+                             (1UL << 6),    /* GASup  */
                              4);
     /*
      *   Type 1 device entry reporting all devices
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 1dab974..5defaac 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -177,7 +177,7 @@
 /* extended feature support */
 #define AMDVI_EXT_FEATURES (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
-        AMDVI_GATS_MODE | AMDVI_HATS_MODE)
+        AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
-- 
2.7.4
