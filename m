Received: from eggs.gnu.org ([2001:4830:134:3::10]:42200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXV-0006iC-OX
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXU-0001dR-2e
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33297
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJfXT-0001ci-RL
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:47 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 13:30:17 +0100
Message-Id: <1497097821-32754-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/6] fw_cfg: move qdev_init_nofail() out from
 fw_cfg_init1() into callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 144e0c6..1313bfd 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -919,8 +919,6 @@ static void fw_cfg_init1(DeviceState *dev)
 
     object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
 
-    qdev_init_nofail(dev);
-
     fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
     fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
     fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_graphics);
@@ -948,6 +946,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     }
 
     fw_cfg_init1(dev);
+    qdev_init_nofail(dev);
+
     s = FW_CFG(dev);
 
     if (s->dma_enabled) {
@@ -985,6 +985,7 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     }
 
     fw_cfg_init1(dev);
+    qdev_init_nofail(dev);
 
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sbd, 0, ctl_addr);
-- 
1.7.10.4
