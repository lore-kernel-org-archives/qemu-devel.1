Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BC3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AF2205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AF2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYt7s-0003vB-7X
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt3c-0004Vt-A6
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:12:28 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:48359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt3a-0005Tt-Q0
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:12:27 -0400
Received: from player791.ha.ovh.net (unknown [10.108.35.211])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 96CE7163A36
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 17:12:24 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 41FC11244BEA3;
 Wed, 13 May 2020 15:12:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 8/9] ppc/pnv: Add model for POWER9 PHB5 PCIe Host bridge
Date: Wed, 13 May 2020 17:11:08 +0200
Message-Id: <20200513151109.453530-9-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200513151109.453530-1-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1033576114966662118
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfeitedvfedugeehvdevjeduiefhieetffejteejueekhffggfevudegudegudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.19; envelope-from=clg@kaod.org;
 helo=14.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 11:12:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PHB4 and PHB5 are very similar. Use the PHB4 models with some minor
adjustements in a subclass for P10.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/pci-host/pnv_phb4.h |  11 ++++
 include/hw/ppc/pnv.h           |   3 +
 include/hw/ppc/pnv_xscom.h     |   6 ++
 hw/pci-host/pnv_phb4_pec.c     |  44 ++++++++++++++
 hw/ppc/pnv.c                   | 101 +++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+)

diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index c882bfd0aa23..ea3810f74066 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -227,4 +227,15 @@ typedef struct PnvPhb4PecClass {
     int stk_compat_size;
 } PnvPhb4PecClass;
 
+/*
+ * POWER10 definitions
+ */
+
+#define PNV_PHB5_VERSION           0x000000a500000001ull
+#define PNV_PHB5_DEVICE_ID         0x0652
+
+#define TYPE_PNV_PHB5_PEC "pnv-phb5-pec"
+#define PNV_PHB5_PEC(obj) \
+    OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
+
 #endif /* PCI_HOST_PNV_PHB4_H */
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 86bfa2107a8c..516229a51e7b 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -127,6 +127,9 @@ typedef struct Pnv10Chip {
     uint32_t     nr_quads;
     PnvQuad      *quads;
 
+#define PNV10_CHIP_MAX_PEC 2
+    PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
+
 } Pnv10Chip;
 
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f26c5217764d..433c7b878af4 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -139,6 +139,12 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_XIVE2_BASE     0x2010800
 #define PNV10_XSCOM_XIVE2_SIZE     0x400
 
+#define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ... */
+#define PNV10_XSCOM_PEC_NEST_SIZE  0x100
+
+#define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
+#define PNV10_XSCOM_PEC_PCI_SIZE   0x200
+
 void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 911d147ffd7d..869fd77b62cc 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -586,9 +586,53 @@ static const TypeInfo pnv_pec_stk_type_info = {
     }
 };
 
+/*
+ * POWER10 definitions
+ */
+
+static uint32_t pnv_phb5_pec_xscom_pci_base(PnvPhb4PecState *pec)
+{
+    return PNV10_XSCOM_PEC_PCI_BASE + 0x1000000 * pec->index;
+}
+
+static uint32_t pnv_phb5_pec_xscom_nest_base(PnvPhb4PecState *pec)
+{
+    /* index goes down ... */
+    return PNV10_XSCOM_PEC_NEST_BASE - 0x1000000 * pec->index;
+}
+
+static void pnv_phb5_pec_class_init(ObjectClass *klass, void *data)
+{
+    PnvPhb4PecClass *pecc = PNV_PHB4_PEC_CLASS(klass);
+    static const char compat[] = "ibm,power10-pbcq";
+    static const char stk_compat[] = "ibm,power10-phb-stack";
+
+    pecc->xscom_nest_base = pnv_phb5_pec_xscom_nest_base;
+    pecc->xscom_pci_base  = pnv_phb5_pec_xscom_pci_base;
+    pecc->xscom_nest_size = PNV10_XSCOM_PEC_NEST_SIZE;
+    pecc->xscom_pci_size  = PNV10_XSCOM_PEC_PCI_SIZE;
+    pecc->compat = compat;
+    pecc->compat_size = sizeof(compat);
+    pecc->stk_compat = stk_compat;
+    pecc->stk_compat_size = sizeof(stk_compat);
+}
+
+static const TypeInfo pnv_phb5_pec_type_info = {
+    .name          = TYPE_PNV_PHB5_PEC,
+    .parent        = TYPE_PNV_PHB4_PEC,
+    .instance_size = sizeof(PnvPhb4PecState),
+    .class_init    = pnv_phb5_pec_class_init,
+    .class_size    = sizeof(PnvPhb4PecClass),
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
 static void pnv_pec_register_types(void)
 {
     type_register_static(&pnv_pec_type_info);
+    type_register_static(&pnv_phb5_pec_type_info);
     type_register_static(&pnv_pec_stk_type_info);
 }
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fc751dd575d4..ac4bd2a17a9e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -705,9 +705,17 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
 static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(chip);
+    int i, j;
 
     pnv_xive2_pic_print_info(&chip10->xive, mon);
     pnv_psi_pic_print_info(&chip10->psi, mon);
+
+    for (i = 0; i < PNV10_CHIP_MAX_PEC; i++) {
+        PnvPhb4PecState *pec = &chip10->pecs[i];
+        for (j = 0; j < pec->num_stacks; j++) {
+            pnv_phb4_pic_print_info(&pec->stacks[j].phb, mon);
+        }
+    }
 }
 
 static void pnv_init(MachineState *machine)
