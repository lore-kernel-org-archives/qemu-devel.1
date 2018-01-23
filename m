Received: from eggs.gnu.org ([2001:4830:134:3::10]:48720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edyVZ-0000Xa-Aw
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edyVW-0005MY-75
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:21:01 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edyVW-0005MM-2y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:20:58 -0500
Received: by mail-qt0-x244.google.com with SMTP id o35so1076813qtj.13
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 05:20:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 10:20:50 -0300
Message-Id: <20180123132051.24448-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] sdhci: fix a NULL pointer dereference due to
 uninitialized AddresSpace object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

missed in 60765b6ceeb4.

  Thread 1 "qemu-system-aarch64" received signal SIGSEGV, Segmentation fault.
  address_space_init (as=0x0, root=0x55555726e410, name=name@entry=0x555555e3f0a7 "sdhci-dma") at memory.c:3050
  3050	    as->root = root;
  (gdb) bt
  #0  address_space_init (as=0x0, root=0x55555726e410, name=name@entry=0x555555e3f0a7 "sdhci-dma") at memory.c:3050
  #1  0x0000555555af62c3 in sdhci_sysbus_realize (dev=<optimized out>, errp=0x7fff7f931150) at hw/sd/sdhci.c:1564
  #2  0x00005555558b25e5 in zynqmp_sdhci_realize (dev=0x555557051520, errp=0x7fff7f931150) at hw/sd/zynqmp-sdhci.c:151
  #3  0x0000555555a2e7f3 in device_set_realized (obj=0x555557051520, value=<optimized out>, errp=0x7fff7f931270) at hw/core/qdev.c:966
  #4  0x0000555555ba3f74 in property_set_bool (obj=0x555557051520, v=<optimized out>, name=<optimized out>, opaque=0x555556e04a20,
      errp=0x7fff7f931270) at qom/object.c:1906
  #5  0x0000555555ba51f4 in object_property_set (obj=obj@entry=0x555557051520, v=v@entry=0x5555576dbd60,
      name=name@entry=0x555555dd6306 "realized", errp=errp@entry=0x7fff7f931270) at qom/object.c:1102

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h | 1 +
 hw/sd/sdhci.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index cb37182536..1cf70f8c23 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -41,6 +41,7 @@ typedef struct SDHCIState {
     /*< public >*/
     SDBus sdbus;
     MemoryRegion iomem;
+    AddressSpace sysbus_dma_as;
     AddressSpace *dma_as;
     MemoryRegion *dma_mr;
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f9264d3be5..fac7fa5c72 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1388,6 +1388,7 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     }
 
     if (s->dma_mr) {
+        s->dma_as = &s->sysbus_dma_as;
         address_space_init(s->dma_as, s->dma_mr, "sdhci-dma");
     } else {
         /* use system_memory() if property "dma" not set */
-- 
2.15.1
