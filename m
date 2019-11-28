Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FEF215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="HJqxTCCX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCiliY/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FEF215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaCd4-0008HJ-OK
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 00:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iaCb5-0006hR-TW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iaCb4-0001li-UQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:11 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iaCb2-0001gJ-AQ; Thu, 28 Nov 2019 00:44:08 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 983D622756;
 Thu, 28 Nov 2019 00:44:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 28 Nov 2019 00:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=01ZFTCIyyQzgA
 Hksv3qc3gSyHc/JhAe1EDSU5BMpnWU=; b=HJqxTCCX9R7O2BHVHYRR+lj4FRkVS
 YAgftqKHdOLsP0PRQjbhgfkdEGmAqrxHHhQxETD5N/Ss5+oVtHCDktRgYDUirQBB
 bEnsItxXxNednuEFwYF+hdSpak2vuAOmI0F81fm1BD43BW9YS+aOcDYsErgzW8V1
 DvAKsRX7nH1QUqSzwHDD7e5BjqqaQcmiKsKXRbxLm47JK4i13U/+gKIGjaK2rqTV
 POzz4o1QuCEUwopeXUXgEw2JZ4lbQkXXB1tpmZDKOiH8RLR+wfAyImnpIgBN+6vj
 zVY5olbUYPwjY8gQr5t7LXYlKQmW8dpQ9QEi+959TdthZyR8QjkkEegAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=01ZFTCIyyQzgAHksv3qc3gSyHc/JhAe1EDSU5BMpnWU=; b=GCiliY/P
 zuzRsyTn/ARtM+bUlaouoaGYGlQe74SlpjfMFhrbjfTcX9clELJ50Sdct98ONocu
 APN+q0qdJoqbY4jX2eq9cTevr8YdaNlJTIYHLnlhESx7fzVdYCkhd8wpaldqcyU8
 28sPEWaxbfL2la7LMd2grLoQf8ewB4neXyf8jEEGgeE04csp+XaNZpQf1ctqoe4h
 Hokj5L6UPtYILMyedQCGhkM87ws3WPhdDBzQk9JxD1a09kROM4X+yUUPS54hjwMD
 I+AtYcMbs1wUYKhH9Rit1iqToe7H4Wjr7UpQ/LEnA6jKy1PblvDzWGAPQzJUfin1
 jhmdw2II/9sYDA==
X-ME-Sender: <xms:p17fXelJTa65gH6ptKwuhzmufdQMzOuz-bFfWZhvmykT7fl-5mjZCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeiiedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
 jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
 hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
 pedt
X-ME-Proxy: <xmx:p17fXRkEqtTFVdASkoFUysEXbAHtx3t3iDmP-obFmw93idnWX7jyQg>
 <xmx:p17fXfYFjGD9sNY-HP0SxIpOJvNrNau3JFH4NJdEE2q8kMoRNhf2uQ>
 <xmx:p17fXYmMp6sNQz4fanub9o9qklNOGeqqqGk3g4UXt673-dvhw8isCw>
 <xmx:p17fXfw9y1ddQpYAzI9dZPDDqtKKm_rgZoWdCFWpxOJXobnYodiOdg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3743C8005A;
 Thu, 28 Nov 2019 00:44:04 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 1/4] target/arm: Remove redundant scaling of nexttick
Date: Thu, 28 Nov 2019 16:15:24 +1030
Message-Id: <20191128054527.25450-2-andrew@aj.id.au>
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

The corner-case codepath was adjusting nexttick such that overflow
wouldn't occur when timer_mod() scaled the value back up. Remove a use
of GTIMER_SCALE and avoid unnecessary operations by calling
timer_mod_ns() directly.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
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
2.20.1


