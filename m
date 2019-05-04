Received: from eggs.gnu.org ([209.51.188.92]:42367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oI-0003sM-9x
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oH-0004ce-Bp
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:06 -0400
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat,  4 May 2019 23:02:33 +0200
Message-Id: <1557003754-26473-3-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] 40p and prep: implement PCI bus mastering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, hpoussin@reactos.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, "open list:PReP" <qemu-ppc@nongnu.org>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/pci-host/prep.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 8b9e1fd..94b7465 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -62,6 +62,7 @@ typedef struct PRePPCIState {
     AddressSpace pci_io_as;
     MemoryRegion pci_io;
     MemoryRegion pci_io_non_contiguous;
+    MemoryRegion pci_io_system;
     MemoryRegion pci_memory;
     MemoryRegion pci_intack;
     MemoryRegion bm;
@@ -146,7 +147,7 @@ static uint64_t raven_io_read(void *opaque, hwaddr addr,
     uint8_t buf[4];
 
     addr = raven_io_address(s, addr);
-    address_space_read(&s->pci_io_as, addr + 0x80000000,
+    address_space_read(&s->pci_io_as, addr,
                        MEMTXATTRS_UNSPECIFIED, buf, size);
 
     if (size == 1) {
@@ -178,7 +179,7 @@ static void raven_io_write(void *opaque, hwaddr addr,
         g_assert_not_reached();
     }
 
-    address_space_write(&s->pci_io_as, addr + 0x80000000,
+    address_space_write(&s->pci_io_as, addr,
                         MEMTXATTRS_UNSPECIFIED, buf, size);
 }
 
@@ -276,14 +277,21 @@ static void raven_pcihost_initfn(Object *obj)
     MemoryRegion *address_space_mem = get_system_memory();
     DeviceState *pci_dev;
 
-    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
+    memory_region_init(&s->pci_io, obj, "pci-io", UINT32_MAX);
     memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
                           "pci-io-non-contiguous", 0x00800000);
     memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
     address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
 
     /* CPU address space */
-    memory_region_add_subregion(address_space_mem, 0x80000000, &s->pci_io);
+    memory_region_add_subregion_overlap(address_space_mem, 0x0,
+                                        &s->pci_io, -1);
+
+    memory_region_init_alias(&s->pci_io_system,  obj, "pci-io-system",
+                             &s->pci_io, 0x0000000, 0x3f800000);
+
+    memory_region_add_subregion(address_space_mem, 0x80000000,
+                                &s->pci_io_system);
     memory_region_add_subregion_overlap(address_space_mem, 0x80000000,
                                         &s->pci_io_non_contiguous, 1);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
-- 
2.7.2
