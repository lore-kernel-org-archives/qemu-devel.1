Received: from eggs.gnu.org ([209.51.188.92]:59846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtF9A-00020I-Pl
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtExo-0000w8-2I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:49 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:34181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtExn-0000uQ-QC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:47 -0500
Received: by mail-pg1-x533.google.com with SMTP id d9so5227624pgl.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:01:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 09:01:36 -0800
Message-Id: <20190211170136.18680-5-richard.henderson@linaro.org>
In-Reply-To: <20190211170136.18680-1-richard.henderson@linaro.org>
References: <20190211170136.18680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 4/4] cputlb: update TLB entry/index after
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

We are failing to take into account that tlb_fill() can cause a
TLB resize, which renders prior TLB entry pointers/indices stale.
Fix it by re-doing the TLB entry lookups immediately after tlb_fill.

Fixes: 86e1eff8bc ("tcg: introduce dynamic TLB sizing", 2019-01-28)
Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20190209162745.12668-3-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.2
