Received: from eggs.gnu.org ([209.51.188.92]:38298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHkMA-00062C-5T
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHkM9-0000xr-12
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:24:14 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hHkM8-0000x3-OI
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:24:12 -0400
Received: by mail-ed1-x544.google.com with SMTP id i13so5955246edf.11
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:24:12 -0700 (PDT)
From: Shahab Vahedi <shahab.vahedi@gmail.com>
Date: Sat, 20 Apr 2019 09:22:37 +0200
Message-Id: <20190420072236.12347-1-shahab.vahedi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] cputlb: Fix io_readx() to respect the
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
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
---
Changelog:
v3
  - Only handle read/fetch. There must be no write access.

v2
  - Extra space before closing parenthesis is removed

v1
  - Initial submit

 accel/tcg/cputlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..6d50fcc52d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -868,6 +868,9 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    /* Only support for reading/fetching IO */
+    assert(access_type == MMU_DATA_LOAD || access_type == MMU_INST_FETCH);
+
     if (recheck) {
         /*
          * This is a TLB_RECHECK access, where the MMU protection
@@ -878,10 +881,11 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr = (access_type == MMU_DATA_LOAD) ?
+            entry->addr_read : entry->addr_code;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.21.0
