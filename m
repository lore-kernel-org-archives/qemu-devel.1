Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5e-0003i8-E7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5d-0006fT-Dj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:50 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:51:08 +0200
Message-Id: <1507578671-158758-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/24] ppc: pnv: drop PnvCoreClass::cpu_oc
 field
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

deduce cpu type directly from core type instead of
maintaining type mapping in PnvCoreClass::cpu_oc and doing
extra cpu_model parsing in pnv_core_class_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - fix typo: s/pvn_core_cpu_typename/pnv_core_cpu_typename/
---
 include/hw/ppc/pnv_core.h |  1 -
 hw/ppc/pnv_core.c         | 18 ++++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 3360c4b..a336a1f 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -42,7 +42,6 @@ typedef struct PnvCore {
 
 typedef struct PnvCoreClass {
     DeviceClass parent_class;
-    ObjectClass *cpu_oc;
 } PnvCoreClass;
 
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index b3e3f23..bd7f2c9 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -27,6 +27,16 @@
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/xics.h"
 
+static const char *pnv_core_cpu_typename(PnvCore *pc)
+{
+    const char *core_type = object_class_get_name(object_get_class(OBJECT(pc)));
+    int len = strlen(core_type) - strlen(PNV_CORE_TYPE_SUFFIX);
+    char *s = g_strdup_printf(POWERPC_CPU_TYPE_NAME("%.*s"), len, core_type);
+    const char *cpu_type = object_class_get_name(object_class_by_name(s));
+    g_free(s);
+    return cpu_type;
+}
+
 static void powernv_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -148,8 +158,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 {
     PnvCore *pc = PNV_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(OBJECT(dev));
-    PnvCoreClass *pcc = PNV_CORE_GET_CLASS(OBJECT(dev));
-    const char *typename = object_class_get_name(pcc->cpu_oc);
+    const char *typename = pnv_core_cpu_typename(pc);
     size_t size = object_type_get_instance_size(typename);
     Error *local_err = NULL;
     void *obj;
@@ -211,11 +220,9 @@ static Property pnv_core_properties[] = {
 static void pnv_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
 
     dc->realize = pnv_core_realize;
     dc->props = pnv_core_properties;
-    pcc->cpu_oc = cpu_class_by_name(TYPE_POWERPC_CPU, data);
 }
 
 static const TypeInfo pnv_core_info = {
@@ -223,6 +230,7 @@ static const TypeInfo pnv_core_info = {
     .parent         = TYPE_CPU_CORE,
     .instance_size  = sizeof(PnvCore),
     .class_size     = sizeof(PnvCoreClass),
+    .class_init = pnv_core_class_init,
     .abstract       = true,
 };
 
@@ -239,8 +247,6 @@ static void pnv_core_register_types(void)
         TypeInfo ti = {
             .parent = TYPE_PNV_CORE,
             .instance_size = sizeof(PnvCore),
-            .class_init = pnv_core_class_init,
-            .class_data = (void *) pnv_core_models[i],
         };
         ti.name = pnv_core_typename(pnv_core_models[i]);
         type_register(&ti);
-- 
2.7.4
