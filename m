Received: from eggs.gnu.org ([2001:4830:134:3::10]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gTeBh-0004zo-2L
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gTeBd-0004js-UM
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:42:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:62117)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gTeBd-0004hU-MV
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 21:42:17 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Date: Sun,  2 Dec 2018 21:37:28 -0500
Message-Id: <20181203023728.26774-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] xen/pt: Fix a xen passthrough failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anthony.perard@citrix.com, sstabellini@kernel.org, roger.pau@citrix.com, JBeulich@suse.com, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Zhao Yan <yan.y.zhao@intel.com>

For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
doesn't support INTx mode, so its machine irq read from host sysfs is 0.
In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
continue.

Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
---
 hw/xen/xen_pt.c             | 5 +++++
 hw/xen/xen_pt_config_init.c | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index f1f3a3727c..de63cb8e94 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -847,6 +847,11 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     }
 
     machine_irq = s->real_device.irq;
+    if(machine_irq == 0) {
+        XEN_PT_LOG(d, "machine irq is 0\n");
+        goto out;
+    }
+
     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
     if (rc < 0) {
         error_setg_errno(errp, errno, "Mapping machine irq %u to"
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 47f9010c75..8baddbed90 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -300,7 +300,12 @@ static int xen_pt_irqpin_reg_init(XenPCIPassthroughState *s,
                                   XenPTRegInfo *reg, uint32_t real_offset,
                                   uint32_t *data)
 {
-    *data = xen_pt_pci_read_intx(s);
+    if (s->real_device.irq)
+        *data = xen_pt_pci_read_intx(s);
+    else {
+        XEN_PT_LOG(&s->dev, "machine irq is 0, init guest PCI_INTERRUPT_PIN to 0\n");
+        *data = 0;
+    }
     return 0;
 }
 
-- 
2.17.1
