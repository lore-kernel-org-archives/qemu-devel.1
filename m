Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPn-00056o-Al
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPk-0007I7-MJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPk-0007Hg-CA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:36 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:26 +0300
Message-Id: <1533815202-11967-14-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 13/29] vmsvga: Add support for extended FIFO
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Liran Alon <liran.alon@oracle.com>

Supporting extended FIFO registers is required to support
SVGA_FIFO_FENCE which allows guest to receive interrupt when FIFO is
processed up to a specified fence.

Thus, as a preperation for supporting SVGA_FIFO_FENCE, add extened
FIFO registers support. Note that exposing SVGA_CAP_EXTENDED_FIFO
requires to support the following registers: SVGA_FIFO_CAPABILITIES,
SVGA_FIFO_FLAGS and SVGA_FIFO_3D_HWVERSION.

For more information on how SVGA_FIFO_3D_HWVERSION is negoitated, see
SVGA3D_Init() in VMware SVGA development kit.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 8eeb0efc9cab..91f990544e14 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1033,6 +1033,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
                     SVGA_CAP_CURSOR_BYPASS;
         }
 #endif
+        caps |= SVGA_CAP_EXTENDED_FIFO;
         ret = caps;
         break;
 
@@ -1138,6 +1139,8 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
         } else {
             vga_dirty_log_start(&s->vga);
         }
+        if (s->enable)
+            s->fifo[SVGA_FIFO_3D_HWVERSION] = 0;    /* 3D disabled */
         break;
 
     case SVGA_REG_WIDTH:
@@ -1384,6 +1387,8 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                            &error_fatal);
     s->fifo = (uint32_t *)memory_region_get_ram_ptr(&s->fifo_ram);
     s->num_fifo_regs = SVGA_FIFO_NUM_REGS;
+    s->fifo[SVGA_FIFO_CAPABILITIES] = 0;
+    s->fifo[SVGA_FIFO_FLAGS] = 0;
 
     vga_common_init(&s->vga, OBJECT(dev));
     vga_init(&s->vga, OBJECT(dev), address_space, io, true);
-- 
1.9.1
