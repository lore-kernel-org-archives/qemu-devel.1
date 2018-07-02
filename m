Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1m2-0004xs-5P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fa1lz-0003Ln-2B
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fa1ly-0003L4-SH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2246E3084034
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:33:54 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  2 Jul 2018 18:33:45 +0200
Message-Id: <20180702163345.17892-2-kraxel@redhat.com>
In-Reply-To: <20180702163345.17892-1-kraxel@redhat.com>
References: <20180702163345.17892-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] warn about two vga cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Two vga cards will try to register for the same legacy (isa) ioports.
Due to this conflict only one of the two cards will work correctly in
vga mode.

Print a warning message in that case.  Also try registering the ports
only once, so the first vga added to the system will work properly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index c82e6d240a..e811571624 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2273,6 +2273,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
 void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
               MemoryRegion *address_space_io, bool init_vga_ports)
 {
+    static bool vgaports_registered;
     MemoryRegion *vga_io_memory;
     const MemoryRegionPortio *vga_ports, *vbe_ports;
 
@@ -2289,9 +2290,14 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
                                         1);
     memory_region_set_coalescing(vga_io_memory);
     if (init_vga_ports) {
-        portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
-        portio_list_set_flush_coalesced(&s->vga_port_list);
-        portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
+        if (vgaports_registered) {
+            warn_report("multiple vga cards may not work as expected");
+        } else {
+            portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
+            portio_list_set_flush_coalesced(&s->vga_port_list);
+            portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
+            vgaports_registered = true;
+        }
     }
     if (vbe_ports) {
         portio_list_init(&s->vbe_port_list, obj, vbe_ports, s, "vbe");
-- 
2.9.3
