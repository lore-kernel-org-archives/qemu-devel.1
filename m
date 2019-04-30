Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW29-000491-1N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzo-0000o9-Pw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzo-0000mL-Ey
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so4621897wmd.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:30 +0100
Message-Id: <20190430165234.32272-12-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 11/15] cputlb: Do unaligned load recursion
 to outermost function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

If we attempt to recurse from load_helper back to load_helper,
even via intermediary, we do not get all of the constants
expanded away as desired.

But if we recurse back to the original helper (or a shim that
has a consistent function signature), the operands are folded
away as desired.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 117 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ccbb47d8d1..e4d0c94301 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1157,10 +1157,13 @@ static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endian)
  * is disassembled. It shouldn't be called directly by guest code.
  */
 
-static uint64_t load_helper(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr,
-                            size_t size, bool big_endian,
-                            bool code_read)
+typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
+                                TCGMemOpIdx oi, uintptr_t retaddr);
+
+static inline uint64_t __attribute__((always_inline))
+load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+            uintptr_t retaddr, size_t size, bool big_endian, bool code_read,
+            FullLoadHelper *full_load)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1233,8 +1236,8 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
     do_unaligned_access:
         addr1 = addr & ~(size - 1);
         addr2 = addr1 + size;
-        r1 = load_helper(env, addr1, oi, retaddr, size, big_endian, code_read);
-        r2 = load_helper(env, addr2, oi, retaddr, size, big_endian, code_read);
+        r1 = full_load(env, addr1, oi, retaddr);
+        r2 = full_load(env, addr2, oi, retaddr);
         shift = (addr & (size - 1)) * 8;
 
         if (big_endian) {
@@ -1291,46 +1294,83 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
  * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
  */
 
+static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
+                              TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, false,
+                       full_ldub_mmu);
+}
+
 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
                                      TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, false);
+    return full_ldub_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, false,
+                       full_le_lduw_mmu);
 }
 
 tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, false);
+    return full_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, false,
+                       full_be_lduw_mmu);
 }
 
 tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, false);
+    return full_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, false,
+                       full_le_ldul_mmu);
 }
 
 tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, false);
+    return full_le_ldul_mmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                 TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, false,
+                       full_be_ldul_mmu);
 }
 
 tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, false);
+    return full_be_ldul_mmu(env, addr, oi, retaddr);
 }
 
 uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, false);
+    return load_helper(env, addr, oi, retaddr, 8, false, false,
+                       helper_le_ldq_mmu);
 }
 
 uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, false);
+    return load_helper(env, addr, oi, retaddr, 8, true, false,
+                       helper_be_ldq_mmu);
 }
 
 /*
@@ -1613,44 +1653,81 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
+static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
+                               TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, true,
+                       full_ldub_cmmu);
+}
+
 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, true);
+    return full_ldub_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, true,
+                       full_le_lduw_cmmu);
 }
 
 uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, true);
+    return full_le_lduw_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, true,
+                       full_be_lduw_cmmu);
 }
 
 uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, true);
+    return full_be_lduw_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, true,
+                       full_le_ldul_cmmu);
 }
 
 uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, true);
+    return full_le_ldul_cmmu(env, addr, oi, retaddr);
+}
+
+static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
+                                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, true,
+                       full_be_ldul_cmmu);
 }
 
 uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, true);
+    return full_be_ldul_cmmu(env, addr, oi, retaddr);
 }
 
 uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, true);
+    return load_helper(env, addr, oi, retaddr, 8, false, true,
+                       helper_le_ldq_cmmu);
 }
 
 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, true);
+    return load_helper(env, addr, oi, retaddr, 8, true, true,
+                       helper_be_ldq_cmmu);
 }
-- 
2.20.1
