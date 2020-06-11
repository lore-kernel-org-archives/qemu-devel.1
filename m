Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 00:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C4A20747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 00:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C4A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjB0H-0003ku-DH
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 20:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jjAzX-0003LD-5t; Wed, 10 Jun 2020 20:22:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:24132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jjAzV-0000y7-Ff; Wed, 10 Jun 2020 20:22:46 -0400
IronPort-SDR: +N7WSepLpNvlE9s1V6vxknTs/KsGMP4pz0h7nThqyEzDCLYZKrzFASViZ+BlmD8xhTUjRcbFAd
 kQvWzWX+liDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 17:22:33 -0700
IronPort-SDR: nQvm1pj/EE0CcpNA3BVf/jF/I9465djAPn5/mlYZGCu5Dtaa/+pS/l6F6jWmRMuxSOd3Lbj8EH
 fMNVOiIngRtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; d="scan'208";a="418930875"
Received: from unknown (HELO localhost.localdomain.sh.intel.com)
 ([10.239.153.142])
 by orsmga004.jf.intel.com with ESMTP; 10 Jun 2020 17:22:31 -0700
From: wentongw <wentong.wu@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/nios2: Update interrupt request when CR_STATUS_PIE disabled
Date: Thu, 11 Jun 2020 04:13:19 -0400
Message-Id: <20200611081319.1864-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wentong.wu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 20:22:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, marex@denx.de, thuth@redhat.com, crwulff@gmail.com,
 wentongw <wentong.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update interrupt request when external interupt pends for STATUS_PIE
disabled. Otherwise on icount enabled nios2 target there will be cpu
abort when guest code changes state register with wrctl instruction.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 hw/nios2/cpu_pic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 1c1989d5..2abc8fa8 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -42,6 +42,8 @@ static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
         } else if (!level) {
             env->irq_pending = 0;
             cpu_reset_interrupt(cs, type);
+        } else {
+            cs->interrupt_request |= type;
         }
     } else {
         if (level) {
-- 
2.21.3


