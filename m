Received: from eggs.gnu.org ([2001:4830:134:3::10]:35035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6f-0006Df-Dj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6e-00071C-EL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:41 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60711
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dQa6e-00070r-7s
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:40 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 15:07:19 +0100
Message-Id: <1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
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

Finally we can now convert the asserts() preventing multiple fw_cfg devices
and unparented fw_cfg devices being instantiated and replace them with proper
error reporting at realize time. This allows us to remove FW_CFG_NAME and
FW_CFG_PATH since they are no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |   41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2291121..31029ac 100644
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
@@ -920,19 +917,22 @@ static int fw_cfg_unattached_at_realize(void)
 }
 
 
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
 
-    assert(!fw_cfg_unattached_at_realize());
+    if (fw_cfg_unattached_at_realize()) {
+        error_setg(errp, "%s device must be added as a child device before "
+                   "realize", TYPE_FW_CFG);
+        return;
+    }
 
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
     fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
@@ -965,7 +965,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
-    fw_cfg_init1(dev);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     ios = FW_CFG_IO(dev);
@@ -1003,7 +1005,9 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
-    fw_cfg_init1(dev);
+    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, ctl_addr);
@@ -1033,6 +1037,7 @@ FWCfgState *fw_cfg_find(void)
     return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
+
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1104,6 +1109,12 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
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
@@ -1170,6 +1181,12 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
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
