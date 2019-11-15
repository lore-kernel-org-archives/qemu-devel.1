Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AEEC43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC6A2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC6A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVat5-0006Eq-KP
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVan4-0007ow-G1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVan3-0003JR-72
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50515 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iVan2-00030a-SZ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AEFFC1A21F9;
 Fri, 15 Nov 2019 13:32:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 797581A1E43;
 Fri, 15 Nov 2019 13:32:23 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 for 5.0 2/6] linux-user: Add support for read/set RTC time
 and alarm using ioctls
Date: Fri, 15 Nov 2019 13:32:12 +0100
Message-Id: <1573821136-30219-3-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573821136-30219-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1573821136-30219-1-git-send-email-Filip.Bozuta@rt-rk.com>
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

This patch implements functionalities of following ioctls:

RTC_RD_TIME - Read RTC time

    Returns this RTC's time in the following structure:

        struct rtc_time {
            int tm_sec;
            int tm_min;
            int tm_hour;
            int tm_mday;
            int tm_mon;
            int tm_year;
            int tm_wday;     /* unused */
            int tm_yday;     /* unused */
            int tm_isdst;    /* unused */
        };

    The fields in this structure have the same meaning and ranges
    as for the tm structure described in gmtime man page.  A pointer
    to this structure should be passed as the third ioctl's argument.

RTC_SET_TIME - Set RTC time

    Sets this RTC's time to the time specified by the rtc_time
    structure pointed to by the third ioctl's argument.  To set
    the RTC's time the process must be privileged (i.e., have the
    CAP_SYS_TIME capability).

RTC_ALM_READ, RTC_ALM_SET - Read/Set alarm time

    Read and set the alarm time, for RTCs that support alarms.
    The alarm interrupt must be separately enabled or disabled
    using the RTC_AIE_ON, RTC_AIE_OFF requests.  The third
    ioctl's argument is a pointer to an rtc_time structure.  Only
    the tm_sec, tm_min, and tm_hour fields of this structure are
    used.

Implementation notes:

    All ioctls in this patch have pointer to a structure rtc_time
    as their third argument. That is the reason why corresponding
    definition is added in linux-user/syscall_types.h. Since all
    elements of this structure are of type 'int', the rest of the
    implementation is straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h        |  4 ++++
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/syscall_types.h | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 97741c7..f472794 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -77,6 +77,10 @@
      IOCTL(RTC_PIE_OFF, 0, TYPE_NULL)
      IOCTL(RTC_WIE_ON, 0, TYPE_NULL)
      IOCTL(RTC_WIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_ALM_READ, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_ALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_RD_TIME, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_SET_TIME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f91579a..f0bf09d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -772,6 +772,10 @@ struct target_pollfd {
 #define TARGET_RTC_PIE_OFF          TARGET_IO('p', 0x06)
 #define TARGET_RTC_WIE_ON           TARGET_IO('p', 0x0f)
 #define TARGET_RTC_WIE_OFF          TARGET_IO('p', 0x10)
+#define TARGET_RTC_ALM_READ         TARGET_IOR('p', 0x08, struct rtc_time)
+#define TARGET_RTC_ALM_SET          TARGET_IOW('p', 0x07, struct rtc_time)
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


