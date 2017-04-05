Received: from eggs.gnu.org ([2001:4830:134:3::10]:57223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ5-0002I0-Aj
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgQ4-0005WE-Bm
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:01 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42821
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgQ4-0005Ud-4U
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:36:00 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  5 Apr 2017 09:35:19 +0100
Message-Id: <1491381329-3995-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 04/14] cg3: switch to load_image_mr() and
 remove prom-addr hack
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
 hw/display/cg3.c |    4 +---
 hw/sparc/sun4m.c |    1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 178a6dd..3d36960 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -300,8 +300,7 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
     vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
     if (fcode_filename) {
-        ret = load_image_targphys(fcode_filename, s->prom_addr,
-                                  FCODE_MAX_ROM_SIZE);
+        ret = load_image_mr(fcode_filename, &s->rom);
         g_free(fcode_filename);
         if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
             error_report("cg3: could not load prom '%s'", CG3_ROM_FILE);
@@ -366,7 +365,6 @@ static Property cg3_properties[] = {
     DEFINE_PROP_UINT16("width",        CG3State, width,     -1),
     DEFINE_PROP_UINT16("height",       CG3State, height,    -1),
     DEFINE_PROP_UINT16("depth",        CG3State, depth,     -1),
-    DEFINE_PROP_UINT64("prom-addr",    CG3State, prom_addr, -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 873cd7d..7a0922b 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -544,7 +544,6 @@ static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
-    qdev_prop_set_uint64(dev, "prom-addr", addr);
     qdev_init_nofail(dev);
     s = SYS_BUS_DEVICE(dev);
 
-- 
1.7.10.4
