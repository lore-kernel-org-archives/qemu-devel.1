Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B67205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B67205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYt6D-000137-PE
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt3W-0004Fd-DT
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:12:22 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:54302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt3V-0005SR-Ab
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:12:22 -0400
Received: from player791.ha.ovh.net (unknown [10.108.57.16])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4C5271D6A43
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 17:12:19 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 576F81244BDFF;
 Wed, 13 May 2020 15:12:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 7/9] ppc/pnv: Add POWER10 quads
Date: Wed, 13 May 2020 17:11:07 +0200
Message-Id: <20200513151109.453530-8-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200513151109.453530-1-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1032168740706290662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfeitedvfedugeehvdevjeduiefhieetffejteejueekhffggfevudegudegudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.63.121; envelope-from=clg@kaod.org;
 helo=1.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 11:12:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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

Still needs some refinements on the XSCOM registers.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  4 ++++
 hw/ppc/pnv.c         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 3ff610a9c7b5..86bfa2107a8c 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -123,6 +123,10 @@ typedef struct Pnv10Chip {
     Pnv9Psi      psi;
     PnvLpcController lpc;
     PnvOCC       occ;
+
+    uint32_t     nr_quads;
+    PnvQuad      *quads;
+
 } Pnv10Chip;
 
 #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9f1698a74467..fc751dd575d4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1621,6 +1621,33 @@ static void pnv_chip_power10_instance_init(Object *obj)
                             TYPE_PNV10_OCC, &error_abort, NULL);
 }
 
+
+static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
+{
+    PnvChip *chip = PNV_CHIP(chip10);
+    int i;
+
+    chip10->nr_quads = DIV_ROUND_UP(chip->nr_cores, 4);
+    chip10->quads = g_new0(PnvQuad, chip10->nr_quads);
+
+    for (i = 0; i < chip10->nr_quads; i++) {
+        char eq_name[32];
+        PnvQuad *eq = &chip10->quads[i];
+        PnvCore *pnv_core = chip->cores[i * 4];
+        int core_id = CPU_CORE(pnv_core)->core_id;
+
+        snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
+        object_initialize_child(OBJECT(chip), eq_name, eq, sizeof(*eq),
+                                TYPE_PNV_QUAD, &error_fatal, NULL);
+
+        object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal);
+        object_property_set_bool(OBJECT(eq), true, "realized", &error_fatal);
+
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->id),
+                                &eq->xscom_regs);
+    }
+}
+
 static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -1642,6 +1669,12 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    pnv_chip_power10_quad_realize(chip10, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* XIVE2 interrupt controller (POWER10) */
     object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_IC_BASE(chip),
                             "ic-bar", &error_fatal);
-- 
2.25.4


