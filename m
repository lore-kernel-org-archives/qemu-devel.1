Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CBAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26CB215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="eA0+3v5+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJz8gHZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26CB215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaCeD-0008VA-MQ
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 00:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iaCbD-0006sP-2j
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iaCbC-000219-3E
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:18 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48381)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iaCbA-0001vq-0c; Thu, 28 Nov 2019 00:44:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id BCC242274C;
 Thu, 28 Nov 2019 00:44:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 28 Nov 2019 00:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=hIc79k55330sL
 qRdCwQIUBdcco3hdPjvxZSvpVOEKc8=; b=eA0+3v5+/zvBS2+vagzNxpbiYLaUC
 xuKavTEb0iBxdqxd11txssmI0eFOr6PRbfSnk6Ta3Z+DH0u/egTH3jnNXeji3pya
 dzw7Ox6cAr0Pys3xRt5q2zyLilOMl4vXMsTtlF9FsXKVjtBmCQ2zrswb3DdqxWFi
 ppXo+lNc1BTT3sXTriBNm6K/N6EtPa9nrh6jsBTyIjEsHFMbLsLsiybxpNWxapkX
 JV1ODtm1JuZKFlZ0LLcMZEcMyIKl++9eiZq/+MlGbUe6oRq9P1Fjg3vutN42kosl
 QFKXaXFEPlk9AX8SfRKMdS0TETki64yHm5EnHeS6TeTX6gTbwuOFP6q7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=hIc79k55330sLqRdCwQIUBdcco3hdPjvxZSvpVOEKc8=; b=UJz8gHZX
 FJ/jRZKjz2VZSIBfjSghAlk8MYDHnQh0cuaVADzsMO/BwNdqXnX/qJe3DWpPz1HI
 VvaNON17PHueO65OMf/sFZWfB0MiLpmA3WisO56A4U/9r6kIZsX5tR8g5jjYD2aU
 vlTNY1xMQDnxeJlE+7FlV7m3HqmsPCTxGmr5CQp5oap6SKOyteGOC7qHD7SFQdGs
 tyRq/rxj4zIVqARmhHI+CraLmcs8e57YXviI3jLxRtv13mwFkN3dRbDCxLSxYKLD
 ihb2AJjp+IhbGbzawPWOCrbxgl1zr9bOfMHwJW/aFpYq7ZRqt0MpjOkfnNCWXYkx
 3m7SNjNCnUQGGA==
X-ME-Sender: <xms:r17fXcEK6hfiSG05qbjUHsIHjU_qonzIvxX6eJN13KwyoV1qVVN_4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeiiedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
 jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
 hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
 pedu
X-ME-Proxy: <xmx:r17fXWuRVh5OBvRBCln-ZUM64hG8ECoLKNz8yNruvNRkesJjMO4PAw>
 <xmx:r17fXfbL3CUBX4GIrEgdfe4Sw0PFriQy1aT_3tmiwtY5aaA9B16K4Q>
 <xmx:r17fXWWSAN3imU6NXhFUh6M8Ei7iXLuEJsvuaOEgy5S8v998XsXfNw>
 <xmx:r17fXVq5HbS7887GKfFiPwnROYwlT5JjZmXxT7R75M5ZLBds6BsNXQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 634E08005B;
 Thu, 28 Nov 2019 00:44:13 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 4/4] ast2600: Configure CNTFRQ at 1125MHz
Date: Thu, 28 Nov 2019 16:15:27 +1030
Message-Id: <20191128054527.25450-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128054527.25450-1-andrew@aj.id.au>
References: <20191128054527.25450-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.26
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This matches the configuration set by u-boot on the AST2600.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed_ast2600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 931887ac681f..5aecc3b3caec 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -259,6 +259,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinity(i),
                                 "mp-affinity", &error_abort);
 
+        object_property_set_int(OBJECT(&s->cpu[i]), 1125000000, "cntfrq",
+                                &error_abort);
+
         /*
          * TODO: the secondary CPUs are started and a boot helper
          * is needed when using -kernel
-- 
2.20.1


