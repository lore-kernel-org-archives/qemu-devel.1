Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B97C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E9D20CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=megamailservers.eu header.i=@megamailservers.eu header.b="LHvuE5zA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E9D20CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=o2online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydrm-0002za-CM
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rsta2@o2online.de>) id 1iydr2-0001uU-C5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rsta2@o2online.de>) id 1iydr1-000210-Do
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:41:40 -0500
Received: from mail202c50.megamailservers.eu ([91.136.10.212]:41086
 helo=mail193c50.megamailservers.eu)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rsta2@o2online.de>)
 id 1iydqy-0001uu-PP; Mon, 03 Feb 2020 10:41:37 -0500
X-Authenticated-User: 017626146082@o2online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
 s=maildub; t=1580744488;
 bh=ASa/+tFb77XKSveJBl+gykVAL1X0h+vCrAKuRTkNbfo=;
 h=From:To:Cc:Subject:Date:From;
 b=LHvuE5zAl/+b41w2TI56SHGE52NQHNFIYvBTRbCRvo2ZG137JM3NahoEpemaiMbOR
 fstQ1/4CVY4POxCl6gTKFx/g0r14q4KekiELdKQqMiL7NLSyAJIr42cqZHP8uvKvgn
 vfu1VjcA37dtBcjt69wHHa2jvGUBnkdSK0IoZ/KM=
Feedback-ID: rsta2@o2online.
Received: from desktop2.localnet (178-21-1-177.ilmprovider.net [178.21.1.177])
 (authenticated bits=0)
 by mail193c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 013FfQsG009440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Feb 2020 15:41:27 +0000
From: Rene Stange <rsta2@o2online.de>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: [PATCH v2 0/2] bcm2835_dma: Fix TD mode
Date: Mon, 03 Feb 2020 16:40:03 +0100
Message-ID: <2357909.uYzqtL8Sc2@desktop2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CTCH-RefID: str=0001.0A0B0211.5E383F28.0042, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC: 0
X-CHA: v=2.3 cv=SamJicZu c=1 sm=1 tr=0 a=oFQkuSNlBNCQRuITVo1IXg==:117
 a=oFQkuSNlBNCQRuITVo1IXg==:17 a=kj9zAlcOel0A:10 a=c27POuBx5ChD24pRu1kA:9
 a=CjuIK1q_8ugA:10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 91.136.10.212
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Andrew Baumann <andrew.baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

this v2 patch splits the initial fix into two commits as suggested.

Regards,

Rene


Rene Stange (2):
  bcm2835_dma: Fix the ylen loop in TD mode
  bcm2835_dma: Re-initialize xlen in TD mode

 hw/dma/bcm2835_dma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.16.4





