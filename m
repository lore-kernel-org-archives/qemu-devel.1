Received: from eggs.gnu.org ([2001:4830:134:3::10]:32786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1Mf-0006eP-MJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV1Mc-0008De-K5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:02:33 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34863
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV1Mc-0008D9-Cx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:02:30 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 21:02:12 +0100
Message-Id: <1499803333-9052-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv8 2/3] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
able to wire it up differently, it is much more convenient for the caller to
instantiate the device and have the fw_cfg default files already preloaded
during realize.

Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
fw_cfg_io_realize() functions so it no longer needs to be called manually
when instantiating the device, and also rename it to fw_cfg_common_realize()
which better describes its new purpose.

Since it is now the responsibility of the machine to wire up the fw_cfg device
it is necessary to introduce a object_property_add_child() call into
fw_cfg_init_io() and fw_cfg_init_mem() to link the fw_cfg device to the root
machine object as before.

Finally with the previous change to fw_cfg_find() we can now remove the
assert() preventing multiple fw_cfg devices being instantiated and replace
them with a simple call to fw_cfg_find() at realize time instead. This allows
us to remove FW_CFG_NAME and FW_CFG_PATH since they are no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/nvram/fw_cfg.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8ef889a..6e96b92 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -37,9 +37,6 @@
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
 
-#define FW_CFG_NAME "fw_cfg"
-#define FW_CFG_PATH "/machine/" FW_CFG_NAME
-
 #define TYPE_FW_CFG     "fw_cfg"
 #define TYPE_FW_CFG_IO  "fw_cfg_io"
 #define TYPE_FW_CFG_MEM "fw_cfg_mem"
@@ -909,17 +906,16 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
 
 
 
-static void fw_cfg_init1(DeviceState *dev)
+static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
 {
     FWCfgState *s = FW_CFG(dev);
     MachineState *machine = MACHINE(qdev_get_machine());
     uint32_t version = FW_CFG_VERSION;
 
-    assert(!object_resolve_path(FW_CFG_PATH, NULL));
-
-    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
-
-    qdev_init_nofail(dev);
+    if (!fw_cfg_find()) {
+        error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);
+        return;
+    }
 
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
     fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
@@ -952,7 +948,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
-    fw_cfg_init1(dev);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     ios = FW_CFG_IO(dev);
@@ -990,7 +988,9 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
-    fw_cfg_init1(dev);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, ctl_addr);
@@ -1025,6 +1025,7 @@ FWCfgState *fw_cfg_find(void)
     return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
+
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1096,6 +1097,12 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
                               &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
                               sizeof(dma_addr_t));
     }
+
+    fw_cfg_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
@@ -1162,6 +1169,12 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
                               sizeof(dma_addr_t));
         sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
     }
+
+    fw_cfg_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
-- 
1.7.10.4
