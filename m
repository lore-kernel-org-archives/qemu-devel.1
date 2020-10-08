Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07898C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 04:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EFA20789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 04:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EFA20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQNVw-00087B-Je
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 00:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1kQNUj-0007DL-8b
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 00:25:33 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:43458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1kQNUf-0001gt-CB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 00:25:32 -0400
Received: from localhost (unknown [192.168.167.8])
 by lucky1.263xmail.com (Postfix) with ESMTP id 3A972EF1F0;
 Thu,  8 Oct 2020 12:25:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.30.214.76])
 by smtp.263.net (postfix) whith ESMTP id
 P2452T140206445422336S1602131103681870_; 
 Thu, 08 Oct 2020 12:25:18 +0800 (CST)
X-UNIQUE-TAG: <6b4f0a22e018b87b7eb2b0dc47b5f28d>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: laurent@vivier.eu
X-SENDER-IP: 111.30.214.76
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: laurent@vivier.eu,
	riku.voipio@iki.fi
Subject: [PATCH] linux-user: signal: Support TARGET_SS_AUTODISARM
Date: Thu,  8 Oct 2020 12:25:01 +0800
Message-Id: <20201008042501.16857-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.132;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 00:25:19
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Chen Gang <chengang@emindsoft.com.cn>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <chengang@emindsoft.com.cn>

Microsoft sqlserver 2017 x86_64 uses it. The implementation references
from the linux kernel.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/generic/signal.h |  6 ++++++
 linux-user/signal.c         | 23 ++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/linux-user/generic/signal.h b/linux-user/generic/signal.h
index e1083f8fba..943bc1a1e2 100644
--- a/linux-user/generic/signal.h
+++ b/linux-user/generic/signal.h
@@ -54,4 +54,10 @@
 #define TARGET_SIG_BLOCK          0    /* for blocking signals */
 #define TARGET_SIG_UNBLOCK        1    /* for unblocking signals */
 #define TARGET_SIG_SETMASK        2    /* for setting the signal mask */
+
+/* bit-flags */
+#define TARGET_SS_AUTODISARM (1U << 31) /* disable sas during sighandling */
+/* mask for all SS_xxx flags */
+#define TARGET_SS_FLAG_BITS  TARGET_SS_AUTODISARM
+
 #endif
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 8cf51ffecd..b5f04ae160 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -263,6 +263,10 @@ int on_sig_stack(unsigned long sp)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
 
+    if (ts->sigaltstack_used.ss_flags & TARGET_SS_AUTODISARM) {
+        return 0;
+    }
+
     return (sp - ts->sigaltstack_used.ss_sp
             < ts->sigaltstack_used.ss_size);
 }
@@ -293,8 +297,13 @@ void target_save_altstack(target_stack_t *uss, CPUArchState *env)
     TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     __put_user(ts->sigaltstack_used.ss_sp, &uss->ss_sp);
-    __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
+    __put_user(ts->sigaltstack_used.ss_flags, &uss->ss_flags);
     __put_user(ts->sigaltstack_used.ss_size, &uss->ss_size);
+    if (ts->sigaltstack_used.ss_flags & TARGET_SS_AUTODISARM) {
+        ts->sigaltstack_used.ss_sp = 0;
+        ts->sigaltstack_used.ss_size = 0;
+        ts->sigaltstack_used.ss_flags = TARGET_SS_DISABLE;
+    }
 }
 
 /* siginfo conversion */
@@ -768,7 +777,7 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
     {
         __put_user(ts->sigaltstack_used.ss_sp, &oss.ss_sp);
         __put_user(ts->sigaltstack_used.ss_size, &oss.ss_size);
-        __put_user(sas_ss_flags(sp), &oss.ss_flags);
+        __put_user(ts->sigaltstack_used.ss_flags, &oss.ss_flags);
     }
 
     if(uss_addr)
@@ -776,6 +785,7 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
         struct target_sigaltstack *uss;
         struct target_sigaltstack ss;
         size_t minstacksize = TARGET_MINSIGSTKSZ;
+        int ss_mode;
 
 #if defined(TARGET_PPC64)
         /* ELF V2 for PPC64 has a 4K minimum stack size for signal handlers */
@@ -799,10 +809,12 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
             goto out;
 
         ret = -TARGET_EINVAL;
-        if (ss.ss_flags != TARGET_SS_DISABLE
-            && ss.ss_flags != TARGET_SS_ONSTACK
-            && ss.ss_flags != 0)
+        ss_mode = ss.ss_flags & ~TARGET_SS_FLAG_BITS;
+        if (ss_mode != TARGET_SS_DISABLE
+            && ss_mode != TARGET_SS_ONSTACK
+            && ss_mode != 0) {
             goto out;
+        }
 
         if (ss.ss_flags == TARGET_SS_DISABLE) {
             ss.ss_size = 0;
@@ -814,6 +826,7 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
             }
         }
 
+        ts->sigaltstack_used.ss_flags = ss.ss_flags;
         ts->sigaltstack_used.ss_sp = ss.ss_sp;
         ts->sigaltstack_used.ss_size = ss.ss_size;
     }
-- 
2.24.0.308.g228f53135a