@@ -1607,7 +1615,10 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 
 static void pnv_chip_power10_instance_init(Object *obj)
 {
+    PnvChip *chip = PNV_CHIP(obj);
     Pnv10Chip *chip10 = PNV10_CHIP(obj);
+    PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
+    int i;
 
     object_initialize_child(obj, "xive", &chip10->xive, sizeof(chip10->xive),
                             TYPE_PNV_XIVE2, &error_abort, NULL);
@@ -1619,6 +1630,17 @@ static void pnv_chip_power10_instance_init(Object *obj)
                             TYPE_PNV10_LPC, &error_abort, NULL);
     object_initialize_child(obj, "occ",  &chip10->occ, sizeof(chip10->occ),
                             TYPE_PNV10_OCC, &error_abort, NULL);
+
+    for (i = 0; i < PNV10_CHIP_MAX_PEC; i++) {
+        object_initialize_child(obj, "pec[*]", &chip10->pecs[i],
+                                sizeof(chip10->pecs[i]), TYPE_PNV_PHB5_PEC,
+                                &error_abort, NULL);
+    }
+
+    /*
+     * Number of PHBs is the chip default
+     */
+    chip->num_phbs = pcc->num_phbs;
 }
 
 
@@ -1648,6 +1670,77 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
     }
 }
 
+static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
+{
+    Pnv10Chip *chip10 = PNV10_CHIP(chip);
+    Error *local_err = NULL;
+    int i, j;
+    int phb_id = 0;
+
+    for (i = 0; i < PNV10_CHIP_MAX_PEC; i++) {
+        PnvPhb4PecState *pec = &chip10->pecs[i];
+        PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_nest_base;
+        uint32_t pec_pci_base;
+
+        object_property_set_int(OBJECT(pec), i, "index", &error_fatal);
+        /*
+         * PEC0 -> 3 stacks
+         * PEC1 -> 3 stacks
+         */
+        object_property_set_int(OBJECT(pec), 3, "num-stacks",
+                                &error_fatal);
+        object_property_set_int(OBJECT(pec), chip->chip_id, "chip-id",
+                                 &error_fatal);
+        object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()),
+                                 "system-memory", &error_abort);
+        object_property_set_bool(OBJECT(pec), true, "realized", &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        pec_nest_base = pecc->xscom_nest_base(pec);
+        pec_pci_base = pecc->xscom_pci_base(pec);
+
+        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
+        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
+
+        for (j = 0; j < pec->num_stacks && phb_id < chip->num_phbs;
+             j++, phb_id++) {
+            PnvPhb4PecStack *stack = &pec->stacks[j];
+            Object *obj = OBJECT(&stack->phb);
+
+            object_property_set_int(obj, phb_id, "index", &error_fatal);
+            object_property_set_int(obj, chip->chip_id, "chip-id",
+                                    &error_fatal);
+            object_property_set_int(obj, PNV_PHB5_VERSION, "version",
+                                    &error_fatal);
+            object_property_set_int(obj, PNV_PHB5_DEVICE_ID, "device-id",
+                                    &error_fatal);
+            object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
+            object_property_set_bool(obj, true, "realized", &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+
+            /* Populate the XSCOM address space. */
+            pnv_xscom_add_subregion(chip,
+                                   pec_nest_base + 0x40 * (stack->stack_no + 1),
+                                   &stack->nest_regs_mr);
+            pnv_xscom_add_subregion(chip,
+                                    pec_pci_base + 0x40 * (stack->stack_no + 1),
+                                    &stack->pci_regs_mr);
+            pnv_xscom_add_subregion(chip,
+                                    pec_pci_base + PNV9_XSCOM_PEC_PCI_STK0 +
+                                    0x40 * stack->stack_no,
+                                    &stack->phb_regs_mr);
+        }
+    }
+}
+
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -1737,6 +1830,13 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     }
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_OCC_BASE,
                             &chip10->occ.xscom_regs);
+
+    /* PHBs */
+    pnv_chip_power10_phb_realize(chip, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -1763,6 +1863,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     k->xscom_core_base = pnv_chip_power10_xscom_core_base;
     k->xscom_pcba = pnv_chip_power10_xscom_pcba;
     dc->desc = "PowerNV Chip POWER10";
+    k->num_phbs = 6;
 
     device_class_set_parent_realize(dc, pnv_chip_power10_realize,
                                     &k->parent_realize);
-- 
2.25.4


