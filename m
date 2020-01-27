Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFD0206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFD0206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5eG-0008P3-KB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iw5ay-0003Pm-Jy
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iw5aw-0003Bu-RV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:42:32 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:49618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iw5av-0003Ah-EP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:42:29 -0500
Received: from player159.ha.ovh.net (unknown [10.110.171.250])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 81EF11C1124
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 15:42:26 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 3724EEA8C619;
 Mon, 27 Jan 2020 14:42:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/3] ppc/pnv: Add support for "hostboot" mode
Date: Mon, 27 Jan 2020 15:41:54 +0100
Message-Id: <20200127144154.10170-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200127144154.10170-1-clg@kaod.org>
References: <20200127144154.10170-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17785277882416532454
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.182
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the "hb-mode" option is activated on the powernv machine, the
firmware is mapped at 0x8000000 and the HRMOR of the HW threads are
set to the same address.

The PNOR mapping on the FW address space of the LPC bus is left enabled
to let the firmware load any other images required to boot the host.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h      |  2 ++
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 28 +++++++++++++++++++++++++++-
 hw/ppc/pnv_core.c         |  3 +++
 hw/ppc/pnv_lpc.c          |  5 ++++-
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index d65dd32036c8..f225f2f6bf67 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -217,6 +217,8 @@ struct PnvMachineState {
     Notifier     powerdown_notifier;
=20
     PnvPnor      *pnor;
+
+    hwaddr       fw_load_addr;
 };
=20
 #define PNV_FDT_ADDR          0x01000000
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 55eee95104da..113550eb7ffb 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -40,6 +40,7 @@ typedef struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
+    uint64_t hrmor;
     PnvChip *chip;
=20
     MemoryRegion xscom_regs;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e2735bb8ddb4..7ad89975ac0e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -716,7 +716,7 @@ static void pnv_init(MachineState *machine)
         exit(1);
     }
=20
-    fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
+    fw_size =3D load_image_targphys(fw_filename, pnv->fw_load_addr, FW_M=
AX_SIZE);
     if (fw_size < 0) {
         error_report("Could not load OPAL firmware '%s'", fw_filename);
         exit(1);
@@ -1533,6 +1533,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
     const char *typename =3D pnv_chip_core_typename(chip);
     int i, core_hwid;
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
=20
     if (!object_class_by_name(typename)) {
         error_setg(errp, "Unable to find PowerNV CPU Core '%s'", typenam=
e);
@@ -1571,6 +1572,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
         object_property_set_int(OBJECT(pnv_core),
                                 pcc->core_pir(chip, core_hwid),
                                 "pir", &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), pnv->fw_load_addr,
+                                "hrmor", &error_fatal);
         object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
                                  &error_abort);
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
@@ -1767,6 +1770,22 @@ static void pnv_machine_power10_class_init(ObjectC=
lass *oc, void *data)
     pmc->dt_power_mgt =3D pnv_dt_power_mgt;
 }
=20
+static bool pnv_machine_get_hb(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(obj);
+
+    return !!pnv->fw_load_addr;
+}
+
+static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(obj);
+
+    if (value) {
+        pnv->fw_load_addr =3D 0x8000000;
+    }
+}
+
 static void pnv_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -1786,6 +1805,13 @@ static void pnv_machine_class_init(ObjectClass *oc=
, void *data)
      */
     mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
     ispc->print_info =3D pnv_pic_print_info;
+
+    object_class_property_add_bool(oc, "hb-mode",
+                                   pnv_machine_get_hb, pnv_machine_set_h=
b,
+                                   &error_abort);
+    object_class_property_set_description(oc, "hb-mode",
+                              "Use a hostboot like boot loader",
+                              NULL);
 }
=20
 #define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index e69763c7f501..c7be06e42fb6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -56,6 +56,8 @@ static void pnv_core_cpu_reset(PnvCore *pc, PowerPCCPU =
*cpu)
     env->nip =3D 0x10;
     env->msr |=3D MSR_HVB; /* Hypervisor mode */
=20
+    env->spr[SPR_HRMOR] =3D pc->hrmor;
+
     pcc->intc_reset(pc->chip, cpu);
 }
=20
@@ -289,6 +291,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
=20
 static Property pnv_core_properties[] =3D {
     DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
+    DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 18256d9ba399..ced7d65deae3 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -825,6 +825,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, boo=
l use_cpld, Error **errp)
     qemu_irq *irqs;
     qemu_irq_handler handler;
     PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    bool hostboot_mode =3D !!pnv->fw_load_addr;
=20
     /* let isa_bus_new() create its own bridge on SysBus otherwise
      * devices speficied on the command line won't find the bus and
@@ -859,7 +860,9 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, boo=
l use_cpld, Error **errp)
      * Start disabled. The HIOMAP protocol will activate the mapping
      * with HIOMAP_C_CREATE_WRITE_WINDOW
      */
-    memory_region_set_enabled(&pnv->pnor->mmio, false);
+    if (!hostboot_mode) {
+        memory_region_set_enabled(&pnv->pnor->mmio, false);
+    }
=20
     return isa_bus;
 }
--=20
2.21.1


