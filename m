Received: from eggs.gnu.org ([2001:4830:134:3::10]:51009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDe-0003RI-DB
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDd-0004vr-Hb
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:38 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDd-0004vD-Cj
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:37 -0500
Received: by mail-pl0-x241.google.com with SMTP id b96so22521399pli.2
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:43 -0800
Message-Id: <20171229063145.29167-37-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 36/38] target/hppa: Use MMU_DEBUG_LOAD when
 reloading for CR[IIR]
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

Bypass any tlb protection checks, as this is not a "real"
access to memory per the architecture.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c |  2 +-
 target/hppa/mem_helper.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index ee72769544..e831944b8d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -154,7 +154,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
                 int prot, t;
 
                 vaddr = hppa_form_gva_psw(old_psw, iasq_f, iaoq_f & -4);
-                t = hppa_get_physical_address(env, vaddr, 0, MMU_INST_FETCH,
+                t = hppa_get_physical_address(env, vaddr, 0, MMU_DEBUG_LOAD,
                                               &paddr, &prot);
                 if (t >= 0) {
                     /* We can't re-load the instruction.  */
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a0a385cb54..4bdc4d77e5 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -131,12 +131,21 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     /* ??? Check PSW_P and ent->access_prot.  This can remove PROT_WRITE.  */
 
     /* Map MMUAccessType to QEMU protection.  */
-    if (ifetch) {
-        a_prot = PROT_EXEC;
-    } else if (type == MMU_DATA_STORE) {
-        a_prot = PROT_WRITE;
-    } else {
+    switch (type) {
+    case MMU_DATA_LOAD:
         a_prot = PROT_READ;
+        break;
+    case MMU_DATA_STORE:
+        a_prot = PROT_WRITE;
+        break;
+    case MMU_INST_FETCH:
+        a_prot = PROT_EXEC;
+        break;
+    case MMU_DEBUG_LOAD:
+        ret = -1;
+        goto egress;
+    default:
+        g_assert_not_reached();
     }
 
     if (unlikely(!(prot & a_prot))) {
-- 
2.14.3
