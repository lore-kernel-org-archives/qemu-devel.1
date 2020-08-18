Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B282206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iBB6Y4Vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B282206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tPp-0002fs-TR
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7W-00013c-3D; Tue, 18 Aug 2020 00:21:10 -0400
Received: from ozlabs.org ([203.11.71.1]:52919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7T-0006VZ-7J; Tue, 18 Aug 2020 00:21:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNj5yPpz9sW8; Tue, 18 Aug 2020 14:19:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724373;
 bh=m0qq4oMiEBFQ8XukQSQ+6w8sTCXSLaSPmouthrXMTSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iBB6Y4VpG/fMpHOvLxAsa6w9iRsUu0joiGVaxZMEG6ym+9JkXN4DqcSlXUGxCqT0a
 V5/Jul2XhmUiEcO88XPIRgYz8UniG+ORvew5piH4Knxqc32lizpa5/P4tMDisO5aq/
 vEL4K5+LFeg8GNWezL0Hj7JNcFjuqboKdXsYlOxI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 38/40] spapr/xive: Simplify error handling of
 kvmppc_xive_cpu_synchronize_state()
Date: Tue, 18 Aug 2020 14:19:20 +1000
Message-Id: <20200818041922.251708-39-david@gibson.dropbear.id.au>
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

Now that kvmppc_xive_cpu_get_state() returns negative on error, use that
and get rid of the temporary Error object and error_propagate().

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707852916.1489912.8376334685349668124.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c | 14 ++++++--------
 include/hw/ppc/xive.h    |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index e9a36115be..d871bb1a00 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -119,7 +119,8 @@ int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
 
 typedef struct {
     XiveTCTX *tctx;
-    Error *err;
+    Error **errp;
+    int ret;
 } XiveCpuGetState;
 
 static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
@@ -127,14 +128,14 @@ static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
 {
     XiveCpuGetState *s = arg.host_ptr;
 
-    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
+    s->ret = kvmppc_xive_cpu_get_state(s->tctx, s->errp);
 }
 
-void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
+int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
 {
     XiveCpuGetState s = {
         .tctx = tctx,
-        .err = NULL,
+        .errp = errp,
     };
 
     /*
@@ -143,10 +144,7 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
     run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
                RUN_ON_CPU_HOST_PTR(&s));
 
-    if (s.err) {
-        error_propagate(errp, s.err);
-        return;
-    }
+    return s.ret;
 }
 
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 785c905357..2c42ae92d2 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -488,7 +488,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
 int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp);
 void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
 int kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
-void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
+int kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
 int kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
 int kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
 
-- 
2.26.2


