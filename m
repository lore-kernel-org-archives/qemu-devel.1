Received: from eggs.gnu.org ([2001:4830:134:3::10]:34926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY95y-00076W-DN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY95v-0003nx-Cz
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:58:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY95v-0003lN-7t
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1E2F401B1FF
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 11:58:42 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 27 Jun 2018 13:58:36 +0200
Message-Id: <20180627115836.25092-2-kraxel@redhat.com>
In-Reply-To: <20180627115836.25092-1-kraxel@redhat.com>
References: <20180627115836.25092-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] warn about two vga cards
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

Two vga cards will listen on the same legacy (isa) ioports.  Due to this
conflict only one of the two cards will work correctly in vga mode.
Print a warning message in that case.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index c82e6d240a..a6c246f76b 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2273,6 +2273,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
 void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
               MemoryRegion *address_space_io, bool init_vga_ports)
 {
+    static bool vgaports_registered;
     MemoryRegion *vga_io_memory;
     const MemoryRegionPortio *vga_ports, *vbe_ports;
 
@@ -2289,6 +2290,11 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
                                         1);
     memory_region_set_coalescing(vga_io_memory);
     if (init_vga_ports) {
+        if (vgaports_registered) {
+            warn_report("multiple vga cards may not work as expected");
+        } else {
+            vgaports_registered = true;
+        }
         portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
         portio_list_set_flush_coalesced(&s->vga_port_list);
         portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
-- 
2.9.3
