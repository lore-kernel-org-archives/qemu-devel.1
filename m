Received: from eggs.gnu.org ([2001:4830:134:3::10]:47944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIFfe-00076q-DC
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIFfd-00024t-Lx
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 12:18:10 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Nov 2018 16:17:58 +0000
Message-Id: <20181101161758.12300-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] hw/ppc/mac_newworld: Free openpic_irqs
 array after use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

In ppc_core99_init(), we allocate an openpic_irqs array, which
we then use to collect up the various qemu_irqs which we're
going to connect to the interrupt controller. Once we've
called sysbus_connect_irq() to connect them all up, the
array is no longer required, but we forgot to free it.

Since board init is only run once at startup, the memory
leak is not a significant one.

Spotted by Coverity: CID 1192916.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/mac_newworld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a630cb81cd8..14273a123e5 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -303,6 +303,7 @@ static void ppc_core99_init(MachineState *machine)
             sysbus_connect_irq(s, k++, openpic_irqs[i][j]);
         }
     }
+    g_free(openpic_irqs);
 
     if (PPC_INPUT(env) == PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
-- 
2.19.1
