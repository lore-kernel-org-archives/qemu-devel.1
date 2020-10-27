Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF8C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E593722258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f1K0L6ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E593722258
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPzv-0001PQ-Sz
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnL-0001fF-R1; Tue, 27 Oct 2020 10:17:51 -0400
Received: from ozlabs.org ([203.11.71.1]:49399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnI-0007Yn-TA; Tue, 27 Oct 2020 10:17:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLZ5GjPz9sf8; Wed, 28 Oct 2020 01:17:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808262;
 bh=562dCV4MbH/MftQHrOS2/q+KhVYTpBSxvy39bn5/W4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f1K0L6ldgKqc/w4L2ol5e/PY/LzGYYW7jQhgcLdFLnWXrbC3xXnz/HtcTzdCaaA4s
 YAlYQ4R+FWEi5/VRna23rXgGZsdxlaQ9CSM2DzKaTdQBWxMLS5yNt65L76Iw+/7JG2
 qLR12x602ck/Qhnlqp4KcRE53nAAM2zC6QMBXPiY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/18] spapr: Clarify why DR connectors aren't user creatable
Date: Wed, 28 Oct 2020 01:17:18 +1100
Message-Id: <20201027141735.728821-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:17:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

DR connector is a device that emulates a firmware abstraction used by PAPR
compliant guests to manage hotplug/dynamic-reconfiguration of PHBs, PCI
devices, memory, and CPUs.

It is internally created by the spapr platform and requires to be owned by
either the machine (PHBs, CPUs, memory) or by a PHB (PCI devices).

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160250199940.765467.6896806997161856576.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 697b28c343..77718cde1f 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -586,7 +586,8 @@ static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
     dk->realize = realize;
     dk->unrealize = unrealize;
     /*
-     * Reason: it crashes FIXME find and document the real reason
+     * Reason: DR connector needs to be wired to either the machine or to a
+     * PHB in spapr_dr_connector_new().
      */
     dk->user_creatable = false;
 }
-- 
2.26.2


