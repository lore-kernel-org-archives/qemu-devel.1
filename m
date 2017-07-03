Received: from eggs.gnu.org ([2001:4830:134:3::10]:47111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7I1-0008Kr-3X
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Hx-0003K3-UV
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7Hx-0003IU-Hw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:41 -0400
Date: Mon, 3 Jul 2017 22:45:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-15-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/21] fw_cfg: move setting of
 FW_CFG_VERSION_DMA bit to fw_cfg_init1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gabriel Somlo <somlo@cmu.edu>, Marcel Apfelbaum <marcel@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The setting of the FW_CFG_VERSION_DMA bit is the same across both the
TYPE_FW_CFG_MEM and TYPE_FW_CFG_IO devices, so unify the logic in
fw_cfg_init1().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Gabriel Somlo <somlo@cmu.edu>
---
 hw/nvram/fw_cfg.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 4e4f71a..99bdbc2 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -913,6 +913,7 @@ static void fw_cfg_init1(DeviceState *dev)
 {
     FWCfgState *s =3D FW_CFG(dev);
     MachineState *machine =3D MACHINE(qdev_get_machine());
+    uint32_t version =3D FW_CFG_VERSION;
=20
     assert(!object_resolve_path(FW_CFG_PATH, NULL));
=20
@@ -927,6 +928,12 @@ static void fw_cfg_init1(DeviceState *dev)
     fw_cfg_bootsplash(s);
     fw_cfg_reboot(s);
=20
+    if (s->dma_enabled) {
+        version |=3D FW_CFG_VERSION_DMA;
+    }
+
+    fw_cfg_add_i32(s, FW_CFG_ID, version);
+
     s->machine_ready.notify =3D fw_cfg_machine_ready;
     qemu_add_machine_init_done_notifier(&s->machine_ready);
 }
@@ -938,7 +945,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint3=
2_t dma_iobase,
     SysBusDevice *sbd;
     FWCfgIoState *ios;
     FWCfgState *s;
-    uint32_t version =3D FW_CFG_VERSION;
     bool dma_requested =3D dma_iobase && dma_as;
=20
     dev =3D qdev_create(NULL, TYPE_FW_CFG_IO);
@@ -959,12 +965,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint=
32_t dma_iobase,
         s->dma_as =3D dma_as;
         s->dma_addr =3D 0;
         sysbus_add_io(sbd, dma_iobase, &s->dma_iomem);
-
-        version |=3D FW_CFG_VERSION_DMA;
     }
=20
-    fw_cfg_add_i32(s, FW_CFG_ID, version);
-
     return s;
 }
=20
@@ -980,7 +982,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     DeviceState *dev;
     SysBusDevice *sbd;
     FWCfgState *s;
-    uint32_t version =3D FW_CFG_VERSION;
     bool dma_requested =3D dma_addr && dma_as;
=20
     dev =3D qdev_create(NULL, TYPE_FW_CFG_MEM);
@@ -1001,11 +1002,8 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
         s->dma_as =3D dma_as;
         s->dma_addr =3D 0;
         sysbus_mmio_map(sbd, 2, dma_addr);
-        version |=3D FW_CFG_VERSION_DMA;
     }
=20
-    fw_cfg_add_i32(s, FW_CFG_ID, version);
-
     return s;
 }
=20
--=20
MST
