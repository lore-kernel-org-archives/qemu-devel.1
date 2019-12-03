Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E806C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D7A20665
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 04:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="W9Ga0kap";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOQ9gAUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7A20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibzaY-00078l-Rd
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 23:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ibzYy-0005by-BZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ibzYx-00018O-6R
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 23:13:24 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ibzYs-00011e-TO; Mon, 02 Dec 2019 23:13:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 61CB25C3;
 Mon,  2 Dec 2019 23:13:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 02 Dec 2019 23:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=QNsQgXYGYrk1YAopBqhxivrkfW
 0hwxhGi//jQO/OV+Y=; b=W9Ga0kapNxAUI7CfChi/1lwKgYjYSBTH0ke+a0x9mt
 W8EV/L/YRFjKWsHATsaL0VAO+9By4PIq+bfInCeLgxNjIYdtEb38mof0d08MhnNi
 VioBEZvDe4BPvbagcCJ40wK1H4p2ONK1TPkQds7HQbQMmnlKSUn7d7ZGblzabqas
 3/vHWDoBGpuB/r9Ltva0ZhOkZuf/jLXqFm7zj/QQIaIlI2IHgGcdzsVOg1D1ip+6
 EopWiRgdaNfmmOaamvoIxyljgn/DDTZGW0Yotb8QXbVrD+HrE0WAjcENPzE9XAXN
 AhN6g0IfHoMNkJc0o53WFZqiTc/lShloI88lTYNPRdhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QNsQgX
 YGYrk1YAopBqhxivrkfW0hwxhGi//jQO/OV+Y=; b=DOQ9gAUdeYVmcEArki+n0s
 ZJ1PpLNZ3CohTIiRNfNuJsk3SFbHoIpY+RsGoWdHbpEMRJp05XQot6Hhn9x96PaL
 lA2uYVD9zHD6g0FsEr1BomSNp7QIbE0/rZN6b/cKY6vorEkgp9zXwRepNEu2pFZh
 VTxDy3WY+dJGnMXPn5zDd/eUDzA0NxTs8SLnagcLY+MlO9NztWB5VP6Pv11zmXSm
 2LAJUENoxAAnhBQn7yMOQoHe71VJe1gZzoyC+SQAh10FH8JUwAtd7IwpWbmx17E9
 m06DcCn6US75U6AYUrp30Ab79//3gM74yiJvxc6InYX876ORQJYqpqfMMlzY3ZKw
 ==
X-ME-Sender: <xms:3ODlXWvJg59mVE4tmkfkfSVlsnd0ZbWUdkGIqfvJ5EOea4iD7__8LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejiedgieeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertd
 ertdejnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
 rdhiugdrrghuqeenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedvtddvrd
 ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
 ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:3ODlXXkvldWrsRnehIqTvkR4sUQP-JB-6Rgt-eoqMPG6URPhhvNKfw>
 <xmx:3ODlXbAIDWi9ZYklof8qiOt-1xGOXnSlkx0GPceoOahMYL-zwA8-7A>
 <xmx:3ODlXQQ4fvm8PEb1BiCdIhDe5KynaWV__IDiEYuju7_EFp0FvDYFlw>
 <xmx:3eDlXfnvgVoD4cvUovxfGYf21M0WRT9Expj960Us3--SdHRObs_TDQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1497B8005A;
 Mon,  2 Dec 2019 23:13:13 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 0/4] Expose GT CNTFRQ as a CPU property to support AST2600
Date: Tue,  3 Dec 2019 14:44:36 +1030
Message-Id: <20191203041440.6275-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This is a v2 of the belated follow-up from a few of my earlier attempts to fix
up the ARM generic timer for correct behaviour on the ASPEED AST2600 SoC. The
AST2600 clocks the generic timer at the rate of HPLL, which is configured to
1125MHz.  This is significantly quicker than the currently hard-coded generic
timer rate of 62.5MHz and so we see "sticky" behaviour in the guest.

v1 can be found here:

https://patchwork.ozlabs.org/cover/1201887/

Changes since v1:

* Fix a user mode build failure from partial renaming of gt_cntfrq_period_ns()
* Add tags from Cedric and Richard

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


