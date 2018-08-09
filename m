Received: from eggs.gnu.org ([2001:4830:134:3::10]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPt-0005C8-3G
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPq-0007Ot-Er
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPq-0007Nx-58
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:42 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:28 +0300
Message-Id: <1533815202-11967-16-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 15/29] vmsvga: Add interrupt mask and status
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>, Liran Alon <liran.alon@oracle.com>

From: Leonid Shatz <leonid.shatz@oracle.com>

Add missing functionality of interrupt mask and status registers.
Writing to interrupt status register clears interrupt request.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index eae3f1455445..4e4f6f8eec42 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -78,6 +78,8 @@ struct vmsvga_state_s {
     int redraw_fifo_first, redraw_fifo_last;
 
     uint32_t num_fifo_regs;
+    uint32_t irq_mask;
+    uint32_t irq_status;
 };
 
 #define TYPE_VMWARE_SVGA "vmware-svga"
@@ -104,6 +106,7 @@ struct pci_vmsvga_state_s {
 #define SVGA_INDEX_PORT         0x0
 #define SVGA_VALUE_PORT         0x1
 #define SVGA_BIOS_PORT          0x2
+#define SVGA_IRQSTATUS_PORT     0x8
 
 #define SVGA_VERSION_2
 
@@ -158,6 +161,7 @@ enum {
     SVGA_REG_MEM_REGS = 30,             /* Number of FIFO registers */
     SVGA_REG_NUM_DISPLAYS = 31,         /* Number of guest displays */
     SVGA_REG_PITCHLOCK = 32,            /* Fixed pitch for all modes */
+    SVGA_REG_IRQMASK = 33,              /* Interrupt mask */
 
     SVGA_PALETTE_BASE = 1024,           /* Base of SVGA color map */
     SVGA_PALETTE_END  = SVGA_PALETTE_BASE + 767,
@@ -183,6 +187,7 @@ enum {
 #define SVGA_CAP_EXTENDED_FIFO          (1 << 15)
 #define SVGA_CAP_MULTIMON               (1 << 16)
 #define SVGA_CAP_PITCHLOCK              (1 << 17)
+#define SVGA_CAP_IRQMASK                (1 << 18)
 
 /*
  * FIFO offsets (seen as an array of 32-bit words)
@@ -1034,6 +1039,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         }
 #endif
         caps |= SVGA_CAP_EXTENDED_FIFO;
+        caps |= SVGA_CAP_IRQMASK;
         ret = caps;
         break;
 
@@ -1091,6 +1097,10 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         ret = 0;
         break;
 
+    case SVGA_REG_IRQMASK:
+        ret = s->irq_mask;
+        break;
+
     default:
         if (s->index >= SVGA_SCRATCH_BASE &&
             s->index < SVGA_SCRATCH_BASE + s->scratch_size) {
@@ -1221,6 +1231,10 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
     case SVGA_PALETTE_BASE ... SVGA_PALETTE_END:
         break;
 
+    case SVGA_REG_IRQMASK:
+        s->irq_mask = value;
+        break;
+
     default:
         if (s->index >= SVGA_SCRATCH_BASE &&
                 s->index < SVGA_SCRATCH_BASE + s->scratch_size) {
@@ -1231,6 +1245,28 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
     }
 }
 
+static uint32_t vmsvga_irqstatus_read(void *opaque, uint32_t address)
+{
+    struct vmsvga_state_s *s = opaque;
+    return s->irq_status;
+}
+
+static void vmsvga_irqstatus_write(void *opaque, uint32_t address, uint32_t data)
+{
+    struct vmsvga_state_s *s = opaque;
+    struct pci_vmsvga_state_s *pci_vmsvga =
+        container_of(s, struct pci_vmsvga_state_s, chip);
+    PCIDevice *pci_dev = PCI_DEVICE(pci_vmsvga);
+
+    /*
+     * Clear selected interrupt sources and lower
+     * interrupt request when none are left active
+     */
+    s->irq_status &= ~data;
+    if (!s->irq_status)
+        pci_set_irq(pci_dev, 0);
+}
+
 static uint32_t vmsvga_bios_read(void *opaque, uint32_t address)
 {
     printf("%s: what are we supposed to return?\n", __func__);
@@ -1298,6 +1334,8 @@ static void vmsvga_reset(DeviceState *dev)
     s->redraw_fifo_first = 0;
     s->redraw_fifo_last = 0;
     s->syncing = 0;
+    s->irq_mask = 0;
+    s->irq_status = 0;
 
     vga_dirty_log_start(&s->vga);
 }
@@ -1327,12 +1365,18 @@ static int vmsvga_post_load(void *opaque, int version_id)
     struct vmsvga_state_s *s = opaque;
 
     s->invalidated = 1;
+
+    if (version_id < 1) {
+        s->irq_mask = 0;
+        s->irq_status = 0;
+    }
+
     return 0;
 }
 
 static const VMStateDescription vmstate_vmware_vga_internal = {
     .name = "vmware_vga_internal",
-    .version_id = 0,
+    .version_id = 1,
     .minimum_version_id = 0,
     .post_load = vmsvga_post_load,
     .fields = (VMStateField[]) {
@@ -1352,6 +1396,8 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
         VMSTATE_UINT32(svgaid, struct vmsvga_state_s),
         VMSTATE_INT32(syncing, struct vmsvga_state_s),
         VMSTATE_UNUSED(4), /* was fb_size */
+        VMSTATE_UINT32_V(irq_mask, struct vmsvga_state_s, 1),
+        VMSTATE_UINT32_V(irq_status, struct vmsvga_state_s, 1),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1404,6 +1450,7 @@ static uint64_t vmsvga_io_read(void *opaque, hwaddr addr, unsigned size)
     case SVGA_IO_MUL * SVGA_INDEX_PORT: return vmsvga_index_read(s, addr);
     case SVGA_IO_MUL * SVGA_VALUE_PORT: return vmsvga_value_read(s, addr);
     case SVGA_IO_MUL * SVGA_BIOS_PORT: return vmsvga_bios_read(s, addr);
+    case SVGA_IO_MUL * SVGA_IRQSTATUS_PORT: return vmsvga_irqstatus_read(s, addr);
     default: return -1u;
     }
 }
@@ -1423,6 +1470,9 @@ static void vmsvga_io_write(void *opaque, hwaddr addr,
     case SVGA_IO_MUL * SVGA_BIOS_PORT:
         vmsvga_bios_write(s, addr, data);
         break;
+    case SVGA_IO_MUL * SVGA_IRQSTATUS_PORT:
+        vmsvga_irqstatus_write(s, addr, data);
+        break;
     }
 }
 
-- 
1.9.1
