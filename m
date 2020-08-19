Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342A9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BCA206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BCA206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8NtU-0002lY-8b
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npp-0004yF-6c; Wed, 19 Aug 2020 09:08:57 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:36813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npl-0006Lq-LV; Wed, 19 Aug 2020 09:08:56 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.109])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 6958258A0B8A;
 Wed, 19 Aug 2020 15:08:51 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:08:50 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00222ed0cb7-28ec-4adb-bcfa-41a54b3a8a55,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/8] spapr/xive: Activate StoreEOI for POWER10 only
Date: Wed, 19 Aug 2020 15:08:39 +0200
Message-ID: <20200819130843.2230799-5-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819130843.2230799-1-clg@kaod.org>
References: <20200819130843.2230799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: a88e599d-486e-4347-8993-cb6e5e2a3057
X-Ovh-Tracer-Id: 2621939408889350950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 09:08:51
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

The StoreEOI features is safe to use with a P10 compat machine but not
with P9 compat, as it can not be migrated to a P9 host.

Introdude a "hw-storeeoi" property in the SpaprXive model to check for
the availability of StoreEOI at the HW level when a kernel IRQ chip is
in use. XIVE emulated is not impacted.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  1 +
 hw/intc/spapr_xive.c        |  3 ++-
 hw/ppc/spapr_irq.c          | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 3f325723ea74..402e38a7cf5e 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -51,6 +51,7 @@ typedef struct SpaprXive {
     VMChangeStateEntry *change;
 
     uint8_t       hv_prio;
+    bool          hw_storeeoi;
 } SpaprXive;
 
 typedef struct SpaprXiveClass {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 943b9958a68b..d184d17e30e7 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -596,6 +596,7 @@ static Property spapr_xive_properties[] = {
     DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE),
     DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE),
     DEFINE_PROP_UINT8("hv-prio", SpaprXive, hv_prio, 7),
+    DEFINE_PROP_BOOL("hw-storeeoi", SpaprXive, hw_storeeoi, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -945,7 +946,7 @@ static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
         /*
          * Override QEMU settings with KVM values
          */
-        if (flags & XIVE_SRC_STORE_EOI) {
+        if (xive->hw_storeeoi && flags & XIVE_SRC_STORE_EOI) {
             args[0] |= SPAPR_XIVE_SRC_STORE_EOI;
         } else {
             args[0] &= ~SPAPR_XIVE_SRC_STORE_EOI;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 72bb938375ef..80cf1c3d6bb2 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -199,6 +199,23 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
     return 0;
 }
 
+static bool spapr_irq_xive_hw_storeeoi(SpaprMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+
+    /*
+     * All P10 compat kernels should enforce load-after-store ordering
+     * for StoreEOI.
+     */
+    if (ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_10,
+                              0, spapr->max_compat_pvr)) {
+        return true;
+    }
+
+    /* StoreEOI on P9 compat is unsafe */
+    return false;
+}
+
 /*
  * sPAPR IRQ frontend routines for devices
  */
@@ -325,6 +342,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 
     if (spapr->irq->xive) {
         uint32_t nr_servers = spapr_max_server_number(spapr);
+        bool storeeoi = spapr_irq_xive_hw_storeeoi(spapr);
         DeviceState *dev;
         int i;
 
@@ -337,6 +355,8 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
         object_property_set_link(OBJECT(dev), "xive-fabric", OBJECT(spapr),
                                  &error_abort);
+        object_property_set_bool(OBJECT(dev), "hw-storeeoi", storeeoi,
+                                 &error_abort);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
         spapr->xive = SPAPR_XIVE(dev);
-- 
2.25.4


