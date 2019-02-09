Received: from eggs.gnu.org ([209.51.188.92]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsVTw-0003h8-Bq
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsVTu-0000kN-ER
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gsVTs-0000ij-GE
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:52 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  9 Feb 2019 11:27:45 -0500
Message-Id: <20190209162745.12668-3-cota@braap.org>
In-Reply-To: <20190209162745.12668-1-cota@braap.org>
References: <20190209162745.12668-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/2] cputlb: update TLB entry/index after
 tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

We are failing to take into account that tlb_fill() can cause a
TLB resize, which renders prior TLB entry pointers/indices stale.
Fix it by re-doing the TLB entry lookups immediately after tlb_fill.

Fixes: 86e1eff8bc ("tcg: introduce dynamic TLB sizing", 2019-01-28)
Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/softmmu_template.h | 8 ++++++++
 accel/tcg/cputlb.c           | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index 1fdd262ea4..e970a8b378 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -129,6 +129,8 @@ WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = entry->ADDR_READ;
     }
@@ -198,6 +200,8 @@ WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
                      mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = entry->ADDR_READ;
     }
@@ -294,6 +298,8 @@ void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
@@ -372,6 +378,8 @@ void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
     }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f580e4dd7e..88cc8389e9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1045,6 +1045,8 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
     if (unlikely(!tlb_hit(entry->addr_code, addr))) {
         if (!VICTIM_TLB_HIT(addr_code, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 0, MMU_INST_FETCH, mmu_idx, 0);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
         }
         assert(tlb_hit(entry->addr_code, addr));
     }
@@ -1125,6 +1127,8 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         if (!VICTIM_TLB_HIT(addr_write, addr)) {
             tlb_fill(ENV_GET_CPU(env), addr, 1 << s_bits, MMU_DATA_STORE,
                      mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            tlbe = tlb_entry(env, mmu_idx, addr);
         }
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
-- 
2.17.1
