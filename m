Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBFAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 23:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916E12070B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 23:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsDzj-00060w-Tz
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 19:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cathy.zhang@intel.com>)
 id 1jsDy8-0003Px-KN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 19:22:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:47201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cathy.zhang@intel.com>)
 id 1jsDy6-0008Iy-QX
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 19:22:44 -0400
IronPort-SDR: PmsqneBd7UKdOe9Nk/FplRm1NYy7aDybWSWc3Zfq6OdFQOrOOi4eSjQALhPMUffr+GXz8RYQXd
 RamSEpTmBXxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127412309"
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; d="scan'208";a="127412309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 16:22:33 -0700
IronPort-SDR: 1xpNScLW0FeXHaUUCP8DNurqsKXwztWRVBE1GM0pCNqbJDq0n2VFMJM014eD/6phjX3dVnimem
 GoIyRQq2wiJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; d="scan'208";a="388044995"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.238.156.127])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2020 16:22:34 -0700
From: Cathy Zhang <cathy.zhang@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/i386: Enable TSX Suspend Load Address Tracking
 feature
Date: Mon,  6 Jul 2020 07:17:16 +0800
Message-Id: <1593991036-12183-3-git-send-email-cathy.zhang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593991036-12183-1-git-send-email-cathy.zhang@intel.com>
References: <1593991036-12183-1-git-send-email-cathy.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.151; envelope-from=cathy.zhang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 19:22:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Cathy Zhang <cathy.zhang@intel.com>, pbonzini@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This instruction aims to give a way to choose which memory accesses
do not need to be tracked in the TSX read set, which is defined as
CPUID.(EAX=7,ECX=0):EDX[bit 16].

The release spec link is as follows:
https://software.intel.com/content/dam/develop/public/us/en/documents/\
architecture-instruction-set-extensions-programming-reference.pdf

The associated kvm patch link is as follows:
https://lore.kernel.org/patchwork/patch/1268026/

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92716f4..256a9a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -987,7 +987,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
-            NULL, NULL, NULL /* pconfig */, NULL,
+            "tsx-ldtrk", NULL, NULL /* pconfig */, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", "core-capability", "ssbd",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3ef1123..155972b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -779,6 +779,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
 /* SERIALIZE instruction */
 #define CPUID_7_0_EDX_SERIALIZE         (1U << 14)
+/* TSX Suspend Load Address Tracking instruction */
+#define CPUID_7_0_EDX_TSX_LDTRK         (1U << 16)
 /* Speculation Control */
 #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
 /* Single Thread Indirect Branch Predictors */
-- 
1.8.3.1


