Received: from eggs.gnu.org ([209.51.188.92]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K6-0005D3-2X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9K4-0007vV-Kd
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:38256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9K4-0007oG-CS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:59:44 -0500
Received: by mail-pl1-x636.google.com with SMTP id e5so7924208plb.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:59:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 07:58:55 -0800
Message-Id: <20190128155907.20607-12-richard.henderson@linaro.org>
In-Reply-To: <20190128155907.20607-1-richard.henderson@linaro.org>
References: <20190128155907.20607-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/23] cputlb: do not evict empty entries to the
 vtlb
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

Currently we evict an entry to the victim TLB when it doesn't match
the current address. But it could be that there's no match because
the current entry is empty (i.e. all -1's, for instance via tlb_flush).
Do not evict the entry to the vtlb in that case.

This change will help us keep track of the TLB's use rate, which
we'll use to implement a policy for dynamic TLB sizing.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20190116170114.26802-2-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index af6bd8ccf9..10f1150c62 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -224,6 +224,15 @@ static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry,
            tlb_hit_page(tlb_entry->addr_code, page);
 }
 
+/**
+ * tlb_entry_is_empty - return true if the entry is not in use
+ * @te: pointer to CPUTLBEntry
+ */
+static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
+{
+    return te->addr_read == -1 && te->addr_write == -1 && te->addr_code == -1;
+}
+
 /* Called with tlb_c.lock held */
 static inline void tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
                                           target_ulong page)
@@ -591,7 +600,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * Only evict the old entry to the victim tlb if it's for a
      * different page; otherwise just overwrite the stale data.
      */
-    if (!tlb_hit_page_anyprot(te, vaddr_page)) {
+    if (!tlb_hit_page_anyprot(te, vaddr_page) && !tlb_entry_is_empty(te)) {
         unsigned vidx = env->tlb_d[mmu_idx].vindex++ % CPU_VTLB_SIZE;
         CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
 
-- 
2.17.2
