Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A911FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2CB206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2CB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7SK-0000sb-LV
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ7PM-0004jy-VY; Thu, 14 May 2020 02:31:52 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1]:50186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ7PK-0001RW-EK; Thu, 14 May 2020 02:31:51 -0400
Received: from [2a01:4f8:0:a53b:fd81:523d:dd49:b8d4] (helo=hetzner.com)
 by mail.hetzner.company with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89) (envelope-from <raphael.pour@hetzner.com>)
 id 1jZ7PG-0000UC-0B; Thu, 14 May 2020 08:31:46 +0200
From: Raphael Pour <raphael.pour@hetzner.com>
To: Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
Date: Thu, 14 May 2020 08:31:11 +0200
Message-Id: <20200514063112.1457125-1-raphael.pour@hetzner.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <1jYr2L-0004mc-Jj@mail.hetzner.company>
References: <1jYr2L-0004mc-Jj@mail.hetzner.company>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: raphael.pour@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=raphael.pour@hetzner.com; helo=mail.hetzner.company
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Raphael Pour <raphael.pour@hetzner.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

introduced with e6df58a5, stderr won't get closed if the fork option is
set. This causes other processes reading stderr to block infinietly or
crash while relying on EOF.

v2:
  - Instead of closing the inherited stderr in the child, avoid the dup 
    in the parent if the fork option is not set.

Raphael Pour (1):
  qemu-nbd: Close inherited stderr

 qemu-nbd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.4


