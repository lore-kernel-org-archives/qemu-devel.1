Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E56C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40992076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40992076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kuB-0000yM-20
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8ktI-0007ew-5b; Thu, 20 Aug 2020 09:46:04 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:53643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8ktE-0003ua-OA; Thu, 20 Aug 2020 09:46:03 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.8])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 3B6C958FDFF8;
 Thu, 20 Aug 2020 15:45:51 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 15:45:50 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005b927a24c-7992-4021-9939-af0c3babdd4a,
 02C359FD435C2C4122574921AFFD4D91C9CEEBEA) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 3/4] spapr/xive: Allocate IPIs independently from the other
 sources
Date: Thu, 20 Aug 2020 15:45:46 +0200
Message-ID: <20200820134547.2355743-4-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200820134547.2355743-1-clg@kaod.org>
References: <20200820134547.2355743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: f87911f2-83e4-4be9-839b-fb4c66113e88
X-Ovh-Tracer-Id: 9119507772774255465
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddutddggeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:45:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect() when the
vCPU connects to the KVM device and not when all the sources are reset
in kvmppc_xive_source_reset()

This requires extra care for hotplug vCPUs and VM restore.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_kvm.c | 47 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 4ea687c93ecd..f838c208b559 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -146,6 +146,15 @@ int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
     return s.ret;
 }
 
+static int kvmppc_xive_reset_ipi(SpaprXive *xive, CPUState *cs, Error **errp)
+{
+    unsigned long ipi = kvm_arch_vcpu_id(cs);
+    uint64_t state = 0;
+
+    return kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE, ipi,
+                              &state, true, errp);
+}
+
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
 {
     ERRP_GUARD();
@@ -175,6 +184,12 @@ int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
         return ret;
     }
 
+    /* Create/reset the vCPU IPI */
+    ret = kvmppc_xive_reset_ipi(xive, tctx->cs, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     kvm_cpu_enable(tctx->cs);
     return 0;
 }
@@ -260,6 +275,12 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
 
     assert(xive->fd != -1);
 
+    /*
+     * The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect()
+     * and not with all sources in kvmppc_xive_source_reset()
+     */
+    assert(srcno >= SPAPR_XIRQ_BASE);
+
     if (xive_source_irq_is_lsi(xsrc, srcno)) {
         state |= KVM_XIVE_LEVEL_SENSITIVE;
         if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
@@ -271,12 +292,28 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
                              true, errp);
 }
 
+/*
+ * To be valid, a source must have been claimed by the machine (valid
+ * entry in the EAS table) and if it is a vCPU IPI, the vCPU should
+ * have been enabled, which means the IPI has been allocated in
+ * kvmppc_xive_cpu_connect().
+ */
+static bool xive_source_is_valid(SpaprXive *xive, int i)
+{
+    return xive_eas_is_valid(&xive->eat[i]) &&
+        (i >= SPAPR_XIRQ_BASE || kvm_cpu_is_enabled(i));
+}
+
 static int kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
 {
     SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
     int i;
 
-    for (i = 0; i < xsrc->nr_irqs; i++) {
+    /*
+     * Skip the vCPU IPIs. These are created/reset when the vCPUs are
+     * connected in kvmppc_xive_cpu_connect()
+     */
+    for (i = SPAPR_XIRQ_BASE; i < xsrc->nr_irqs; i++) {
         int ret;
 
         if (!xive_eas_is_valid(&xive->eat[i])) {
@@ -370,7 +407,7 @@ static void kvmppc_xive_source_get_state(XiveSource *xsrc)
     for (i = 0; i < xsrc->nr_irqs; i++) {
         uint8_t pq;
 
-        if (!xive_eas_is_valid(&xive->eat[i])) {
+        if (!xive_source_is_valid(xive, i)) {
             continue;
         }
 
@@ -553,7 +590,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
             uint8_t pq;
             uint8_t old_pq;
 
-            if (!xive_eas_is_valid(&xive->eat[i])) {
+            if (!xive_source_is_valid(xive, i)) {
                 continue;
             }
 
@@ -581,7 +618,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
     for (i = 0; i < xsrc->nr_irqs; i++) {
         uint8_t pq;
 
-        if (!xive_eas_is_valid(&xive->eat[i])) {
+        if (!xive_source_is_valid(xive, i)) {
             continue;
         }
 
@@ -696,7 +733,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
 
     /* Restore the EAT */
     for (i = 0; i < xive->nr_irqs; i++) {
-        if (!xive_eas_is_valid(&xive->eat[i])) {
+        if (!xive_source_is_valid(xive, i)) {
             continue;
         }
 
-- 
2.25.4


