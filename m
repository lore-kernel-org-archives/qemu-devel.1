Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B38AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0280C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0280C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCfP-0007vk-1Y
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa9-0001yF-HY
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:57355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa7-0006bT-LC
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:41 -0400
IronPort-SDR: ZDUrle0MO2D/+wJRqfrsjHnB/Ur3vweJhAQepoaWw/R7rz43HwDKzC49UeIYe36cGw2R2ERWC8
 YP10bORfbHKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162385628"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="162385628"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 22:10:38 -0700
IronPort-SDR: F11YT0Q2xbpycPdedWPh7jUu6EgnjR+AGAvLe3WCvq6dI2hT/FUKNBB1JB8QiPeWs8+4ohux7F
 mZE0aujyF0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="420427137"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 22:10:36 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, sean.j.christopherson@intel.com, qemu-devel@nongnu.org
Subject: [Qemu-devel][PATCH v6 6/6] x86/cpu: Advise CET bits in CPU/MSR
 feature words
Date: Tue, 13 Oct 2020 13:19:35 +0800
Message-Id: <20201013051935.6052-7-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201013051935.6052-1-weijiang.yang@intel.com>
References: <20201013051935.6052-1-weijiang.yang@intel.com>
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=weijiang.yang@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 01:10:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yang Weijiang <weijiang.yang@intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CET SHSTK and IBT feature are enumerated via CPUID.(EAX=07H,ECX=0H):ECX[bit 7]
and EDX[bit 20]. CET state load/restore at vmentry/vmexit are enabled via
VMX_ENTRY_CTLS[bit 20] and VMX_EXIT_CTLS[bit 28].

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5496fd68d4..904bf1d4b6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -965,7 +965,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", "shstk",
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -988,7 +988,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
             "tsx-ldtrk", NULL, NULL /* pconfig */, NULL,
-            NULL, NULL, NULL, NULL,
+            "ibt", NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", "core-capability", "ssbd",
         },
@@ -1250,7 +1250,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "vmx-exit-save-cet-ctl", NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -1265,7 +1265,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, NULL, NULL,
+            "vmx-entry-load-cet-ctl", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-- 
2.26.2


