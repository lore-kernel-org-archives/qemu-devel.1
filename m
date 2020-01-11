Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA73C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 15:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF04206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 15:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF04206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqJ81-0005yE-QA
	for qemu-devel@archiver.kernel.org; Sat, 11 Jan 2020 10:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iqJ1B-0004nN-NG
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 10:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iqJ1A-0005q8-DA
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 10:49:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50515 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iqJ1A-0005kH-50
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 10:49:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 0A9BF1A1FDA;
 Sat, 11 Jan 2020 16:49:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E5A921A1187;
 Sat, 11 Jan 2020 16:49:37 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/19] linux-user: Add support for KCOV_<ENABLE|DISABLE>
 ioctls
Date: Sat, 11 Jan 2020 16:40:40 +0100
Message-Id: <1578757241-29583-19-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578757241-29583-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1578757241-29583-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

KCOV_ENABLE and KCOV_DISABLE play the role in kernel coverage
tracing. These ioctls do not use the third argument of ioctl()
system call and are straightforward to implement in QEMU.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 5 +++++
 linux-user/syscall.c      | 3 +++
 linux-user/syscall_defs.h | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index d72cd76..39b3825 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -552,3 +552,8 @@
   IOCTL_IGNORE(TIOCSTART)
   IOCTL_IGNORE(TIOCSTOP)
 #endif
+
+#ifdef CONFIG_KCOV
+  IOCTL(KCOV_ENABLE, 0, TYPE_NULL)
+  IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 171c0ca..6edcb0d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -73,6 +73,9 @@
 #ifdef CONFIG_SENDFILE
 #include <sys/sendfile.h>
 #endif
+#ifdef CONFIG_KCOV
+#include <sys/kcov.h>
+#endif
 
 #define termios host_termios
 #define winsize host_winsize
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 225dcfb..87e390d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2457,6 +2457,10 @@ struct target_mtpos {
 #define TARGET_MTIOCGET        TARGET_IOR('m', 2, struct target_mtget)
 #define TARGET_MTIOCPOS        TARGET_IOR('m', 3, struct target_mtpos)
 
+/* kcov ioctls */
+#define TARGET_KCOV_ENABLE     TARGET_IO('c', 100)
+#define TARGET_KCOV_DISABLE    TARGET_IO('c', 101)
+
 struct target_sysinfo {
     abi_long uptime;                /* Seconds since boot */
     abi_ulong loads[3];             /* 1, 5, and 15 minute load averages */
-- 
2.7.4


