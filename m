Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12C-000218-W2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12B-0001jT-Vd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12B-0001jH-MP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:31 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:03 +0200
Message-Id: <1500040339-119465-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 12/28] alpha: replace cpu_alpha_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

cpu_alpha_init() used to provide default fallback if invalid
(i.e. non existent) cpu_model were provided.

dp264 machine provides its own default so sole user of fallback
is [bsd|linux]-user targets which specifies 'any' cpu model that
fallbacks to "ev67" in cpu_alpha_init(). Push fallback handling
into alpha_cpu_class_by_name() and replace cpu_alpha_init() with
cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS:
  tested only linux-user as I don't have bsd box to test on

CC: Richard Henderson <rth@twiddle.net>
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
---
 target/alpha/cpu.h |  4 +---
 hw/alpha/dp264.c   |  8 ++++++--
 target/alpha/cpu.c | 20 +++++---------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 691ac00..a390b82 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -457,9 +457,7 @@ enum {
 
 void alpha_translate_init(void);
 
-AlphaCPU *cpu_alpha_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_alpha_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_ALPHA_CPU, cpu_model)
 
 void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 85405da..2a85593 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -51,7 +51,7 @@ static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
 static void clipper_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
+    const char *cpu_model = machine->cpu_model ? machine->cpu_model : "ev67";
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
@@ -67,7 +67,11 @@ static void clipper_init(MachineState *machine)
     /* Create up to 4 cpus.  */
     memset(cpus, 0, sizeof(cpus));
     for (i = 0; i < smp_cpus; ++i) {
-        cpus[i] = cpu_alpha_init(cpu_model ? cpu_model : "ev67");
+        cpus[i] = ALPHA_CPU(cpu_generic_init(TYPE_ALPHA_CPU, cpu_model));
+        if (!cpus[i]) {
+            error_report("Unable to find CPU definition");
+            exit(1);
+        }
     }
 
     cpus[0]->env.trap_arg0 = ram_size;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 8186c9d..ff18e1a 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -155,24 +155,14 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
     if (oc != NULL && object_class_is_abstract(oc)) {
         oc = NULL;
     }
-    return oc;
-}
-
-AlphaCPU *cpu_alpha_init(const char *cpu_model)
-{
-    AlphaCPU *cpu;
-    ObjectClass *cpu_class;
 
-    cpu_class = alpha_cpu_class_by_name(cpu_model);
-    if (cpu_class == NULL) {
-        /* Default to ev67; no reason not to emulate insns by default.  */
-        cpu_class = object_class_by_name(TYPE("ev67"));
+    /* TODO: remove match everything nonsense */
+    /* Default to ev67; no reason not to emulate insns by default. */
+    if (!oc) {
+        oc = object_class_by_name(TYPE("ev67"));
     }
-    cpu = ALPHA_CPU(object_new(object_class_get_name(cpu_class)));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
 
-    return cpu;
+    return oc;
 }
 
 static void ev4_cpu_initfn(Object *obj)
-- 
2.7.4
