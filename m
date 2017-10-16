Received: from eggs.gnu.org ([2001:4830:134:3::10]:46554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1e41N3-0001mA-8o
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1e41N0-0000cc-4G
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:07:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1e41Mz-0000bR-UG
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:07:34 -0400
From: Mohammed Gamal <mgamal@redhat.com>
Date: Mon, 16 Oct 2017 11:06:23 +0200
Message-Id: <1508144783-18792-3-git-send-email-mgamal@redhat.com>
In-Reply-To: <1508144783-18792-1-git-send-email-mgamal@redhat.com>
References: <1508144783-18792-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND 2/2] x86_iommu: check if machine has PCI
 bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, ehabkost@redhat.com, peterx@redhat.com, pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru, Mohammed Gamal <mgamal@redhat.com>

Starting qemu with
qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
leads to a segfault. The code assume PCI bus is present and
tries to access the bus structure without checking.

Since Intel VT-d and AMDVI should only work with PCI, add a
check for PCI bus and return error if not present.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 hw/i386/x86-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 51de519..8a01a2d 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -88,7 +88,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
         PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
     QLIST_INIT(&x86_iommu->iec_notifiers);
 
-    if (!pcms) {
+    if (!pcms || !pcms->bus) {
         error_setg(errp, "Machine-type '%s' not supported by IOMMU",
                    mc->name);
         return;
-- 
1.8.3.1
