Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C5DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B70A20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="EGANWB7O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUBePxy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70A20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTlR-0002TC-SS
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ieTkS-0001WF-A2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ieTkR-0000Mo-E9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:51:32 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ieTkO-0000LK-Nt; Mon, 09 Dec 2019 19:51:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 609A522721;
 Mon,  9 Dec 2019 19:51:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 09 Dec 2019 19:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=d1dmNORHMlpfYt+AMVjS4Tn/Y9
 CmVlh1D4pT80hKJvA=; b=EGANWB7Okcu9K8aWsEYz4CRdtDGQsxLuLligsRB6ti
 JFImEmY7kDlEp+Aea0styf6bZIaEQIUIfsfOBTnpcnKgy766YU35QCrtAzGFmh01
 d8Yd0wrGpQYPl6/QvidlH51VzQmLxQekMrvuStk3Ar7J9QkzZbQYmvSqLjiGu8kU
 JaDnSrvWwGuVMq4JLNPylWzL64wm2xLkvicumQPal0rYjMO8pbbYNcNtK8bgBXvo
 Sp8yqctwnpO0up5Z5dwWk0Roa3mwziCMRQm+6dQD5MKsZDfgn7LUZf4RwSHXqpp5
 F3e5sTmDtKAAqHa4qDevny6NDncOtOr1lSu5T/Cgk/9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=d1dmNORHMlpfYt+AM
 VjS4Tn/Y9CmVlh1D4pT80hKJvA=; b=dUBePxy4jB+2eJ8N6BIpIwWSdW60BtDH5
 f8GLISfI0IrWei4Zm7/FDjRCuLV7vVnCHkQnE2dRQ9kj+ppmyEK2M9oyhUsvNhmD
 hIKL8oi/Kd9RxgcxKOcj8tYl8Io6VPlPqsyjZzTK709I8fwGziQrzEeUZvFcsY/M
 RNNyAsgJvUS5uHnJka6ta02UT5LCJl0s0qxQSzBY86iqViXIL2ogdlnyqYnpLI49
 jb6XquB8VHtD1+VyfD5G2EDLO+PKHNHdx+tvl2ty3RcOg1zTkLn58mB9D2Yxobwx
 mo9y/QJp/uVkwtsScTlqz77jn2Q2REgEQR54d3Oiy7sxHgjuhkUgw==
X-ME-Sender: <xms:DezuXTDyjHNFYywOLvVtVNjEn483YPNwMxUDr2RuAAu8TtNN-of8TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelvddgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
 ihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilh
 hfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:DezuXQkEf9j6xlgs_gHLWNuS4aW5NgSMIvJbWAeJgG8bjHLR073G3A>
 <xmx:DezuXS1_N2GIT4MIlmUigbvPnfx5x9rFXc0-C5wlD_VaIIuOyvi7lA>
 <xmx:DezuXYhw5BQe376ss99gDzmAOv-EjEEKpq_wmDe0KEygLkqhIqjfTQ>
 <xmx:DuzuXbCX0R4rOKucipTRUdBpaOgbl3c-3hGioVMizG1Pv2JMoskDAQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 145E830600BD;
 Mon,  9 Dec 2019 19:51:22 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 0/2] hw/arm: ast2600: Wire up eMMC controller
Date: Tue, 10 Dec 2019 11:22:49 +1030
Message-Id: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.27
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

The AST2600 has an additional SDHCI intended for use as an eMMC boot source.
These two patches rework the existing ASPEED SDHCI model to accommodate the
single-slot nature of the eMMC controller and wire it into the AST2600 SoC.

Please review!

Andrew

Andrew Jeffery (2):
  hw/sd: Configure number of slots exposed by the ASPEED SDHCI model
  hw/arm: ast2600: Wire up the eMMC controller

 hw/arm/aspeed.c              | 15 ++++++++++++++-
 hw/arm/aspeed_ast2600.c      | 23 +++++++++++++++++++++++
 hw/arm/aspeed_soc.c          |  3 +++
 hw/sd/aspeed_sdhci.c         | 11 +++++++++--
 include/hw/arm/aspeed_soc.h  |  2 ++
 include/hw/sd/aspeed_sdhci.h |  1 +
 6 files changed, 52 insertions(+), 3 deletions(-)

base-commit: 6a4ef4e5d1084ce41fafa7d470a644b0fd3d9317
-- 
git-series 0.9.1

