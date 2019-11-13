Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C14C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3C0206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C0206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvl7-0002Te-CZ
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iUvit-0000v6-TO
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iUvis-0005kx-Gw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:42:27 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35073 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iUvir-0005TM-Un
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:42:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 957A01A22B9;
 Wed, 13 Nov 2019 17:41:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 60A881A22A8;
 Wed, 13 Nov 2019 17:41:20 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.0 2/6] linux-user: Add set and read for rtc time and
 alarm using ioctls
Date: Wed, 13 Nov 2019 17:41:07 +0100
Message-Id: <1573663271-31519-3-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573663271-31519-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1573663271-31519-1-git-send-email-Filip.Bozuta@rt-rk.com>
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
Cc: laurent@viver.eu, Filip.Bozuta@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h        |  4 ++++
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/syscall_types.h | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 97741c7..ff1cdd2 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -77,6 +77,10 @@
      IOCTL(RTC_PIE_OFF, 0, TYPE_NULL)
      IOCTL(RTC_WIE_ON, 0, TYPE_NULL)
      IOCTL(RTC_WIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_ALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_ALM_READ, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_RD_TIME, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_SET_TIME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f91579a..2298547 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -772,6 +772,10 @@ struct target_pollfd {
 #define TARGET_RTC_PIE_OFF          TARGET_IO('p', 0x06)
 #define TARGET_RTC_WIE_ON           TARGET_IO('p', 0x0f)
 #define TARGET_RTC_WIE_OFF          TARGET_IO('p', 0x10)
+#define TARGET_RTC_ALM_SET          TARGET_IOW('p', 0x07, struct rtc_time)
+#define TARGET_RTC_ALM_READ         TARGET_IOR('p', 0x08, struct rtc_time)
+#define TARGET_RTC_RD_TIME          TARGET_IOR('p', 0x09, struct rtc_time)
+#define TARGET_RTC_SET_TIME         TARGET_IOW('p', 0x0a, struct rtc_time)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e36983..a35072a 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -255,6 +255,17 @@ STRUCT(blkpg_partition,
        MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
        MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
 
+STRUCT(rtc_time,
+       TYPE_INT, /* tm_sec */
+       TYPE_INT, /* tm_min */
+       TYPE_INT, /* tm_hour */
+       TYPE_INT, /* tm_mday */
+       TYPE_INT, /* tm_mon */
+       TYPE_INT, /* tm_year */
+       TYPE_INT, /* tm_wday */
+       TYPE_INT, /* tm_yday */
+       TYPE_INT) /* tm_isdst */
+
 STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* op */
        TYPE_INT, /* flags */
-- 
2.7.4


