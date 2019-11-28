Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72024C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34980215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="lLUBC5ke";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="meTqPbZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34980215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaCgL-0002Qg-DS
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 00:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iaCb5-0006hT-Ty
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iaCb4-0001lU-Tt
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:11 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iaCb1-0001dI-IH; Thu, 28 Nov 2019 00:44:08 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2B2A322763;
 Thu, 28 Nov 2019 00:44:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 28 Nov 2019 00:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=tpwcyHnQIJvLrT57pGFzeHHaxD
 3LecagW2N1Jk6TFbU=; b=lLUBC5kebFnop+JV4z9WHjM4WBqUfPzHGlAH8vK3x/
 3bx+cgQV8f5clssFQx1NditEMlDUT3yQz00rVFBmIBvGnC12ZhoyH/q8QpDzXssq
 nwns0YxqdHvO6L40+HcAncJu6u0zTQ0ZJrMzaz4ead4bVjvBIxLl+pSVFKM4gkQS
 7rAXFh5Bad5+q2g5Z8zohHKqhPSGhf7+9uhNORoslRRiyStUSWS3qs48DZhi5JlL
 CyLZjM6ABS1b+GSSGOoIOJr8gchpPMddEQxsfKd3CmBjJF9OwZE7ul3qqGii3aD9
 KOms/NCVcgDmSHMeEcMrr146fXmCeCNSgH/b6bTvYv6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tpwcyHnQIJvLrT57p
 GFzeHHaxD3LecagW2N1Jk6TFbU=; b=meTqPbZLpjAyMD3GKapEmKS93oTdd3LEu
 SX/HJ4a+Ok7EyyNkB8jc+qQvAl2yWcqP60INnUXQ4Es0Q7fhnVpjIEEwdRHkTkoq
 IZcczFd0AY/W/wmLOsEYEncnJBPpsutLyHU/y0cbMjl9Nn0tshlW7TgkTby6wqNl
 5bD0QjJEcEMPHetZD1gq4UuAVMEpbseo7+qlEZ0lDNCsZjpKPsbfJTW2mIdBxZfR
 H75OgGbj+440r1n1Y1YNd+KYGsuByQHhdv9YDlxIBo0cOsn333m5rzb7igHVTdsY
 9IQiTyTQjQP/VNc9bFCdcza0YM31aV4Ix3OpildpcJCw6Yaiygr4w==
X-ME-Sender: <xms:pF7fXWki8ke301TsUy9Fmke7F5nm7d5G_KRD2TTNFxWEolTF8sj4Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeiiedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
 ihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilh
 hfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:pF7fXZ6tzfA4iM_LPVJXuOSYCl2Pk7xAX5eYtighUxG0uWWRpeVqJA>
 <xmx:pF7fXf_VpbzBLCNoJ5DvoHdHBHGHy_t_s4dMwi2BcOmFBDwuZdZbKQ>
 <xmx:pF7fXZiUX75fqMXCfXFGFMB9bF5nj0ao8D9GCjaDjg3z5XTwWNNhKQ>
 <xmx:pV7fXXL6zXQ3WMsXrwGrq5ZGdZvszzBBvmN3sY2xr8-MVdZdM4jIag>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 73E1A80062;
 Thu, 28 Nov 2019 00:44:02 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 0/4] Expose GT CNTFRQ as a CPU property to support AST2600
Date: Thu, 28 Nov 2019 16:15:23 +1030
Message-Id: <20191128054527.25450-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
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

Hello,

This is a belated follow-up from a few of my earlier attempts to fix up the
ARM generic timer for correct behaviour on the ASPEED AST2600 SoC. The AST2600
clocks the generic timer at the rate of HPLL, which is configured to 1125MHz.
This is significantly quicker than the currently hard-coded generic timer rate
of 62.5MHz and so we see "sticky" behaviour in the guest.

Please review.

Andrew

Andrew Jeffery (4):
  target/arm: Remove redundant scaling of nexttick
  target/arm: Abstract the generic timer frequency
  target/arm: Prepare generic timer for per-platform CNTFRQ
  ast2600: Configure CNTFRQ at 1125MHz

 hw/arm/aspeed_ast2600.c |  3 +++
 target/arm/cpu.c        | 41 +++++++++++++++++++++++++++++++++--------
 target/arm/cpu.h        | 28 ++++++++++++++++++++++++++++
 target/arm/helper.c     | 24 ++++++++++++++++++------
 4 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.20.1


