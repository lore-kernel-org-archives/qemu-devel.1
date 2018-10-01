Received: from eggs.gnu.org ([2001:4830:134:3::10]:59142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747e-0005IA-Aj
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747d-00059B-Hy
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:50 -0400
Received: from mail-co1nam03on0606.outbound.protection.outlook.com
	([2a01:111:f400:fe48::606]:10238
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747d-00058x-7L
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:49 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:45 +0000
Message-ID: <1538423049-29524-10-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 9/9] x86_iommu/amd: Enable Guest virtual
 APIC support
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
---
 hw/i386/acpi-build.c | 3 ++-
 hw/i386/amd_iommu.h  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1ef396d..236a20e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2518,7 +2518,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linke=
r)
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
index 8061e9c..687fcd8 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -176,7 +176,7 @@
 /* extended feature support */
 #define AMDVI_EXT_FEATURES (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
-        AMDVI_GATS_MODE | AMDVI_HATS_MODE)
+        AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
=20
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
--=20
2.7.4
