Received: from eggs.gnu.org ([208.118.235.92]:35861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgT-0004Or-SJ
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgR-0005Rg-Th
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:05 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:60316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1geWgR-0005Qu-Ix
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:03 -0500
Message-Id: <fa4665529f65d02a924437b18e90686b173676f6.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 6/8] ppc4xx: Pass array index to function
 instead of pointer into the array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

The sdram_set_bcr() function in ppc440_uc.c takes a pointer into an
array then calculates its index from that. It's simpler and easier to
just pass the index which simplifies both the function and its callers.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index e46f59fba8..60dbb35eee 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -564,28 +564,26 @@ static target_ulong sdram_size(uint32_t bcr)
     return size;
 }
 
-static void sdram_set_bcr(ppc440_sdram_t *sdram,
-                          uint32_t *bcrp, uint32_t bcr, int enabled)
+static void sdram_set_bcr(ppc440_sdram_t *sdram, int i,
+                          uint32_t bcr, int enabled)
 {
-    unsigned n = bcrp - sdram->bcr;
-
-    if (*bcrp & 1) {
-        /* Unmap RAM */
+    if (sdram->bcr[i] & 1) {
+        /* First unmap RAM if enabled */
         memory_region_del_subregion(get_system_memory(),
-                                    &sdram->containers[n]);
-        memory_region_del_subregion(&sdram->containers[n],
-                                    &sdram->ram_memories[n]);
-        object_unparent(OBJECT(&sdram->containers[n]));
+                                    &sdram->containers[i]);
+        memory_region_del_subregion(&sdram->containers[i],
+                                    &sdram->ram_memories[i]);
+        object_unparent(OBJECT(&sdram->containers[i]));
     }
-    *bcrp = bcr & 0xFFDEE001;
+    sdram->bcr[i] = bcr & 0xFFDEE001;
     if (enabled && (bcr & 1)) {
-        memory_region_init(&sdram->containers[n], NULL, "sdram-containers",
+        memory_region_init(&sdram->containers[i], NULL, "sdram-containers",
                            sdram_size(bcr));
-        memory_region_add_subregion(&sdram->containers[n], 0,
-                                    &sdram->ram_memories[n]);
+        memory_region_add_subregion(&sdram->containers[i], 0,
+                                    &sdram->ram_memories[i]);
         memory_region_add_subregion(get_system_memory(),
                                     sdram_base(bcr),
-                                    &sdram->containers[n]);
+                                    &sdram->containers[i]);
     }
 }
 
@@ -595,12 +593,10 @@ static void sdram_map_bcr(ppc440_sdram_t *sdram)
 
     for (i = 0; i < sdram->nbanks; i++) {
         if (sdram->ram_sizes[i] != 0) {
-            sdram_set_bcr(sdram,
-                          &sdram->bcr[i],
-                          sdram_bcr(sdram->ram_bases[i], sdram->ram_sizes[i]),
-                          1);
+            sdram_set_bcr(sdram, i, sdram_bcr(sdram->ram_bases[i],
+                                              sdram->ram_sizes[i]), 1);
         } else {
-            sdram_set_bcr(sdram, &sdram->bcr[i], 0, 0);
+            sdram_set_bcr(sdram, i, 0, 0);
         }
     }
 }
-- 
2.13.7
