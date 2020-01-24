Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9235BC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8552071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8552071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1DA-0006sW-De
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1CM-0005Yo-41
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1CK-0006MV-Nk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43546 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iv1CK-0005x5-FP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:48:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 299331A1FE9;
 Fri, 24 Jan 2020 16:47:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id EE38B1A2006;
 Fri, 24 Jan 2020 16:47:34 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] linux-user: Add support for FS_IOC_FS<GET|SET>XATTR
 ioctls
Date: Fri, 24 Jan 2020 16:47:16 +0100
Message-Id: <1579880839-31466-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
index 73dcc76..9fb9d6f 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -173,6 +173,13 @@
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
index 9b61ae8..ed5068f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -966,6 +966,12 @@ struct target_rtc_pll_info {
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


