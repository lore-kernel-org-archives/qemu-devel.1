Received: from eggs.gnu.org ([2001:4830:134:3::10]:40442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdtQx-0002PK-Nl
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdtQw-0004bh-QK
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:28:11 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 13 Jul 2018 10:27:34 +0200
Message-Id: <1531470464-21522-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1531470464-21522-1-git-send-email-thuth@redhat.com>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/16] hw/display/xlnx_dp: Move problematic
 code from instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

aux_create_slave() calls qdev_init_nofail() which in turn "realizes"
the corresponding object. Thus this most not be called from an
instance_init function. Move the code to the realize function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/xlnx_dp.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 5130122..c7542d8 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1225,28 +1225,23 @@ static void xlnx_dp_init(Object *obj)
                              xlnx_dp_set_dpdma,
                              OBJ_PROP_LINK_STRONG,
                              &error_abort);
+}
 
-    /*
-     * Initialize AUX Bus.
-     */
-    s->aux_bus = aux_init_bus(DEVICE(obj), "aux");
+static void xlnx_dp_realize(DeviceState *dev, Error **errp)
+{
+    XlnxDPState *s = XLNX_DP(dev);
+    DisplaySurface *surface;
+    struct audsettings as;
 
-    /*
-     * Initialize DPCD and EDID..
-     */
+    s->aux_bus = aux_init_bus(dev, "aux");
+
+    /* Initialize DPCD and EDID */
     s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd", 0x00000));
     s->edid = I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2c-ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
 
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
-}
-
-static void xlnx_dp_realize(DeviceState *dev, Error **errp)
-{
-    XlnxDPState *s = XLNX_DP(dev);
-    DisplaySurface *surface;
-    struct audsettings as;
 
     s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
     surface = qemu_console_surface(s->console);
-- 
1.8.3.1
