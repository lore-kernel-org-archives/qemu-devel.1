Received: from eggs.gnu.org ([2001:4830:134:3::10]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12Z-0002gx-Bp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12X-0001yI-Sz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:55 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:12 +0200
Message-Id: <1500040339-119465-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 21/28] arm: replace cpu_arm_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>, qemu-arm@nongnu.org

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Jan Kiszka <jan.kiszka@web.de>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Andrzej Zaborowski <balrogg@gmail.com>
CC: qemu-arm@nongnu.org
---
 target/arm/cpu.h    | 3 +--
 hw/arm/musicpal.c   | 2 +-
 hw/arm/omap1.c      | 2 +-
 hw/arm/omap2.c      | 2 +-
 hw/arm/pxa2xx.c     | 4 ++--
 hw/arm/strongarm.c  | 2 +-
 target/arm/helper.c | 5 -----
 7 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 16a1e59..c9be0ac 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -746,7 +746,6 @@ int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 #endif
 
-ARMCPU *cpu_arm_init(const char *cpu_model);
 target_ulong do_arm_semihosting(CPUARMState *env);
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
@@ -1999,7 +1998,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
 
-#define cpu_init(cpu_model) CPU(cpu_arm_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_arm_signal_handler
 #define cpu_list arm_cpu_list
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9c710f7..0d519f9 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1593,7 +1593,7 @@ static void musicpal_init(MachineState *machine)
     if (!cpu_model) {
         cpu_model = "arm926";
     }
-    cpu = cpu_arm_init(cpu_model);
+    cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
     if (!cpu) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 54582bd..391eb28 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3863,7 +3863,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
 
     /* Core */
     s->mpu_model = omap310;
-    s->cpu = cpu_arm_init(core);
+    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
     if (s->cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 91f5733..a20bb1f 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2261,7 +2261,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
 
     /* Core */
     s->mpu_model = omap2420;
-    s->cpu = cpu_arm_init(core ?: "arm1136-r2");
+    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r2"));
     if (s->cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 629e6c6..2f1c141 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2065,7 +2065,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
     if (!revision)
         revision = "pxa270";
 
-    s->cpu = cpu_arm_init(revision);
+    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
     if (s->cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
@@ -2197,7 +2197,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
 
     s = g_new0(PXA2xxState, 1);
 
-    s->cpu = cpu_arm_init("pxa255");
+    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
     if (s->cpu == NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 7683edc..a27d7c8 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1597,7 +1597,7 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
         exit(1);
     }
 
-    s->cpu = cpu_arm_init(rev);
+    s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
 
     if (!s->cpu) {
         error_report("Unable to find CPU definition");
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2594faa..86e69a6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5237,11 +5237,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 }
 
-ARMCPU *cpu_arm_init(const char *cpu_model)
-{
-    return ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
-}
-
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-- 
2.7.4
