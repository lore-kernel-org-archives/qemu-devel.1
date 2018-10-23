Received: from eggs.gnu.org ([2001:4830:134:3::10]:51474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JG-0003DV-Pr
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JD-0008Aq-Nf
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:02 -0400
Received: from [185.30.24.106] (port=13438
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JC-00084l-N6
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:41:59 -0400
Date: Tue, 23 Oct 2018 19:41:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-10-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/28] x86_iommu/amd: remove V=1 check from
 amdvi_validate_dte()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

From: "Singh, Brijesh" <brijesh.singh@amd.com>

Currently, the amdvi_validate_dte() assumes that a valid DTE will
always have V=1. This is not true. The V=1 means that bit[127:1] are
valid. A valid DTE can have IV=1 and V=0 (i.e address translation
disabled and interrupt remapping enabled)

Remove the V=1 check from amdvi_validate_dte(), make the caller
responsible to check for V or IV bits.

This also fixes a bug in existing code that when error is
detected during the translation we'll fail the translation
instead of assuming a passthrough mode.

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
 hw/i386/amd_iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1fd669fef8..7206bb09c2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -807,7 +807,7 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
            AMDVI_DEV_PERM_SHIFT;
 }
 
-/* a valid entry should have V = 1 and reserved bits honoured */
+/* validate that reserved bits are honoured */
 static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
                                uint64_t *dte)
 {
@@ -820,7 +820,7 @@ static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
         return false;
     }
 
-    return dte[0] & AMDVI_DEV_VALID;
+    return true;
 }
 
 /* get a device table entry given the devid */
@@ -966,8 +966,12 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
         return;
     }
 
-    /* devices with V = 0 are not translated */
     if (!amdvi_get_dte(s, devid, entry)) {
+        return;
+    }
+
+    /* devices with V = 0 are not translated */
+    if (!(entry[0] & AMDVI_DEV_VALID)) {
         goto out;
     }
 
-- 
MST
