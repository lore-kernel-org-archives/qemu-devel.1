Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17979C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 04:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B581A206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 04:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="TQ20b1eK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjtlUuFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B581A206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifcZR-0005I5-Pt
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 23:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ifcXw-0003Oe-MO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 23:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ifcXv-0003Gt-JO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 23:27:20 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ifcXs-00035M-EX; Thu, 12 Dec 2019 23:27:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id F12AD877;
 Thu, 12 Dec 2019 23:27:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 12 Dec 2019 23:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=PqgLhpy94OGx/TZUhKr14ouSOm
 hNdalV2V/031LW2zc=; b=TQ20b1eKD9tveMzCEHh14gs1nOP7CDus0iJBcem7JE
 W1N7fTq9QC0oDxCMbs6FNEE1OhD/64Ch1F6UnpKqjDF/8hY0BzxrKATiazH5I+5l
 7+7cPTCKOIhdo5JuqIKD7E1JG6UlfAcOdihS04W2IBcdG0gD5QSgiMmBxW0LMRd2
 5zrP1TPkwu51xCEShImCDtEL791aVNEPcUBX9+Dhca2PDdcyxJG6r1BIMKjo9/wf
 19UXE6s3vxWhnVopngjgYU0LCD73aOH9iKUyl1EbUUxr1MSWxeFYVUDGl2gsj549
 aOcQh90rGX1AUy3cVLnOW3/Q1Cmw8u+iklmFYnaFnwNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=PqgLhpy94OGx/TZUh
 Kr14ouSOmhNdalV2V/031LW2zc=; b=fjtlUuFiyE4jIDZ3KSWKN1GNKe9+zXfZm
 fpuP9YIwMCvdP62UyS9WOJ/YmQ2PQou19V02LzHCds9lM377pStfrYuRA6C3wJ0S
 GaY0d4NCUix9qK7H+fJj+fHrn6SL6o2ZPNxSojamgDODokHiaOLzWz56OcY/tv9x
 C03n3B3z+Jtf3VnV4XdXxEy8tzDjcsKni/YjWp/yNz7pEeGaYGE1EdC/KQCAt/0W
 Gfh5AsckbHI4xOAHn7NCTpGFIi5T6gtMA8Hwjdjqm4p/tVgwh1DTLP7Jn/mQcgXw
 xMMuIDkfMxONihV7+doR+dinxwSJ6FMPeMfCdHRQhL8RTSyeGG6wA==
X-ME-Sender: <xms:IBPzXdlMrB_MOnDJmOfb4k3215zaCAUKop6ZXCqZ9uuOZU0IZ0xsxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
 ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtvddrke
 durddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhi
 ugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:IBPzXdGjmPDFsEAobpPH6MTrWKJcPrJ6djzR77tzJVexEs8ywzDpVA>
 <xmx:IBPzXepygpgOXjWZ9tol5MBD-fwWJB_WkSjZZSk2Eq4R4pR7aCHJKQ>
 <xmx:IBPzXR4zgA3paZxElv-tetBNg92gcVenbawa1JC1IedWwyGkBGx-_g>
 <xmx:IRPzXd0yGcDmFYHjWxycXSVzfZ5W3zuaQCEK9nZAzpvOFVyM6l1DRQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 79FA980063;
 Thu, 12 Dec 2019 23:27:10 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] hw/arm: ast2600: Wire up eMMC controller
Date: Fri, 13 Dec 2019 14:58:40 +1030
Message-Id: <cover.fc3e5e495d85ebd919c1f06a1a2c7c7730518f9c.1576211124.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The AST2600 has an additional SDHCI intended for use as an eMMC boot source.
These two patches rework the existing ASPEED SDHCI model to accommodate the
single-slot nature of the eMMC controller and wire it into the AST2600 SoC.

v2 contains some minor refactorings in response to issues pointed out by
Cedric.

v1 can be found here:

https://patchwork.ozlabs.org/cover/1206845/

Please review!

Andrew

Andrew Jeffery (2):
  hw/sd: Configure number of slots exposed by the ASPEED SDHCI model
  hw/arm: ast2600: Wire up the eMMC controller

 hw/arm/aspeed.c              | 27 +++++++++++++++++----------
 hw/arm/aspeed_ast2600.c      | 23 +++++++++++++++++++++++
 hw/arm/aspeed_soc.c          |  2 ++
 hw/sd/aspeed_sdhci.c         | 11 +++++++++--
 include/hw/arm/aspeed_soc.h  |  2 ++
 include/hw/sd/aspeed_sdhci.h |  1 +
 6 files changed, 54 insertions(+), 12 deletions(-)

base-commit: 6a4ef4e5d1084ce41fafa7d470a644b0fd3d9317
-- 
git-series 0.9.1

