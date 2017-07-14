Received: from eggs.gnu.org ([2001:4830:134:3::10]:41473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12M-0002I6-CK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12K-0001op-Rp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12K-0001oe-IG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:40 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:07 +0200
Message-Id: <1500040339-119465-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 16/28] nios2: replace cpu_nios2_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

cpu_nios2_init() always falls back to TYPE_NIOS2_CPU object
regardless of cpu_model. Put fallback logic into
nios2_cpu_class_by_name() which would translate any cpu_model
into TYPE_NIOS2_CPU class and replace cpu_nios2_init()
with cpu_generic_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Chris Wulff <crwulff@gmail.com>
CC: Marek Vasut <marex@denx.de>
---
 target/nios2/cpu.h        | 3 +--
 hw/nios2/10m50_devboard.c | 2 +-
 target/nios2/cpu.c        | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 13931f3..50d803a 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -212,7 +212,6 @@ static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
 #define ENV_OFFSET offsetof(Nios2CPU, env)
 
 void nios2_tcg_init(void);
-Nios2CPU *cpu_nios2_init(const char *cpu_model);
 void nios2_cpu_do_interrupt(CPUState *cs);
 int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env);
@@ -229,7 +228,7 @@ void nios2_check_interrupts(CPUNios2State *env);
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) CPU(cpu_nios2_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_NIOS2_CPU, cpu_model)
 
 #define cpu_gen_code cpu_nios2_gen_code
 #define cpu_signal_handler cpu_nios2_signal_handler
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 051be73..c8aa116 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -75,7 +75,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
                                 phys_ram_alias);
 
     /* Create CPU -- FIXME */
-    cpu = cpu_nios2_init("nios2");
+    cpu = NIOS2_CPU(cpu_generic_init(TYPE_NIOS2_CPU, "nios2"));
 
     /* Register: CPU interrupt controller (PIC) */
     cpu_irq = nios2_cpu_pic_init(cpu);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index d56bb72..5b02fb6 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -83,13 +83,9 @@ static void nios2_cpu_initfn(Object *obj)
     }
 }
 
-Nios2CPU *cpu_nios2_init(const char *cpu_model)
+static ObjectClass *nios2_cpu_class_by_name(const char *cpu_model)
 {
-    Nios2CPU *cpu = NIOS2_CPU(object_new(TYPE_NIOS2_CPU));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
+    return object_class_by_name(TYPE_NIOS2_CPU);
 }
 
 static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -203,6 +199,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     ncc->parent_reset = cc->reset;
     cc->reset = nios2_cpu_reset;
 
+    cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
     cc->do_interrupt = nios2_cpu_do_interrupt;
     cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
-- 
2.7.4
