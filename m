Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1F3C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4465206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4465206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDZA-0007IE-RO
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDY6-0005is-KP
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDY5-0003gl-Mj
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:56665)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1jGDY5-0003gP-EI
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:45 -0400
IronPort-SDR: natrt4NfZs8pxDFTMfJO9EcDUKWQRNGlNYOyEUh26X79FbMzvJubwR4SLT5V+vO5s74Pro4ugo
 UFay3WEqGD6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 20:14:44 -0700
IronPort-SDR: uYur9/pt0qTm1pCiSl2Gb8z6WaZ27QWwAxqe0ET2NSe31lYk6CKbczLb2jDBKy4p6igdDvkzTZ
 9acOqk7HrLcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="292453701"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.161])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2020 20:14:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 3/3] target/i386: Tell why guest exits to user space due to #AC
Date: Mon, 23 Mar 2020 10:56:58 +0800
Message-Id: <20200323025658.4540-4-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323025658.4540-1-xiaoyao.li@intel.com>
References: <20200323025658.4540-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tell why guest exits from kvm to user space due to #AC, so user knows
what happened.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 411402aa29fa..36bc1485d478 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -4464,8 +4464,15 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = -1;
         break;
     case KVM_EXIT_EXCEPTION:
-        fprintf(stderr, "KVM: exception %d exit (error code 0x%x)\n",
-                run->ex.exception, run->ex.error_code);
+        if (run->ex.exception == AC_VECTOR) {
+            fprintf(stderr, "Guest encounters an #AC due to split lock. Because "
+                    "guest doesn't expect this split lock #AC (it doesn't set "
+                    "msr_test_ctrl.split_lock_detect) and host sets "
+                    "split_lock_detect=fatal, guest has to be killed.\n");
+        } else {
+            fprintf(stderr, "KVM: exception %d exit (error code 0x%x)\n",
+                    run->ex.exception, run->ex.error_code);
+        }
         ret = -1;
         break;
     case KVM_EXIT_DEBUG:
-- 
2.20.1


