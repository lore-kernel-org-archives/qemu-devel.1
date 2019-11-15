Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8994E2053B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaqQ-0003Vq-AO
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVan4-0007p3-Fd
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVan3-0003Jd-90
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:30 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50548 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iVan2-00030b-Ui
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:33:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C3F401A225F;
 Fri, 15 Nov 2019 13:32:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 86A1E1A20BF;
 Fri, 15 Nov 2019 13:32:23 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 for 5.0 4/6] linux-user: Add support for get/set RTC wakeup
 alarm using ioctls
Date: Fri, 15 Nov 2019 13:32:14 +0100
Message-Id: <1573821136-30219-5-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573821136-30219-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1573821136-30219-1-git-send-email-Filip.Bozuta@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

RTC_WKALM_SET, RTC_WKALM_GET - Get/Set wakeup alarm

    Some RTCs support a more powerful alarm interface, using these
    ioctls to read or write the RTC's alarm time (respectively)
    with this structure:

        struct rtc_wkalrm {
            unsigned char enabled;
            unsigned char pending;
            struct rtc_time time;
        };

    The enabled flag is used to enable or disable the alarm inter=E2=80=90
    rupt, or to read its current status; when using these calls,
    RTC_AIE_ON and RTC_AIE_OFF are not used.  The pending flag is
    used by RTC_WKALM_RD to report a pending interrupt (so it's
    mostly useless on Linux, except when talking to the RTC man=E2=80=90
    aged by EFI firmware).  The time field is as used with
    RTC_ALM_READ and RTC_ALM_SET except that the tm_mday, tm_mon,
    and tm_year fields are also valid.  A pointer to this struc=E2=80=90
    ture should be passed as the third ioctl's argument.

Implementation notes:

    All ioctls in this patch have pointer to a structure rtc_wkalrm
    as their third argument. That is the reason why corresponding
    definition is added in linux-user/syscall_types.h. Since all
    elements of this structure are either of type 'unsigned char'
    or 'struct rtc_time' (that was covered in one of previous
    patches), the rest of the implementation is straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h        | 2 ++
 linux-user/syscall_defs.h  | 2 ++
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index accbdee..b09396e 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -85,6 +85,8 @@
      IOCTL(RTC_IRQP_SET, IOC_W, TYPE_ULONG)
      IOCTL(RTC_EPOCH_READ, IOC_R, MK_PTR(TYPE_ULONG))
      IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
+     IOCTL(RTC_WKALM_RD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
+     IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
=20
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index bbfa935..37504a2 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -780,6 +780,8 @@ struct target_pollfd {
 #define TARGET_RTC_IRQP_SET         TARGET_IOW('p', 0x0c, abi_ulong)
 #define TARGET_RTC_EPOCH_READ       TARGET_IOR('p', 0x0d, abi_ulong)
 #define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
+#define TARGET_RTC_WKALM_RD         TARGET_IOR('p', 0x10, struct rtc_wka=
lrm)
+#define TARGET_RTC_WKALM_SET        TARGET_IOW('p', 0x0f, struct rtc_wka=
lrm)
=20
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)=
 ||    \
        defined(TARGET_XTENSA)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index a35072a..820bc8e 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -266,6 +266,11 @@ STRUCT(rtc_time,
        TYPE_INT, /* tm_yday */
        TYPE_INT) /* tm_isdst */
=20
+STRUCT(rtc_wkalrm,
+       TYPE_CHAR, /* enabled */
+       TYPE_CHAR, /* pending */
+       MK_STRUCT(STRUCT_rtc_time)) /* time */
+
 STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* op */
        TYPE_INT, /* flags */
--=20
2.7.4


