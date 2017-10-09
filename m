Received: from eggs.gnu.org ([2001:4830:134:3::10]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5c-0003fM-P4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5b-0006eZ-QE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:48 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:51:07 +0200
Message-Id: <1507578671-158758-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 20/24] ppc: pnv: normalize core/chip type
 names
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

typically for cpus/core type names following convention is used

   new_type_prefix-superclass_typename

make PNV core/chip to follow common convention.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/pnv.h      | 11 +++++++----
 include/hw/ppc/pnv_core.h |  2 ++
 hw/ppc/pnv.c              |  2 +-
 hw/ppc/pnv_core.c         |  2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 2525f7f..d82eee1 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -80,19 +80,22 @@ typedef struct PnvChipClass {
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
 } PnvChipClass;
=20
-#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-power8e_v2.1"
+#define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
+#define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
+
+#define TYPE_PNV_CHIP_POWER8E PNV_CHIP_TYPE_NAME("power8e_v2.1")
 #define PNV_CHIP_POWER8E(obj) \
     OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8E)
=20
-#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-power8_v2.0"
+#define TYPE_PNV_CHIP_POWER8 PNV_CHIP_TYPE_NAME("power8_v2.0")
 #define PNV_CHIP_POWER8(obj) \
     OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8)
=20
-#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-power8nvl_v1.0"
+#define TYPE_PNV_CHIP_POWER8NVL PNV_CHIP_TYPE_NAME("power8nvl_v1.0")
 #define PNV_CHIP_POWER8NVL(obj) \
     OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8NVL)
=20
-#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0"
+#define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v1.0")
 #define PNV_CHIP_POWER9(obj) \
     OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER9)
=20
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 2955a41..3360c4b 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -45,6 +45,8 @@ typedef struct PnvCoreClass {
     ObjectClass *cpu_oc;
 } PnvCoreClass;
=20
+#define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
+#define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
 extern char *pnv_core_typename(const char *model);
=20
 #endif /* _PPC_PNV_CORE_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 707f38c..3eafa28 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -608,7 +608,7 @@ static void ppc_powernv_init(MachineState *machine)
=20
     /* Create the processor chips */
     i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
-    chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%.*s",
+    chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
                                     i, machine->cpu_type);
     if (!object_class_by_name(chip_typename)) {
         error_report("invalid CPU model '%.*s' for %s machine",
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 44b0b24..b3e3f23 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -252,5 +252,5 @@ type_init(pnv_core_register_types)
=20
 char *pnv_core_typename(const char *model)
 {
-    return g_strdup_printf(TYPE_PNV_CORE "-%s", model);
+    return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
 }
--=20
2.7.4
