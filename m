Received: from eggs.gnu.org ([2001:4830:134:3::10]:36712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAl-0007vY-Jo
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwh-0003x1-Aj
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:51 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:39 +0100
Message-Id: <20181113165247.4806-6-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/13] target: arm: Move the DC ZVA helper into
 op_helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
---
 target/arm/helper.c    | 84 ------------------------------------------
 target/arm/op_helper.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7b30a4cb49..bc2c8cdb67 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8917,90 +8917,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 
 #endif
 
-void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
-{
-    /* Implement DC ZVA, which zeroes a fixed-length block of memory.
-     * Note that we do not implement the (architecturally mandated)
-     * alignment fault for attempts to use this on Device memory
-     * (which matches the usual QEMU behaviour of not implementing either
-     * alignment faults or any memory attribute handling).
-     */
-
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    uint64_t blocklen = 4 << cpu->dcz_blocksize;
-    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-
-#ifndef CONFIG_USER_ONLY
-    {
-        /* Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
-         * the block size so we might have to do more than one TLB lookup.
-         * We know that in fact for any v8 CPU the page size is at least 4K
-         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
-         * 1K as an artefact of legacy v5 subpage support being present in the
-         * same QEMU executable.
-         */
-        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
-        void *hostaddr[maxidx];
-        int try, i;
-        unsigned mmu_idx = cpu_mmu_index(env, false);
-        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
-
-        for (try = 0; try < 2; try++) {
-
-            for (i = 0; i < maxidx; i++) {
-                hostaddr[i] = tlb_vaddr_to_host(env,
-                                                vaddr + TARGET_PAGE_SIZE * i,
-                                                1, mmu_idx);
-                if (!hostaddr[i]) {
-                    break;
-                }
-            }
-            if (i == maxidx) {
-                /* If it's all in the TLB it's fair game for just writing to;
-                 * we know we don't need to update dirty status, etc.
-                 */
-                for (i = 0; i < maxidx - 1; i++) {
-                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
-                }
-                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
-                return;
-            }
-            /* OK, try a store and see if we can populate the tlb. This
-             * might cause an exception if the memory isn't writable,
-             * in which case we will longjmp out of here. We must for
-             * this purpose use the actual register value passed to us
-             * so that we get the fault address right.
-             */
-            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
-            /* Now we can populate the other TLB entries, if any */
-            for (i = 0; i < maxidx; i++) {
-                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
-                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
-                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
-                }
-            }
-        }
-
-        /* Slow path (probably attempt to do this to an I/O device or
-         * similar, or clearing of a block of code we have translations
-         * cached for). Just do a series of byte writes as the architecture
-         * demands. It's not worth trying to use a cpu_physical_memory_map(),
-         * memset(), unmap() sequence here because:
-         *  + we'd need to account for the blocksize being larger than a page
-         *  + the direct-RAM access case is almost always going to be dealt
-         *    with in the fastpath code above, so there's no speed benefit
-         *  + we would have to deal with the map returning NULL because the
-         *    bounce buffer was in use
-         */
-        for (i = 0; i < blocklen; i++) {
-            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
-        }
-    }
-#else
-    memset(g2h(vaddr), 0, blocklen);
-#endif
-}
-
 /* Note that signed overflow is undefined in C.  The following routines are
    careful to use unsigned types where modulo arithmetic is required.
    Failure to do so _will_ break on newer gcc.  */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index eb6fb82fb8..44a74cb296 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1480,3 +1480,87 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
+
+void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
+{
+    /* Implement DC ZVA, which zeroes a fixed-length block of memory.
+     * Note that we do not implement the (architecturally mandated)
+     * alignment fault for attempts to use this on Device memory
+     * (which matches the usual QEMU behaviour of not implementing either
+     * alignment faults or any memory attribute handling).
+     */
+
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    uint64_t blocklen = 4 << cpu->dcz_blocksize;
+    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
+
+#ifndef CONFIG_USER_ONLY
+    {
+        /* Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
+         * the block size so we might have to do more than one TLB lookup.
+         * We know that in fact for any v8 CPU the page size is at least 4K
+         * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
+         * 1K as an artefact of legacy v5 subpage support being present in the
+         * same QEMU executable.
+         */
+        int maxidx = DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
+        void *hostaddr[maxidx];
+        int try, i;
+        unsigned mmu_idx = cpu_mmu_index(env, false);
+        TCGMemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
+
+        for (try = 0; try < 2; try++) {
+
+            for (i = 0; i < maxidx; i++) {
+                hostaddr[i] = tlb_vaddr_to_host(env,
+                                                vaddr + TARGET_PAGE_SIZE * i,
+                                                1, mmu_idx);
+                if (!hostaddr[i]) {
+                    break;
+                }
+            }
+            if (i == maxidx) {
+                /* If it's all in the TLB it's fair game for just writing to;
+                 * we know we don't need to update dirty status, etc.
+                 */
+                for (i = 0; i < maxidx - 1; i++) {
+                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
+                }
+                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
+                return;
+            }
+            /* OK, try a store and see if we can populate the tlb. This
+             * might cause an exception if the memory isn't writable,
+             * in which case we will longjmp out of here. We must for
+             * this purpose use the actual register value passed to us
+             * so that we get the fault address right.
+             */
+            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
+            /* Now we can populate the other TLB entries, if any */
+            for (i = 0; i < maxidx; i++) {
+                uint64_t va = vaddr + TARGET_PAGE_SIZE * i;
+                if (va != (vaddr_in & TARGET_PAGE_MASK)) {
+                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
+                }
+            }
+        }
+
+        /* Slow path (probably attempt to do this to an I/O device or
+         * similar, or clearing of a block of code we have translations
+         * cached for). Just do a series of byte writes as the architecture
+         * demands. It's not worth trying to use a cpu_physical_memory_map(),
+         * memset(), unmap() sequence here because:
+         *  + we'd need to account for the blocksize being larger than a page
+         *  + the direct-RAM access case is almost always going to be dealt
+         *    with in the fastpath code above, so there's no speed benefit
+         *  + we would have to deal with the map returning NULL because the
+         *    bounce buffer was in use
+         */
+        for (i = 0; i < blocklen; i++) {
+            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
+        }
+    }
+#else
+    memset(g2h(vaddr), 0, blocklen);
+#endif
+}
-- 
2.19.1
