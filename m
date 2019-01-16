Received: from eggs.gnu.org ([209.51.188.92]:44017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoZO-0001QJ-GG
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoZN-0001AO-6P
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:38 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjoZK-00017O-KW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:36 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 16 Jan 2019 12:01:12 -0500
Message-Id: <20190116170114.26802-2-cota@braap.org>
In-Reply-To: <20190116170114.26802-1-cota@braap.org>
References: <20190116170114.26802-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 1/3] cputlb: do not evict empty entries to
 the vtlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Currently we evict an entry to the victim TLB when it doesn't match
the current address. But it could be that there's no match because
the current entry is empty (i.e. all -1's, for instance via tlb_flush).
Do not evict the entry to the vtlb in that case.

This change will help us keep track of the TLB's use rate, which
we'll use to implement a policy for dynamic TLB sizing.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
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
2.17.1
