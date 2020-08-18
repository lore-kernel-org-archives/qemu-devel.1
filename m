Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9095CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C239206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MtSPeq0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C239206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tLu-00030O-It
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6g-00009K-CJ; Tue, 18 Aug 2020 00:20:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51551 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6e-0006PG-Dw; Tue, 18 Aug 2020 00:20:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNg3NFKz9sVt; Tue, 18 Aug 2020 14:19:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724371;
 bh=84GQnKrJ/KKX2ARDOv43YFIXRVyBvCRDdcNlh8ieclo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MtSPeq0RX/VviDGUIHidGFb8LQk/k5EoWN0MqrvCD0OrBUb3f8+L75QsHllEsGOCK
 2FjvefUw+msCth5N4866CWMo6uy+tI+5C64PQYpY1NBJZXuSqc+r18+u4DMAUJjRuG
 AHdfnGogSFCzI7wgv7UiqPW1XDn/CHBRRv/lHPws=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 29/40] spapr/xive: Rework error handling of
 kvmppc_xive_cpu_[gs]et_state()
Date: Tue, 18 Aug 2020 14:19:11 +1000
Message-Id: <20200818041922.251708-30-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

kvm_set_one_reg() returns a negative errno on failure, use that instead
of errno. Also propagate it to callers so they can use it to check
for failures and hopefully get rid of their local_err boilerplate.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707846665.1489912.14267225652103441921.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 15 ++++++++++-----
 include/hw/ppc/xive.h    |  4 ++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index b2a36fd59d..5e088ccbf8 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -73,7 +73,7 @@ static void kvm_cpu_disable_all(void)
  * XIVE Thread Interrupt Management context (KVM)
  */
 
-void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
 {
     SpaprXive *xive = SPAPR_XIVE(tctx->xptr);
     uint64_t state[2];
@@ -86,13 +86,16 @@ void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
 
     ret = kvm_set_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
     if (ret != 0) {
-        error_setg_errno(errp, errno,
+        error_setg_errno(errp, -ret,
                          "XIVE: could not restore KVM state of CPU %ld",
                          kvm_arch_vcpu_id(tctx->cs));
+        return ret;
     }
+
+    return 0;
 }
 
-void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 {
     SpaprXive *xive = SPAPR_XIVE(tctx->xptr);
     uint64_t state[2] = { 0 };
@@ -102,14 +105,16 @@ void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 
     ret = kvm_get_one_reg(tctx->cs, KVM_REG_PPC_VP_STATE, state);
     if (ret != 0) {
-        error_setg_errno(errp, errno,
+        error_setg_errno(errp, -ret,
                          "XIVE: could not capture KVM state of CPU %ld",
                          kvm_arch_vcpu_id(tctx->cs));
-        return;
+        return ret;
     }
 
     /* word0 and word1 of the OS ring. */
     *((uint64_t *) &tctx->regs[TM_QW1_OS]) = state[0];
+
+    return 0;
 }
 
 typedef struct {
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2d87ed4372..785c905357 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -489,7 +489,7 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
 void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
-void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
-void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
 
 #endif /* PPC_XIVE_H */
-- 
2.26.2


