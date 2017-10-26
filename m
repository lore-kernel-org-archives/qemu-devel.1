Received: from eggs.gnu.org ([2001:4830:134:3::10]:44283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7in3-0004av-D4
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7in2-0008Hr-F1
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7in2-0008Gm-6Y
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:05:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:03:44 +0200
Message-Id: <20171026140404.21948-20-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/39] sh4: simplify superh_cpu_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

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
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-23-git-send-email-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/sh4/cpu.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ec6db61bdf..972c809d8c 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -120,36 +120,26 @@ void sh4_cpu_list(FILE *f, fprintf_function cpu_fpr=
intf)
     g_slist_free(list);
 }
=20
-static gint superh_cpu_name_compare(gconstpointer a, gconstpointer b)
-{
-    const SuperHCPUClass *scc =3D SUPERH_CPU_CLASS(a);
-    const char *name =3D b;
-
-    return strcasecmp(scc->name, name);
-}
-
 static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-    GSList *list, *item;
+    char *s, *typename =3D NULL;
=20
-    if (strcasecmp(cpu_model, "any") =3D=3D 0) {
-        return object_class_by_name(TYPE_SH7750R_CPU);
+    s =3D g_ascii_strdown(cpu_model, -1);
+    if (strcmp(s, "any") =3D=3D 0) {
+        oc =3D object_class_by_name(TYPE_SH7750R_CPU);
+        goto out;
     }
=20
-    oc =3D object_class_by_name(cpu_model);
-    if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_SUPERH_CPU) !=
=3D NULL
-        && !object_class_is_abstract(oc)) {
-        return oc;
+    typename =3D g_strdup_printf(SUPERH_CPU_TYPE_NAME("%s"), s);
+    oc =3D object_class_by_name(typename);
+    if (oc !=3D NULL && object_class_is_abstract(oc)) {
+        oc =3D NULL;
     }
=20
-    oc =3D NULL;
-    list =3D object_class_get_list(TYPE_SUPERH_CPU, false);
-    item =3D g_slist_find_custom(list, cpu_model, superh_cpu_name_compar=
e);
-    if (item !=3D NULL) {
-        oc =3D item->data;
-    }
-    g_slist_free(list);
+out:
+    g_free(s);
+    g_free(typename);
     return oc;
 }
=20
--=20
2.13.6
