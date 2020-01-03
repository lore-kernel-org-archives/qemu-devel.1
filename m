Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24634C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 22:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FFE215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 22:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FFE215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inVLS-0003hd-EH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 17:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1inVHr-0006z4-3N
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 17:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1inVHp-000876-7s
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 17:19:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53918 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1inVHo-00080u-Uk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 17:19:17 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 5F8EE1A2210;
 Fri,  3 Jan 2020 23:18:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 184661A21B9;
 Fri,  3 Jan 2020 23:18:10 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/12] linux-user: Add support for
 FS_IOC32_<GET|SET>VERSION ioctls
Date: Fri,  3 Jan 2020 23:17:55 +0100
Message-Id: <1578089882-3587-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578089882-3587-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1578089882-3587-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

These FS_IOC32_<GET|SET>VERSION ioctls are identical to
FS_IOC_<GET|SET>VERSION ioctls, but without the anomaly of their
number defined as if their third argument is of type long, while
it is treated internally in kernel as is of type int.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 4fd6939..3affd88 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -142,6 +142,8 @@
      IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 964b2b4..a73cc3d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -922,6 +922,8 @@ struct target_pollfd {
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
 #define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, int)
 #define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
+#define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
+#define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.7.4


