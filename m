Received: from eggs.gnu.org ([209.51.188.92]:40451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW5U-0007Cl-Uu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW5T-0003mO-0A
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:58:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLW5S-0003lo-Pt
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:58:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so21866015wrp.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:58:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:31 +0100
Message-Id: <20190430165234.32272-13-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 12/15] cputlb: Do unaligned store recursion
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

This is less tricky than for loads, because we always fall
back to single byte stores to implement unaligned stores.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e4d0c94301..a083324768 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1413,9 +1413,9 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
  * Store Helpers
  */
 
-static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-                         TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
-                         bool big_endian)
+static inline void __attribute__((always_inline))
+store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+             TCGMemOpIdx oi, uintptr_t retaddr, size_t size, bool big_endian)
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
@@ -1514,7 +1514,7 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
                 /* Little-endian extract.  */
                 val8 = val >> (i * 8);
             }
-            store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
+            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
         }
         return;
     }
-- 
2.20.1
