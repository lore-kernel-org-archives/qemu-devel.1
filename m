Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED3BC43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC85212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC85212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbHW-00047a-3I
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbD5-0007jM-Fh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:54365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbD3-00041U-Oe
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:31 -0400
IronPort-SDR: KINNilbLm2cmYAQ3nj9zMCCr3jq3a/VzMjddxAQVuLmb7v8kO/nQzV4QzYuaAx5z4HeDIW0kmR
 jlgnbmJx1b+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="250751928"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="250751928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:28 -0700
IronPort-SDR: y0rsCka7ZOivCmYZ0nQ8VYhSpxqZHAoRKgjMVeAFPO2aC7frjBXh86RaAInhtZ+NkOLBf5hD97
 Rhp/LeijCigg==
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="521323042"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:27 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 04/10] Fix the qemu crash when guest shutdown in COLO mode
Date: Wed, 14 Oct 2020 15:25:50 +0800
Message-Id: <20201014072555.12515-5-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014072555.12515-1-chen.zhang@intel.com>
References: <20201014072555.12515-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:28:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=2.199, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Zhang Chen <chen.zhang@intel.com>, "Rao, Lei" <lei.rao@intel.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Rao, Lei" <lei.rao@intel.com>

In COLO mode, if the startup parameters of QEMU include "no-shutdown",
QEMU will crash when the guest shutdown. The root cause is when the
guest shutdown, the state of VM will switch COLO to SHUTDOWN. When do
checkpoint again, the state will be changed to COLO. But the state
switch is undefined in runstate_transitions_def, we should add it.
This patch fixes the following:
qemu-system-x86_64: invalid runstate transition: 'shutdown' -> 'colo'
Aborted

Signed-off-by: leirao <lei.rao@intel.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 softmmu/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5a11a62f78..bafe7c5b70 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -632,6 +632,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
     { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_SHUTDOWN, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_SHUTDOWN, RUN_STATE_COLO },
 
     { RUN_STATE_DEBUG, RUN_STATE_SUSPENDED },
     { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
-- 
2.17.1


