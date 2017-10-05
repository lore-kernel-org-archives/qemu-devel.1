Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xq-0003QL-U4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xl-0003ml-5N
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:34 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:48 +0200
Message-Id: <1507220690-265042-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 21/23] ppc: pnv: define core types statically
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
---
 hw/ppc/pnv_core.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index acdfa17..000c87e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -225,38 +225,30 @@ static void pnv_core_class_init(ObjectClass *oc, void *data)
     dc->props = pnv_core_properties;
 }
 
-static const TypeInfo pnv_core_info = {
-    .name           = TYPE_PNV_CORE,
-    .parent         = TYPE_CPU_CORE,
-    .instance_size  = sizeof(PnvCore),
-    .class_size     = sizeof(PnvCoreClass),
-    .class_init = pnv_core_class_init,
-    .abstract       = true,
-};
-
-static const char *pnv_core_models[] = {
-    "power8e_v2.1", "power8_v2.0", "power8nvl_v1.0", "power9_v1.0"
-};
-
-static void pnv_core_register_types(void)
-{
-    int i ;
-
-    type_register_static(&pnv_core_info);
-    for (i = 0; i < ARRAY_SIZE(pnv_core_models); ++i) {
-        TypeInfo ti = {
-            .parent = TYPE_PNV_CORE,
-            .instance_size = sizeof(PnvCore),
-        };
-        ti.name = pnv_core_typename(pnv_core_models[i]);
-        type_register(&ti);
-        g_free((void *)ti.name);
+#define DEFINE_PNV_CORE_TYPE(cpu_model)         \
+    {                                           \
+        .parent = TYPE_PNV_CORE,                \
+        .name = PNV_CORE_TYPE_NAME(cpu_model),  \
     }
-}
 
-type_init(pnv_core_register_types)
+static const TypeInfo pnv_core_infos[] = {
+    {
+        .name           = TYPE_PNV_CORE,
+        .parent         = TYPE_CPU_CORE,
+        .instance_size  = sizeof(PnvCore),
+        .class_size     = sizeof(PnvCoreClass),
+        .class_init = pnv_core_class_init,
+        .abstract       = true,
+    },
+    DEFINE_PNV_CORE_TYPE("power8e_v2.1"),
+    DEFINE_PNV_CORE_TYPE("power8_v2.0"),
+    DEFINE_PNV_CORE_TYPE("power8nvl_v1.0"),
+    DEFINE_PNV_CORE_TYPE("power9_v1.0"),
+};
 
 char *pnv_core_typename(const char *model)
 {
     return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
 }
+
+DEFINE_TYPES(pnv_core_infos)
-- 
2.7.4
