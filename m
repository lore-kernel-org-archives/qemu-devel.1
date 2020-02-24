Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09788C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C8B2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C8B2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Dz1-0003Ua-S2
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 08:41:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1j6Dxy-0001qz-RN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1j6Dxv-0004Jy-6y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:21090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1j6Dxu-0004Ja-V8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:40:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 05:40:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; d="scan'208";a="284354772"
Received: from snr.bj.intel.com ([10.240.193.90])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 05:40:02 -0800
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH v1 3/3] i386: Mark the 'INTEL_PT' CPUID bit as unmigratable
Date: Tue, 25 Feb 2020 05:38:32 +0800
Message-Id: <1582580312-19864-4-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org,
 beeman.strong@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After expose all the capabilities of Intel PT to KVM guest, the guest Intel
PT CPUID information may difference with same guest cpu model on differnt
hardware. It will block the live migration. This patch will mark the Intel
PT feature as unmigratable.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4d9e203..caee8b1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1024,6 +1024,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .reg = R_EBX,
         },
         .tcg_features = TCG_7_0_EBX_FEATURES,
+        .unmigratable_flags = CPUID_7_0_EBX_INTEL_PT,
     },
     [FEAT_7_0_ECX] = {
         .type = CPUID_FEATURE_WORD,
-- 
1.8.3.1


