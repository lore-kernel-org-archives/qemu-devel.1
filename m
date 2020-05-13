Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E29C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0790F2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0790F2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtC4-0002CT-Kf
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt3l-0004uu-IS
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:12:37 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:55302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jYt3k-0005Wb-Eh
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:12:37 -0400
Received: from player791.ha.ovh.net (unknown [10.108.54.172])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8237A1C06FD
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 17:12:34 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id 8BCB01244BEFA;
 Wed, 13 May 2020 15:12:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 9/9] ppc/psi: Add support for StoreEOI and 64k ESB pages
 (POWER10)
Date: Wed, 13 May 2020 17:11:09 +0200
Message-Id: <20200513151109.453530-10-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200513151109.453530-1-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1036390865241410534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfeitedvfedugeehvdevjeduiefhieetffejteejueekhffggfevudegudegudfgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.127.22; envelope-from=clg@kaod.org;
 helo=1.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 11:12:34
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

POWER10 adds support for StoreEOI operation and 64K ESB pages on PSIHB
to be consistent with the other interrupt sources of the system.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c     |  6 ++++++
 hw/ppc/pnv_psi.c | 32 +++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ac4bd2a17a9e..0062e9b5ab28 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1523,6 +1523,9 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
                             "bar", &error_fatal);
+    /* This is the only device with 4k ESB pages */
+    object_property_set_int(OBJECT(&chip9->psi), XIVE_ESB_4K, "shift",
+                            &error_fatal);
     object_property_set_bool(OBJECT(&chip9->psi), true, "realized", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -1795,6 +1798,9 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
                             "bar", &error_fatal);
+    /* PSI can now be configured to use 64k ESB pages on POWER10 */
+    object_property_set_int(OBJECT(&chip10->psi), XIVE_ESB_64K, "shift",
+                            &error_fatal);
     object_property_set_bool(OBJECT(&chip10->psi), true, "realized",
                              &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index c34a49b000f2..fbf92cf93a22 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -607,7 +607,6 @@ static const TypeInfo pnv_psi_power8_info = {
 #define   PSIHB9_IRQ_METHOD             PPC_BIT(0)
 #define   PSIHB9_IRQ_RESET              PPC_BIT(1)
 #define PSIHB9_ESB_CI_BASE              0x60
-#define   PSIHB9_ESB_CI_64K             PPC_BIT(1)
 #define   PSIHB9_ESB_CI_ADDR_MASK       PPC_BITMASK(8, 47)
 #define   PSIHB9_ESB_CI_VALID           PPC_BIT(63)
 #define PSIHB9_ESB_NOTIF_ADDR           0x68
@@ -652,6 +651,14 @@ static const TypeInfo pnv_psi_power8_info = {
 #define   PSIHB9_IRQ_STAT_DIO           PPC_BIT(12)
 #define   PSIHB9_IRQ_STAT_PSU           PPC_BIT(13)
 
+/* P10 register extensions */
+
+#define PSIHB10_CR                       PSIHB9_CR
+#define    PSIHB10_CR_STORE_EOI          PPC_BIT(12)
+
+#define PSIHB10_ESB_CI_BASE              PSIHB9_ESB_CI_BASE
+#define   PSIHB10_ESB_CI_64K             PPC_BIT(1)
+
 static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno)
 {
     PnvPsi *psi = PNV_PSI(xf);
@@ -710,6 +717,13 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
 
     switch (addr) {
     case PSIHB9_CR:
+        if (val & PSIHB10_CR_STORE_EOI) {
+            psi9->source.esb_flags |= XIVE_SRC_STORE_EOI;
+        } else {
+            psi9->source.esb_flags &= ~XIVE_SRC_STORE_EOI;
+        }
+        break;
+
     case PSIHB9_SEMR:
         /* FSP stuff */
         break;
@@ -721,15 +735,20 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
         break;
 
     case PSIHB9_ESB_CI_BASE:
+        if (val & PSIHB10_ESB_CI_64K) {
+            psi9->source.esb_shift = XIVE_ESB_64K;
+        } else {
+            psi9->source.esb_shift = XIVE_ESB_4K;
+        }
         if (!(val & PSIHB9_ESB_CI_VALID)) {
             if (psi->regs[reg] & PSIHB9_ESB_CI_VALID) {
                 memory_region_del_subregion(sysmem, &psi9->source.esb_mmio);
             }
         } else {
             if (!(psi->regs[reg] & PSIHB9_ESB_CI_VALID)) {
-                memory_region_add_subregion(sysmem,
-                                        val & ~PSIHB9_ESB_CI_VALID,
-                                        &psi9->source.esb_mmio);
+                hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
+                memory_region_add_subregion(sysmem, addr,
+                                            &psi9->source.esb_mmio);
             }
         }
         psi->regs[reg] = val;
@@ -838,6 +857,8 @@ static void pnv_psi_power9_instance_init(Object *obj)
 
     object_initialize_child(obj, "source", &psi->source, sizeof(psi->source),
                             TYPE_XIVE_SOURCE, &error_abort, NULL);
+    object_property_add_alias(obj, "shift", OBJECT(&psi->source), "shift",
+                              &error_abort);
 }
 
 static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
@@ -847,9 +868,6 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     int i;
 
-    /* This is the only device with 4k ESB pages */
-    object_property_set_int(OBJECT(xsrc), XIVE_ESB_4K, "shift",
-                            &error_fatal);
     object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_abort);
-- 
2.25.4


