Received: from eggs.gnu.org ([209.51.188.92]:34892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtH8Y-0005NP-FR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 14:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtH8X-0000lo-Fh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 14:21:02 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:51202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gtH8X-0000ky-3N
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 14:21:01 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Feb 2019 20:20:39 +0100
Message-Id: <20190211192039.5457-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/hppa: forward requests to CPU HPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

HP-UX 10.20 uses busmaster writes to the CPU EIR to signal
interrupts from the SCSI constroller. (Similar to what is known
as MSI on x86)

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/hppa/dino.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 31e09942b5..360716de57 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -105,6 +105,7 @@ typedef struct DinoState {
     MemoryRegion bm;
     MemoryRegion bm_ram_alias;
     MemoryRegion bm_pci_alias;
+    MemoryRegion bm_cpu_alias;
 
     MemoryRegion cpu0_eir_mem;
 } DinoState;
@@ -473,12 +474,17 @@ PCIBus *dino_init(MemoryRegion *addr_space,
     memory_region_init_alias(&s->bm_pci_alias, OBJECT(s),
                              "bm-pci", &s->pci_mem,
                              0xf0000000 + DINO_MEM_CHUNK_SIZE,
-                             31 * DINO_MEM_CHUNK_SIZE);
+                             30 * DINO_MEM_CHUNK_SIZE);
+    memory_region_init_alias(&s->bm_cpu_alias, OBJECT(s),
+                             "bm-cpu", addr_space, 0xfff00000,
+                             0xfffff);
     memory_region_add_subregion(&s->bm, 0,
                                 &s->bm_ram_alias);
     memory_region_add_subregion(&s->bm,
                                 0xf0000000 + DINO_MEM_CHUNK_SIZE,
                                 &s->bm_pci_alias);
+    memory_region_add_subregion(&s->bm, 0xfff00000,
+                                &s->bm_cpu_alias);
     address_space_init(&s->bm_as, &s->bm, "pci-bm");
     pci_setup_iommu(b, dino_pcihost_set_iommu, s);
 
-- 
2.20.1
