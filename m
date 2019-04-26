Received: from eggs.gnu.org ([209.51.188.92]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aa-0000Ak-Bg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aZ-0007Kw-2d
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:44 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aY-0007GO-S7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id j11so2024176pff.13
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 10:24:21 -0700
Message-Id: <20190426172421.27133-16-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 15/15] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Shahab Vahedi <shahab.vahedi@gmail.com>

From: Shahab Vahedi <shahab.vahedi@gmail.com>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
Message-Id: <20190420072236.12347-1-shahab.vahedi@gmail.com>
[rth: Remove assert; fix expression formatting.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..f2f618217d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -878,10 +878,11 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr = (access_type == MMU_DATA_LOAD ?
+                    entry->addr_read : entry->addr_code);
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.17.1
