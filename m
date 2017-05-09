Received: from eggs.gnu.org ([2001:4830:134:3::10]:39406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7xKi-0006al-BK
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7xKh-0008Mo-CZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:05:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  9 May 2017 15:04:58 +1000
Message-Id: <20170509050458.23237-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH] spapr: Don't accidentally advertise HTM
 support on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sam.bobroff@au1.ibm.com, thuth@redhat.com
Cc: lvivier@redhat.com, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Logic in spapr_populate_pa_features() enables the bit advertising
Hardware Transactional Memory (HTM) in the guest's device tree only when
KVM advertises its availability with the KVM_CAP_PPC_HTM feature.

However, this assumes that the HTM bit is off in the base template used for
the device tree value.  That is true for POWER8, but not for POWER9.

It looks like that was accidentally changed in 9fb4541 "spapr: Enable ISA
3.0 MMU mode selection via CAS".

Fixes: 9fb4541f5803f8d2ba116b12113386e26482ba30

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e2dc77c..1b7cada 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -219,7 +219,7 @@ static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int offset,
         /* 16: Vector */
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
         /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
         /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
         0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
         /* 30: MMR, 32: LE atomic, 34: EBB + ext EBB */
-- 
2.9.3
