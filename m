Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A892C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABC920735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 06:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABC920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNt2Z-0003tn-GO
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 02:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cathy.zhang@intel.com>) id 1jNt21-0003VA-BL
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cathy.zhang@intel.com>) id 1jNt1z-0005BW-Jm
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:57:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:34271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cathy.zhang@intel.com>)
 id 1jNt1z-00059n-6n
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 02:57:19 -0400
IronPort-SDR: BGsi1Nj3q1KGbO1pPurngzL2+wNBBT265X6F1lApbhgPd8Z/VMXj5ADMRrhAOSwstw7AkPskGv
 SP8+dJo9bzZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2020 23:57:10 -0700
IronPort-SDR: Lr7knNyBEDv3IuwB+Yr7uZp02UD3fJvELuabZgNEkn5IhQP5+CF7DKV51f8IU5sM0GeDGBwcRT
 7yai+tzj0cwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; d="scan'208";a="270992545"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.238.156.101])
 by orsmga002.jf.intel.com with ESMTP; 12 Apr 2020 23:57:08 -0700
From: Cathy Zhang <cathy.zhang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH] x86/cpu: Enable AVX512_VP2INTERSECT cpu feature
Date: Mon, 13 Apr 2020 14:52:38 +0800
Message-Id: <1586760758-13638-1-git-send-email-cathy.zhang@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: qemu-devel@nongnu.org, cathy.zhang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AVX512_VP2INTERSECT compute vector pair intersection to a pair
of mask registers, which is introduced with intel Tiger Lake,
defining as CPUID.(EAX=7,ECX=0):EDX[bit 08].

Refer to the following release spec:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa2..c8c95c3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1078,7 +1078,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
             NULL, NULL, NULL, NULL,
-            NULL, NULL, "md-clear", NULL,
+            "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL /* pconfig */, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309..5c34795 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -770,6 +770,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
 /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
+/* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
+#define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
 /* Speculation Control */
 #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
 /* Single Thread Indirect Branch Predictors */
-- 
1.8.3.1


