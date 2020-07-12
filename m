Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20DCC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9601720674
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 23:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9601720674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1julhc-0003a5-Rq
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 19:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julfC-00072g-Ov
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1julf6-0007FF-U2
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 19:45:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2661728|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.196332-0.00398669-0.799682; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01l07440; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.I0oni3i_1594597526; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I0oni3i_1594597526) by smtp.aliyun-inc.com(10.147.40.7);
 Mon, 13 Jul 2020 07:45:27 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/8] Implement blfoat16 in softfloat
Date: Mon, 13 Jul 2020 07:45:13 +0800
Message-Id: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 19:45:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, wenmeng_zhang@c-sky.com,
 richard.henderson@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As bfloat16 is more and more popular in many archs, implement bfloat16
interfaces in softfloat, so that archs can add their bfloat16 insns
based on the blfoat16 interfaces here.

This patch set is more copy of float16 than really define new
interfaces or implementations.

Any thoughts are welcomed!

LIU Zhiwei (8):
  fpu/softfloat: fix up float16 nan recognition
  fpu/softfloat: use the similiar logic to recognize sNaN and qNaN
  fpu/softfloat: add FloatFmt for bfloat16
  fpu/softfloat: add pack and unpack interfaces for bfloat16
  fpu/softfloat: define brain floating-point types
  fpu/softfloat: define operation for bfloat16
  fpu/softfloat: define covert operation for bfloat16
  fpu/softfloat: define misc operation for bfloat16

 fpu/softfloat-specialize.inc.c |  50 ++++-
 fpu/softfloat.c                | 393 ++++++++++++++++++++++++++++++++-
 include/fpu/softfloat-types.h  |   8 +
 include/fpu/softfloat.h        | 133 +++++++++++
 4 files changed, 577 insertions(+), 7 deletions(-)

-- 
2.23.0


