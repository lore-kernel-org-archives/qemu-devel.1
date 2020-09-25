Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F4C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 02:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C402075F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 02:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C402075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLdK2-0000uY-DT
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 22:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colin.xu@intel.com>)
 id 1kLdJW-0000Uq-Ji
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 22:18:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:26280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colin.xu@intel.com>)
 id 1kLdJT-0004je-US
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 22:18:22 -0400
IronPort-SDR: Ey4CNbyRwB4q+YorXaB1dyBm3dWdvc8prrWq8ZoOXpLNglVmUp9cTi8+UUhcZm3r6hTonXdQP4
 k3Rf/RUltghg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="162306440"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="162306440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 19:18:11 -0700
IronPort-SDR: N5cMB49TnerwnmHefpmB4SIt36A06SS8kjiU0KtgFLyZRXfVn/q2vGQP76REMWCaF2Ph3G4aH1
 GAzsP5yeMGVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="511893828"
Received: from unknown (HELO coxu-arch-shz.sh.intel.com) ([10.239.160.21])
 by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2020 19:18:10 -0700
From: Colin Xu <colin.xu@intel.com>
To: kraxel@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH] input-linux: Reset il->fd handler before closing it
Date: Fri, 25 Sep 2020 10:18:08 +0800
Message-Id: <20200925021808.26471-1-colin.xu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=colin.xu@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 22:18:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Cc: qemu-devel@nongnu.org, colin.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If object-del input-linux object on-the-fly, instance finalize will
close evdev fd without resetting it. However the main thread is still
trying to lock_acquire/lock_release during ppoll, which leads to a very
high CPU utilization.

Signed-off-by: Colin Xu <colin.xu@intel.com>
---
 ui/input-linux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/input-linux.c b/ui/input-linux.c
index ab351a418701..34cc531190f9 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -418,6 +418,7 @@ static void input_linux_instance_finalize(Object *obj)
 
     if (il->initialized) {
         QTAILQ_REMOVE(&inputs, il, next);
+        qemu_set_fd_handler(il->fd, NULL, NULL, NULL);
         close(il->fd);
     }
     g_free(il->evdev);
-- 
2.28.0


