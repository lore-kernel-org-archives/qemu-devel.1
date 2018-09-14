Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soV-0008MS-DW
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soS-0003ew-Kk
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:31 -0400
Received: from mail-eopbgr690075.outbound.protection.outlook.com
	([40.107.69.75]:22016
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0soS-0003bD-C8
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:28 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Fri, 14 Sep 2018 13:26:58 -0500
Message-Id: <1536949623-23564-4-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/8] x86_iommu/amd: remove V=1 check from
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Currently, the amdvi_validate_dte() assumes that a valid DTE will
always have V=1. This is not true. The V=1 means that bit[127:1] are
valid. A valid DTE can have IV=1 and V=0 (i.e pt=off, intremap=on).

Remove the V=1 check from amdvi_validate_dte(), make the caller
responsible to check for V or IV bits.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 hw/i386/amd_iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1fd669f..225825e 100644
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
@@ -967,7 +967,8 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     }
 
     /* devices with V = 0 are not translated */
-    if (!amdvi_get_dte(s, devid, entry)) {
+    if (!amdvi_get_dte(s, devid, entry) &&
+        !(entry[0] & AMDVI_DEV_VALID)) {
         goto out;
     }
 
-- 
2.7.4
