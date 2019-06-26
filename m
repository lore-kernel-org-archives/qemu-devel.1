Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDB8C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CF820644
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CF820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAxm-0003DO-Th
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58994)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paul.c.lai@intel.com>) id 1hgAsQ-0006XL-St
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paul.c.lai@intel.com>) id 1hgAsP-0001XU-Sx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:34:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:42189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <paul.c.lai@intel.com>)
 id 1hgAsP-0001Tj-KH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:34:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Jun 2019 09:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; d="scan'208";a="164012735"
Received: from pclaidev.sc.intel.com ([143.183.85.146])
 by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2019 09:34:25 -0700
From: Paul Lai <paul.c.lai@intel.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 09:32:32 -0700
Message-Id: <20190626163232.25711-1-paul.c.lai@intel.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: [Qemu-devel] Add SPLIT_LOCK DETECT capability to SnowRidge (SNR)
 cpu model
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
Cc: wei.w.wang@intel.com, luwei.kang@intel.com, tao3.xu@intel.com,
 paul.c.lai@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SPLIT_LOCK DETECT is enabled in qemu patch:
  x86: define a new MSR based feature word -- FEAT_CORE_CAPABILITY
and kernel patch series that includes:
  x86/split_lock: Align x86_capability to unsigned long to avoid split locked
access

WAITPKG (UMONITOR/UMWAIT/TPAUSE) supplied in:
      x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE
are turned off by default, so not added to this cpu model.

Signed-off-by: Paul Lai <paul.c.lai@intel.com>
Tested-by: Tao3 Xu <tao3.xu@intel.com>

---
Changes in v4:
	Add SPLIT_LOCK DETECT capability to SnowRidge (SNR) cpu model
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c96f032f03..63d89276fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2739,7 +2739,10 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_ECX_MOVDIR64B,
         .features[FEAT_7_0_EDX] =
             CPUID_7_0_EDX_SPEC_CTRL |
-            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
+            CPUID_7_0_EDX_CORE_CAPABILITY,
+        .features[FEAT_CORE_CAPABILITY] =
+            MSR_CORE_CAP_SPLIT_LOCK_DETECT,
         /*
          * Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
-- 
2.17.2


