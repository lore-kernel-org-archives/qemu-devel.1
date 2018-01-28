Received: from eggs.gnu.org ([2001:4830:134:3::10]:52296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBT-00036h-TJ
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBR-0000J4-Fi
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:23 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBR-0000IC-96
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:21 -0500
Received: by mail-pf0-x242.google.com with SMTP id a88so3251278pfe.12
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:17 -0800
Message-Id: <20180128231528.22719-33-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 32/43] target/hppa: Only use EXCP_DTLB_MISS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Unknown why this works, but if we return EXCP_ITLB_MISS we
will triple-fault the first userland instruction fetch.
Is it something to do with having a combined I/DTLB?

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a34c64cc4a..08a4eb2480 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -96,7 +96,9 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     if (ent == NULL || !ent->entry_valid) {
         phys = 0;
         prot = 0;
-        ret = (type & PAGE_EXEC ? EXCP_ITLB_MISS : EXCP_DTLB_MISS);
+        /* ??? Unconditionally report data tlb miss,
+           even if this is an instruction fetch.  */
+        ret = EXCP_DTLB_MISS;
         goto egress;
     }
 
-- 
2.14.3
