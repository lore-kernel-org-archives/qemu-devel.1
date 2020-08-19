Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F0520738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F0520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NwQ-0005rB-9E
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npr-00055I-Lv; Wed, 19 Aug 2020 09:08:59 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:46331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npp-0006Mv-US; Wed, 19 Aug 2020 09:08:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.10])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 15D3F51EFD31;
 Wed, 19 Aug 2020 15:08:56 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:08:54 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00262a691de-efbb-447f-b2d2-3f782b00fa18,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 8/8] spapr/xive: Introduce a XIVE StoreEOI IRQ backend
Date: Wed, 19 Aug 2020 15:08:43 +0200
Message-ID: <20200819130843.2230799-9-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819130843.2230799-1-clg@kaod.org>
References: <20200819130843.2230799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 21d15091-42c4-4934-a479-09f3442ea952
X-Ovh-Tracer-Id: 2623346785664338727
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 09:08:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is still useful to run a P9 compat guest with StoreEOI enabled,
introduce a new IRQ backend to allow that. May be we should add a
migration blocker.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             |  6 +++++-
 hw/ppc/spapr_irq.c         | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ca8cb4421374..548895a89cca 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -90,6 +90,7 @@ typedef struct SpaprIrq {
 extern SpaprIrq spapr_irq_xics;
 extern SpaprIrq spapr_irq_xics_legacy;
 extern SpaprIrq spapr_irq_xive;
+extern SpaprIrq spapr_irq_xive_storeeoi;
 extern SpaprIrq spapr_irq_dual;
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a5bb0736e237..23f26d50f598 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3248,6 +3248,8 @@ static char *spapr_get_ic_mode(Object *obj, Error **errp)
         return g_strdup("xics");
     } else if (spapr->irq == &spapr_irq_xive) {
         return g_strdup("xive");
+    } else if (spapr->irq == &spapr_irq_xive_storeeoi) {
+        return g_strdup("xive-storeeoi");
     } else if (spapr->irq == &spapr_irq_dual) {
         return g_strdup("dual");
     }
@@ -3268,6 +3270,8 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
         spapr->irq = &spapr_irq_xics;
     } else if (strcmp(value, "xive") == 0) {
         spapr->irq = &spapr_irq_xive;
+    } else if (strcmp(value, "xive-storeeoi") == 0) {
+        spapr->irq = &spapr_irq_xive_storeeoi;
     } else if (strcmp(value, "dual") == 0) {
         spapr->irq = &spapr_irq_dual;
     } else {
@@ -3350,7 +3354,7 @@ static void spapr_instance_init(Object *obj)
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
                             spapr_set_ic_mode);
     object_property_set_description(obj, "ic-mode",
-                 "Specifies the interrupt controller mode (xics, xive, dual)");
+                 "Specifies the interrupt controller mode (xics, xive, xive-storeeoi, dual)");
 
     object_property_add_str(obj, "host-model",
         spapr_get_host_model, spapr_set_host_model);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d036c8fef519..c2e83fd0b34d 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -119,6 +119,15 @@ SpaprIrq spapr_irq_xive = {
     .xive        = true,
 };
 
+/*
+ * XIVE IRQ backend + StoreEOI activated
+ */
+
+SpaprIrq spapr_irq_xive_storeeoi = {
+    .xics        = false,
+    .xive        = true,
+};
+
 /*
  * Dual XIVE and XICS IRQ backend.
  *
@@ -213,6 +222,11 @@ static bool spapr_irq_xive_hw_storeeoi(SpaprMachineState *spapr)
     }
 
     /* StoreEOI on P9 compat is unsafe */
+    if (spapr->irq == &spapr_irq_xive_storeeoi) {
+        warn_report("HW Store EOI on a POWER9 CPU is unsafe.");
+        return true;
+    }
+
     return false;
 }
 
-- 
2.25.4


