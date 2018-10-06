Received: from eggs.gnu.org ([2001:4830:134:3::10]:34476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO9-0000AY-09
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8uO8-0007IZ-3O
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8uO7-00075S-S8
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 17:45:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  6 Oct 2018 17:45:04 -0400
Message-Id: <20181006214508.5331-3-cota@braap.org>
In-Reply-To: <20181006214508.5331-1-cota@braap.org>
References: <20181006214508.5331-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 2/6] cputlb: do not evict invalid entries to the
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
Cc: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Currently we evict an entry to the victim TLB when it doesn't match
the current address. But it could be that there's no match because
the current entry is invalid. Do not evict the entry to the vtlb
in that case.

This change will help us keep track of the TLB's use rate.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-all.h | 14 ++++++++++++++
 accel/tcg/cputlb.c     |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 117d2fbbca..d938dedafc 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -362,6 +362,20 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
     return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
 }
 
+/**
+ * tlb_is_valid - return true if at least one of the addresses is valid
+ * @te: pointer to CPUTLBEntry
+ *
+ * This is useful when we don't have a particular address to compare against,
+ * and we just want to know whether any entry holds valid data.
+ */
+static inline bool tlb_is_valid(const CPUTLBEntry *te)
+{
+    return !(te->addr_read & TLB_INVALID_MASK) ||
+           !(te->addr_write & TLB_INVALID_MASK) ||
+           !(te->addr_code & TLB_INVALID_MASK);
+}
+
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
 void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0b51efc374..0e2c149d6b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -695,7 +695,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * Only evict the old entry to the victim tlb if it's for a
      * different page; otherwise just overwrite the stale data.
      */
-    if (!tlb_hit_page_anyprot(te, vaddr_page)) {
+    if (!tlb_hit_page_anyprot(te, vaddr_page) && tlb_is_valid(te)) {
         unsigned vidx = env->vtlb_index++ % CPU_VTLB_SIZE;
         CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
 
-- 
2.17.1
