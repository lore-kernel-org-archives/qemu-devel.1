Received: from eggs.gnu.org ([2001:4830:134:3::10]:41329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11z-0001o1-Ki
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW11y-0001c9-HA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW11y-0001bk-8Q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:18 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:01 +0200
Message-Id: <1500040339-119465-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 10/28] sparc: replace cpu_sparc_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Fabien Chouteau <chouteau@adacore.com>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/cpu.h   | 3 +--
 hw/sparc/leon3.c     | 2 +-
 hw/sparc/sun4m.c     | 2 +-
 hw/sparc64/sparc64.c | 2 +-
 target/sparc/cpu.c   | 5 -----
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 0e41916..b45cfb4 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -579,7 +579,6 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
 
 #ifndef NO_CPU_IO_DEFS
 /* cpu_init.c */
-SPARCCPU *cpu_sparc_init(const char *cpu_model);
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* mmu_helper.c */
@@ -656,7 +655,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 int cpu_sparc_signal_handler(int host_signum, void *pinfo, void *puc);
 
 #ifndef NO_CPU_IO_DEFS
-#define cpu_init(cpu_model) CPU(cpu_sparc_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_SPARC_CPU, cpu_model)
 #endif
 
 #define cpu_signal_handler cpu_sparc_signal_handler
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f415997..fb4faee 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -126,7 +126,7 @@ static void leon3_generic_hw_init(MachineState *machine)
         cpu_model = "LEON3";
     }
 
-    cpu = cpu_sparc_init(cpu_model);
+    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
         exit(1);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0faff46..74b3534 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -797,7 +797,7 @@ static void cpu_devinit(const char *cpu_model, unsigned int id,
     SPARCCPU *cpu;
     CPUSPARCState *env;
 
-    cpu = cpu_sparc_init(cpu_model);
+    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
         exit(1);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4e4fdab..ecf38a4 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -353,7 +353,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
     if (cpu_model == NULL) {
         cpu_model = default_cpu_model;
     }
-    cpu = cpu_sparc_init(cpu_model);
+    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "Unable to find Sparc CPU definition\n");
         exit(1);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1271b7f..722bd48 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -118,11 +118,6 @@ static void sparc_cpu_parse_features(const char *typename, char *features,
         &plus_features, &minus_features, errp);
 }
 
-SPARCCPU *cpu_sparc_init(const char *cpu_model)
-{
-    return SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
-}
-
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu)
 {
 #if !defined(TARGET_SPARC64)
-- 
2.7.4
