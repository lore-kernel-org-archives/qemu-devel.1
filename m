Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B963C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 04:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9047320789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 04:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047320789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQNcw-0004LI-DT
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 00:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1kQNaY-00030X-5h
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 00:31:34 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:52998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chengang@emindsoft.com.cn>)
 id 1kQNaV-0003ur-76
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 00:31:33 -0400
Received: from localhost (unknown [192.168.167.16])
 by lucky1.263xmail.com (Postfix) with ESMTP id D4B8EC974E;
 Thu,  8 Oct 2020 12:31:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.30.214.76])
 by smtp.263.net (postfix) whith ESMTP id
 P30220T139797897148160S1602131473193031_; 
 Thu, 08 Oct 2020 12:31:26 +0800 (CST)
X-UNIQUE-TAG: <9ca2866c13437ba1c64229f912200d3d>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: riku.voipio@iki.fi
X-SENDER-IP: 111.30.214.76
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: chengang@emindsoft.com.cn
To: riku.voipio@iki.fi,
	laurent@vivier.eu
Subject: [PATCH] linux-user: target: signal: Support TARGET_SS_AUTODISARM
Date: Thu,  8 Oct 2020 12:31:05 +0800
Message-Id: <20201008043105.21058-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=211.157.147.133;
 envelope-from=chengang@emindsoft.com.cn; helo=lucky1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 00:31:26
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add definitions to pass building.

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 linux-user/alpha/target_signal.h  | 6 ++++++
 linux-user/hppa/target_signal.h   | 5 +++++
 linux-user/mips/target_signal.h   | 6 ++++++
 linux-user/mips64/target_signal.h | 5 +++++
 linux-user/sparc/target_signal.h  | 6 ++++++
 5 files changed, 28 insertions(+)

diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index cd63d59fde..241e207815 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -93,4 +93,10 @@ typedef struct target_sigaltstack {
 #define TARGET_GEN_SUBRNG7     -25
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
+
+/* bit-flags */
+#define TARGET_SS_AUTODISARM (1U << 31) /* disable sas during sighandling */
+/* mask for all SS_xxx flags */
+#define TARGET_SS_FLAG_BITS  TARGET_SS_AUTODISARM
+
 #endif /* ALPHA_TARGET_SIGNAL_H */
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index c2a0102ed7..2c9d4e611e 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -66,4 +66,9 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ	2048
 #define TARGET_SIGSTKSZ		8192
 
+/* bit-flags */
+#define TARGET_SS_AUTODISARM (1U << 31) /* disable sas during sighandling */
+/* mask for all SS_xxx flags */
+#define TARGET_SS_FLAG_BITS  TARGET_SS_AUTODISARM
+
 #endif /* HPPA_TARGET_SIGNAL_H */
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 66e1ad44a6..4fdf15e279 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -73,4 +73,10 @@ typedef struct target_sigaltstack {
 /* compare linux/arch/mips/kernel/signal.c:setup_frame() */
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #endif
+
+/* bit-flags */
+#define TARGET_SS_AUTODISARM (1U << 31) /* disable sas during sighandling */
+/* mask for all SS_xxx flags */
+#define TARGET_SS_FLAG_BITS  TARGET_SS_AUTODISARM
+
 #endif /* MIPS_TARGET_SIGNAL_H */
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index 753e91fbd6..93c64df3b7 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -68,4 +68,9 @@ typedef struct target_sigaltstack {
 #define TARGET_MINSIGSTKSZ    2048
 #define TARGET_SIGSTKSZ       8192
 
+/* bit-flags */
+#define TARGET_SS_AUTODISARM (1U << 31) /* disable sas during sighandling */
+/* mask for all SS_xxx flags */
+#define TARGET_SS_FLAG_BITS  TARGET_SS_AUTODISARM
+
 #endif /* MIPS64_TARGET_SIGNAL_H */
diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index 5cc40327d2..a465d699d2 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -68,4 +68,10 @@ typedef struct target_sigaltstack {
 #define TARGET_SIGSTKSZ		16384
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
+
+/* bit-flags */
+#define TARGET_SS_AUTODISARM (1U << 31) /* disable sas during sighandling */
+/* mask for all SS_xxx flags */
+#define TARGET_SS_FLAG_BITS  TARGET_SS_AUTODISARM
+
 #endif /* SPARC_TARGET_SIGNAL_H */
-- 
2.24.0.308.g228f53135a




