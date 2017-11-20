Received: from eggs.gnu.org ([2001:4830:134:3::10]:37407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchc-0001ks-C4
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchb-0006WD-Iw
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:56 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:16 -0600
Message-Id: <20171120032420.9134-9-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 08/12] e500: add mpc8540 i2c controller to ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 6f77844303..bef7d313d4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -861,6 +861,14 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     qdev_init_nofail(dev);
     ccsr_addr_space = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
 
+    dev = qdev_create(NULL, "mpc8540-i2c");
+    object_property_add_child(qdev_get_machine(), "i2c[*]",
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    memory_region_add_subregion(ccsr_addr_space, 0x3000,
+                                sysbus_mmio_get_region(s, 0));
+
     mpicdev = ppce500_init_mpic(machine, params, ccsr_addr_space, irqs);
 
     /* Serial */
-- 
2.11.0
