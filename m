Received: from eggs.gnu.org ([2001:4830:134:3::10]:44276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWPHm-0001SB-3q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWPHk-0008CJ-6G
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:24:02 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gWPHj-0008BI-Rg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:24:00 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 16:56:35 +0000
Message-Id: <20181210165636.28366-3-peter.maydell@linaro.org>
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
References: <20181210165636.28366-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 2/3] target/m68k: In get_physical_address() check
 for memory access failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In get_physical_address(), use address_space_ldl() and
address_space_stl() instead of ldl_phys() and stl_phys().
This allows us to check whether the memory access failed.
For the moment, we simply return -1 in this case;
add a TODO comment that we should ideally generate the
appropriate kind of fault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/helper.c | 62 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 374e4861886..b5fa2f8056d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -660,6 +660,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     bool debug = access_type & ACCESS_DEBUG;
     int page_bits;
     int i;
+    MemTxResult txres;
 
     /* Transparent Translation (physical = logical) */
     for (i = 0; i < M68K_MAX_TTR; i++) {
@@ -689,12 +690,19 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     /* Root Index */
     entry = M68K_POINTER_BASE(next) | M68K_ROOT_INDEX(address);
 
-    next = ldl_phys(cs->as, entry);
+    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (txres != MEMTX_OK) {
+        goto txfail;
+    }
     if (!M68K_UDT_VALID(next)) {
         return -1;
     }
     if (!(next & M68K_DESC_USED) && !debug) {
-        stl_phys(cs->as, entry, next | M68K_DESC_USED);
+        address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                          MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK) {
+            goto txfail;
+        }
     }
     if (next & M68K_DESC_WRITEPROT) {
         if (access_type & ACCESS_PTEST) {
@@ -709,12 +717,19 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     /* Pointer Index */
     entry = M68K_POINTER_BASE(next) | M68K_POINTER_INDEX(address);
 
-    next = ldl_phys(cs->as, entry);
+    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (txres != MEMTX_OK) {
+        goto txfail;
+    }
     if (!M68K_UDT_VALID(next)) {
         return -1;
     }
     if (!(next & M68K_DESC_USED) && !debug) {
-        stl_phys(cs->as, entry, next | M68K_DESC_USED);
+        address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                          MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK) {
+            goto txfail;
+        }
     }
     if (next & M68K_DESC_WRITEPROT) {
         if (access_type & ACCESS_PTEST) {
@@ -733,27 +748,46 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
         entry = M68K_4K_PAGE_BASE(next) | M68K_4K_PAGE_INDEX(address);
     }
 
-    next = ldl_phys(cs->as, entry);
+    next = address_space_ldl(cs->as, entry, MEMTXATTRS_UNSPECIFIED, &txres);
+    if (txres != MEMTX_OK) {
+        goto txfail;
+    }
 
     if (!M68K_PDT_VALID(next)) {
         return -1;
     }
     if (M68K_PDT_INDIRECT(next)) {
-        next = ldl_phys(cs->as, M68K_INDIRECT_POINTER(next));
+        next = address_space_ldl(cs->as, M68K_INDIRECT_POINTER(next),
+                                 MEMTXATTRS_UNSPECIFIED, &txres);
+        if (txres != MEMTX_OK) {
+            goto txfail;
+        }
     }
     if (access_type & ACCESS_STORE) {
         if (next & M68K_DESC_WRITEPROT) {
             if (!(next & M68K_DESC_USED) && !debug) {
-                stl_phys(cs->as, entry, next | M68K_DESC_USED);
+                address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                                  MEMTXATTRS_UNSPECIFIED, &txres);
+                if (txres != MEMTX_OK) {
+                    goto txfail;
+                }
             }
         } else if ((next & (M68K_DESC_MODIFIED | M68K_DESC_USED)) !=
                            (M68K_DESC_MODIFIED | M68K_DESC_USED) && !debug) {
-                stl_phys(cs->as, entry,
-                         next | (M68K_DESC_MODIFIED | M68K_DESC_USED));
+            address_space_stl(cs->as, entry,
+                              next | (M68K_DESC_MODIFIED | M68K_DESC_USED),
+                              MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK) {
+                goto txfail;
+            }
         }
     } else {
         if (!(next & M68K_DESC_USED) && !debug) {
-            stl_phys(cs->as, entry, next | M68K_DESC_USED);
+            address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                              MEMTXATTRS_UNSPECIFIED, &txres);
+            if (txres != MEMTX_OK) {
+                goto txfail;
+            }
         }
     }
 
@@ -785,6 +819,14 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     }
 
     return 0;
+
+txfail:
+    /*
+     * A page table load/store failed. TODO: we should really raise a
+     * suitable guest fault here if this is not a debug access.
+     * For now just return that the translation failed.
+     */
+    return -1;
 }
 
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.19.2
