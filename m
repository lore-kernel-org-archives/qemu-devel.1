Received: from eggs.gnu.org ([209.51.188.92]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UH-000654-0U
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UG-0006ON-4X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:40847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK5UF-0006Nb-T8
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:16 -0400
Received: by mail-pg1-x52c.google.com with SMTP id d31so1993096pgl.7
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 11:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 11:22:10 -0700
Message-Id: <20190426182210.10442-3-richard.henderson@linaro.org>
In-Reply-To: <20190426182210.10442-1-richard.henderson@linaro.org>
References: <20190426182210.10442-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/2] target/hppa: Always return EXCP_DMAR for
 protection id trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Nick Hudson <skrll@netbsd.org>

From: Nick Hudson <skrll@netbsd.org>

The EXCP_DMP trap is considered legacy.

"In PA-RISC 1.1 (Second Edition) and later revisions, processors must use
traps 26, 27,and 28 which provide equivalent functionality"

Signed-off-by: Nick Hudson <skrll@netbsd.org>
Message-Id: <20190423063621.8203-3-nick.hudson@gmx.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..77fb544838 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -154,8 +154,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
 
     if (unlikely(!(prot & type))) {
         /* The access isn't allowed -- Inst/Data Memory Protection Fault.  */
-        ret = (type & PAGE_EXEC ? EXCP_IMP :
-               prot & PAGE_READ ? EXCP_DMP : EXCP_DMAR);
+        ret = (type & PAGE_EXEC) ? EXCP_IMP : EXCP_DMAR;
         goto egress;
     }
 
-- 
2.17.1
