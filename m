Received: from eggs.gnu.org ([2001:4830:134:3::10]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiW-0002Db-Ew
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiV-0006A4-DO
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiV-00069m-7A
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:47 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:02 +0200
Message-Id: <1506935300-132598-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 20/38] sh4: simplify superh_cpu_class_by_name()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

currently for sh4 cpu_model argument for '-cpu' option
could be either 'cpu model' name or cpu_typename.

however typically '-cpu' takes 'cpu model' name and
cpu type for sh4 target isn't advertised publicly
('-cpu help' prints only 'cpu model' names) so we
shouldn't care about this use case (it's more of a bug).

1. Drop '-cpu cpu_typename' to align with the rest of
   targets.
2. Compose searched for typename from cpu model and use
   it with object_class_by_name() directly instead of
   over-complicated
       object_class_get_list()
       g_slist_find_custom() + superh_cpu_name_compare()

With #1 droped, #2 could be used for both lookups which
simplifies superh_cpu_class_by_name() quite a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: aurelien@aurel32.net
---
 target/sh4/cpu.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9198460..b71ff01 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -120,36 +120,26 @@ void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     g_slist_free(list);
 }
 
-static gint superh_cpu_name_compare(gconstpointer a, gconstpointer b)
-{
-    const SuperHCPUClass *scc = SUPERH_CPU_CLASS(a);
-    const char *name = b;
-
-    return strcasecmp(scc->name, name);
-}
-
 static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
 {
-    ObjectClass *oc;
-    GSList *list, *item;
+    ObjectClass *oc = NULL;;
+    char *s, *typename = NULL;
 
-    if (strcasecmp(cpu_model, "any") == 0) {
-        return object_class_by_name(TYPE_SH7750R_CPU);
+    s = g_ascii_strdown(cpu_model, -1);
+    if (strcmp(s, "any") == 0) {
+        oc = object_class_by_name(TYPE_SH7750R_CPU);
+        goto out;
     }
 
-    oc = object_class_by_name(cpu_model);
-    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_SUPERH_CPU) != NULL
-        && !object_class_is_abstract(oc)) {
-        return oc;
+    typename = g_strdup_printf(SUPERH_CPU_TYPE_NAME("%s"), s);
+    oc = object_class_by_name(typename);
+    if (oc != NULL && object_class_is_abstract(oc)) {
+        oc = NULL;
     }
 
-    oc = NULL;
-    list = object_class_get_list(TYPE_SUPERH_CPU, false);
-    item = g_slist_find_custom(list, cpu_model, superh_cpu_name_compare);
-    if (item != NULL) {
-        oc = item->data;
-    }
-    g_slist_free(list);
+out:
+    g_free(s);
+    g_free(typename);
     return oc;
 }
 
-- 
2.7.4
