Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDd-0003Q0-8w
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDa-0004uS-UG
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:37 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDa-0004u7-Pg
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:34 -0500
Received: by mail-pl0-x242.google.com with SMTP id bi12so22518165plb.6
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:41 -0800
Message-Id: <20171229063145.29167-35-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 34/38] target/hppa: Only use EXCP_DTLB_MISS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Unknown why this works, but if we return EXCP_ITLB_MISS we
will triple-fault the first userland instruction fetch.
Is it something to do with having a combined I/DTLB?

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index e2f94faab5..a0a385cb54 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -97,7 +97,9 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     if (ent == NULL || !ent->entry_valid) {
         phys = 0;
         prot = 0;
-        ret = (ifetch ? EXCP_ITLB_MISS : EXCP_DTLB_MISS);
+        /* ??? Unconditionally report data tlb miss,
+           even if this is an instruction fetch.  */
+        ret = EXCP_DTLB_MISS;
         goto egress;
     }
 
-- 
2.14.3
