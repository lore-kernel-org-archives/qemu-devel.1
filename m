Received: from eggs.gnu.org ([2001:4830:134:3::10]:33063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJLx-0000d7-W7
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dUJLx-0004mI-8O
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:02:54 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sun,  9 Jul 2017 23:02:18 +0200
Message-Id: <1499634139-20399-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
References: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v3 2/3] hw/arm/virt: Set INTx/gsi mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: christoffer.dall@linaro.org, agraf@suse.de, pranavkumar@linaro.org, drjones@redhat.com, wei@redhat.com

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

Let's provide the GPEX host bridge with the INTx/gsi mapping. This is
needed for INTx/gsi routing.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 010f724..f86c229 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1012,6 +1012,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
     char *nodename;
     int i;
     PCIHostState *pci;
+    GPEXHost *s;
 
     dev = qdev_create(NULL, TYPE_GPEX_HOST);
     qdev_init_nofail(dev);
@@ -1047,8 +1048,11 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
     /* Map IO port space */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
 
+    s = GPEX_HOST(dev);
+
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        gpex_set_irq_num(s, i, irq + i);
     }
 
     pci = PCI_HOST_BRIDGE(dev);
-- 
2.5.5
