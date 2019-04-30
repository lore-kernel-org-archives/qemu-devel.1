Received: from eggs.gnu.org ([209.51.188.92]:39265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2D-0004E1-1Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzn-0000lZ-6l
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzm-0000jB-U6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id n25so4588770wmk.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:29 +0100
Message-Id: <20190430165234.32272-11-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v5 10/15] cputlb: Drop attribute flatten
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

Going to approach this problem via __attribute__((always_inline))
instead, but full conversion will take several steps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 105 ++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 63 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 9c04eb1687..ccbb47d8d1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1291,51 +1291,44 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
  * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
  */
 
-tcg_target_ulong __attribute__((flatten))
-helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                    uintptr_t retaddr)
+tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
+                                     TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 1, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_le_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_be_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, true, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_le_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, false, false);
 }
 
-tcg_target_ulong __attribute__((flatten))
-helper_be_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+tcg_target_ulong helper_be_ldul_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, true, false);
 }
 
-uint64_t __attribute__((flatten))
-helper_le_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                  uintptr_t retaddr)
+uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
+                           TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, false, false);
 }
 
-uint64_t __attribute__((flatten))
-helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                  uintptr_t retaddr)
+uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
+                           TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, true, false);
 }
@@ -1519,51 +1512,44 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     }
 }
 
-void __attribute__((flatten))
-helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
-                   TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 1, false);
 }
 
-void __attribute__((flatten))
-helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 2, false);
 }
 
-void __attribute__((flatten))
-helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 2, true);
 }
 
-void __attribute__((flatten))
-helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 4, false);
 }
 
-void __attribute__((flatten))
-helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 4, true);
 }
 
-void __attribute__((flatten))
-helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 8, false);
 }
 
-void __attribute__((flatten))
-helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
-                  TCGMemOpIdx oi, uintptr_t retaddr)
+void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                       TCGMemOpIdx oi, uintptr_t retaddr)
 {
     store_helper(env, addr, val, oi, retaddr, 8, true);
 }
@@ -1627,51 +1613,44 @@ helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 
 /* Code access functions.  */
 
-uint8_t __attribute__((flatten))
-helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                    uintptr_t retaddr)
+uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 1, false, true);
 }
 
-uint16_t __attribute__((flatten))
-helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint16_t helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, false, true);
 }
 
-uint16_t __attribute__((flatten))
-helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint16_t helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 2, true, true);
 }
 
-uint32_t __attribute__((flatten))
-helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint32_t helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, false, true);
 }
 
-uint32_t __attribute__((flatten))
-helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint32_t helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 4, true, true);
 }
 
-uint64_t __attribute__((flatten))
-helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, false, true);
 }
 
-uint64_t __attribute__((flatten))
-helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-                   uintptr_t retaddr)
+uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
     return load_helper(env, addr, oi, retaddr, 8, true, true);
 }
-- 
2.20.1
