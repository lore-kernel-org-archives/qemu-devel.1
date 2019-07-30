Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBB3C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96250206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96250206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUcw-0001qD-RB
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hsUZd-0005Rs-RH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hsUZb-0005Zm-Hz
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:02:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:53310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hsUZZ-0005Y8-Mj; Tue, 30 Jul 2019 12:01:59 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hsUZT-0001RG-68; Tue, 30 Jul 2019 19:01:51 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 19:01:38 +0300
Message-Id: <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full before
 ioctl call
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, ehabkost@redhat.com,
 kvm@vger.kernel.org, mtosatti@redhat.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not the whole structure is initialized before passing it to the KVM.
Reduce the number of Valgrind reports.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dbbb137..ed57e31 100644
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
@@ -3477,6 +3479,7 @@ static int kvm_put_debugregs(X86CPU *cpu)
         return 0;
     }
 
+    memset(&dbgregs, 0, sizeof(dbgregs));
     for (i = 0; i < 4; i++) {
         dbgregs.db[i] = env->dr[i];
     }
-- 
1.8.3.1


