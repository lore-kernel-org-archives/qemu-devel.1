Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA23C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CF020706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DNWHZS+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CF020706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7t9W-0004iO-6t
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t67-0007IZ-8x; Tue, 18 Aug 2020 00:19:43 -0400
Received: from ozlabs.org ([203.11.71.1]:51169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t65-0006L0-9p; Tue, 18 Aug 2020 00:19:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNZ1bJqz9sTt; Tue, 18 Aug 2020 14:19:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724366;
 bh=62brQkG4nIHthJ12gqOXwUyRW/t7bCiEYH2IKJRyf+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DNWHZS+YxP3rfhILq4FgIuvw7jOb+TSzOjyffbzn7tpUlEBSG3TFdFMS8dJFIYKFQ
 Tj9zNns/uhcMpxSZwT4TgNQKq4mz3KVM0zLCJZGVht7vHrXG0XOp8zIZ4+4v9vXnTz
 IEP6WSYu20DpWVlwq3bQ5HVUS9QbWWS6kuSFPGR4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 06/40] target/ppc: add vmulld instruction
Date: Tue, 18 Aug 2020 14:18:48 +1000
Message-Id: <20200818041922.251708-7-david@gibson.dropbear.id.au>
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
Cc: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lijun Pan <ljp@linux.ibm.com>

vmulld: Vector Multiply Low Doubleword.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
Message-Id: <20200701234344.91843-6-ljp@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vmx-impl.inc.c | 1 +
 target/ppc/translate/vmx-ops.inc.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index b6c9290707..f8e8b978ec 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -807,6 +807,7 @@ GEN_VXFORM_DUAL(vmulouw, PPC_ALTIVEC, PPC_NONE,
 GEN_VXFORM(vmulosb, 4, 4);
 GEN_VXFORM(vmulosh, 4, 5);
 GEN_VXFORM(vmulosw, 4, 6);
+GEN_VXFORM_V(vmulld, MO_64, tcg_gen_gvec_mul, 4, 7);
 GEN_VXFORM(vmuleub, 4, 8);
 GEN_VXFORM(vmuleuh, 4, 9);
 GEN_VXFORM(vmuleuw, 4, 10);
diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
index 84e05fb827..b49787ac97 100644
--- a/target/ppc/translate/vmx-ops.inc.c
+++ b/target/ppc/translate/vmx-ops.inc.c
@@ -48,6 +48,9 @@ GEN_HANDLER_E(name, 0x04, opc2, opc3, inval, PPC_NONE, PPC2_ISA300)
 GEN_HANDLER_E_2(name, 0x04, opc2, opc3, opc4, 0x00000000, PPC_NONE,     \
                                                        PPC2_ISA300)
 
+#define GEN_VXFORM_310(name, opc2, opc3)                                \
+GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ISA310)
+
 #define GEN_VXFORM_DUAL(name0, name1, opc2, opc3, type0, type1) \
 GEN_HANDLER_E(name0##_##name1, 0x4, opc2, opc3, 0x00000000, type0, type1)
 
@@ -104,6 +107,7 @@ GEN_VXFORM_DUAL(vmulouw, vmuluwm, 4, 2, PPC_ALTIVEC, PPC_NONE),
 GEN_VXFORM(vmulosb, 4, 4),
 GEN_VXFORM(vmulosh, 4, 5),
 GEN_VXFORM_207(vmulosw, 4, 6),
+GEN_VXFORM_310(vmulld, 4, 7),
 GEN_VXFORM(vmuleub, 4, 8),
 GEN_VXFORM(vmuleuh, 4, 9),
 GEN_VXFORM_207(vmuleuw, 4, 10),
-- 
2.26.2


