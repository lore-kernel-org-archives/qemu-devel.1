Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF7CA9ECB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 01:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0391720650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 01:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0391720650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQM1m-00073L-5G
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 21:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iQM0u-0006Uw-0e
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 21:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iQM0r-00055r-S5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 21:46:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:28146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iQM0q-0004td-Li
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 21:46:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Oct 2019 18:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400"; d="scan'208";a="206283499"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2019 18:45:58 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
Subject: [PATCH] target/i386: return directly from hyperv_init_vcpu() if
 hyperv not enabled
Date: Fri,  1 Nov 2019 09:45:28 +0800
Message-Id: <20191101014528.14505-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If hyperv is not enabled, related features are not set or enabled.

No extra work to do, return directly.

---
First time touch hyperv, hope my understanding is correct.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bfd09bd441..6532904f0c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1365,6 +1365,9 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     Error *local_err = NULL;
     int ret;
 
+    if (!hyperv_enabled(cpu))
+        return 0;
+
     if (cpu->hyperv_passthrough && hv_passthrough_mig_blocker == NULL) {
         error_setg(&hv_passthrough_mig_blocker,
                    "'hv-passthrough' CPU flag prevents migration, use explicit"
-- 
2.17.1


