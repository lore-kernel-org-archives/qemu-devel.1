Received: from eggs.gnu.org ([2001:4830:134:3::10]:57950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLpzI-0001WX-Rh
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 08:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLpzH-0007lt-VQ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 08:04:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52932
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dLpzH-0007k0-P3
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 08:04:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 16 Jun 2017 13:04:10 +0100
Message-Id: <1497614651-1017-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497614651-1017-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497614651-1017-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 4/5] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
able to wire it up differently, it is much more convenient for the caller to
instantiate the device and have the fw_cfg default files already preloaded
during realize.

Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
fw_cfg_io_realize() functions so it no longer needs to be called manually
when instantiating the device, and also rename it to fw_cfg_common_realize()
which better describes its new purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 39fcc04..b5f10ac 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -910,14 +910,12 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
 
 
 
-static void fw_cfg_init1(DeviceState *dev)
+static void fw_cfg_common_realize(DeviceState *dev)
 {
     FWCfgState *s = FW_CFG(dev);
     MachineState *machine = MACHINE(qdev_get_machine());
     uint32_t version = FW_CFG_VERSION;
 
-    qdev_init_nofail(dev);
-
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
     fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
     fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_graphics);
@@ -949,7 +947,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
-    fw_cfg_init1(dev);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     ios = FW_CFG_IO(dev);
@@ -987,7 +985,7 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
         qdev_prop_set_bit(dev, "dma_enabled", false);
     }
 
-    fw_cfg_init1(dev);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, ctl_addr);
@@ -1098,6 +1096,8 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
                               &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
                               sizeof(dma_addr_t));
     }
+
+    fw_cfg_common_realize(dev);
 }
 
 static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
@@ -1164,6 +1164,8 @@ static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
                               sizeof(dma_addr_t));
         sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
     }
+
+    fw_cfg_common_realize(dev);
 }
 
 static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
-- 
1.7.10.4
