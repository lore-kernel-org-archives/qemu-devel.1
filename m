Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349D1C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096A82467E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096A82467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXxm-0001Vc-7R
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlW-0001P9-GK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlV-0003Bc-4M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:02 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003Ap-RZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:01 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSLAe-1j17KS291M-00Sd6n; Thu, 23 Jan 2020 09:22:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] linux-user: Add support for getting/setting RTC time and
 alarm using ioctls
Date: Thu, 23 Jan 2020 09:22:23 +0100
Message-Id: <20200123082227.2037994-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jEMpOTztBfFIlZTX4txnqWtGcJgh/znkufOiFsPSJx1XFo85WAM
 u77N0FRTgD7eEb/wrjtxl71rfYCGUdHaC6Qg1x7a+qx1Cbp0NRrUWGGb3y/5i97Apult8lE
 l4Yw9LznngNqPByu2hkhj+e3ERgcaV/LapaMuMUph9D1q195AJX83ObagUp5UFKfmCbIeqA
 WPq8+p3xYxdGtPIk7gpwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y1nnBkYg1nk=:F/xRqeTOW3bN7TOuuF40XX
 OK6pYTm2CaGJVqE8HLPuw63D2y2K3ttDMFN7lT2C05bnCoDGX83g1y8Hgnk9n/OGvmoJEc9w0
 r99qCP3ADwXkJw3KtyjOYvY4JJyC6HlxAKtatYZjRu2SNAB/MCnyEbb6zyFZ2cqNlDks05j6d
 Spyhq7IEsARMA14g5MrDz3Dt4GO4R+sklQMEtdBu57d1PrXWKI/9AMlDZBb4vf7emd3co+pUf
 ZpoDU00U6gkbd3CwBNcyOEO/D3MpbpOm+nEcXpVDKHfoLx0OIcmJCdPU+SbWJVtu0j9wba4OB
 IfR5YlkZ45oWJW3BD9mIwlMeYwbCJS/r3JeU9yDBzKX0kxsho9VuBh3+sldDORtgHgi0tbx9F
 e4pSxh+N0eSAmnVWHCuI+0Z+xAT8yKt0nKSnHProU9qztYo04NjZDJYd5lUBBaAW73k6KaP4d
 ObXNhVN9qHoZBfBQHCsG2+4dSuIwvk8IB8U79cci85uuYFNLXUU7Ouvdngk3O1r3izzLpQVWb
 sWcm2NoCWStR2wKLVN7bME9q1YjTKTUtUnKnjLgvPrVqcB3sd/cMrZm57ZTFskiJEmHFu4swt
 wW14/Chy8JKs7vrPAnnrEPXfuzSOOhemkA7H3tlIbsNi9KmHgAXosyQEUb6tT9tlB7EoRd6r+
 6XaC7c6XSKsz38afzYiJrKWeN4+H90dEcOYZJMJW+En+WX8ZasAgrWQQu79MihZuT+GHfi/Pg
 9nmJhcFWcz0P7ET7FU6VK9k8VezBqw7HFXZq98f+MfQ8KULLwT/REbKDcUNhRa84J9Y6GyS7S
 CaaPPAuiqhjzBKA/nPYgwiuQKOxkloHmG+wWqu/CCGRoei0j79FKNDpAEZz4k86MmBRvxyY
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

This patch implements functionalities of following ioctls:

RTC_RD_TIME - Getting RTC time

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
    as the tm structure described in gmtime man page. A pointer
    to this structure should be passed as the third ioctl's argument.

RTC_SET_TIME - Setting RTC time

    Sets this RTC's time to the time specified by the rtc_time
    structure pointed to by the third ioctl's argument. To set
    the RTC's time the process must be privileged (i.e., have the
    CAP_SYS_TIME capability).

RTC_ALM_READ, RTC_ALM_SET - Getting/Setting alarm time

    Read and set the alarm time, for RTCs that support alarms.
    The alarm interrupt must be separately enabled or disabled
    using the RTC_AIE_ON, RTC_AIE_OFF requests. The third
    ioctl's argument is a pointer to a rtc_time structure. Only
    the tm_sec, tm_min, and tm_hour fields of this structure are
    used.

Implementation notes:

    All ioctls in this patch have pointer to a structure rtc_time
    as their third argument. That is the reason why corresponding
    definition is added in linux-user/syscall_types.h. Since all
    elements of this structure are of type 'int', the rest of the
    implementation is straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-3-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  4 ++++
 linux-user/syscall_defs.h  |  4 ++++
 linux-user/syscall_types.h | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 55ad47186dc0..c39dd0128a60 100644
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
index fc3d79ab9762..dc36dd475112 100644
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
index 8ff78a625ace..bddc89a6641b 100644
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
2.24.1


