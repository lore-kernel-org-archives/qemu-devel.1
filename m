Received: from eggs.gnu.org ([2001:4830:134:3::10]:42660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NE-0000jE-Vp
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NE-00008z-8p
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:21 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV0NE-00007q-3y
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:20 -0500
Received: by mail-pl0-x241.google.com with SMTP id n13so23462370plp.11
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 11:31:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 11:31:07 -0800
Message-Id: <20171229193113.11753-3-richard.henderson@linaro.org>
In-Reply-To: <20171229193113.11753-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/8] target/moxie: Fix tlb_fill
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

We should not exit unless moxie_cpu_handle_mmu_fault has failed.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/moxie/helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 2ecee89f11..6890ffd71c 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -36,9 +36,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        cpu_restore_state(cs, retaddr);
+        cpu_loop_exit_restore(cs, retaddr);
     }
-    cpu_loop_exit(cs);
 }
 
 void helper_raise_exception(CPUMoxieState *env, int ex)
-- 
2.14.3
