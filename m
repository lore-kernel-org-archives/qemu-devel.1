Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D8C43141
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F4C20715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F4C20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVGus-000192-5k
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVGos-0004RD-Rn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVGon-0007Q7-SL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:14:02 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54213 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iVGon-0007Nj-23
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:13:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AA3171A22AC;
 Thu, 14 Nov 2019 16:13:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5570D1A22C9;
 Thu, 14 Nov 2019 16:13:50 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for 5.0 6/6] linux-user: Add support for read/clear RTC
 voltage low detector using ioctls
Date: Thu, 14 Nov 2019 16:13:42 +0100
Message-Id: <1573744422-9974-7-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573744422-9974-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1573744422-9974-1-git-send-email-Filip.Bozuta@rt-rk.com>
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

RTC_VL_READ - Read voltage low detection information

    Read the voltage low for RTCs that support voltage low.
    The third ioctl's' argument points to an int in which
    the voltage low is returned.

RTC_VL_CLR - Clear voltage low information

    Clear the information about voltage low for RTCs that
    support voltage low. The third ioctl(2) argument is
    ignored.

Implementation notes:

    Since one ioctl has a pointer to 'int' as its third agrument,
    and another ioctl has NULL as its third argument, their
    implementation was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index a8dd235..371c25e 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -89,6 +89,8 @@
      IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
      IOCTL(RTC_PLL_GET, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
      IOCTL(RTC_PLL_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
+     IOCTL(RTC_VL_READ, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(RTC_VL_CLR, 0, TYPE_NULL)
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 8370f41..af4f366 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -796,6 +796,8 @@ struct target_rtc_pll_info {
                                                struct target_rtc_pll_info)
 #define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,                      \
                                                struct target_rtc_pll_info)
+#define TARGET_RTC_VL_READ          TARGET_IOR('p', 0x13, int)
+#define TARGET_RTC_VL_CLR           TARGET_IO('p', 0x14)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
-- 
2.7.4


