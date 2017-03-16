Received: from eggs.gnu.org ([2001:4830:134:3::10]:50173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkH-000498-5K
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coRkF-0003jM-QY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coRkF-0003ij-IK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7551964D8A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:30:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 10:30:39 +0100
Message-Id: <1489656642-12925-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
References: <1489656642-12925-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 4/7] cirrus: add option to disable
 blitter
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

Ok, we have this beast in the cirrus code which is not used at all by
modern guests, except when you try to find security holes in qemu.  So,
add an option to disable blitter altogether.  Guests released within
the last ten years should not show any rendering issues if you turn off
blitter support.

There are no known bugs in the cirrus blitter code.  But in the past we
hoped a few times already that we've finally nailed the last issue.  So
having some easy way to mitigate in case yet another blitter issue shows
up certainly makes me sleep a bit better at night.

For completeness:  The by far better way to mitigate is to switch away
from cirrus and use stdvga instead.  Or something more modern like
virtio-vga in case your guest has support for it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1489494540-15745-1-git-send-email-kraxel@redhat.com
---
 hw/display/cirrus_vga.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 6ffe64f..326d511 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -205,6 +205,7 @@ typedef struct CirrusVGAState {
     uint32_t cirrus_bank_base[2];
     uint32_t cirrus_bank_limit[2];
     uint8_t cirrus_hidden_palette[48];
+    bool enable_blitter;
     int cirrus_blt_pixelwidth;
     int cirrus_blt_width;
     int cirrus_blt_height;
@@ -960,6 +961,10 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
 {
     uint8_t blt_rop;
 
+    if (!s->enable_blitter) {
+        goto bitblt_ignore;
+    }
+
     s->vga.gr[0x31] |= CIRRUS_BLT_BUSY;
 
     s->cirrus_blt_width = (s->vga.gr[0x20] | (s->vga.gr[0x21] << 8)) + 1;
@@ -3024,6 +3029,8 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
 static Property isa_cirrus_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
+    DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
+                       cirrus_vga.enable_blitter, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3093,6 +3100,8 @@ static void pci_cirrus_vga_realize(PCIDevice *dev, Error **errp)
 static Property pci_vga_cirrus_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct PCICirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
+    DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
+                     cirrus_vga.enable_blitter, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
