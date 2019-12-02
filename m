Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41DDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30042071F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30042071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfDV-0003zO-QP
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 01:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ibfCm-0003Dc-OI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ibfCl-0007cH-1V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:29:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:35652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ibfCk-0007b8-Q8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:29:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Dec 2019 22:28:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="360703490"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga004.jf.intel.com with ESMTP; 01 Dec 2019 22:28:57 -0800
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH 1/4] target/i386: Add Denverton-v2 (no MPX) CPU model
Date: Mon,  2 Dec 2019 14:28:48 +0800
Message-Id: <20191202062852.27948-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: tao3.xu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because MPX is being removed from the linux kernel, remove MPX feature
from Denverton.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f518a21a..06a3077f95 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3482,6 +3482,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Atom Processor (Denverton)",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "monitor", "off" },
+                    { "mpx", "off" },
+                    { /* end of list */ },
+                },
+            },
+            { /* end of list */ },
+        },
     },
     {
         .name = "Snowridge",
-- 
2.20.1


