Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA42C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FC5206B2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MgH6i6/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FC5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWIx-0006i9-L5
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kaWHN-0005NZ-KR; Wed, 04 Nov 2020 22:49:41 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57625 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kaWHL-0003wY-9p; Wed, 04 Nov 2020 22:49:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CRTzb3HnLz9sTL; Thu,  5 Nov 2020 14:49:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604548171;
 bh=h9uWSlyNbwH/ldEkW6U/uD3o+yRhPlC7O+nq4loYpmE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MgH6i6/cte9FID8DtM3qPcGauqNXCdIAfE0z9kdQJrOAsQSa2QPPIQNX9nIZRw/6K
 2kmofWjWyESp6xGQUJKb44Y5dPDgu9dCJUNQ7JisKJhKb/gRkIqZy+YSTmiBJgaq7+
 EolkFlRJ3zeXLHsxu34NHq5/gdIxJgx6EUzsh3qw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 3/3] spapr: Convert hpt_prepare_thread() to use
 qemu_try_memalign()
Date: Thu,  5 Nov 2020 14:49:19 +1100
Message-Id: <20201105034919.393653-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105034919.393653-1-david@gibson.dropbear.id.au>
References: <20201105034919.393653-1-david@gibson.dropbear.id.au>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

HPT resizing is asynchronous: the guest first kicks off the creation of a
new HPT, then it waits for that new HPT to be actually created and finally
it asks the current HPT to be replaced by the new one.

In the case of a userland allocated HPT, this currently relies on calling
qemu_memalign() which aborts on OOM and never returns NULL. Since we seem
to have path to report the failure to the guest with an H_NO_MEM return
value, use qemu_try_memalign() instead of qemu_memalign().

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160398563636.32380.1747166034877173994.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 607740150f..1d8e8e6a88 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -360,7 +360,7 @@ static void *hpt_prepare_thread(void *opaque)
     SpaprPendingHpt *pending = opaque;
     size_t size = 1ULL << pending->shift;
 
-    pending->hpt = qemu_memalign(size, size);
+    pending->hpt = qemu_try_memalign(size, size);
     if (pending->hpt) {
         memset(pending->hpt, 0, size);
         pending->ret = H_SUCCESS;
-- 
2.28.0


