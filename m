Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E59C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC022072B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 23:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC022072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49495 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isE7a-0003mQ-Ii
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 18:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isDz1-0008O9-Lh
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 17:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isDyz-0002hP-9Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 17:51:23 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53722 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1isDyy-0002fZ-Vg
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 17:51:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BDA721A20CB;
 Thu, 16 Jan 2020 23:50:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A19BE1A21C1;
 Thu, 16 Jan 2020 23:50:12 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/12] linux-user: Add support for FS_IOC_FS<GET|SET>XATTR
 ioctls
Date: Thu, 16 Jan 2020 23:49:43 +0100
Message-Id: <1579214991-19602-5-git-send-email-aleksandar.markovic@rt-rk.com>
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

Both FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR accept a pointer to
the structure

struct fsxattr {
    __u32         fsx_xflags;     /* xflags field value (get/set) */
    __u32         fsx_extsize;    /* extsize field value (get/set)*/
    __u32         fsx_nextents;   /* nextents field value (get)	*/
    __u32         fsx_projid;     /* project identifier (get/set) */
    __u32         fsx_cowextsize; /* CoW extsize field value (get/set)*/
    unsigned char fsx_pad[8];
};

as their third argument.

These ioctls were relatively recently introduced, so the "#ifdef"
guards are used in this implementation.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 7 +++++++
 linux-user/syscall_defs.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3affd88..e1b89a7 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -144,6 +144,13 @@
      IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
+#ifdef FS_IOC_FSGETXATTR
+     IOCTL(FS_IOC_FSGETXATTR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_fsxattr)))
+#endif
+#ifdef FS_IOC_FSSETXATTR
+     IOCTL(FS_IOC_FSSETXATTR, IOC_W, MK_PTR(MK_STRUCT(STRUCT_fsxattr)))
+#endif
+
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a73cc3d..e1663b6 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -924,6 +924,12 @@ struct target_pollfd {
 #define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
 #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
+#ifdef FS_IOC_FSGETXATTR
+#define TARGET_FS_IOC_FSGETXATTR TARGET_IOR('X', 31, struct fsxattr)
+#endif
+#ifdef FS_IOC_FSSETXATTR
+#define TARGET_FS_IOC_FSSETXATTR TARGET_IOR('X', 32, struct fsxattr)
+#endif
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.7.4


