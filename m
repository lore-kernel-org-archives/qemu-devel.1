Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C7C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7FD21897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="chLDAUSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7FD21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFWAE-0001ug-Fp
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3K-00061K-9J; Tue, 08 Sep 2020 01:20:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37829 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3H-0005uK-Qm; Tue, 08 Sep 2020 01:20:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkk6T9nz9sTv; Tue,  8 Sep 2020 15:19:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542398;
 bh=jcnikD43TknD0h7PbZyyb0oDHmtpwlFiVMarcY7U0tU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=chLDAUSYC8tZNC5N2ocBoiIyV4j4otuXklbtEbRuhCGrheb7xmVlrC6HcYU5xzQjg
 i2dxkw+n+az2erHnwbVorCc0xfEEgMkaJyF4Z6xs88uj8/Edyi4Ccip7yKJr4leqfG
 pdEZKHbh5pYYS0Pgmw67193GrNG4mhxAkaQKg7bo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 10/33] spapr/xive: Allocate IPIs independently from the other
 sources
Date: Tue,  8 Sep 2020 15:19:30 +1000
Message-Id: <20200908051953.1616885-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:19:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 bauerman@linux.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The vCPU IPIs are now allocated in kvmppc_xive_cpu_connect() when the
vCPU connects to the KVM device and not when all the sources are reset
in kvmppc_xive_source_reset()

This requires extra care for hotplug vCPUs and VM restore.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200820134547.2355743-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 47 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 3e80ea0ce9..507637d51e 100644
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
@@ -234,6 +249,12 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
 
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
@@ -245,12 +266,28 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
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
@@ -332,7 +369,7 @@ static void kvmppc_xive_source_get_state(XiveSource *xsrc)
     for (i = 0; i < xsrc->nr_irqs; i++) {
         uint8_t pq;
 
-        if (!xive_eas_is_valid(&xive->eat[i])) {
+        if (!xive_source_is_valid(xive, i)) {
             continue;
         }
 
@@ -515,7 +552,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
             uint8_t pq;
             uint8_t old_pq;
 
-            if (!xive_eas_is_valid(&xive->eat[i])) {
+            if (!xive_source_is_valid(xive, i)) {
                 continue;
             }
 
@@ -543,7 +580,7 @@ static void kvmppc_xive_change_state_handler(void *opaque, int running,
     for (i = 0; i < xsrc->nr_irqs; i++) {
         uint8_t pq;
 
-        if (!xive_eas_is_valid(&xive->eat[i])) {
+        if (!xive_source_is_valid(xive, i)) {
             continue;
         }
 
@@ -658,7 +695,7 @@ int kvmppc_xive_post_load(SpaprXive *xive, int version_id)
 
     /* Restore the EAT */
     for (i = 0; i < xive->nr_irqs; i++) {
-        if (!xive_eas_is_valid(&xive->eat[i])) {
+        if (!xive_source_is_valid(xive, i)) {
             continue;
         }
 
-- 
2.26.2


