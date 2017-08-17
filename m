Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCTJ-0000ws-So
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCTI-0005Jb-SY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:53 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCTI-0005JK-NP
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:52 -0400
Received: by mail-qt0-x242.google.com with SMTP id i19so5325285qte.1
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 21:31:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 17 Aug 2017 01:31:02 -0300
Message-Id: <20170817043102.6322-9-f4bug@amsat.org>
In-Reply-To: <20170817043102.6322-1-f4bug@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/8] mips: update mips_cpu_list() to use
 object_class_get_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

while here, move it from translate_init.c to helper.c

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/helper.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++
 target/mips/translate_init.c | 10 ----------
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index ea076261af..8d12b0088a 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1093,3 +1093,49 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
 
     cpu_loop_exit_restore(cs, pc);
 }
+
+/* Sort alphabetically by type name, except for "any". */
+static gint mips_cpu_list_compare(gconstpointer a, gconstpointer b)
+{
+    ObjectClass *class_a = (ObjectClass *)a;
+    ObjectClass *class_b = (ObjectClass *)b;
+    const char *name_a, *name_b;
+
+    name_a = object_class_get_name(class_a);
+    name_b = object_class_get_name(class_b);
+    if (strcmp(name_a, "any-" TYPE_MIPS_CPU) == 0) {
+        return 1;
+    } else if (strcmp(name_b, "any-" TYPE_MIPS_CPU) == 0) {
+        return -1;
+    } else {
+        return strcmp(name_a, name_b);
+    }
+}
+
+static void mips_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    CPUListState *s = user_data;
+    const char *typename;
+    char *name;
+
+    typename = object_class_get_name(oc);
+    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_MIPS_CPU));
+    (*s->cpu_fprintf)(s->file, "  %s\n", name);
+    g_free(name);
+}
+
+void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    CPUListState s = {
+        .file = f,
+        .cpu_fprintf = cpu_fprintf,
+    };
+    GSList *list;
+
+    list = object_class_get_list(TYPE_MIPS_CPU, false);
+    list = g_slist_sort(list, mips_cpu_list_compare);
+    (*cpu_fprintf)(f, "Available CPUs:\n");
+    g_slist_foreach(list, mips_cpu_list_entry, &s);
+    g_slist_free(list);
+}
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 8bbded46c4..b75f4c9065 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -767,16 +767,6 @@ static const mips_def_t *cpu_mips_find_by_name (const char *name)
     return NULL;
 }
 
-void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(mips_defs); i++) {
-        (*cpu_fprintf)(f, "MIPS '%s'\n",
-                       mips_defs[i].name);
-    }
-}
-
 #ifndef CONFIG_USER_ONLY
 static void no_mmu_init (CPUMIPSState *env, const mips_def_t *def)
 {
-- 
2.14.1
