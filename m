Received: from eggs.gnu.org ([2001:4830:134:3::10]:42187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEakE-0001H6-FK
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEak9-0006C4-Gg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:55:14 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEak9-0006Ab-63
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 07:55:09 -0500
Received: by mail-wm0-x243.google.com with SMTP id y80so21058254wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 04:55:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 14 Nov 2017 13:53:04 +0100
Message-Id: <20171114125304.854-1-richard.henderson@linaro.org>
In-Reply-To: <20171114094203.28030-1-richard.henderson@linaro.org>
References: <20171114094203.28030-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/1] target/arm: Use helper_retaddr in stxp
 helpers
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

We use raw memory primitives along the !parallel_cpus paths in order to
simplify the endianness handling.  Because of that, we did not benefit
from the generic changes to cpu_ldst_user_only_template.h.

The simplest fix is to manipulate helper_retaddr here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index d0e435ca4b..96a3ecf707 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -456,6 +456,8 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
 #ifdef CONFIG_USER_ONLY
         /* ??? Enforce alignment.  */
         uint64_t *haddr = g2h(addr);
+
+        helper_retaddr = ra;
         o0 = ldq_le_p(haddr + 0);
         o1 = ldq_le_p(haddr + 1);
         oldv = int128_make128(o0, o1);
@@ -465,6 +467,7 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
             stq_le_p(haddr + 0, int128_getlo(newv));
             stq_le_p(haddr + 1, int128_gethi(newv));
         }
+        helper_retaddr = 0;
 #else
         int mem_idx = cpu_mmu_index(env, false);
         TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
@@ -523,6 +526,8 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
 #ifdef CONFIG_USER_ONLY
         /* ??? Enforce alignment.  */
         uint64_t *haddr = g2h(addr);
+
+        helper_retaddr = ra;
         o1 = ldq_be_p(haddr + 0);
         o0 = ldq_be_p(haddr + 1);
         oldv = int128_make128(o0, o1);
@@ -532,6 +537,7 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
             stq_be_p(haddr + 0, int128_gethi(newv));
             stq_be_p(haddr + 1, int128_getlo(newv));
         }
+        helper_retaddr = 0;
 #else
         int mem_idx = cpu_mmu_index(env, false);
         TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
-- 
2.12.0
