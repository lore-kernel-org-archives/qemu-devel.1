Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A38C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3033F206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kCn/HJmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3033F206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tP2-0001fE-6S
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7U-00010B-Qn; Tue, 18 Aug 2020 00:21:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58983 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7T-0006Rr-2a; Tue, 18 Aug 2020 00:21:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNh6qTmz9sW5; Tue, 18 Aug 2020 14:19:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724372;
 bh=tGp8arJc1GfPjA66OlF7aLV68t4YlEwdGzyvgzTqt4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kCn/HJmw/3QSC5rCw2kxQRvseTFgmUY1iYTI5qqHimCwMNPQ2Huxvf5gEelW7of2I
 G5rELbxGk6QLRWR9hkug6p/Bc1XKKTwXRFGMmeQvmf4x+6ntrdBwOdCm5oixJq6xQh
 Zj1hKqpYblOstdOKhhu08520wE30+wgo/bTmRF5o=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 35/40] ppc/xive: Fix error handling in vmstate_xive_tctx_*()
 callbacks
Date: Tue, 18 Aug 2020 14:19:17 +1000
Message-Id: <20200818041922.251708-36-david@gibson.dropbear.id.au>
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

Now that kvmppc_xive_cpu_get_state() and kvmppc_xive_cpu_set_state()
return negative errnos on failures, use that instead local_err because
it is the recommended practice. Also return that instead of -1 since
vmstate expects negative errnos.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159707850840.1489912.14912810818646455474.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a453e8f4dc..17ca5a1916 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -695,12 +695,13 @@ static int vmstate_xive_tctx_pre_save(void *opaque)
 {
     XiveTCTX *tctx = XIVE_TCTX(opaque);
     Error *local_err = NULL;
+    int ret;
 
     if (xive_in_kernel(tctx->xptr)) {
-        kvmppc_xive_cpu_get_state(tctx, &local_err);
-        if (local_err) {
+        ret = kvmppc_xive_cpu_get_state(tctx, &local_err);
+        if (ret < 0) {
             error_report_err(local_err);
-            return -1;
+            return ret;
         }
     }
 
@@ -711,16 +712,17 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
 {
     XiveTCTX *tctx = XIVE_TCTX(opaque);
     Error *local_err = NULL;
+    int ret;
 
     if (xive_in_kernel(tctx->xptr)) {
         /*
          * Required for hotplugged CPU, for which the state comes
          * after all states of the machine.
          */
-        kvmppc_xive_cpu_set_state(tctx, &local_err);
-        if (local_err) {
+        ret = kvmppc_xive_cpu_set_state(tctx, &local_err);
+        if (ret < 0) {
             error_report_err(local_err);
-            return -1;
+            return ret;
         }
     }
 
-- 
2.26.2


