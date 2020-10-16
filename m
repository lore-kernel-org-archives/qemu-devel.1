Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E8C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79022080A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79022080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIkY-0002cB-Oq
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhT-0006JC-48
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:36617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhR-0005C7-Hk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:46 -0400
IronPort-SDR: qhCR6FnwBL6wZT3EqVwYNoZUS4HtPiwbmauTbIMQMhLeJlkn1/dYUTVzPrbEj+ka6eb75Gr45p
 GTGxtlc8We+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="184094655"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="184094655"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:44 -0700
IronPort-SDR: 6ZTsQoFIb753XQyv7gYci9aFzLYF7fHKUBD6MnQmKhUun16t5dF73QHA8aX0cey3YrdbYYa+h7
 wbpyG7A8qKvg==
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="464572829"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:42 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 04/10] Fix the qemu crash when guest shutdown in COLO mode
Date: Fri, 16 Oct 2020 13:52:02 +0800
Message-Id: <20201016055208.7969-5-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201016055208.7969-1-chen.zhang@intel.com>
References: <20201016055208.7969-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:54:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.996,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Derek Su <dereksu@qnap.com>, Zhang Chen <chen.zhang@intel.com>, "Rao,
 Lei" <lei.rao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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

Signed-off-by: Lei Rao <lei.rao@intel.com>
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


