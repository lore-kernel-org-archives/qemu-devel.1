Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEB7218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEB7218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihVlP-00071e-U9
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 04:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1ihVjw-0005QO-Uf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1ihVju-0001BK-Ce
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:35:32 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:34219 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1ihVju-0005fI-0S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:35:30 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 4351B1A153B;
 Wed, 18 Dec 2019 10:34:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id EBD4F1A1D9B;
 Wed, 18 Dec 2019 10:34:19 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/6] linux-user: Add support for getting/setting RTC
 periodic interrupt and epoch using ioctls
Date: Wed, 18 Dec 2019 10:34:09 +0100
Message-Id: <1576661652-2870-4-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576661652-2870-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1576661652-2870-1-git-send-email-Filip.Bozuta@rt-rk.com>
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionalities of following ioctls:

RTC_IRQP_READ, RTC_IRQP_SET - Getting/Setting IRQ rate

    Read and set the frequency for periodic interrupts, for RTCs
    that support periodic interrupts. The periodic interrupt must
    be separately enabled or disabled using the RTC_PIE_ON,
    RTC_PIE_OFF requests. The third ioctl's argument is an
    unsigned long * or an unsigned long, respectively. The value
    is the frequency in interrupts per second. The set of allow=E2=80=90
    able frequencies is the multiples of two in the range 2 to
    8192. Only a privileged process (i.e., one having the
    CAP_SYS_RESOURCE capability) can set frequencies above the
    value specified in /proc/sys/dev/rtc/max-user-freq. (This
    file contains the value 64 by default.)

RTC_EPOCH_READ, RTC_EPOCH_SET - Getting/Setting epoch

    Many RTCs encode the year in an 8-bit register which is either
    interpreted as an 8-bit binary number or as a BCD number. In
    both cases, the number is interpreted relative to this RTC's
    Epoch. The RTC's Epoch is initialized to 1900 on most systems
    but on Alpha and MIPS it might also be initialized to 1952,
    1980, or 2000, depending on the value of an RTC register for
    the year. With some RTCs, these operations can be used to
    read or to set the RTC's Epoch, respectively. The third
    ioctl's argument is an unsigned long * or an unsigned long,
    respectively, and the value returned (or assigned) is the
    Epoch. To set the RTC's Epoch the process must be privileged
    (i.e., have the CAP_SYS_TIME capability).

Implementation notes:

    All ioctls in this patch have a pointer to 'ulong' as their
    third argument. That is the reason why corresponding parts
    of added code in linux-user/syscall_defs.h contain special
    handling related to 'ulong' type: they use 'abi_ulong' type
    to make sure that ioctl's code is calculated correctly for
    both 32-bit and 64-bit targets. Also, 'MK_PTR(TYPE_ULONG)'
    is used for the similar reason in linux-user/ioctls.h.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h       | 4 ++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index f472794..accbdee 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -81,6 +81,10 @@
      IOCTL(RTC_ALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
      IOCTL(RTC_RD_TIME, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
      IOCTL(RTC_SET_TIME, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_time)))
+     IOCTL(RTC_IRQP_READ, IOC_R, MK_PTR(TYPE_ULONG))
+     IOCTL(RTC_IRQP_SET, IOC_W, TYPE_ULONG)
+     IOCTL(RTC_EPOCH_READ, IOC_R, MK_PTR(TYPE_ULONG))
+     IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
=20
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f0bf09d..bbfa935 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -776,6 +776,10 @@ struct target_pollfd {
 #define TARGET_RTC_ALM_SET          TARGET_IOW('p', 0x07, struct rtc_tim=
e)
 #define TARGET_RTC_RD_TIME          TARGET_IOR('p', 0x09, struct rtc_tim=
e)
 #define TARGET_RTC_SET_TIME         TARGET_IOW('p', 0x0a, struct rtc_tim=
e)
+#define TARGET_RTC_IRQP_READ        TARGET_IOR('p', 0x0b, abi_ulong)
+#define TARGET_RTC_IRQP_SET         TARGET_IOW('p', 0x0c, abi_ulong)
+#define TARGET_RTC_EPOCH_READ       TARGET_IOR('p', 0x0d, abi_ulong)
+#define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
=20
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)=
 ||    \
        defined(TARGET_XTENSA)
--=20
2.7.4


