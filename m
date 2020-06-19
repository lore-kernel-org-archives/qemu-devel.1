Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE275207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 07:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE275207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmBVq-0001xe-Vi
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 03:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jmBT3-0005is-FC
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:29:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:38791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1jmBT0-0002VR-0S
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 03:29:41 -0400
IronPort-SDR: HUYBmWafCmmYk7FKooSdZ+IYBjcgd1OjozEn+Bv9wtICBJyxXhUxZdVXzZActkLzIOQC0GTKWk
 ZhgmcgwZbzvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="140406126"
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; d="scan'208";a="140406126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 00:29:35 -0700
IronPort-SDR: yUTo7uHXwSommPblEe8DZ2UqInq71ZP9cZI1Y8gb5ak58JJ1ENJcbZdu8WLQOlQBurboFzZfHp
 tdaiqD5N5wKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; d="scan'208";a="292040613"
Received: from chenyi-pc.sh.intel.com ([10.239.159.72])
 by orsmga002.jf.intel.com with ESMTP; 19 Jun 2020 00:29:33 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v5 2/4] target/i386: add fast short REP MOV support
Date: Fri, 19 Jun 2020 15:31:12 +0800
Message-Id: <20200619073114.24303-3-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619073114.24303-1-chenyi.qiang@intel.com>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=chenyi.qiang@intel.com; helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:29:31
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For CPUs support fast short REP MOV[CPUID.(EAX=7,ECX=0):EDX(bit4)], e.g
Icelake and Tigerlake, expose it to the guest VM.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b309ef3ab..1f3d8db842 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -984,7 +984,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, "avx512-4vnniw", "avx512-4fmaps",
-            NULL, NULL, NULL, NULL,
+            "fsrm", NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL /* pconfig */, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7d77efd9e4..da4e7e656b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -775,6 +775,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
 /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
+/* Fast Short Rep Mov */
+#define CPUID_7_0_EDX_FSRM              (1U << 4)
 /* AVX512 Vector Pair Intersection to a Pair of Mask Registers */
 #define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
 /* Speculation Control */
-- 
2.17.1


