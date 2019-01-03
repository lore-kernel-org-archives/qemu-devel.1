Received: from eggs.gnu.org ([208.118.235.92]:58457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf65B-0000jJ-Df
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf656-0007ha-E1
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:42:57 -0500
Message-Id: <cbf1a249da96b354c44a07c9af40e025fa64a8cd.1546532844.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546532844.git.balaton@eik.bme.hu>
References: <cover.1546532844.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 03 Jan 2019 17:27:24 +0100
Subject: [Qemu-devel] [PATCH v3 5/6] ppc4xx: Pass array index to function
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
Do similar cleanup in ppc4xx_devs.c to similar function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v3: Also do similar cleanup in ppc4xx_devs.c

 hw/ppc/ppc440_uc.c   | 36 ++++++++++++++++--------------------
 hw/ppc/ppc4xx_devs.c | 44 ++++++++++++++++++++------------------------
 2 files changed, 36 insertions(+), 44 deletions(-)

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
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 9418478575..fdfeb67e65 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -405,36 +405,34 @@ static target_ulong sdram_size (uint32_t bcr)
     return size;
 }
 
-static void sdram_set_bcr(ppc4xx_sdram_t *sdram,
-                          uint32_t *bcrp, uint32_t bcr, int enabled)
+static void sdram_set_bcr(ppc4xx_sdram_t *sdram, int i,
+                          uint32_t bcr, int enabled)
 {
-    unsigned n = bcrp - sdram->bcr;
-
-    if (*bcrp & 0x00000001) {
+    if (sdram->bcr[i] & 0x00000001) {
         /* Unmap RAM */
 #ifdef DEBUG_SDRAM
         printf("%s: unmap RAM area " TARGET_FMT_plx " " TARGET_FMT_lx "\n",
-               __func__, sdram_base(*bcrp), sdram_size(*bcrp));
+               __func__, sdram_base(sdram->bcr[i]), sdram_size(sdram->bcr[i]));
 #endif
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
     if (enabled && (bcr & 0x00000001)) {
 #ifdef DEBUG_SDRAM
         printf("%s: Map RAM area " TARGET_FMT_plx " " TARGET_FMT_lx "\n",
                __func__, sdram_base(bcr), sdram_size(bcr));
 #endif
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
 
@@ -444,12 +442,10 @@ static void sdram_map_bcr (ppc4xx_sdram_t *sdram)
 
     for (i = 0; i < sdram->nbanks; i++) {
         if (sdram->ram_sizes[i] != 0) {
-            sdram_set_bcr(sdram,
-                          &sdram->bcr[i],
-                          sdram_bcr(sdram->ram_bases[i], sdram->ram_sizes[i]),
-                          1);
+            sdram_set_bcr(sdram, i, sdram_bcr(sdram->ram_bases[i],
+                                              sdram->ram_sizes[i]), 1);
         } else {
-            sdram_set_bcr(sdram, &sdram->bcr[i], 0x00000000, 0);
+            sdram_set_bcr(sdram, i, 0x00000000, 0);
         }
     }
 }
@@ -589,16 +585,16 @@ static void dcr_write_sdram (void *opaque, int dcrn, uint32_t val)
             sdram->pmit = (val & 0xF8000000) | 0x07C00000;
             break;
         case 0x40: /* SDRAM_B0CR */
-            sdram_set_bcr(sdram, &sdram->bcr[0], val, sdram->cfg & 0x80000000);
+            sdram_set_bcr(sdram, 0, val, sdram->cfg & 0x80000000);
             break;
         case 0x44: /* SDRAM_B1CR */
-            sdram_set_bcr(sdram, &sdram->bcr[1], val, sdram->cfg & 0x80000000);
+            sdram_set_bcr(sdram, 1, val, sdram->cfg & 0x80000000);
             break;
         case 0x48: /* SDRAM_B2CR */
-            sdram_set_bcr(sdram, &sdram->bcr[2], val, sdram->cfg & 0x80000000);
+            sdram_set_bcr(sdram, 2, val, sdram->cfg & 0x80000000);
             break;
         case 0x4C: /* SDRAM_B3CR */
-            sdram_set_bcr(sdram, &sdram->bcr[3], val, sdram->cfg & 0x80000000);
+            sdram_set_bcr(sdram, 3, val, sdram->cfg & 0x80000000);
             break;
         case 0x80: /* SDRAM_TR */
             sdram->tr = val & 0x018FC01F;
-- 
2.13.7
