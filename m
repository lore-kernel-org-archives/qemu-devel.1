Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fV2-0005Sk-5g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUz-0001Zc-Hl
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:26 +1000
Message-Id: <20170511041426.6488-24-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/23] target/ppc: Avoid printing wrong aliases
 in CPU help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

When running with KVM, we update the "family" CPU alias to point
to the right host CPU type, so that it for example possible to
use "-cpu POWER8" on a POWER8NVL host. However, the function for
printing the list of available CPU models is called earlier than
the KVM setup code, so the output of "-cpu help" is wrong in that
case. Since it would be somewhat ugly anyway to have different
help texts depending on whether "-enable-kvm" has been specified
or not, we should better always print the same text, so fix this
issue by printing "alias for preferred XXX CPU" instead.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h            |  1 +
 target/ppc/kvm.c            | 12 ------------
 target/ppc/translate_init.c | 27 +++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c0f63f6..401e10e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1225,6 +1225,7 @@ static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
 
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
+PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
 
 struct PPCVirtualHypervisor {
     Object parent;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb2cf2b..51249ce 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2424,18 +2424,6 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
-static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
-{
-    ObjectClass *oc = OBJECT_CLASS(pcc);
-
-    while (oc && !object_class_is_abstract(oc)) {
-        oc = object_class_get_parent(oc);
-    }
-    assert(oc);
-
-    return POWERPC_CPU_CLASS(oc);
-}
-
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index fda30b0..56a0ab2 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10285,6 +10285,18 @@ PowerPCCPU *cpu_ppc_init(const char *cpu_model)
     return POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
 }
 
+PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
+{
+    ObjectClass *oc = OBJECT_CLASS(pcc);
+
+    while (oc && !object_class_is_abstract(oc)) {
+        oc = object_class_get_parent(oc);
+    }
+    assert(oc);
+
+    return POWERPC_CPU_CLASS(oc);
+}
+
 /* Sort by PVR, ordering special case "host" last. */
 static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
@@ -10316,6 +10328,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     ObjectClass *oc = data;
     CPUListState *s = user_data;
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+    DeviceClass *family = DEVICE_CLASS(ppc_cpu_get_family_class(pcc));
     const char *typename = object_class_get_name(oc);
     char *name;
     int i;
@@ -10338,8 +10351,18 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
         if (alias_oc != oc) {
             continue;
         }
-        (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n",
-                          alias->alias, name);
+        /*
+         * If running with KVM, we might update the family alias later, so
+         * avoid printing the wrong alias here and use "preferred" instead
+         */
+        if (strcmp(alias->alias, family->desc) == 0) {
+            (*s->cpu_fprintf)(s->file,
+                              "PowerPC %-16s (alias for preferred %s CPU)\n",
+                              alias->alias, family->desc);
+        } else {
+            (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n",
+                              alias->alias, name);
+        }
     }
     g_free(name);
 }
-- 
2.9.3
