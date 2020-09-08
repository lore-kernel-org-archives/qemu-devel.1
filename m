Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE3C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F8821897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WQ75FgFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F8821897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFW4u-0008Ke-4D
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3I-0005xC-Gv; Tue, 08 Sep 2020 01:20:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53943 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3F-0005sN-G3; Tue, 08 Sep 2020 01:20:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkk2sJ6z9sTm; Tue,  8 Sep 2020 15:19:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542398;
 bh=L+ql0mFkJJ6RIqHIX4UIYSGet1NsQYu3ApRmEert8Mg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WQ75FgFi1xMubHZ606Lgf+pH4K1oxB+8LApb6qIodqo68BOxXLOT48FMLr6yKt/qP
 kuMEUPZ3fFt8jfH5peve6T8hasNm+PstGJFUZWo2tHMKsX3w/jPrg3TNPErvruT5Xh
 W9y5OOyeAW5nLcj7goap7ZTq7iP37RoK+UaDMG1Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 07/33] spapr/xive: Use the xics flag to check for XIVE-only IRQ
 backends
Date: Tue,  8 Sep 2020 15:19:27 +1000
Message-Id: <20200908051953.1616885-8-david@gibson.dropbear.id.au>
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

The sPAPR machine has four different IRQ backends, each implementing
the XICS or XIVE interrupt mode or both in the case of the 'dual'
backend.

If a machine is started in P8 compat mode, QEMU should necessarily
support the XICS interrupt mode and in that case, the XIVE-only IRQ
backend is invalid. Currently, spapr_irq_check() tests the pointer
value to the IRQ backend to check for this condition, instead use the
'xics' flag. It's equivalent and it will ease the introduction of new
XIVE-only IRQ backends if needed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200820140106.2357228-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 72bb938375..f59960339e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -172,7 +172,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
          * To cover both and not confuse the OS, add an early failure in
          * QEMU.
          */
-        if (spapr->irq == &spapr_irq_xive) {
+        if (!spapr->irq->xics) {
             error_setg(errp, "XIVE-only machines require a POWER9 CPU");
             return -1;
         }
-- 
2.26.2


