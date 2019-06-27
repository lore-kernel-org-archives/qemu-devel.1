Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0158DC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF8E205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF8E205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXG1-0006gU-2x
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgWOl-0001iC-Af
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgWOe-0006fV-Hm
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:33:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56542 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hgWOS-0005nV-AU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:33:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 874D41A4566;
 Thu, 27 Jun 2019 17:32:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5CB741A4562;
 Thu, 27 Jun 2019 17:32:08 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Thu, 27 Jun 2019 17:31:48 +0200
Message-Id: <1561649510-21183-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v14 3/5] linux-user: Fix flock structure for
 MIPS O64 ABI
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Only MIPS O32 and N32 have special (different than other
architectures) definition of structure flock in kernel.

Bring flock definition for MIPS O64 ABI to the correct state,
which is currently different than the most common definition,
and it should be the same.

Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/generic/fcntl.h     | 2 +-
 linux-user/mips/target_fcntl.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index a775a49..1b48dde 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -129,7 +129,7 @@ struct target_flock {
     short l_whence;
     abi_long l_start;
     abi_long l_len;
-#if defined(TARGET_MIPS)
+#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
     abi_long l_sysid;
 #endif
     int l_pid;
diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
index 000527c..795bba7 100644
--- a/linux-user/mips/target_fcntl.h
+++ b/linux-user/mips/target_fcntl.h
@@ -27,7 +27,11 @@
 #define TARGET_F_SETOWN        24       /*  for sockets. */
 #define TARGET_F_GETOWN        23       /*  for sockets. */
 
+#if (TARGET_ABI_BITS == 32)
 #define TARGET_ARCH_FLOCK_PAD abi_long pad[4];
+#else
+#define TARGET_ARCH_FLOCK_PAD
+#endif
 #define TARGET_ARCH_FLOCK64_PAD
 
 #define TARGET_F_GETLK64       33      /*  using 'struct flock64' */
-- 
2.7.4


