Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9551B206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="R3M6lwnr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyNocwe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9551B206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibzb1-0007ge-IC
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 23:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ibzZE-0005qT-UU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ibzZC-0001QM-5M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:40 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43443)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ibzZ5-0001Hr-T9; Mon, 02 Dec 2019 23:13:32 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 1032FC28;
 Mon,  2 Dec 2019 23:13:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 02 Dec 2019 23:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 8MgJM3J3IhBnKwFW2SJqSeqOlRczVQkkEIqpATcIvsU=; b=R3M6lwnrDWJz4HEf
 xRcLyRZFSLtXks4a8rzJLzRGVlwlDWKziNcdMlodCGJarTDja8PE2Jo+zLSdT340
 CybYogFCKMxhS0rU2Qz4oRb3AT7DBH2hfI9ITKJDwHAI46wNsq5J9yCpCoNh4d2y
 jzhoB7u3iIyHTXfNpzQVuWdjm8snGGvl1670zpxgots1GwzJVaI0XqiVFc5fzb8B
 kveXTIREuuAo39e4SKQmVF7BzWUKAOH5isxvMxVzmlMVe5IUF26QjZySKlCVKNi0
 DqqZMSfXAYz/2ievqBSlBfdfnmZyKjjobZsz3qqYWKjps8Ak4JJeoON5XA3yOmLl
 e3okGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=8MgJM3J3IhBnKwFW2SJqSeqOlRczVQkkEIqpATcIv
 sU=; b=cyNocwe7zRRg7qZyoqiApGhSHGuY20krC3YrzXePhcacMw4HwHcWon66Y
 dzF6kUXex/fg0qJNEmkzJaJaCaYTRe2dlgyykFH0uODVkwUV5q3N7w/9orfwNQYj
 tkwJarq4US3RmO99lsgB8coClH4jn2Y+mI/rB2+5svPllMz1pD0a42nkv0lGAAwr
 CeFZZS9HEw+ruTLUQpywWXETsqe+v3OtP9YMBjJz+8FdGgBm2hExYQfkj6VIJHnX
 hFBgObAZABLxXFKDXlUq5Klbg6pLHz6VsIGKaTy3wcJyW3nA6A3ot2BaNuWXtC0a
 sGyPMrTXWkXbge+dbgcLo47U/P9yw==
X-ME-Sender: <xms:6ODlXR3uXAw-tY723_kafn6aw2UlkDFXiZk_nasfsFfzLJse9XdoMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughr
 vgifucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtd
 dvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:6ODlXaKzD7qUsgVo4RgYuz0anFUnXZ3pAl8mC0t6VfSIltZfp-bTUw>
 <xmx:6ODlXQAOQOJb6m48Sz3RC0aPtGVTF17G2uS_AhfFd5VzBtOb8P3VpA>
 <xmx:6ODlXTxqr3VMmGR-f5TPZEYberkfyOaCeNA_o-m8gVGjOPkvDZQkfg>
 <xmx:6ODlXfYpoV8xwiuv1xGLw1qvv3pEFaiYJt4b81v9YplqZZccagKU5Q>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 03FB880060;
 Mon,  2 Dec 2019 23:13:25 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 4/4] ast2600: Configure CNTFRQ at 1125MHz
Date: Tue,  3 Dec 2019 14:44:40 +1030
Message-Id: <20191203041440.6275-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203041440.6275-1-andrew@aj.id.au>
References: <20191203041440.6275-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.24
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This matches the configuration set by u-boot on the AST2600.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


