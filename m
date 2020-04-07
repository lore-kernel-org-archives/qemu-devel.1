Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA06C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B0720748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JqSMEe7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B0720748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLg4Z-0000RV-Mv
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyN-0007zt-Gb
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyL-0004Du-TQ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37507 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyL-0004BN-Hu; Tue, 07 Apr 2020 00:36:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K5dzbz9sT2; Tue,  7 Apr 2020 14:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=pW1uxdAur4xOwVTiGuVMZXeX7VCLpHTwUVMf33z0AzA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JqSMEe7UPjn7O1J51+bcO3vTFLp6MWObGzgMvq4Bafnsj/BxjK+P7SF7RUedv17O7
 A1ApqorpBUrwzMntF+jpXfhQXAEvO48ioBDLaTvX2O19rd74/OBTjzh06ODZ5Ye5Wr
 0kDkb8hum70kJfEyfe8EX8bgA4wpYD7hw2UhAml4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/10] ppc/pnv: Create BMC devices only when defaults are
 enabled
Date: Tue,  7 Apr 2020 14:36:06 +1000
Message-Id: <20200407043606.291546-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, Nathan Chancellor <natechancellor@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
introduced default BMC devices which can be a problem when the same
devices are defined on the command line with :

  -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10

QEMU fails with :

  qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS

Use defaults_enabled() when creating the default BMC devices to let
the user provide its own BMC devices using '-nodefaults'. If no BMC
device are provided, output a warning but let QEMU run as this is a
supported configuration. However, when multiple BMC devices are
defined, stop QEMU with a clear error as the results are unexpected.

Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200404153655.166834-1-clg@kaod.org>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 32 ++++++++++++++++++++++++++-----
 hw/ppc/pnv_bmc.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h |  2 ++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b75ad06390..c9cb6fa357 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -571,10 +571,29 @@ static void pnv_powerdown_notify(Notifier *n, void =
*opaque)
=20
 static void pnv_reset(MachineState *machine)
 {
+    PnvMachineState *pnv =3D PNV_MACHINE(machine);
+    IPMIBmc *bmc;
     void *fdt;
=20
     qemu_devices_reset();
=20
+    /*
+     * The machine should provide by default an internal BMC simulator.
+     * If not, try to use the BMC device that was provided on the comman=
d
+     * line.
+     */
+    bmc =3D pnv_bmc_find(&error_fatal);
+    if (!pnv->bmc) {
+        if (!bmc) {
+            warn_report("machine has no BMC device. Use '-device "
+                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3D=
bmc0,irq=3D10' "
+                        "to define one");
+        } else {
+            pnv_bmc_set_pnor(bmc, pnv->pnor);
+            pnv->bmc =3D bmc;
+        }
+    }
+
     fdt =3D pnv_dt_create(machine);
=20
     /* Pack resulting tree */
@@ -833,9 +852,6 @@ static void pnv_init(MachineState *machine)
     }
     g_free(chip_typename);
=20
-    /* Create the machine BMC simulator */
-    pnv->bmc =3D pnv_bmc_create(pnv->pnor);
-
     /* Instantiate ISA bus on chip 0 */
     pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
=20
@@ -845,8 +861,14 @@ static void pnv_init(MachineState *machine)
     /* Create an RTC ISA device too */
     mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
=20
-    /* Create the IPMI BT device for communication with the BMC */
-    pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
+    /*
+     * Create the machine BMC simulator and the IPMI BT device for
+     * communication with the BMC
+     */
+    if (defaults_enabled()) {
+        pnv->bmc =3D pnv_bmc_create(pnv->pnor);
+        pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
+    }
=20
     /*
      * OpenPOWER systems use a IPMI SEL Event message to notify the
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 8863354c1c..4e018b8b70 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -213,6 +213,18 @@ static const IPMINetfn hiomap_netfn =3D {
     .cmd_handlers =3D hiomap_cmds
 };
=20
+
+void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
+{
+    object_ref(OBJECT(pnor));
+    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor),
+                                   &error_abort);
+
+    /* Install the HIOMAP protocol handlers to access the PNOR */
+    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc), IPMI_NETFN_OEM,
+                            &hiomap_netfn);
+}
+
 /*
  * Instantiate the machine BMC. PowerNV uses the QEMU internal
  * simulator but it could also be external.
@@ -232,3 +244,36 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
=20
     return IPMI_BMC(obj);
 }
+
+typedef struct ForeachArgs {
+    const char *name;
+    Object *obj;
+} ForeachArgs;
+
+static int bmc_find(Object *child, void *opaque)
+{
+    ForeachArgs *args =3D opaque;
+
+    if (object_dynamic_cast(child, args->name)) {
+        if (args->obj) {
+            return 1;
+        }
+        args->obj =3D child;
+    }
+    return 0;
+}
+
+IPMIBmc *pnv_bmc_find(Error **errp)
+{
+    ForeachArgs args =3D { TYPE_IPMI_BMC_SIMULATOR, NULL };
+    int ret;
+
+    ret =3D object_child_foreach_recursive(object_get_root(), bmc_find, =
&args);
+    if (ret) {
+        error_setg(errp, "machine should have only one BMC device. "
+                   "Use '-nodefaults'");
+        return NULL;
+    }
+
+    return args.obj ? IPMI_BMC(args.obj) : NULL;
+}
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fb4d0c0234..d4b0b0e2ff 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -241,6 +241,8 @@ struct PnvMachineState {
 void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
 void pnv_bmc_powerdown(IPMIBmc *bmc);
 IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
+IPMIBmc *pnv_bmc_find(Error **errp);
+void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
=20
 /*
  * POWER8 MMIO base addresses
--=20
2.25.2


