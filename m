Received: from eggs.gnu.org ([2001:4830:134:3::10]:48970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UD-0004Sm-Fp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0U8-0008Dw-Cu
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:29 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0U8-0008DK-6r
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:24 -0400
Received: by mail-pl0-x22a.google.com with SMTP id z9-v6so8098975plo.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:24 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:16 +0900
Message-Id: <20180702151023.24532-19-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 18/25] target/openrisc: Stub out
 handle_mmu_fault for softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

This hook is only used by CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/mmu.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index a4613e9ae4..f4c0a3e217 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -177,42 +177,17 @@ static void cpu_openrisc_raise_mmu_exception(OpenRISCCPU *cpu,
     cpu->env.lock_addr = -1;
 }
 
-#ifndef CONFIG_USER_ONLY
 int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
                                   int rw, int mmu_idx)
 {
+#ifdef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    int ret = 0;
-    hwaddr physical = 0;
-    int prot = 0;
-
-    ret = get_phys_addr(cpu, &physical, &prot, address, rw);
-
-    if (ret == TLBRET_MATCH) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
-        ret = 0;
-    } else if (ret < 0) {
-        cpu_openrisc_raise_mmu_exception(cpu, address, rw, ret);
-        ret = 1;
-    }
-
-    return ret;
-}
+    cpu_openrisc_raise_mmu_exception(cpu, address, rw, 0);
+    return 1;
 #else
-int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                                  int rw, int mmu_idx)
-{
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    int ret = 0;
-
-    cpu_openrisc_raise_mmu_exception(cpu, address, rw, ret);
-    ret = 1;
-
-    return ret;
-}
+    g_assert_not_reached();
 #endif
+}
 
 #ifndef CONFIG_USER_ONLY
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.17.0
