Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeJ-0002Ly-91
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe8-0003Pq-Mg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:56 +1000
Message-Id: <20170908103558.31632-39-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 38/40] ppc: drop caching ObjectClass from
 PowerPCCPUAlias
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

Caching there practically doesn't give any benefits
and that at slow path druring querying supported CPU list.
But it introduces non conventional path of where from
comes used CPU type name (kvm_ppc_register_host_cpu_type).

Taking in account that kvm_ppc_register_host_cpu_type()
fixes up models the aliases point to, it's sufficient to
make ppc_cpu_class_by_name() translate cpu alias to
correct cpu type name.
So drop PowerPCCPUAlias::oc field + ppc_cpu_class_by_alias()
and let ppc_cpu_class_by_name() do conversion to cpu type name,
which simplifies code a little bit saving ~20LOC and trouble
wondering why ppc_cpu_class_by_alias() is necessary.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.h     |  1 -
 target/ppc/kvm.c            |  1 -
 target/ppc/translate_init.c | 26 ++------------------------
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 629f112337..df31d7f492 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -31,7 +31,6 @@
 typedef struct PowerPCCPUAlias {
     const char *alias;
     const char *model;
-    ObjectClass *oc;
 } PowerPCCPUAlias;
 
 extern PowerPCCPUAlias ppc_cpu_aliases[];
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6861f2f585..6442dfcb95 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2533,7 +2533,6 @@ static int kvm_ppc_register_host_cpu_type(void)
             if (suffix) {
                 *suffix = 0;
             }
-            ppc_cpu_aliases[i].oc = oc;
             break;
         }
     }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 7c1d83b489..3e24cddb86 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10253,28 +10253,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
     return pcc;
 }
 
-static ObjectClass *ppc_cpu_class_by_name(const char *name);
-
-static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
-{
-    ObjectClass *invalid_class = (void*)ppc_cpu_class_by_alias;
-
-    /* Cache target class lookups in the alias table */
-    if (!alias->oc) {
-        alias->oc = ppc_cpu_class_by_name(alias->model);
-        if (!alias->oc) {
-            /* Fast check for non-existing aliases */
-            alias->oc = invalid_class;
-        }
-    }
-
-    if (alias->oc == invalid_class) {
-        return NULL;
-    } else {
-        return alias->oc;
-    }
-}
-
 static ObjectClass *ppc_cpu_class_by_name(const char *name)
 {
     char *cpu_model, *typename;
@@ -10386,7 +10364,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
                       name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
-        ObjectClass *alias_oc = ppc_cpu_class_by_alias(alias);
+        ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
 
         if (alias_oc != oc) {
             continue;
@@ -10466,7 +10444,7 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
         CpuDefinitionInfoList *entry;
         CpuDefinitionInfo *info;
 
-        oc = ppc_cpu_class_by_alias(alias);
+        oc = ppc_cpu_class_by_name(alias->model);
         if (oc == NULL) {
             continue;
         }
-- 
2.13.5
