Received: from eggs.gnu.org ([2001:4830:134:3::10]:58886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeE-0002GH-CA
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe6-0003ME-81
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:54 +1000
Message-Id: <20170908103558.31632-37-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 36/40] ppc: replace inter-function cyclic
 dependency/recurssion with 2 simple lookups
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

previous patches cleaned up cpu model/alias naming which
allows to simplify cpu model/alias to cpu type lookup a bit
byt removing recurssion and dependency of ppc_cpu_class_by_name() /
ppc_cpu_class_by_alias() on each other.
Besides of simplifying code it reduces it by ~15LOC.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index f392fa6ea9..4092310c83 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10252,22 +10252,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
     return pcc;
 }
 
-static gint ppc_cpu_compare_class_name(gconstpointer a, gconstpointer b)
-{
-    ObjectClass *oc = (ObjectClass *)a;
-    const char *name = b;
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    if (strncasecmp(name, object_class_get_name(oc), strlen(name)) == 0 &&
-        ppc_cpu_is_valid(pcc) &&
-        strcmp(object_class_get_name(oc) + strlen(name),
-               POWERPC_CPU_TYPE_SUFFIX) == 0) {
-        return 0;
-    }
-    return -1;
-}
-
-
 static ObjectClass *ppc_cpu_class_by_name(const char *name);
 
 static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
@@ -10292,8 +10276,8 @@ static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
 
 static ObjectClass *ppc_cpu_class_by_name(const char *name)
 {
-    GSList *list, *item;
-    ObjectClass *ret = NULL;
+    char *cpu_model, *typename;
+    ObjectClass *oc;
     const char *p;
     int i, len;
 
@@ -10314,21 +10298,20 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
         }
     }
 
-    list = object_class_get_list(TYPE_POWERPC_CPU, false);
-    item = g_slist_find_custom(list, name, ppc_cpu_compare_class_name);
-    if (item != NULL) {
-        ret = OBJECT_CLASS(item->data);
+    cpu_model = g_ascii_strdown(name, -1);
+    p = ppc_cpu_lookup_alias(cpu_model);
+    if (p) {
+        g_free(cpu_model);
+        cpu_model = g_strdup(p);
     }
-    g_slist_free(list);
 
-    if (ret) {
-        return ret;
-    }
+    typename = g_strdup_printf("%s" POWERPC_CPU_TYPE_SUFFIX, cpu_model);
+    oc = object_class_by_name(typename);
+    g_free(typename);
+    g_free(cpu_model);
 
-    for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
-        if (strcasecmp(ppc_cpu_aliases[i].alias, name) == 0) {
-            return ppc_cpu_class_by_alias(&ppc_cpu_aliases[i]);
-        }
+    if (oc && ppc_cpu_is_valid(POWERPC_CPU_CLASS(oc))) {
+        return oc;
     }
 
     return NULL;
-- 
2.13.5
