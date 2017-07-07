Received: from eggs.gnu.org ([2001:4830:134:3::10]:54474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTS-0005rA-NZ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTR-00044B-W7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTR-00040L-OV
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:54 +0100
Message-Id: <1499438577-7674-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 08/11] hw/block/pflash_cfi01,
 pflash_cfi02: Use memory_region_init_rom_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Since we pass the same DeviceState object to
memory_region_init_rom_device_nomigrate() and vmstate_register_ram(),
we can switch to using memory_region_init_rom_device() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/pflash_cfi01.c | 3 +--
 hw/block/pflash_cfi02.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index c044b56..1113ab1 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -743,7 +743,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         return NULL;
 #endif
 
-    memory_region_init_rom_device_nomigrate(
+    memory_region_init_rom_device(
         &pfl->mem, OBJECT(dev),
         &pflash_cfi01_ops,
         pfl,
@@ -753,7 +753,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    vmstate_register_ram(&pfl->mem, DEVICE(pfl));
     pfl->storage = memory_region_get_ram_ptr(&pfl->mem);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index a08b09b..c81ddd3 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -621,7 +621,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return NULL;
 #endif
 
-    memory_region_init_rom_device_nomigrate(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
+    memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl), pfl->be ?
                                   &pflash_cfi02_ops_be : &pflash_cfi02_ops_le,
                                   pfl, pfl->name, chip_len, &local_err);
     if (local_err) {
@@ -629,7 +629,6 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    vmstate_register_ram(&pfl->orig_mem, DEVICE(pfl));
     pfl->storage = memory_region_get_ram_ptr(&pfl->orig_mem);
     pfl->chip_len = chip_len;
 
-- 
2.7.4
