Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8EC206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="psiTW247";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DltCjfY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8EC206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibzas-0007OT-8E
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 23:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ibzYz-0005dP-9s
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ibzYy-0001Ai-7P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:25 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ibzYv-00015I-2A; Mon, 02 Dec 2019 23:13:21 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id CE5C2EC1;
 Mon,  2 Dec 2019 23:13:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 02 Dec 2019 23:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 xQZFQojovBLO7NXxKyIwYjcITEQBg1WTDSYEUPbUvsQ=; b=psiTW247RLk6Bn+b
 OHJ5bOJIY8TB3QfJNrWZKWoaqlJH8mcSWBn/vWjFZ/ZgPw8cjt3K8dLeJaJB7NRf
 zyNfEkpZP20Q2oU8zIUkJdy2Fc0mBxaeQAd5U9D5rDPKglmsKR+9PKA2zBPtArZY
 y1o6S0+Yt2Ff2YjEmnmKrYi2pvu7XzlFAgxHad9lHJilgDkNm1MnfuGXqhzo+JwN
 E/z290Nvo9At28xjYL3qS25dv1+booOAgTR+vR49KdyDpr3QNb4+DpsOAc0yivaa
 mpUkN+4yselQnRNTIztQeGzE57EN9P8N3e0wKQZ8dMXV6of2Eh0MhEVZ1H2IuDj1
 jb9aHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=xQZFQojovBLO7NXxKyIwYjcITEQBg1WTDSYEUPbUv
 sQ=; b=DltCjfY/2s8M8DMpmvBsds5dpYyaozh1+KoFQaO1Momh73PY3egzFmyeo
 YWU1Stu/9b8ZR+9KTZmMtzlNmQrm2ZiYQIhzEMO5sXgtup1XeOx1nD5CCngIlnnB
 QQAX7udwxoL+2v2Iu7Gru2sdwma07/PmNhxOTVbrQw1IpISaEPGSn85Z9yDXImBV
 kYo0fcrLvKsQuG0l+DLR7Rd5rLqR37w7ulUxPorU5q/vCAAEwx9a1fOSJjR+sfzo
 3tjTSjnsoUzXNfNtEbyNUU2j5x3X2YQvoVW2GAQcpRwoVjHUCiRW5gVEQg2tWnjT
 iMt/i5nHYr8zeL8zSKPO3idwjo5OQ==
X-ME-Sender: <xms:3-DlXV5zeTb59XZiYUOBuxQVHegQETwjYRdP4lW1Gp8SozqNKrwrtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughr
 vgifucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtd
 dvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:3-DlXX9hBhufnoo0nS34ecerAFcImpaVPaAzfXVsqaptytvYyjYIRg>
 <xmx:3-DlXZfiiSvJqIZDN6NxycnCiEnncGdo3oV8tvxm3PHxvp6VIusxLA>
 <xmx:3-DlXb3Fq7WLWE2ZfhXrsRgNbUQYuaodfqNDZv5FrYOKoIaepyuBJA>
 <xmx:3-DlXfYRO6Jz28nPvS8kBt2-hHD5VOs4ShCwHewgEdeDa39wgyaj8Q>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id D29B48005C;
 Mon,  2 Dec 2019 23:13:16 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 1/4] target/arm: Remove redundant scaling of nexttick
Date: Tue,  3 Dec 2019 14:44:37 +1030
Message-Id: <20191203041440.6275-2-andrew@aj.id.au>
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
2.20.1


