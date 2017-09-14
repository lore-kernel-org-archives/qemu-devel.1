Received: from eggs.gnu.org ([2001:4830:134:3::10]:55513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dsabW-0003lc-SD
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dsabT-0005UL-KX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1dsabT-0005Tb-EX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:19:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EE294A6FB
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 20:19:14 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
Date: Thu, 14 Sep 2017 22:18:31 +0200
Message-Id: <1505420311-23744-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH] amd_iommu: Return error on machines with no PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, mst@redhat.com, thuth@redhat.com, Mohammed Gamal <mgamal@redhat.com>

Starting the following command line causes a segfault
qemu-system-x86_64 -S -machine isapc,accel=kvm -device amd-iommu

This is due to the fact that the machine type 'isapc' doesn't have
a PCI bus, while amd_iommu doesn't check if the machine has PCI support
and subsequently does a null-pointer access. AMD IOMMU shouldn't even work
if the target machine doesn't have PCI.

Add a check for PCI on the given machine type and return an error if PCI
is not supported.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 hw/i386/amd_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 334938a..9a667b7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1153,6 +1153,13 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     }
 
     bus = pcms->bus;
+
+    if (!bus) {
+        error_setg(err, "Machine-type '%s' does not support PCI",
+                   mc->name);
+        return;
+    }
+
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
-- 
1.8.3.1
