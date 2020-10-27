Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C32C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2785A21D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X/pq4I+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2785A21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ6f-0000bx-Sv
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnO-0001nP-Qi; Tue, 27 Oct 2020 10:17:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56467 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnM-0007Yw-RO; Tue, 27 Oct 2020 10:17:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLc3wz1z9sXh; Wed, 28 Oct 2020 01:17:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808264;
 bh=1SqgTWzs/0SMAOqpRury5FOnxtJE8GPuIbhDyt77ebg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X/pq4I+V0NM9/Ugcco0hzPqgotkSH/VCvUN21e8Bq8k2k9i9saUwuVeOxwoc+/Ae0
 gu9qaprl0o2xrluJaxfQhbeAHLwpHPm1U3D4lySxcXbfKinKhUPaYHykIlTtG6Ync1
 H034gMkVyq0Fx/TZQYtVZxwMlrGsXpw2lVo8rFSM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 03/18] hw/net: move allocation to the heap due to very large
 stack frame
Date: Wed, 28 Oct 2020 01:17:20 +1100
Message-Id: <20201027141735.728821-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Elena Afanasova <eafanasova@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Afanasova <eafanasova@gmail.com>

[dwg] The stack frame itself probably isn't that big a deal, but
avoiding alloca() is generally recommended these days.

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
Message-Id: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/net/spapr_llan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 2093f1bad0..581320a0e7 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
     SpaprVioDevice *sdev = spapr_vio_find_by_reg(spapr->vio_bus, reg);
     SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
     unsigned total_len;
-    uint8_t *lbuf, *p;
+    uint8_t *p;
+    g_autofree uint8_t *lbuf = NULL;
     int i, nbufs;
     int ret;
 
@@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
         return H_RESOURCE;
     }
 
-    lbuf = alloca(total_len);
+    lbuf = g_malloc(total_len);
     p = lbuf;
     for (i = 0; i < nbufs; i++) {
         ret = spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
-- 
2.26.2


