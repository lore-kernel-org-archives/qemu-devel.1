Received: from eggs.gnu.org ([2001:4830:134:3::10]:51037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURO-0004XD-2q
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURN-0001gY-91
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:50 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURN-0001gI-3g
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:49 -0500
Received: by mail-pg0-x242.google.com with SMTP id z17so3815345pgc.4
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:26:48 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.26.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:26:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:25:53 -0800
Message-Id: <20180124232625.30105-14-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 13/45] target/hppa: Implement unaligned
 access trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index ca619578dd..4d0b760baa 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -48,6 +48,23 @@ static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
     info->print_insn = print_insn_hppa;
 }
 
+static void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                         MMUAccessType access_type,
+                                         int mmu_idx, uintptr_t retaddr)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+
+    cs->exception_index = EXCP_UNALIGN;
+    if (env->psw & PSW_Q) {
+        /* ??? Needs tweaking for hppa64.  */
+        env->cr[CR_IOR] = addr;
+        env->cr[CR_ISR] = addr >> 32;
+    }
+
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
 static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -139,7 +156,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 #else
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
 #endif
-
+    cc->do_unaligned_access = hppa_cpu_do_unaligned_access;
     cc->disas_set_info = hppa_cpu_disas_set_info;
     cc->tcg_initialize = hppa_translate_init;
 
-- 
2.14.3
