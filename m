Received: from eggs.gnu.org ([209.51.188.92]:49807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002na-O7
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8y-00027f-9M
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:08 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:43249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8p-0001uY-0E
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:57 -0500
Received: by mail-pg1-x52d.google.com with SMTP id v28so655021pgk.10
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:21 -0800
Message-Id: <20190212045721.28041-25-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 24/24] hw/hppa: forward requests to CPU HPA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

HP-UX 10.20 uses busmaster writes to the CPU EIR to signal
interrupts from the SCSI constroller. (Similar to what is known
as MSI on x86)

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190211192039.5457-1-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
