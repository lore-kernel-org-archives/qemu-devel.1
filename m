Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747b-0005G5-UX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g747Z-00057O-GE
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:47 -0400
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com
	([104.47.37.49]:27474
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g747Z-000562-8p
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:44:45 -0400
From: "Singh, Brijesh" <brijesh.singh@amd.com>
Date: Mon, 1 Oct 2018 19:44:32 +0000
Message-ID: <1538423049-29524-4-git-send-email-brijesh.singh@amd.com>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 3/9] x86_iommu/amd: remove V=1 check from
 amdvi_validate_dte()
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

Currently, the amdvi_validate_dte() assumes that a valid DTE will
always have V=3D1. This is not true. The V=3D1 means that bit[127:1] are
valid. A valid DTE can have IV=3D1 and V=3D0 (i.e address translation
disabled and interrupt remapping enabled)

Remove the V=3D1 check from amdvi_validate_dte(), make the caller
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
---
 hw/i386/amd_iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1fd669f..7206bb0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -807,7 +807,7 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
            AMDVI_DEV_PERM_SHIFT;
 }
=20
-/* a valid entry should have V =3D 1 and reserved bits honoured */
+/* validate that reserved bits are honoured */
 static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
                                uint64_t *dte)
 {
@@ -820,7 +820,7 @@ static bool amdvi_validate_dte(AMDVIState *s, uint16_t =
devid,
         return false;
     }
=20
-    return dte[0] & AMDVI_DEV_VALID;
+    return true;
 }
=20
 /* get a device table entry given the devid */
@@ -966,8 +966,12 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, =
hwaddr addr,
         return;
     }
=20
-    /* devices with V =3D 0 are not translated */
     if (!amdvi_get_dte(s, devid, entry)) {
+        return;
+    }
+
+    /* devices with V =3D 0 are not translated */
+    if (!(entry[0] & AMDVI_DEV_VALID)) {
         goto out;
     }
=20
--=20
2.7.4
