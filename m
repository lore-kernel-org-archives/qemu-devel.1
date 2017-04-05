Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgW9-0007gr-AB
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgW8-0008Rs-7T
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42862
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgW7-0008QB-Pd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:42:16 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:29 +0100
Message-Id: <1491381329-3995-15-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 14/14] tcx: switch to load_image_mr() and
 remove prom_addr hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org

Previous to the existence of load_image_mr(), the only way to load in the
FCode ROM image was to pass in its physical address via qdev properties
and use load_image_targphys().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/display/tcx.c |    4 +---
 hw/sparc/sun4m.c |    1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 3f00735..5a1115c 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -843,8 +843,7 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, TCX_ROM_FILE);
     if (fcode_filename) {
-        ret = load_image_targphys(fcode_filename, s->prom_addr,
-                                  FCODE_MAX_ROM_SIZE);
+        ret = load_image_mr(fcode_filename, &s->rom);
         g_free(fcode_filename);
         if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
             error_report("tcx: could not load prom '%s'", TCX_ROM_FILE);
@@ -902,7 +901,6 @@ static Property tcx_properties[] = {
     DEFINE_PROP_UINT16("width",    TCXState, width,     -1),
     DEFINE_PROP_UINT16("height",   TCXState, height,    -1),
     DEFINE_PROP_UINT16("depth",    TCXState, depth,     -1),
-    DEFINE_PROP_UINT64("prom_addr", TCXState, prom_addr, -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 7a0922b..5f022cc 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -491,7 +491,6 @@ static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
-    qdev_prop_set_uint64(dev, "prom_addr", addr);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
 
-- 
1.7.10.4
