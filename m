Received: from eggs.gnu.org ([2001:4830:134:3::10]:60580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDG-0003vl-98
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDE-0000Wd-9A
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDE-0000W2-0W
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:08 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:36 +0200
Message-Id: <1503050939-227939-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 04/27] sparc: move adhoc CPUSPARCState
 initialization to realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

SPARCCPU::env was initialized from previosuly set properties
(with help of sparc_cpu_parse_features) in cpu_sparc_register().
However there is not reason to keep it there as this task is
typically done at realize time. So move post properties
initialization into sparc_cpu_realizefn, which brings
cpu_sparc_init() closer to cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e735d73..7f74b1c 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -109,7 +109,6 @@ static void sparc_cpu_parse_features(CPUState *cs, char *features,
 
 static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
 {
-    CPUSPARCState *env = &cpu->env;
     char *s = g_strdup(cpu_model);
     char *featurestr = strtok(s, ",");
     Error *err = NULL;
@@ -122,19 +121,6 @@ static int cpu_sparc_register(SPARCCPU *cpu, const char *cpu_model)
         return -1;
     }
 
-    env->version = env->def.iu_version;
-    env->fsr = env->def.fpu_version;
-    env->nwindows = env->def.nwindows;
-#if !defined(TARGET_SPARC64)
-    env->mmuregs[0] |= env->def.mmu_version;
-    cpu_sparc_set_id(env, 0);
-    env->mxccregs[7] |= env->def.mxcc_version;
-#else
-    env->mmu_version = env->def.mmu_version;
-    env->maxtl = env->def.maxtl;
-    env->version |= env->def.maxtl << 8;
-    env->version |= env->def.nwindows - 1;
-#endif
     return 0;
 }
 
@@ -817,15 +803,29 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
-#if defined(CONFIG_USER_ONLY)
     SPARCCPU *cpu = SPARC_CPU(dev);
     CPUSPARCState *env = &cpu->env;
 
+#if defined(CONFIG_USER_ONLY)
     if ((env->def.features & CPU_FEATURE_FLOAT)) {
         env->def.features |= CPU_FEATURE_FLOAT128;
     }
 #endif
 
+    env->version = env->def.iu_version;
+    env->fsr = env->def.fpu_version;
+    env->nwindows = env->def.nwindows;
+#if !defined(TARGET_SPARC64)
+    env->mmuregs[0] |= env->def.mmu_version;
+    cpu_sparc_set_id(env, 0);
+    env->mxccregs[7] |= env->def.mxcc_version;
+#else
+    env->mmu_version = env->def.mmu_version;
+    env->maxtl = env->def.maxtl;
+    env->version |= env->def.maxtl << 8;
+    env->version |= env->def.nwindows - 1;
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.7.4
