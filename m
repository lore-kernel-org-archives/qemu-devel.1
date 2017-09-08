Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeD-0002FK-MF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe5-0003LK-NR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:29 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:51 +1000
Message-Id: <20170908103558.31632-34-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 33/40] ppc: use macros to make cpu type name
 from string literal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Replace
  "-" TYPE_POWERPC_CPU
when composing cpu type name from cpu model string literal
and the same pattern in format strings with
 POWERPC_CPU_TYPE_SUFFIX and POWERPC_CPU_TYPE_NAME(model)
macroses like we do in x86.

Later POWERPC_CPU_TYPE_NAME() will be used to define default
cpu type per machine type and as bonus it will be consistent
and easy grep-able pattern across all other targets that I'm
plannig to treat the same way.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.c     | 2 +-
 target/ppc/cpu.h            | 3 +++
 target/ppc/kvm.c            | 2 +-
 target/ppc/kvm_ppc.h        | 2 +-
 target/ppc/translate_init.c | 6 +++---
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index e0d9faf848..782977425b 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -51,7 +51,7 @@
                                                                             \
     static const TypeInfo                                                   \
     glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_type_info) = {         \
-        .name       = _name "-" TYPE_POWERPC_CPU,                           \
+        .name       = POWERPC_CPU_TYPE_NAME(_name),                           \
         .parent     = stringify(_type) "-family-" TYPE_POWERPC_CPU,         \
         .class_init =                                                       \
             glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init),   \
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 042372c5ad..c9d3ffa89b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1354,6 +1354,9 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_model)
 
+#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
+#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_ppc_signal_handler
 #define cpu_list ppc_cpu_list
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b6bd0fa7a6..abcfe13b8a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2529,7 +2529,7 @@ static int kvm_ppc_register_host_cpu_type(void)
             char *suffix;
 
             ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWERPC_CPU);
+            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
             if (suffix) {
                 *suffix = 0;
             }
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index e6711fc2b7..f780e6ec7b 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -9,7 +9,7 @@
 #ifndef KVM_PPC_H
 #define KVM_PPC_H
 
-#define TYPE_HOST_POWERPC_CPU "host-" TYPE_POWERPC_CPU
+#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
 #ifdef CONFIG_KVM
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 703ea12f2a..ee42c56288 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10261,7 +10261,7 @@ static gint ppc_cpu_compare_class_name(gconstpointer a, gconstpointer b)
     if (strncasecmp(name, object_class_get_name(oc), strlen(name)) == 0 &&
         ppc_cpu_is_valid(pcc) &&
         strcmp(object_class_get_name(oc) + strlen(name),
-               "-" TYPE_POWERPC_CPU) == 0) {
+               POWERPC_CPU_TYPE_SUFFIX) == 0) {
         return 0;
     }
     return -1;
@@ -10403,7 +10403,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     }
 
     name = g_strndup(typename,
-                     strlen(typename) - strlen("-" TYPE_POWERPC_CPU));
+                     strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
     (*s->cpu_fprintf)(s->file, "PowerPC %-16s PVR %08x\n",
                       name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
@@ -10464,7 +10464,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     typename = object_class_get_name(oc);
     info = g_malloc0(sizeof(*info));
     info->name = g_strndup(typename,
-                           strlen(typename) - strlen("-" TYPE_POWERPC_CPU));
+                           strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
-- 
2.13.5
