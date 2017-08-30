Received: from eggs.gnu.org ([2001:4830:134:3::10]:51002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2zB-0001pl-6o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2zA-0003aB-Am
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:49 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 30 Aug 2017 15:24:34 +0200
Message-Id: <1504099475-241036-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/8] ppc: drop caching ObjectClass from
 PowerPCCPUAlias
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
---
 target/ppc/cpu-models.h     |  1 -
 target/ppc/kvm.c            |  1 -
 target/ppc/translate_init.c | 26 ++------------------------
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index d748c68..e9c6015 100644
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
index d185ef9..6870e6f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2496,7 +2496,6 @@ static int kvm_ppc_register_host_cpu_type(void)
             if (suffix) {
                 *suffix = 0;
             }
-            ppc_cpu_aliases[i].oc = oc;
             break;
         }
     }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index a803a7f..963c4f3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10177,28 +10177,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
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
@@ -10310,7 +10288,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
                       name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
-        ObjectClass *alias_oc = ppc_cpu_class_by_alias(alias);
+        ObjectClass *alias_oc = ppc_cpu_class_by_name(alias->model);
 
         if (alias_oc != oc) {
             continue;
@@ -10390,7 +10368,7 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
         CpuDefinitionInfoList *entry;
         CpuDefinitionInfo *info;
 
-        oc = ppc_cpu_class_by_alias(alias);
+        oc = ppc_cpu_class_by_name(alias->model);
         if (oc == NULL) {
             continue;
         }
-- 
2.7.4
