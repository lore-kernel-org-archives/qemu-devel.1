Received: from eggs.gnu.org ([2001:4830:134:3::10]:54273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvV-0001jM-9f
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvT-00037u-MZ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvT-000372-7a
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:16 -0300
Message-Id: <20180625222524.382-5-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/12] i386: display known CPUID features
 linewrapped, in alphabetical order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

When using '-cpu help' the list of CPUID features is grouped according
to the internal low level CPUID grouping. The data printed results in
very long lines too.

This combines to make it hard for users to read the output and identify
if QEMU knows about the feature they wish to use.

This change gets rid of the grouping of features and treats all flags as
single list. The list is sorted into alphabetical order and the printing
with line wrapping at the 77th column.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180606165527.17365-4-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19ac1e6569..9da4920421 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3331,17 +3331,21 @@ static void x86_cpu_class_check_missing_features(=
X86CPUClass *xcc,
=20
 /* Print all cpuid feature names in featureset
  */
-static void listflags(FILE *f, fprintf_function print, const char **feat=
ureset)
+static void listflags(FILE *f, fprintf_function print, GList *features)
 {
-    int bit;
-    bool first =3D true;
-
-    for (bit =3D 0; bit < 32; bit++) {
-        if (featureset[bit]) {
-            print(f, "%s%s", first ? "" : " ", featureset[bit]);
-            first =3D false;
+    size_t len =3D 0;
+    GList *tmp;
+
+    for (tmp =3D features; tmp; tmp =3D tmp->next) {
+        const char *name =3D tmp->data;
+        if ((len + strlen(name) + 1) >=3D 75) {
+            print(f, "\n");
+            len =3D 0;
         }
+        print(f, "%s%s", len =3D=3D 0 ? "  " : " ", name);
+        len +=3D strlen(name) + 1;
     }
+    print(f, "\n");
 }
=20
 /* Sort alphabetically by type name, respecting X86CPUClass::ordering. *=
/
@@ -3392,26 +3396,35 @@ static void x86_cpu_list_entry(gpointer data, gpo=
inter user_data)
 /* list available CPU models and flags */
 void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
-    int i;
+    int i, j;
     CPUListState s =3D {
         .file =3D f,
         .cpu_fprintf =3D cpu_fprintf,
     };
     GSList *list;
+    GList *names =3D NULL;
=20
     (*cpu_fprintf)(f, "Available CPUs:\n");
     list =3D get_sorted_cpu_model_list();
     g_slist_foreach(list, x86_cpu_list_entry, &s);
     g_slist_free(list);
=20
-    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
+    names =3D NULL;
     for (i =3D 0; i < ARRAY_SIZE(feature_word_info); i++) {
         FeatureWordInfo *fw =3D &feature_word_info[i];
-
-        (*cpu_fprintf)(f, "  ");
-        listflags(f, cpu_fprintf, fw->feat_names);
-        (*cpu_fprintf)(f, "\n");
+        for (j =3D 0; j < 32; j++) {
+            if (fw->feat_names[j]) {
+                names =3D g_list_append(names, (gpointer)fw->feat_names[=
j]);
+            }
+        }
     }
+
+    names =3D g_list_sort(names, (GCompareFunc)strcmp);
+
+    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
+    listflags(f, cpu_fprintf, names);
+    (*cpu_fprintf)(f, "\n");
+    g_list_free(names);
 }
=20
 static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
--=20
2.18.0.rc1.1.g3f1ff2140
