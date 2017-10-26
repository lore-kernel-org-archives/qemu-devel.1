Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7ifw-0008HD-Rr
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7ift-0008D1-LA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:58:24 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:49415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7ift-0008Bc-Cm
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:58:21 -0400
Received: by mail-wr0-x243.google.com with SMTP id g90so3260195wrd.6
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 06:58:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 15:58:14 +0200
Message-Id: <20171026135814.20773-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, peter.maydell@linaro.org

Fix the build for --disable-tcg.

Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c            | 2 ++
 target/i386/cpu.c           | 2 ++
 target/mips/cpu.c           | 2 ++
 target/ppc/translate_init.c | 2 ++
 target/s390x/cpu.c          | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 056284985d..a7f03eabe8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1760,7 +1760,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->disas_set_info = arm_disas_set_info;
+#ifdef CONFIG_TCG
     cc->tcg_initialize = arm_translate_init;
+#endif
 }
 
 static void cpu_register(const ARMCPUInfo *info)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 53ec94ac9b..2f556c0ea3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4212,7 +4212,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #endif
     cc->cpu_exec_enter = x86_cpu_exec_enter;
     cc->cpu_exec_exit = x86_cpu_exec_exit;
+#ifdef CONFIG_TCG
     cc->tcg_initialize = tcg_x86_init;
+#endif
 
     dc->user_creatable = true;
 }
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0ae70288dd..80812f3e08 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -198,7 +198,9 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->vmsd = &vmstate_mips_cpu;
 #endif
     cc->disas_set_info = mips_cpu_disas_set_info;
+#ifdef CONFIG_TCG
     cc->tcg_initialize = mips_tcg_init;
+#endif
 
     cc->gdb_num_core_regs = 73;
     cc->gdb_stop_before_watchpoint = true;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 13436e4760..61a9552c1c 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10578,7 +10578,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->virtio_is_big_endian = ppc_cpu_is_big_endian;
 #endif
+#ifdef CONFIG_TCG
     cc->tcg_initialize = ppc_translate_init;
+#endif
 
     dc->fw_name = "PowerPC,UNKNOWN";
 }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 824dfd6b65..ae3cee91a2 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -497,7 +497,9 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 #endif
     cc->disas_set_info = s390_cpu_disas_set_info;
+#ifdef CONFIG_TCG
     cc->tcg_initialize = s390x_translate_init;
+#endif
 
     cc->gdb_num_core_regs = S390_NUM_CORE_REGS;
     cc->gdb_core_xml_file = "s390x-core64.xml";
-- 
2.13.6
