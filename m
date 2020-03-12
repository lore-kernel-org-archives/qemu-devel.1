Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C294C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481F520578
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 08:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481F520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJXg-0002AZ-EO
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 04:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1jCJX8-0001ZR-Ki
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1jCJX6-0005EA-Sf
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:49:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:6651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1jCJX6-0005AY-LG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 04:49:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 01:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; d="scan'208";a="236569414"
Received: from snr.bj.intel.com ([10.240.193.90])
 by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2020 01:49:29 -0700
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH v2] target/i386: set the CPUID level to 0x14 on old
 machine-type
Date: Fri, 13 Mar 2020 00:48:06 +0800
Message-Id: <1584031686-16444-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUID level need to be set to 0x14 manually on old
machine-type if Intel PT is enabled in guest. E.g. the
CPUID[0].EAX(level)=7 and CPUID[7].EBX[25](intel-pt)=1 when the
Qemu with "-machine pc-i440fx-3.1 -cpu qemu64,+intel-pt" parameter.

Some Intel PT capabilities are exposed by leaf 0x14 and the
missing capabilities will cause some MSRs access failed.
This patch add a warning message to inform the user to extend
the CPUID level.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
v1->v2:
- Mask off Intel PT when the CPUID level < 0x14, not only a warning.
  qemu-system-x86_64: warning: Intel PT need CPUID leaf 0x14, please set by "-cpu ...,+intel-pt,level=0x14": CPUID.07H:EBX.intel-pt [bit 25]
- Remove the checking of kvm_enabled() because it is unnecessary.

 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 306d50a..cab44c5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6302,9 +6302,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
 
         /* Intel Processor Trace requires CPUID[0x14] */
-        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
-             kvm_enabled() && cpu->intel_pt_auto_level) {
-            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
+            if (cpu->intel_pt_auto_level) {
+                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+            } else if (cpu->env.cpuid_min_level < 0x14) {
+                mark_unavailable_features(cpu, FEAT_7_0_EBX,
+                    CPUID_7_0_EBX_INTEL_PT,
+                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,level=0x14\"");
+            }
         }
 
         /* CPU topology with multi-dies support requires CPUID[0x1F] */
-- 
1.8.3.1


