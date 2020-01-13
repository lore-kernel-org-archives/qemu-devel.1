Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E177C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9AB2187F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9AB2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir6hk-0007hx-DP
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 15:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ir6Tm-0005W5-PA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ir6Tl-00073M-FF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:38:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:47233 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ir6Tl-0006zv-8g
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:38:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8B82A1A1FB3;
 Mon, 13 Jan 2020 21:38:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 727AB1A1F9E;
 Mon, 13 Jan 2020 21:38:26 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/20] linux-user: Add support for FDFMT<BEG|TRK|END> ioctls
Date: Mon, 13 Jan 2020 21:34:39 +0100
Message-Id: <1578947683-21011-17-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls provide means for controlling
formatting of a floppy drive.

FDFMTTRK's third agrument is a pointer to the structure:

struct format_descr {
    unsigned int device,head,track;
};

defined in Linux kernel header <linux/fd.h>.

Since all fields of the structure are of type 'unsigned int', there is
no need to define "target_format_descr".

FDFMTBEG and FDFMTEND ioctls do not use the third argument.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 3 +++
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 9e3ca90..e754a6b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -115,6 +115,9 @@
      IOCTL(FDMSGON, 0, TYPE_NULL)
      IOCTL(FDMSGOFF, 0, TYPE_NULL)
      IOCTL(FDSETEMSGTRESH, 0, TYPE_NULL)
+     IOCTL(FDFMTBEG, 0, TYPE_NULL)
+     IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
+     IOCTL(FDFMTEND, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
      IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
      IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index efe3860..d85ab46 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -899,6 +899,9 @@ struct target_pollfd {
 
 #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
 #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
+#define TARGET_FDFMTBEG       TARGET_IO(2, 0x47)
+#define TARGET_FDFMTTRK      TARGET_IOW(2, 0x48, struct format_descr)
+#define TARGET_FDFMTEND       TARGET_IO(2, 0x49)
 #define TARGET_FDSETEMSGTRESH TARGET_IO(2, 0x4a)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
 #define TARGET_FDSETMAXERRS  TARGET_IOW(2, 0x4c, struct floppy_max_errors)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index e4e0429..8ff78a6 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -261,6 +261,11 @@ STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* datalen */
        TYPE_PTRVOID) /* data */
 
+STRUCT(format_descr,
+       TYPE_INT,     /* device */
+       TYPE_INT,     /* head */
+       TYPE_INT)     /* track */
+
 STRUCT(floppy_max_errors,
        TYPE_INT, /* abort */
        TYPE_INT, /* read_track */
-- 
2.7.4


