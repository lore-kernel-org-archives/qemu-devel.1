Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D075DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9E2207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FfpgKeRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9E2207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tSQ-0000TK-Pw
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1k5tRS-00082Z-B8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:17:30 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:48202)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1k5tRL-0000r1-1q
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=qJV28RWeXXmja64yCO
 d/BOEjJm7qSWkzCUC8qTqUSb0=; b=FfpgKeRKWFxsRrx9NNrBrE5Y7hIHOH53XJ
 oezCwMMSKDlPno2OFkWv9H9hzSfFCxjEllbe5WRK5YLDGE4GGyu5+/VhOOCkciY+
 PFaw2D7eFn1Kap93BaCHuw/mV/LtzlZ2/Zt62Wjuzp/Rx8xAN/x/Z+U297XYy4ZZ
 hIyYHiQ/8=
Received: from localhost.localdomain (unknown [115.204.177.14])
 by smtp1 (Coremail) with SMTP id GdxpCgAH5Qz7FTRfW6WfAQ--.825S4;
 Thu, 13 Aug 2020 00:17:00 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: kraxel@redhat.com
Subject: [PATCH 0/2] hw: ehci: fix two minor issues
Date: Wed, 12 Aug 2020 09:16:59 -0700
Message-Id: <20200812161659.29305-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgAH5Qz7FTRfW6WfAQ--.825S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5jjyUUUUU
X-Originating-IP: [115.204.177.14]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTx1+bVsGVhBhKwAAsQ
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 11:32:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are two minor issues in echi controller.
The detail is in the patch.

Li Qiang (2):
  hw: ehci: destroy sglist in error path
  hw: ehci: check return value of 'usb_packet_map'

 hw/usb/hcd-ehci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.17.1


