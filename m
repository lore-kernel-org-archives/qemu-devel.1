Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AAC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD3E22CEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD3E22CEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VLB-0003lm-Br
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utx-0001gv-FO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Uts-000885-4g
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44152 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i5Utr-0007RO-M9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5D9D71A1DCC;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2EFAD1A20C7;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 14:59:23 +0200
Message-Id: <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v6 3/8] linux-user: Add support for FIOGETOWN
 and FIOSETOWN ioctls
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FIOGETOWN and FIOSETOWN ioctls have platform-specific definitions,
hence non-standard definition in QEMU too.

Other than that, they both have a single integer argument, and their
functionality is emulated in a straightforward way.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index cd9b6f9..1830de9 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -177,6 +177,8 @@
 #endif
 #endif /* CONFIG_USBFS */
 
+  IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 19a1d39..498223b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -758,10 +758,14 @@ struct target_pollfd {
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
+#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
+#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
 #define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
+#define TARGET_FIOGETOWN       0x8903
+#define TARGET_FIOSETOWN       0x8901
 #define TARGET_SIOCATMARK      0x8905
 #define TARGET_SIOCSPGRP       0x8902
 #define TARGET_SIOCGPGRP       0x8904
-- 
2.7.4


