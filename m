Received: from eggs.gnu.org ([2001:4830:134:3::10]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVx5F-0006b5-3A
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVx5D-0007Zs-7G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:25 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41068
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dVx5D-0007ZV-04
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:40:23 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 14 Jul 2017 10:40:07 +0100
Message-Id: <1500025208-14827-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv9 2/3] fw_cfg: move qdev_init_nofail() from
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
 hw/nvram/fw_cfg.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index ac52b50..b850ac3 100644
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
@@ -1021,6 +1021,7 @@ FWCfgState *fw_cfg_find(void)
     return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
+
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1092,6 +1093,8 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
                               &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
                               sizeof(dma_addr_t));
     }
+
+    fw_cfg_common_realize(dev, errp);
 }
 
 static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
@@ -1158,6 +1161,8 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
                               sizeof(dma_addr_t));
         sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
     }
+
+    fw_cfg_common_realize(dev, errp);
 }
 
 static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
-- 
1.7.10.4
