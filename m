Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A94C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8989D214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="MdCLTp4d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MR1gLMwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989D214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdwl-0001JO-BN
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ifdoy-0003Fo-3u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ifdox-00056Y-0G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:59 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:59891)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ifdou-00050e-Mg; Fri, 13 Dec 2019 00:48:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 69B568F7;
 Fri, 13 Dec 2019 00:48:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 13 Dec 2019 00:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 Y2G4Ydhqmr8BBUdomWAJiCRB/fhnREwhAAn2omPfwug=; b=MdCLTp4dfLtQJ8a0
 7G8iWhsruhSpcZ+1LMxK8vb9NYpBp/2zF11p9OTPoz4TTEFF6QBid7Fcdy9seGBP
 J5bDR/z5840l0gbz4YKV5yo1RSkiABi6h8TfkLZ+8CG1xotZEpjgV2syIIxvSa8z
 x1YeghQKiaR9ElRtAVrqispkD17orP8aZlnNTFKvOoKWWQlCLb5Hx2RItxn8e7rx
 2PV2QCZREY/Q8+GlbFEB1S8KNpGaYEq5dy4+jWUVEWROeD9ZuWBsGbOxI0n7jQMz
 2nXRuZKjyAIMIIG1mYZ5ncxGOuLTUWVEVyS2j71ItNz2IwpUaMrNx8E6nHB28efC
 BRN9eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=Y2G4Ydhqmr8BBUdomWAJiCRB/fhnREwhAAn2omPfw
 ug=; b=MR1gLMwDMZCGhn8K16fzDJhe1ZeYghY/W8U92hHvm/5NIfj3scf8ok+I3
 5pUl2Ap4gizwFfyTfPf6HKFDOdvAkiup0ZJNxYeZPEbMaqfPVfu1bxi59AhNEiem
 BBL6CGgztrJ4AtwCVGLKLW0ZrRAmKq/Bt1vBnrQQClkAcx+xpMErgjZQOe7zqgV9
 7ckIJHEPxfqoiJ3Roof9z7R2f5GWErSZi9EJK/2TVpuCqvzz6onexbCXHYUL/pTE
 Jhe/fii+QqpT3eWfoNwuVwLEdwqhzgjhhtLnVgdEUFxnOxlTFo6gFEnqMHmxXCo7
 gwoMj2ap729N3np5EnGKtWF0iLMKA==
X-ME-Sender: <xms:RibzXflDqFkqypoaoriat0Hj8rvQHRUe2Err55jxcIpdeb5hqUqtUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughr
 vgifucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtd
 dvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:RibzXZuNbwyUk0Dot8ylXpgGKTmmLyJ9vzTW0Fa1pC5kg653MreiiQ>
 <xmx:RibzXd8frxzpMH3ECFYNoNuo5iQznVeBgL8ewJKtplYmvjL46vuRsg>
 <xmx:RibzXTMWaNbVsq0b_swMmcOatFl9bQKZdCLzmPL6Dxo3staJotf-KQ>
 <xmx:RybzXccGlFrswB54pYBaNRZKbAHrWNKnhLeElJMCnq8ykUMJGMaNpw>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id E07E480069;
 Fri, 13 Dec 2019 00:48:51 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v3 4/4] ast2600: Configure CNTFRQ at 1125MHz
Date: Fri, 13 Dec 2019 16:19:51 +1030
Message-Id: <080ca1267a09381c43cf3c50d434fb6c186f2b6e.1576215453.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
References: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.19
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, clg@kaod.org, philmd@redhat.com, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This matches the configuration set by u-boot on the AST2600.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
git-series 0.9.1

