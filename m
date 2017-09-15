Received: from eggs.gnu.org ([2001:4830:134:3::10]:55522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dsoa0-0000Fl-My
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dsoZr-0003ES-55
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:14:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1dsoZq-0003Ds-VA
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:14:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C1373680F
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 11:14:30 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
Date: Fri, 15 Sep 2017 13:13:46 +0200
Message-Id: <1505474026-13151-3-git-send-email-mgamal@redhat.com>
In-Reply-To: <1505474026-13151-1-git-send-email-mgamal@redhat.com>
References: <1505474026-13151-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] x86_iommu: check if machine has PCI bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, thuth@redhat.com, peterx@redhat.com, Mohammed Gamal <mgamal@redhat.com>

Starting qemu with
qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
leads to a segfault. The code assume PCI bus is present and
tries to access the bus structure without checking.

Since Intel VT-d and AMDVI should only work with PCI, add a
check for PCI bus and return error if not present.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 hw/i386/x86-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 4d17e1f..afd8cd9 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -88,7 +88,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
         PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
     QLIST_INIT(&x86_iommu->iec_notifiers);
 
-    if (!pcms) {
+    if (!pcms || !pcms->bus) {
         error_setg(errp, "Machine-type '%s' not supported by iommu",
                    mc->name);
         return;
-- 
1.8.3.1
