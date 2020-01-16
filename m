Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5980C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 22:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A658020728
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 22:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A658020728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isE0L-0001cs-72
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 17:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isDyz-0008ML-9g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 17:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isDyx-0002fP-Ql
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 17:51:20 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52004 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1isDyv-00024S-VE
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 17:51:18 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C4EC71A21A0;
 Thu, 16 Jan 2020 23:50:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 2592D1A21BC;
 Thu, 16 Jan 2020 23:50:12 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/12] linux-user: Add support for FS_IOC32_<GET|SET>FLAGS
 ioctls
Date: Thu, 16 Jan 2020 23:49:41 +0100
Message-Id: <1579214991-19602-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

These FS_IOC32_<GET|SET>FLAGS ioctls are identical to
FS_IOC_<GET|SET>FLAGS ioctls, but without the anomaly of their
number defined as if their third argument is of type long, while
it is treated internally in kernel as is of type int.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c44f42e..4fd6939 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -140,6 +140,8 @@
      IOCTL(FS_IOC_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f68a8b6..964b2b4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -920,6 +920,8 @@ struct target_pollfd {
 #define TARGET_FS_IOC_GETVERSION TARGET_IOR('v', 1, abi_long)
 #define TARGET_FS_IOC_SETVERSION TARGET_IOW('v', 2, abi_long)
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
+#define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, int)
+#define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.7.4


