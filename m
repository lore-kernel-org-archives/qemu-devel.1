Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywil-0002Tn-TX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywik-0006IE-Ch
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywik-0006Hk-4I
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:09:02 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:13 +0200
Message-Id: <1506935300-132598-32-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 31/38] sparc: sparc: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: mark.cave-ayland@ilande.co.uk
CC: atar4qemu@gmail.com
---
 hw/sparc/sun4m.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index e1bdd48..68b2378 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -94,7 +94,6 @@ struct sun4m_hwdef {
     } vsimm[MAX_VSIMMS];
     hwaddr ecc_base;
     uint64_t max_mem;
-    const char * const default_cpu_model;
     uint32_t ecc_version;
     uint32_t iommu_version;
     uint16_t machine_id;
@@ -790,14 +789,14 @@ static const TypeInfo ram_info = {
     .class_init    = ram_class_init,
 };
 
-static void cpu_devinit(const char *cpu_model, unsigned int id,
+static void cpu_devinit(const char *cpu_type, unsigned int id,
                         uint64_t prom_addr, qemu_irq **cpu_irqs)
 {
     CPUState *cs;
     SPARCCPU *cpu;
     CPUSPARCState *env;
 
-    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
+    cpu = SPARC_CPU(cpu_create(cpu_type));
     env = &cpu->env;
 
     cpu_sparc_set_id(env, id);
@@ -820,7 +819,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                           MachineState *machine)
 {
     DeviceState *slavio_intctl;
-    const char *cpu_model = machine->cpu_model;
     unsigned int i;
     void *iommu, *espdma, *ledma, *nvram;
     qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS],
@@ -833,11 +831,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     unsigned int num_vsimms;
 
     /* init CPUs */
-    if (!cpu_model)
-        cpu_model = hwdef->default_cpu_model;
-
     for(i = 0; i < smp_cpus; i++) {
-        cpu_devinit(cpu_model, i, hwdef->slavio_base, &cpu_irqs[i]);
+        cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
     }
 
     for (i = smp_cpus; i < MAX_CPUS; i++)
@@ -1074,7 +1069,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = ss5_id,
         .iommu_version = 0x05000000,
         .max_mem = 0x10000000,
-        .default_cpu_model = "Fujitsu MB86904",
     },
     /* SS-10 */
     {
@@ -1100,7 +1094,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = ss10_id,
         .iommu_version = 0x03000000,
         .max_mem = 0xf00000000ULL,
-        .default_cpu_model = "TI SuperSparc II",
     },
     /* SS-600MP */
     {
@@ -1124,7 +1117,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = ss600mp_id,
         .iommu_version = 0x01000000,
         .max_mem = 0xf00000000ULL,
-        .default_cpu_model = "TI SuperSparc II",
     },
     /* SS-20 */
     {
@@ -1166,7 +1158,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = ss20_id,
         .iommu_version = 0x13000000,
         .max_mem = 0xf00000000ULL,
-        .default_cpu_model = "TI SuperSparc II",
     },
     /* Voyager */
     {
@@ -1190,7 +1181,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = vger_id,
         .iommu_version = 0x05000000,
         .max_mem = 0x10000000,
-        .default_cpu_model = "Fujitsu MB86904",
     },
     /* LX */
     {
@@ -1215,7 +1205,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = lx_id,
         .iommu_version = 0x04000000,
         .max_mem = 0x10000000,
-        .default_cpu_model = "TI MicroSparc I",
     },
     /* SS-4 */
     {
@@ -1240,7 +1229,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = ss4_id,
         .iommu_version = 0x05000000,
         .max_mem = 0x10000000,
-        .default_cpu_model = "Fujitsu MB86904",
     },
     /* SPARCClassic */
     {
@@ -1264,7 +1252,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = scls_id,
         .iommu_version = 0x05000000,
         .max_mem = 0x10000000,
-        .default_cpu_model = "TI MicroSparc I",
     },
     /* SPARCbook */
     {
@@ -1288,7 +1275,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] = {
         .machine_id = sbook_id,
         .iommu_version = 0x05000000,
         .max_mem = 0x10000000,
-        .default_cpu_model = "TI MicroSparc I",
     },
 };
 
@@ -1355,6 +1341,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->is_default = 1;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
 }
 
 static const TypeInfo ss5_type = {
@@ -1372,6 +1359,7 @@ static void ss10_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 4;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
 }
 
 static const TypeInfo ss10_type = {
@@ -1389,6 +1377,7 @@ static void ss600mp_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 4;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
 }
 
 static const TypeInfo ss600mp_type = {
@@ -1406,6 +1395,7 @@ static void ss20_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = 4;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
 }
 
 static const TypeInfo ss20_type = {
@@ -1422,6 +1412,7 @@ static void voyager_class_init(ObjectClass *oc, void *data)
     mc->init = vger_init;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
 }
 
 static const TypeInfo voyager_type = {
@@ -1438,6 +1429,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *data)
     mc->init = ss_lx_init;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
 }
 
 static const TypeInfo ss_lx_type = {
@@ -1454,6 +1446,7 @@ static void ss4_class_init(ObjectClass *oc, void *data)
     mc->init = ss4_init;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
 }
 
 static const TypeInfo ss4_type = {
@@ -1470,6 +1463,7 @@ static void scls_class_init(ObjectClass *oc, void *data)
     mc->init = scls_init;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
 }
 
 static const TypeInfo scls_type = {
@@ -1486,6 +1480,7 @@ static void sbook_class_init(ObjectClass *oc, void *data)
     mc->init = sbook_init;
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
+    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
 }
 
 static const TypeInfo sbook_type = {
-- 
2.7.4
