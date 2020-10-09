Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C632C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0262226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OsfWPTv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0262226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpXv-0007kj-Bk
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVM-00059c-BR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:04 -0400
Received: from ozlabs.org ([203.11.71.1]:40495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVK-0001lq-61
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wW1hLSz9sTR; Fri,  9 Oct 2020 21:19:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238795;
 bh=ReJY2aou6sp3rSgeP/ZOyb10zb5wURuuxehViZoJX7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OsfWPTv7eYSVXeRyepAGA1autXz8l3nlvCTENQiaO7nCbW+5vTjUeq3SuAdtFb2Cp
 BqMW/+yjpDCG1bRHai6zy/B0P8MOJcZlFwOhVlgEhgwlzmE9tg7/3IfZn8MHMiky2e
 uG23r91MYeiAZXfQ8xgZtlNPTtucNkFNtttTqdzo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/20] spapr: Handle HPT allocation failure in nested guest
Date: Fri,  9 Oct 2020 21:19:32 +1100
Message-Id: <20201009101951.1569252-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:19:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: dbarboza@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nonngu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fabiano Rosas <farosas@linux.ibm.com>

The nested KVM code does not yet support HPT guests. Calling the
KVM_CAP_PPC_ALLOC_HTAB ioctl currently leads to KVM setting the guest
as HPT and erroneously executing code in L1 that should only run in
hypervisor mode, leading to an exception in the L1 vcpu thread when it
enters the nested guest.

This can be reproduced with -machine max-cpu-compat=power8 in the L2
guest command line.

The KVM code has since been modified to fail the ioctl when running in
a nested environment so QEMU needs to be able to handle that. This
patch provides an error message informing the user about the lack of
support for HPT in nested guests.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Message-Id: <20200911043123.204162-1-farosas@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2db810f73a..544a1947d9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1483,6 +1483,12 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
     spapr_free_hpt(spapr);
 
     rc = kvmppc_reset_htab(shift);
+
+    if (rc == -EOPNOTSUPP) {
+        error_setg(errp, "HPT not supported in nested guests");
+        return;
+    }
+
     if (rc < 0) {
         /* kernel-side HPT needed, but couldn't allocate one */
         error_setg_errno(errp, errno,
-- 
2.26.2


