Received: from eggs.gnu.org ([2001:4830:134:3::10]:51365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURt-000513-L7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURs-00024i-NB
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:21 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURs-00023f-H1
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:20 -0500
Received: by mail-pf0-x243.google.com with SMTP id a88so4351197pfe.12
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:20 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:14 -0800
Message-Id: <20180124232625.30105-35-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 34/45] target/hppa: Use MMU_DEBUG_LOAD when
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

Bypass any tlb protection checks, as this is not a "real"
access to memory per the architecture.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c |  2 +-
 target/hppa/mem_helper.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index d54d830196..1a9bbe268a 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -156,7 +156,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
                     vaddr = hppa_form_gva_psw(old_psw, iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, 0,
-                                                  MMU_INST_FETCH,
+                                                  MMU_DEBUG_LOAD,
                                                   &paddr, &prot);
                     if (t >= 0) {
                         /* We can't re-load the instruction.  */
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 81bcbe45db..4decfca407 100644
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
