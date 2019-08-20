Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793EEC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5C920C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5C920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyDz-000332-PJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8L-0005bP-Im
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8K-0003C5-Fu
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8K-0003BO-AA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 913618D6CAA;
 Tue, 20 Aug 2019 07:00:43 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F552BABE;
 Tue, 20 Aug 2019 07:00:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:32 +0200
Message-Id: <1566284395-30287-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 20 Aug 2019 07:00:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/36] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Not the whole structure is initialized before passing it to the KVM.
Reduce the number of Valgrind reports.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a66b956..ce3f1c3 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -190,6 +190,7 @@ static int kvm_get_tsc(CPUState *cs)
         return 0;
     }
 
+    memset(&msr_data, 0, sizeof(msr_data));
     msr_data.info.nmsrs = 1;
     msr_data.entries[0].index = MSR_IA32_TSC;
     env->tsc_valid = !runstate_is_running();
@@ -1706,6 +1707,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     if (has_xsave) {
         env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
+        memset(env->xsave_buf, 0, sizeof(struct kvm_xsave));
     }
 
     max_nested_state_len = kvm_max_nested_state_length();
@@ -3488,6 +3490,7 @@ static int kvm_put_debugregs(X86CPU *cpu)
         return 0;
     }
 
+    memset(&dbgregs, 0, sizeof(dbgregs));
     for (i = 0; i < 4; i++) {
         dbgregs.db[i] = env->dr[i];
     }
-- 
1.8.3.1



