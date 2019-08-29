Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C10822CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 06:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SBk827bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C10822CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Dds-0006CC-Ou
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 02:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbw-0004CL-SS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i3Dbu-0003aU-GO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 02:08:44 -0400
Received: from ozlabs.org ([203.11.71.1]:50239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i3Dbt-0003XB-BG; Thu, 29 Aug 2019 02:08:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46JscM4Ypkz9sML; Thu, 29 Aug 2019 16:08:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567058915;
 bh=+KMIIrEMKWLk7Qipnryp56epqxFq27CVZFDEi2PW4dY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SBk827bSYz3hgpyVqpaVbicswY1iia7b9p0wv2ah8f52Ib5/8gbOpJ9BQgqWubO5F
 MaCxBtu8IIOR++dGXeom0k8mUruX3BHOXfL5F9q8OWS8BpABU04TZZetLMoESyFsnk
 ENAU+N9X3lW+enN7MWSP5qLCG/2zh5HDlvfbQAYQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Thu, 29 Aug 2019 16:08:13 +1000
Message-Id: <20190829060827.25731-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829060827.25731-1-david@gibson.dropbear.id.au>
References: <20190829060827.25731-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 05/19] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Make the current "powernv" machine an abstract type and derive from it
new machines with specific CPU models: power8 and power9.

The "powernv" machine is now an alias on the "powernv9" machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190731141233.1340-2-clg@kaod.org>
[dwg: Adjust pnv-xscom-test to cope with this change]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c           | 70 +++++++++++++++++++++++++++++++++++++-----
 tests/pnv-xscom-test.c | 16 ++++++++--
 2 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2077452d6f..3f08db7b9e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -605,9 +605,20 @@ static void pnv_chip_power9_pic_print_info(PnvChip *=
chip, Monitor *mon)
     pnv_psi_pic_print_info(&chip9->psi, mon);
 }
=20
+static bool pnv_match_cpu(const char *default_type, const char *cpu_type=
)
+{
+    PowerPCCPUClass *ppc_default =3D
+        POWERPC_CPU_CLASS(object_class_by_name(default_type));
+    PowerPCCPUClass *ppc =3D
+        POWERPC_CPU_CLASS(object_class_by_name(cpu_type));
+
+    return ppc_default->pvr_match(ppc_default, ppc->pvr);
+}
+
 static void pnv_init(MachineState *machine)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(machine);
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
@@ -667,13 +678,23 @@ static void pnv_init(MachineState *machine)
         }
     }
=20
+    /*
+     * Check compatibility of the specified CPU with the machine
+     * default.
+     */
+    if (!pnv_match_cpu(mc->default_cpu_type, machine->cpu_type)) {
+        error_report("invalid CPU model '%s' for %s machine",
+                     machine->cpu_type, mc->name);
+        exit(1);
+    }
+
     /* Create the processor chips */
     i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
     chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
                                     i, machine->cpu_type);
     if (!object_class_by_name(chip_typename)) {
-        error_report("invalid CPU model '%.*s' for %s machine",
-                     i, machine->cpu_type, MACHINE_GET_CLASS(machine)->n=
ame);
+        error_report("invalid chip model '%.*s' for %s machine",
+                     i, machine->cpu_type, mc->name);
         exit(1);
     }
=20
@@ -1351,17 +1372,38 @@ static void pnv_machine_class_props_init(ObjectCl=
ass *oc)
                               NULL);
 }
=20
-static void pnv_machine_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+
+    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8";
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
+
+    xic->icp_get =3D pnv_icp_get;
+    xic->ics_get =3D pnv_ics_get;
+    xic->ics_resend =3D pnv_ics_resend;
+}
+
+static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
+
+    mc->alias =3D "powernv";
+}
+
+static void pnv_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
     InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D pnv_init;
     mc->reset =3D pnv_reset;
     mc->max_cpus =3D MAX_CPUS;
-    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
                                       * storage */
     mc->no_parallel =3D 1;
@@ -1371,9 +1413,6 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
      * enough to fit the maximum initrd size at it's load address
      */
     mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
-    xic->icp_get =3D pnv_icp_get;
-    xic->ics_get =3D pnv_ics_get;
-    xic->ics_resend =3D pnv_ics_resend;
     ispc->print_info =3D pnv_pic_print_info;
=20
     pnv_machine_class_props_init(oc);
@@ -1393,10 +1432,27 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
         .parent        =3D TYPE_PNV9_CHIP,          \
     }
=20
+#define DEFINE_PNV_MACHINE_TYPE(cpu, class_initfn)      \
+    {                                                   \
+        .name          =3D MACHINE_TYPE_NAME(cpu),        \
+        .parent        =3D TYPE_PNV_MACHINE,              \
+        .instance_size =3D sizeof(PnvMachineState),       \
+        .instance_init =3D pnv_machine_instance_init,     \
+        .class_init    =3D class_initfn,                  \
+        .interfaces =3D (InterfaceInfo[]) {               \
+            { TYPE_XICS_FABRIC },                       \
+            { TYPE_INTERRUPT_STATS_PROVIDER },          \
+            { },                                        \
+        },                                              \
+    }
+
 static const TypeInfo types[] =3D {
+    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init),
+    DEFINE_PNV_MACHINE_TYPE("powernv9", pnv_machine_power9_class_init),
     {
         .name          =3D TYPE_PNV_MACHINE,
         .parent        =3D TYPE_MACHINE,
+        .abstract       =3D true,
         .instance_size =3D sizeof(PnvMachineState),
         .instance_init =3D pnv_machine_instance_init,
         .class_init    =3D pnv_machine_class_init,
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 63d464048d..9fddc7d5f9 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -77,9 +77,15 @@ static void test_xscom_cfam_id(QTestState *qts, const =
PnvChip *chip)
 static void test_cfam_id(const void *data)
 {
     const PnvChip *chip =3D data;
+    const char *machine =3D "powernv8";
     QTestState *qts;
=20
-    qts =3D qtest_initf("-M powernv,accel=3Dtcg -cpu %s", chip->cpu_mode=
l);
+    if (chip->chip_type =3D=3D PNV_CHIP_POWER9) {
+        machine =3D "powernv9";
+    }
+
+    qts =3D qtest_initf("-M %s,accel=3Dtcg -cpu %s",
+                      machine, chip->cpu_model);
     test_xscom_cfam_id(qts, chip);
     qtest_quit(qts);
 }
@@ -113,8 +119,14 @@ static void test_core(const void *data)
 {
     const PnvChip *chip =3D data;
     QTestState *qts;
+    const char *machine =3D "powernv8";
+
+    if (chip->chip_type =3D=3D PNV_CHIP_POWER9) {
+        machine =3D "powernv9";
+    }
=20
-    qts =3D qtest_initf("-M powernv,accel=3Dtcg -cpu %s", chip->cpu_mode=
l);
+    qts =3D qtest_initf("-M %s,accel=3Dtcg -cpu %s",
+                      machine, chip->cpu_model);
     test_xscom_core(qts, chip);
     qtest_quit(qts);
 }
--=20
2.21.0


