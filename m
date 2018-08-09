Received: from eggs.gnu.org ([2001:4830:134:3::10]:56091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPE-0004cX-Fz
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPB-00071i-SN
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPB-00071Z-IX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:01 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:14 +0300
Message-Id: <1533815202-11967-2-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 01/29] vmsvga: Stop using redundant fifo
 pointer variable
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

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 0bbb78b9a6fd..60a672530840 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -63,7 +63,6 @@ struct vmsvga_state_s {
     int syncing;
 
     MemoryRegion fifo_ram;
-    uint8_t *fifo_ptr;
     unsigned int fifo_size;
 
     uint32_t *fifo;
@@ -1022,7 +1021,6 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
 
     case SVGA_REG_CONFIG_DONE:
         if (value) {
-            s->fifo = (uint32_t *) s->fifo_ptr;
             vga_dirty_log_stop(&s->vga);
         }
         s->config = !!value;
@@ -1179,9 +1177,6 @@ static int vmsvga_post_load(void *opaque, int version_id)
     struct vmsvga_state_s *s = opaque;
 
     s->invalidated = 1;
-    if (s->config) {
-        s->fifo = (uint32_t *) s->fifo_ptr;
-    }
     return 0;
 }
 
@@ -1240,7 +1235,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     s->fifo_size = SVGA_FIFO_SIZE;
     memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
                            &error_fatal);
-    s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
+    s->fifo = (uint32_t *)memory_region_get_ram_ptr(&s->fifo_ram);
 
     vga_common_init(&s->vga, OBJECT(dev));
     vga_init(&s->vga, OBJECT(dev), address_space, io, true);
-- 
1.9.1
