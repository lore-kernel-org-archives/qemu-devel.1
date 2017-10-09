Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5j-0003nV-67
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5f-0006gl-2Q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:55 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:51:09 +0200
Message-Id: <1507578671-158758-23-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 22/24] ppc: pnv: define core types statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

pnv core type definition doesn't have any fields that
require it to be defined at runtime. So replace code
that fills in TypeInfo at runtime with static TypeInfo
array that does the same at complie time.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index bd7f2c9..438dbd1 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -225,38 +225,30 @@ static void pnv_core_class_init(ObjectClass *oc, vo=
id *data)
     dc->props =3D pnv_core_properties;
 }
=20
-static const TypeInfo pnv_core_info =3D {
-    .name           =3D TYPE_PNV_CORE,
-    .parent         =3D TYPE_CPU_CORE,
-    .instance_size  =3D sizeof(PnvCore),
-    .class_size     =3D sizeof(PnvCoreClass),
-    .class_init =3D pnv_core_class_init,
-    .abstract       =3D true,
-};
-
-static const char *pnv_core_models[] =3D {
-    "power8e_v2.1", "power8_v2.0", "power8nvl_v1.0", "power9_v1.0"
-};
-
-static void pnv_core_register_types(void)
-{
-    int i ;
-
-    type_register_static(&pnv_core_info);
-    for (i =3D 0; i < ARRAY_SIZE(pnv_core_models); ++i) {
-        TypeInfo ti =3D {
-            .parent =3D TYPE_PNV_CORE,
-            .instance_size =3D sizeof(PnvCore),
-        };
-        ti.name =3D pnv_core_typename(pnv_core_models[i]);
-        type_register(&ti);
-        g_free((void *)ti.name);
+#define DEFINE_PNV_CORE_TYPE(cpu_model)         \
+    {                                           \
+        .parent =3D TYPE_PNV_CORE,                \
+        .name =3D PNV_CORE_TYPE_NAME(cpu_model),  \
     }
-}
=20
-type_init(pnv_core_register_types)
+static const TypeInfo pnv_core_infos[] =3D {
+    {
+        .name           =3D TYPE_PNV_CORE,
+        .parent         =3D TYPE_CPU_CORE,
+        .instance_size  =3D sizeof(PnvCore),
+        .class_size     =3D sizeof(PnvCoreClass),
+        .class_init =3D pnv_core_class_init,
+        .abstract       =3D true,
+    },
+    DEFINE_PNV_CORE_TYPE("power8e_v2.1"),
+    DEFINE_PNV_CORE_TYPE("power8_v2.0"),
+    DEFINE_PNV_CORE_TYPE("power8nvl_v1.0"),
+    DEFINE_PNV_CORE_TYPE("power9_v1.0"),
+};
=20
 char *pnv_core_typename(const char *model)
 {
     return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
 }
+
+DEFINE_TYPES(pnv_core_infos)
--=20
2.7.4
