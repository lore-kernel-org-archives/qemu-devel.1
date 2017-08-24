Received: from eggs.gnu.org ([2001:4830:134:3::10]:54999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv36-0000f4-7y
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv34-0007Up-IX
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv34-0007UN-9e
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CB6081E01
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C636C5D736
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:32 +0200
Message-Id: <1503592308-93913-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v3 09/25] alpha: replace
 cpu_alpha_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

cpu_alpha_init() used to provide default fallback if invalid
(i.e. non existent) cpu_model were provided.

dp264 machine provides its own default so sole user of fallback
is [bsd|linux]-user targets which specifies 'any' cpu model that
fallbacks to "ev67" in cpu_alpha_init(). Push fallback handling
into alpha_cpu_class_by_name() and replace cpu_alpha_init() with
cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Richard Henderson <rth@twiddle.net>
---
PS:
  tested only linux-user as I don't have bsd box to test on
---
 target/alpha/cpu.h |  4 +---
 hw/alpha/dp264.c   |  8 ++++++--
 target/alpha/cpu.c | 20 +++++---------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index e95be2b..0738e97 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -468,9 +468,7 @@ enum {
 
 void alpha_translate_init(void);
 
-AlphaCPU *cpu_alpha_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_alpha_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_ALPHA_CPU, cpu_model)
 
 void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 3b307ad..1c5a177 100644
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
index 76150f4..1ea597b 100644
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
