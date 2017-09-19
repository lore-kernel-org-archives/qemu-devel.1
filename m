Received: from eggs.gnu.org ([2001:4830:134:3::10]:39968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLee-0007D1-95
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLeb-0003ss-Eu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLea-0003rn-Vb
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:24 +0200
Message-Id: <20170919164337.18555-26-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 25/38] s390x: print CPU definitions in sorted
 order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Other architectures provide nicely sorted lists, let's do it similarly on
s390x.

While at it, clean up the code we have to touch either way.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-16-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 56 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8e20e7637b..c295e641e6 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -270,16 +270,11 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
     return last_compatible;
 }
 
-struct S390PrintCpuListInfo {
-    FILE *f;
-    fprintf_function print;
-};
-
-static void print_cpu_model_list(ObjectClass *klass, void *opaque)
+static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
 {
-    struct S390PrintCpuListInfo *info = opaque;
-    S390CPUClass *scc = S390_CPU_CLASS(klass);
-    char *name = g_strdup(object_class_get_name(klass));
+    CPUListState *s = user_data;
+    const S390CPUClass *scc = S390_CPU_CLASS((ObjectClass *)data);
+    char *name = g_strdup(object_class_get_name((ObjectClass *)data));
     const char *details = "";
 
     if (scc->is_static) {
@@ -290,21 +285,52 @@ static void print_cpu_model_list(ObjectClass *klass, void *opaque)
 
     /* strip off the -s390-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
-    (*info->print)(info->f, "s390 %-15s %-35s %s\n", name, scc->desc,
-                   details);
+    (*s->cpu_fprintf)(s->file, "s390 %-15s %-35s %s\n", name, scc->desc,
+                      details);
     g_free(name);
 }
 
+static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
+{
+    const S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *)a);
+    const S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *)b);
+    const char *name_a = object_class_get_name((ObjectClass *)a);
+    const char *name_b = object_class_get_name((ObjectClass *)b);
+
+    /* move qemu and host to the top of the list, qemu first, host second */
+    if (name_a[0] == 'q') {
+        return -1;
+    } else if (name_b[0] == 'q') {
+        return 1;
+    } else if (name_a[0] == 'h') {
+        return -1;
+    } else if (name_b[0] == 'h') {
+        return 1;
+    }
+
+    /* keep the same order we have in our table (sorted by release date) */
+    if (cc_a->cpu_def != cc_b->cpu_def) {
+        return cc_a->cpu_def - cc_b->cpu_def;
+    }
+
+    /* exact same definition - list base model first */
+    return cc_a->is_static ? -1 : 1;
+}
+
 void s390_cpu_list(FILE *f, fprintf_function print)
 {
-    struct S390PrintCpuListInfo info = {
-        .f = f,
-        .print = print,
+    CPUListState s = {
+        .file = f,
+        .cpu_fprintf = print,
     };
     S390FeatGroup group;
     S390Feat feat;
+    GSList *list;
 
-    object_class_foreach(print_cpu_model_list, TYPE_S390_CPU, false, &info);
+    list = object_class_get_list(TYPE_S390_CPU, false);
+    list = g_slist_sort(list, s390_cpu_list_compare);
+    g_slist_foreach(list, s390_print_cpu_model_list_entry, &s);
+    g_slist_free(list);
 
     (*print)(f, "\nRecognized feature flags:\n");
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
-- 
2.13.5
