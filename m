Received: from eggs.gnu.org ([209.51.188.92]:36409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHRxR-0002jc-Mc
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHRxI-0000Wj-9E
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:45:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hHRxA-0000Pa-Sn
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:45:14 -0400
Received: by mail-ed1-x541.google.com with SMTP id k45so4236909edb.6
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 04:45:10 -0700 (PDT)
From: Shahab Vahedi <shahab.vahedi@gmail.com>
Date: Fri, 19 Apr 2019 13:45:02 +0200
Message-Id: <20190419114502.20388-1-shahab.vahedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "open list:Overall" <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Shahab Vahedi <shahab.vahedi@gmail.com>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
---
Changelog:
- Extra space before closing parenthesis is removed

 accel/tcg/cputlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..4a305ac942 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr =
+            (access_type == MMU_DATA_LOAD)  ? entry->addr_read  :
+            (access_type == MMU_DATA_STORE) ? entry->addr_write :
+            entry->addr_code;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.21.0
