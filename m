Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F75C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 07:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207F521D43
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 07:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207F521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJXl1-0006io-8u
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 03:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kJTXj-0002A2-Vf
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:28:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:53068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kJTXi-0007c2-6w
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 23:28:07 -0400
IronPort-SDR: D6+qoVcVp3TS7XLhj08kRYyg5fxFoqEEYWln7cnMRk+p9H+Ga4ZUI7VPu9WWIDqpVF4TevHAty
 rvyv4baioOWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="139574095"
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; d="scan'208";a="139574095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 20:28:04 -0700
IronPort-SDR: gFc/VIGXIb9rGDnpQDn9uowc6hCDC58XOX4qeePT8WRgd8EXW2SbFGaeXspjhOo/a+lcHN5naa
 WPsMTV2G84sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; d="scan'208";a="303579340"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.192.103])
 by orsmga003.jf.intel.com with ESMTP; 18 Sep 2020 20:28:02 -0700
From: leirao <lei.rao@intel.com>
To: chen.zhang@intel.com, lizhijian@cn.fujitsu.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com
Subject: [PATCH 3/3] Fix the qemu crash when guest shutdown in COLO mode
Date: Fri, 18 Sep 2020 23:10:23 -0400
Message-Id: <1600485023-263643-4-git-send-email-lei.rao@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600485023-263643-1-git-send-email-lei.rao@intel.com>
References: <1600485023-263643-1-git-send-email-lei.rao@intel.com>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=lei.rao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 23:27:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2020 03:55:13 -0400
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
Cc: leirao <lei.rao@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In COLO mode, if the startup parameters of QEMU include "no-shutdown",
QEMU will crash when the guest shutdown. The root cause is when the
guest shutdown, the state of VM will switch COLO to SHUTDOWN. When do
checkpoint again, the state will be changed to COLO. But the state
switch is undefined in runstate_transitions_def, we should add it.
This patch fixes the following:
qemu-system-x86_64: invalid runstate transition: 'shutdown' -> 'colo'
Aborted

Signed-off-by: leirao <lei.rao@intel.com>
---
 softmmu/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index f7b1034..c21606c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -631,6 +631,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
     { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_SHUTDOWN, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_SHUTDOWN, RUN_STATE_COLO },
 
     { RUN_STATE_DEBUG, RUN_STATE_SUSPENDED },
     { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
-- 
1.8.3.1


