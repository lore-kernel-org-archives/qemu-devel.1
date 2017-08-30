Received: from eggs.gnu.org ([2001:4830:134:3::10]:50916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2z5-0001of-I1
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2z3-0003W0-KX
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 30 Aug 2017 15:24:29 +0200
Message-Id: <1504099475-241036-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/8] ppc: use macros to make cpu type name
 from string literal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

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
---
 target/ppc/cpu.h            | 3 +++
 target/ppc/kvm_ppc.h        | 2 +-
 target/ppc/cpu-models.c     | 2 +-
 target/ppc/kvm.c            | 2 +-
 target/ppc/translate_init.c | 6 +++---
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 12f0949..0512393 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1354,6 +1354,9 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_model)
 
+#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
+#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
+
 #define cpu_signal_handler cpu_ppc_signal_handler
 #define cpu_list ppc_cpu_list
 
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 381afe6..f5d7397 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -9,7 +9,7 @@
 #ifndef KVM_PPC_H
 #define KVM_PPC_H
 
-#define TYPE_HOST_POWERPC_CPU "host-" TYPE_POWERPC_CPU
+#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
 #ifdef CONFIG_KVM
 
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4d3e635..8b27962 100644
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
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f31c67e..2aa5382 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2492,7 +2492,7 @@ static int kvm_ppc_register_host_cpu_type(void)
             char *suffix;
 
             ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWERPC_CPU);
+            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
             if (suffix) {
                 *suffix = 0;
             }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 43be9a8..f377cf2 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10185,7 +10185,7 @@ static gint ppc_cpu_compare_class_name(gconstpointer a, gconstpointer b)
     if (strncasecmp(name, object_class_get_name(oc), strlen(name)) == 0 &&
         ppc_cpu_is_valid(pcc) &&
         strcmp(object_class_get_name(oc) + strlen(name),
-               "-" TYPE_POWERPC_CPU) == 0) {
+               POWERPC_CPU_TYPE_SUFFIX) == 0) {
         return 0;
     }
     return -1;
@@ -10327,7 +10327,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     }
 
     name = g_strndup(typename,
-                     strlen(typename) - strlen("-" TYPE_POWERPC_CPU));
+                     strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
     (*s->cpu_fprintf)(s->file, "PowerPC %-16s PVR %08x\n",
                       name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
@@ -10388,7 +10388,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     typename = object_class_get_name(oc);
     info = g_malloc0(sizeof(*info));
     info->name = g_strndup(typename,
-                           strlen(typename) - strlen("-" TYPE_POWERPC_CPU));
+                           strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
-- 
2.7.4
