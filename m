Received: from eggs.gnu.org ([2001:4830:134:3::10]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCY8J-0002bJ-7u
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCY8E-0000JC-LQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:48:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCY8E-0000GU-DS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:48:06 -0400
Received: by mail-pg1-x542.google.com with SMTP id f8-v6so11531750pgq.5
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:48:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:47:59 -0700
Message-Id: <20181016224759.3158-2-richard.henderson@linaro.org>
In-Reply-To: <20181016224759.3158-1-richard.henderson@linaro.org>
References: <20181016224759.3158-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/1] target/hppa: Raise exception 26 on emulated
 hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>

From: Helge Deller <deller@gmx.de>

On PCXS chips (PA7000, pa 1.1a), trap #18 is raised on memory faults,
while all later chips (>= PA7100) generate either trap #26, #27 or #28
(depending on the fault type).

Since the current qemu emulation emulates a B160L machine (with a
PA7300LC PCX-L2 chip, we should raise trap #26 (EXCP_DMAR) instead
of #18 (EXCP_DMP) on access faults by the Linux kernel to page zero.

With the patch we now get the correct output (I tested against real
hardware):
 Kernel Fault: Code=26 (Data memory access rights trap)
instead of:
 Kernel Fault: Code=18 (Data memory protection/unaligned access trap)

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20181007205153.GA30270@ls3530.fritz.box>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index ab160c2a74..aecf3075f6 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -137,7 +137,8 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
-        ret = (type & PAGE_EXEC ? EXCP_IMP : EXCP_DMP);
+        ret = (type & PAGE_EXEC ? EXCP_IMP :
+               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
         goto egress;
     }
 
-- 
2.17.2
