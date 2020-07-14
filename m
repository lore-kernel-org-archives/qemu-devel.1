Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C75A21897
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C75A21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGWN-0003Uf-Ay
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jvGU3-0007mT-FC
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:40:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:43779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jvGTz-0002ZL-DJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:40:15 -0400
IronPort-SDR: PFPqKxIJbo8+Nt7Y9j5pD4sHmx7ImIbhcGCFqoVqAwVSYiPRW7C5YA2g5W1OrZooMlRew1I8VR
 sWwdJHSsV5xQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128407139"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="128407139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 01:40:10 -0700
IronPort-SDR: tbMOYftRXr70ITZnjJYrGMCyEzeLo5t2VnsnAQnGoljP5Pty/072IK88UEEaoLYU8MbRWwKCUh
 DSUL2TDnSgIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="299464851"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 01:40:08 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v6 2/3] target/i386: fix model number and add missing features
 for Icelake-Server CPU model
Date: Tue, 14 Jul 2020 16:41:47 +0800
Message-Id: <20200714084148.26690-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714084148.26690-1-chenyi.qiang@intel.com>
References: <20200714084148.26690-1-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=chenyi.qiang@intel.com; helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 04:40:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the missing features(sha_ni, avx512ifma, rdpid, fsrm,
vmx-rdseed-exit, vmx-pml, vmx-eptp-switching) and change the model
number to 106 in the Icelake-Server-v4 CPU model.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 target/i386/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 55e063babe..6afc59d8ff 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3512,6 +3512,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "sha-ni", "on" },
+                    { "avx512ifma", "on" },
+                    { "rdpid", "on" },
+                    { "fsrm", "on" },
+                    { "vmx-rdseed-exit", "on" },
+                    { "vmx-pml", "on" },
+                    { "vmx-eptp-switching", "on" },
+                    { "model", "106" },
+                    { /* end of list */ }
+                },
+            },
             { /* end of list */ }
         }
     },
-- 
2.17.1


