Received: from eggs.gnu.org ([2001:4830:134:3::10]:55167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv3F-0000qY-VI
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv3F-0007bI-1B
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv3E-0007aj-RZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C997280B2A
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AD9E4139
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:45 +0200
Message-Id: <1503592308-93913-23-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 22/25] moxie: replace
 cpu_moxie_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/moxie/cpu.h  | 3 +--
 hw/moxie/moxiesim.c | 2 +-
 target/moxie/cpu.c  | 5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 8991aae..75decaa 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -112,7 +112,6 @@ static inline MoxieCPU *moxie_env_get_cpu(CPUMoxieState *env)
 
 #define ENV_OFFSET offsetof(MoxieCPU, env)
 
-MoxieCPU *cpu_moxie_init(const char *cpu_model);
 void moxie_cpu_do_interrupt(CPUState *cs);
 void moxie_cpu_dump_state(CPUState *cpu, FILE *f,
                           fprintf_function cpu_fprintf, int flags);
@@ -121,7 +120,7 @@ void moxie_translate_init(void);
 int cpu_moxie_signal_handler(int host_signum, void *pinfo,
                              void *puc);
 
-#define cpu_init(cpu_model) CPU(cpu_moxie_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_MOXIE_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_moxie_signal_handler
 
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index df3f124..4c27b45 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -118,7 +118,7 @@ static void moxiesim_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "MoxieLite-moxie-cpu";
     }
-    cpu = cpu_moxie_init(cpu_model);
+    cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
     if (!cpu) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 927b1a1..748d02f 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -150,11 +150,6 @@ static const MoxieCPUInfo moxie_cpus[] = {
     { .name = "any",            .initfn = moxie_any_initfn },
 };
 
-MoxieCPU *cpu_moxie_init(const char *cpu_model)
-{
-    return MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
-}
-
 static void cpu_register(const MoxieCPUInfo *info)
 {
     TypeInfo type_info = {
-- 
2.7.4
