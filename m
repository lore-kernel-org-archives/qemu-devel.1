Received: from eggs.gnu.org ([2001:4830:134:3::10]:39186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQbig-0004by-BE
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQbif-0003yg-2Q
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQbie-0003xU-Ru
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:55:33 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  6 Jun 2018 17:55:27 +0100
Message-Id: <20180606165527.17365-4-berrange@redhat.com>
In-Reply-To: <20180606165527.17365-1-berrange@redhat.com>
References: <20180606165527.17365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] i386: display known CPUID features
 linewrapped, in alphabetical order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When using '-cpu help' the list of CPUID features is grouped according
to the internal low level CPUID grouping. The data printed results in
very long lines too.

This combines to make it hard for users to read the output and identify
if QEMU knows about the feature they wish to use.

This change gets rid of the grouping of features and treats all flags as
single list. The list is sorted into alphabetical order and the printing
with line wrapping at the 77th column.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 target/i386/cpu.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cb074082b3..8043e41be8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3157,17 +3157,21 @@ static void x86_cpu_class_check_missing_features(=
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
@@ -3218,26 +3222,35 @@ static void x86_cpu_list_entry(gpointer data, gpo=
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
2.17.0
