Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOb-0008Q5-Fm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-000787-5O
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:42 +1100
Message-Id: <20171017042152.29443-25-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/34] ppc: move ppc_cpu_lookup_alias() before
 its first user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

next commit will drop ppc_cpu_lookup_alias() declaration from header
and make it static which will break its last user ppc_cpu_class_by_name()
since ppc_cpu_class_by_name() defined before ppc_cpu_lookup_alias().

To avoid this move ppc_cpu_lookup_alias() right before
ppc_cpu_class_by_name().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 3d16481ca1..17ac95b732 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10060,6 +10060,19 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint3=
2_t pvr)
     return pcc;
 }
=20
+const char *ppc_cpu_lookup_alias(const char *alias)
+{
+    int ai;
+
+    for (ai =3D 0; ppc_cpu_aliases[ai].alias !=3D NULL; ai++) {
+        if (strcmp(ppc_cpu_aliases[ai].alias, alias) =3D=3D 0) {
+            return ppc_cpu_aliases[ai].model;
+        }
+    }
+
+    return NULL;
+}
+
 static ObjectClass *ppc_cpu_class_by_name(const char *name)
 {
     char *cpu_model, *typename;
@@ -10152,19 +10165,6 @@ static void ppc_cpu_parse_featurestr(const char =
*type, char *features,
     pcc->parent_parse_features(type, features, errp);
 }
=20
-const char *ppc_cpu_lookup_alias(const char *alias)
-{
-    int ai;
-
-    for (ai =3D 0; ppc_cpu_aliases[ai].alias !=3D NULL; ai++) {
-        if (strcmp(ppc_cpu_aliases[ai].alias, alias) =3D=3D 0) {
-            return ppc_cpu_aliases[ai].model;
-        }
-    }
-
-    return NULL;
-}
-
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 {
     ObjectClass *oc =3D OBJECT_CLASS(pcc);
--=20
2.13.6
