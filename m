Received: from eggs.gnu.org ([209.51.188.92]:53185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghail-00053i-9C
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghaik-0001go-6V
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:50:07 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:11318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghaij-0001ep-U9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:50:06 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 10 Jan 2019 13:48:54 +0000
Message-ID: <20190110134917.16425-3-anthony.perard@citrix.com>
In-Reply-To: <20190110134917.16425-1-anthony.perard@citrix.com>
References: <20190110134917.16425-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/25] xen/pt: allow passthrough of devices with
 bogus interrupt pin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Zhao Yan <yan.y.zhao@intel.com>, Anthony PERARD <anthony.perard@citrix.com>

From: Zhao Yan <yan.y.zhao@intel.com>

For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
doesn't support INTx mode, so its machine irq read from host sysfs is 0.
In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
continue.

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen_pt.c             | 6 ++++++
 hw/xen/xen_pt_config_init.c | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index f1f3a3727c..815dc46ba7 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -847,6 +847,12 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     }
 
     machine_irq = s->real_device.irq;
+    if (machine_irq == 0) {
+        XEN_PT_LOG(d, "machine irq is 0\n");
+        cmd |= PCI_COMMAND_INTX_DISABLE;
+        goto out;
+    }
+
     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
     if (rc < 0) {
         error_setg_errno(errp, errno, "Mapping machine irq %u to"
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 47f9010c75..9fd953a689 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -300,7 +300,9 @@ static int xen_pt_irqpin_reg_init(XenPCIPassthroughState *s,
                                   XenPTRegInfo *reg, uint32_t real_offset,
                                   uint32_t *data)
 {
-    *data = xen_pt_pci_read_intx(s);
+    if (s->real_device.irq) {
+        *data = xen_pt_pci_read_intx(s);
+    }
     return 0;
 }
 
-- 
Anthony PERARD
