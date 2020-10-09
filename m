Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85387C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4468221FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d3+LaH9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4468221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpir-00036k-SL
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVj-0005od-V5
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:27 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57373 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVi-0001ni-6k
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wc05Jvz9sWF; Fri,  9 Oct 2020 21:19:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238800;
 bh=u+u/uqaHt49lnjdO3dVQIsEehBNDpgPAcRkG/Kv2VeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d3+LaH9JdEu8QI+sRurP6L0Pj691SKKN1+HKr6wnYUMZtfA8kW6OHoP2eluipRtWp
 8jXxIgVeT4/YdWMC5HUEzyIW0MctAP/l8B1E1MO/xmvr0oEeF8SOsdjlCKTmWXtW3w
 bPY90aYXImD/ULHATCy2NFczL0NkspLbyIxutX9w=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/20] ppc/pnv: Increase max firmware size
Date: Fri,  9 Oct 2020 21:19:46 +1100
Message-Id: <20201009101951.1569252-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
References: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: dbarboza@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nonngu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

Builds enabling GCOV can be bigger than 4MB and the limit on FSP
systems is 16MB.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20201002091440.1349326-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6670967e26..d9e52873ea 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -61,7 +61,7 @@
 
 #define FW_FILE_NAME            "skiboot.lid"
 #define FW_LOAD_ADDR            0x0
-#define FW_MAX_SIZE             (4 * MiB)
+#define FW_MAX_SIZE             (16 * MiB)
 
 #define KERNEL_LOAD_ADDR        0x20000000
 #define KERNEL_MAX_SIZE         (256 * MiB)
-- 
2.26.2


