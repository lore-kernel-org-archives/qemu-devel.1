Received: from eggs.gnu.org ([2001:4830:134:3::10]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gU5Yx-0004iV-Ix
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gU5Yu-00056j-AX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:56:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:7874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gU5Yu-00054i-1l
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:56:08 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Date: Tue,  4 Dec 2018 02:50:49 -0500
Message-Id: <20181204075049.10285-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] xen/pt: allow passthrough of devices with
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
Cc: anthony.perard@citrix.com, sstabellini@kernel.org, xen-devel@lists.xenproject.org, Zhao Yan <yan.y.zhao@intel.com>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Jan Beulich <JBeulich@suse.com>

For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
doesn't support INTx mode, so its machine irq read from host sysfs is 0.
In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
continue.

Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>
Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>

---
v2: fix some coding style issue
v3:
   1. let subject be more descriptive (roger)
   2. disable INTx assertion if machine irq is 0.(roger)
   3. in xen_pt_irqpin_reg_init(), drop the else branch as the default
value for *data is 0. (roger)
---
 hw/xen/xen_pt.c             | 7 +++++++
 hw/xen/xen_pt_config_init.c | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index e5a6eff..b563837 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -847,6 +847,13 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     }
 
     machine_irq = s->real_device.irq;
+    if (machine_irq == 0) {
+        XEN_PT_LOG(d, "machine irq is 0\n");
+        cmd |= PCI_COMMAND_INTX_DISABLE;
+        s->machine_irq = 0;
+        goto out;
+    }
+
     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
     if (rc < 0) {
         error_setg_errno(errp, errno, "Mapping machine irq %u to"
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index aee31c6..12f71c1 100644
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
2.7.4
