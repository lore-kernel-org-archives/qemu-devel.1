Received: from eggs.gnu.org ([2001:4830:134:3::10]:54472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwZ-0008Uz-Jt
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1TwY-0001Za-2C
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50162
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1TwX-0001Y1-RH
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:29 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 21 Apr 2017 09:28:37 +0100
Message-Id: <1492763327-12742-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/13] cg3: switch to load_image_mr() and
 remove prom-addr hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Previous to the existence of load_image_mr(), the only way to load in the
FCode ROM image was to pass in its physical address via qdev properties
and use load_image_targphys().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cg3.c |    4 +---
 hw/sparc/sun4m.c |    1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index b42f60e..03d9197 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -303,8 +303,7 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
     vmstate_register_ram_global(&s->rom);
     fcode_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, CG3_ROM_FILE);
     if (fcode_filename) {
-        ret = load_image_targphys(fcode_filename, s->prom_addr,
-                                  FCODE_MAX_ROM_SIZE);
+        ret = load_image_mr(fcode_filename, &s->rom);
         g_free(fcode_filename);
         if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
             error_report("cg3: could not load prom '%s'", CG3_ROM_FILE);
@@ -369,7 +368,6 @@ static Property cg3_properties[] = {
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
