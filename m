Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnlZd-0000Rj-QL
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnlZZ-0008TE-QQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cnlZZ-0008Se-KE
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:29:05 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C08A39D4F2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 12:29:05 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Mar 2017 13:29:00 +0100
Message-Id: <1489494540-15745-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] cirrus: add option to disable blitter
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
---
 hw/display/cirrus_vga.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index efbd2c1..38fda55 100644
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
@@ -966,6 +967,10 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
 {
     uint8_t blt_rop;
 
+    if (!s->enable_blitter) {
+        goto bitblt_ignore;
+    }
+
     s->vga.gr[0x31] |= CIRRUS_BLT_BUSY;
 
     s->cirrus_blt_width = (s->vga.gr[0x20] | (s->vga.gr[0x21] << 8)) + 1;
@@ -3030,6 +3035,8 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
 static Property isa_cirrus_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
+    DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
+                       cirrus_vga.enable_blitter, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3099,6 +3106,8 @@ static void pci_cirrus_vga_realize(PCIDevice *dev, Error **errp)
 static Property pci_vga_cirrus_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct PCICirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
+    DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
+                     cirrus_vga.enable_blitter, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
