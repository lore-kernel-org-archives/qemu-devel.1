Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6233C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7908520673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7908520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxQJp-0004qA-Nb
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 02:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hxQJQ-0004QN-5G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hxQJP-0006z6-41
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:29:40 -0400
Received: from thoth.sbs.de ([192.35.17.2]:48446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hxQJO-0006wY-QH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:29:39 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x7D6TYrF021230
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2019 08:29:34 +0200
Received: from [167.87.5.105] ([167.87.5.105])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x7D6TXxS009720;
 Tue, 13 Aug 2019 08:29:33 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <776d4705-f554-0c57-b231-ac66056d99f6@siemens.com>
Date: Tue, 13 Aug 2019 08:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.2
Subject: [Qemu-devel] [PATCH] kvm: vmxcap: Enhance with latest features
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on SDM from May 2019.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/kvm/vmxcap | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 99a8146aaa..d8c7d6dfb8 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -178,7 +178,11 @@ controls = [
             19: 'Conceal non-root operation from PT',
             20: 'Enable XSAVES/XRSTORS',
             22: 'Mode-based execute control (XS/XU)',
+            23: 'Sub-page write permissions',
+            24: 'GPA translation for PT',
             25: 'TSC scaling',
+            26: 'User wait and pause',
+            28: 'ENCLV exiting',
             },
         cap_msr = MSR_IA32_VMX_PROCBASED_CTLS2,
         ),
@@ -197,6 +201,7 @@ controls = [
             22: 'Save VMX-preemption timer value',
             23: 'Clear IA32_BNDCFGS',
             24: 'Conceal VM exits from PT',
+            25: 'Clear IA32_RTIT_CTL',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -214,6 +219,7 @@ controls = [
             15: 'Load IA32_EFER',
             16: 'Load IA32_BNDCFGS',
             17: 'Conceal VM entries from PT',
+            18: 'Load IA32_RTIT_CTL',
             },
         cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
@@ -227,6 +233,7 @@ controls = [
             6: 'HLT activity state',
             7: 'Shutdown activity state',
             8: 'Wait-for-SIPI activity state',
+            14: 'PT in VMX operation',
             15: 'IA32_SMBASE support',
             (16,24): 'Number of CR3-target values',
             (25,27): 'MSR-load/store count recommendation',
@@ -249,6 +256,7 @@ controls = [
             17: '1GB EPT pages',
             20: 'INVEPT supported',
             21: 'EPT accessed and dirty flags',
+            22: 'Advanced VM-exit information for EPT violations',
             25: 'Single-context INVEPT',
             26: 'All-context INVEPT',
             32: 'INVVPID supported',
-- 
2.16.4

