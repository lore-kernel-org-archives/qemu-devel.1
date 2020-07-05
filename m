Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B3C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 23:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388212070B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 23:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388212070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsDyr-0004i2-FS
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 19:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cathy.zhang@intel.com>)
 id 1jsDy7-0003Pj-0Y
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 19:22:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:47203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cathy.zhang@intel.com>)
 id 1jsDy4-0008JT-3J
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 19:22:42 -0400
IronPort-SDR: wbWzaOcBxL8b2F2m0nabkeLBEqlac9peVESLWE+Q5nLW58J49HIJzs/glhLT5+V1Lk8l0VMxSp
 jiOwl0cN5CTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127412308"
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; d="scan'208";a="127412308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 16:22:32 -0700
IronPort-SDR: owIgXnEnycUTI/OUAluS49bm4mQ4p8m6bE0U/JHEa8OwEwv8GHczAD0qgJIODHc2Lqswm+mZ7m
 ADgfpmM/G77g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; d="scan'208";a="388044992"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.238.156.127])
 by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2020 16:22:32 -0700
From: Cathy Zhang <cathy.zhang@intel.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/i386: Add SERIALIZE cpu feature
Date: Mon,  6 Jul 2020 07:17:15 +0800
Message-Id: <1593991036-12183-2-git-send-email-cathy.zhang@intel.com>
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

The availability of the SERIALIZATION instruction is indicated
by the presence of the CPUID feature flag SERIALIZE, which is
defined as CPUID.(EAX=7,ECX=0):ECX[bit 14].

The release spec link is as follows:
https://software.intel.com/content/dam/develop/public/us/en/documents/\
architecture-instruction-set-extensions-programming-reference.pdf

The associated kvm patch link is as follows:
https://lore.kernel.org/patchwork/patch/1268025/

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 36cbd3d..92716f4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -986,7 +986,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
             NULL, NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "serialize", NULL,
             NULL, NULL, NULL /* pconfig */, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7d77efd..3ef1123 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -777,6 +777,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
 /* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
 #define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
+/* SERIALIZE instruction */
+#define CPUID_7_0_EDX_SERIALIZE         (1U << 14)
 /* Speculation Control */
 #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
 /* Single Thread Indirect Branch Predictors */
-- 
1.8.3.1


