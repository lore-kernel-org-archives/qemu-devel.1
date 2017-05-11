Received: from eggs.gnu.org ([2001:4830:134:3::10]:56240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUz-0005O4-7W
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUx-0001XK-S4
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:23 +1000
Message-Id: <20170511041426.6488-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/23] spapr: Don't accidentally advertise HTM
 support on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

Logic in spapr_populate_pa_features() enables the bit advertising
Hardware Transactional Memory (HTM) in the guest's device tree only when
KVM advertises its availability with the KVM_CAP_PPC_HTM feature.

However, this assumes that the HTM bit is off in the base template used for
the device tree value.  That is true for POWER8, but not for POWER9.

It looks like that was accidentally changed in 9fb4541 "spapr: Enable ISA
3.0 MMU mode selection via CAS".

Fixes: 9fb4541f5803f8d2ba116b12113386e26482ba30

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
