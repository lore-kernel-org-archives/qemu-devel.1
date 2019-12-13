Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FF5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11199214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Mog8UeNj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huNnvZ+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11199214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdrc-00065h-87
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ifdon-000308-Ti
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ifdom-0004l4-L8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:49 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55527)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ifdok-0004eA-2a; Fri, 13 Dec 2019 00:48:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id C76068F7;
 Fri, 13 Dec 2019 00:48:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 13 Dec 2019 00:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 1UCByQUYAsPHw0TDr/9tqYqfBlUQ9Y9+Vdyqo8I6jT0=; b=Mog8UeNjUGLCDyBb
 0uRLdhuWZ0qlfpi5XASc7z8WWwpSyFQ7pN2floLJa+a3B0ZAKwloarK9oZ9e0hzY
 /vhVvOSHPe/HGi3xIncIMthFqvmgJxUELYeivAuNKMmc8un43wE7g1Xv5d0XNlRJ
 w7u4Awg71DC+EHHiMp6amC3aKVNzVUvoFnoB7JVIt80rTiB3j7cERJt+71qwtzwz
 3w1k5yCcxfV66EW5CkMM1W1qkZFdenj/Th9QJ696WVfCULl96tRNPYxs5sIrPv0u
 g0/yH6KORo9qYNv4Sx3FYsPLjObEYY35aHqRJ7HYwhhgzYEaGOlhYtU950F7nbik
 MDPDVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=1UCByQUYAsPHw0TDr/9tqYqfBlUQ9Y9+Vdyqo8I6j
 T0=; b=huNnvZ+Q+4YfRQUYbw+RYsKYGLgs/h5sW/7Lcjf2/b8/mNZEIDLhCAI7d
 Y0ZbojLikiX8c6MWiQBCr9DPkWviEEdf8xqDb2KMyLprfrMoiKVDUREqw/d5E5Q+
 Ol8L7V2lC04dPiGFK28O7RZA4sCXuF3JbTU63O64c8rUAx0CO2199Trxt7jDQW2k
 WAaVZiKVj6M5YRrxkXTQdYuc90wz/MsJniu9N/c+mAq0zjC5XOeyxBGcBiaKdt/O
 +6rZup5oDrLFackU4BXDd46wp37guwchJ1QT0wJnlAaDqaUoucpyHr86PzsSy+7C
 LWAjQLPsElhSTHgk/CTbg2yzwokXg==
X-ME-Sender: <xms:PCbzXZhT39XpRfIBKoJfiZZDPvxRtMaxYav1-Dnmf-0vE7nfKsClcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughr
 vgifucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtd
 dvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PCbzXXJVifcYCyYH3BPdZz43WTXkTFGorCHKNyE_uxXSgqwg2pzQKA>
 <xmx:PCbzXR9Aev1m8W3mbBlN1_rYuwaPR-qF24Nv4bioavYFy_V27JoWmg>
 <xmx:PCbzXQ4bWFHGNkRr0kfTpWiYM56y42V1d8-rBIe-DE6y551K1MtavQ>
 <xmx:PCbzXdOTrqq-9kTMKdtxf-Cy0_FEU2kqBvvXH2yCgekHkTIWT1occQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4C6DE80060;
 Fri, 13 Dec 2019 00:48:41 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v3 1/4] target/arm: Remove redundant scaling of nexttick
Date: Fri, 13 Dec 2019 16:19:48 +1030
Message-Id: <f8c680720e3abe55476e6d9cb604ad27fdbeb2e0.1576215453.git-series.andrew@aj.id.au>
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

The corner-case codepath was adjusting nexttick such that overflow
wouldn't occur when timer_mod() scaled the value back up. Remove a use
of GTIMER_SCALE and avoid unnecessary operations by calling
timer_mod_ns() directly.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 target/arm/helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a089fb5a6909..65c4441a3896 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2446,9 +2446,10 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * timer expires we will reset the timer for any remaining period.
          */
         if (nexttick > INT64_MAX / GTIMER_SCALE) {
-            nexttick = INT64_MAX / GTIMER_SCALE;
+            timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
+        } else {
+            timer_mod(cpu->gt_timer[timeridx], nexttick);
         }
-        timer_mod(cpu->gt_timer[timeridx], nexttick);
         trace_arm_gt_recalc(timeridx, irqstate, nexttick);
     } else {
         /* Timer disabled: ISTATUS and timer output always clear */
-- 
git-series 0.9.1

