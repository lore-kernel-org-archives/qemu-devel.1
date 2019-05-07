Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F76C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D450D20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D450D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNzaL-00021K-Ri
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:52:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hNzZ9-0001Tp-Oo
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hNzZ8-0003Hh-IB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:51:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:34783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hNzZ7-0003BO-WE
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:51:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 05:51:11 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by orsmga005.jf.intel.com with ESMTP; 07 May 2019 05:51:09 -0700
From: Tao Xu <tao3.xu@intel.com>
To: ehabkost@redhat.com,
	rth@twiddle.net,
	pbonzini@redhat.com
Date: Tue,  7 May 2019 20:48:53 +0800
Message-Id: <20190507124853.9015-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH v2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: robert.hu@intel.com, tao3.xu@intel.com, xiaoyao.li@intel.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As noted in
http://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02212.html
Because MSR based feature has been supported by QEMU,
we add CPUID_7_0_EDX_ARCH_CAPABILITIES on Cascadelake-Server CPU
model, and add IA32_ARCH_CAPABILITIES MSR based features (RDCL_NO,
IBRS_ALL and SKIP_L1DFL_VMENTRY).

And "014018e19b i386: Make arch_capabilities migratable" has been
in QEMU upstream, the CPUID_7_0_EDX_ARCH_CAPABILITIES can be
safely added into CPU Model.

Changes in v2:
    - rebased patch to latest qemu base

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/i386/pc.c      | 7 ++++++-
 target/i386/cpu.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d98b737b8f..27c3d25436 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -115,7 +115,12 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
-GlobalProperty pc_compat_4_0[] = {};
+GlobalProperty pc_compat_4_0[] = {
+    { "Cascadelake-Server" "-" TYPE_X86_CPU, "arch-capabilities", "off" },
+    { "Cascadelake-Server" "-" TYPE_X86_CPU, "rdctl-no", "off" },
+    { "Cascadelake-Server" "-" TYPE_X86_CPU, "ibrs-all", "off" },
+    { "Cascadelake-Server" "-" TYPE_X86_CPU, "skip-l1dfl-vmentry", "off" },
+};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
 GlobalProperty pc_compat_3_1[] = {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c5514d4..2aa0a8f9ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2536,7 +2536,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_ECX_PKU |
             CPUID_7_0_ECX_AVX512VNNI,
         .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES,
         /* Missing: XSAVES (not supported by some Linux versions,
                 * including v4.1 to v4.12).
                 * KVM doesn't yet expose any XSAVES state save component,
@@ -2548,6 +2549,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
     },
-- 
2.17.1


