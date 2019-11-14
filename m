Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC202C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8185F2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8185F2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVGud-00010V-D0
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVGon-0004Ns-OK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iVGol-0007O3-PD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:13:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52154 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iVGol-0007MN-7u
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:13:55 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 63BED1A22B3;
 Thu, 14 Nov 2019 16:13:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 383261A22A9;
 Thu, 14 Nov 2019 16:13:50 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 for 5.0 1/6] linux-user: Add support for enable/disable RTC
 features using ioctls
Date: Thu, 14 Nov 2019 16:13:37 +0100
Message-Id: <1573744422-9974-2-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573744422-9974-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1573744422-9974-1-git-send-email-Filip.Bozuta@rt-rk.com>
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

RTC_AIE_ON, RTC_AIE_OFF - Alarm interrupt enable on/off

    Enable or disable the alarm interrupt, for RTCs that support
    alarms.  The third ioctl's argument is ignored.

RTC_UIE_ON, RTC_UIE_OFF - Update interrupt enable on/off

    Enable or disable the interrupt on every clock update, for
    RTCs that support this once-per-second interrupt.  The third
    ioctl's argument is ignored.

RTC_PIE_ON, RTC_PIE_OFF - Periodic interrupt enable on/off

    Enable or disable the periodic interrupt, for RTCs that sup=E2=80=90
    port these periodic interrupts.  The third ioctl's argument
    is ignored.  Only a privileged process (i.e., one having the
    CAP_SYS_RESOURCE capability) can enable the periodic interrupt
    if the frequency is currently set above the value specified in
    /proc/sys/dev/rtc/max-user-freq.

RTC_WIE_ON, RTC_WIE_OFF - Watchdog interrupt enable on/off

    Enable or disable the Watchdog interrupt, for RTCs that sup-
    port this Watchdog interrupt. The third ioctl's argument is
    ignored.

Implementation notes:

    Since all of involved ioctls have NULL as their third argument,
    their implementation was straightforward.

    The line '#include <linux/rtc.h>' was added to recognize
    preprocessor definitions for these ioctls.  This needs to be
    done only once in this series of commits.  Also, the content
    of this file (with respect to ioctl definitions) remained
    unchanged for a long time, therefore there is no need to
    worry about supporting older Linux kernel version.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h       |  9 +++++++++
 linux-user/syscall.c      |  1 +
 linux-user/syscall_defs.h | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c6b9d6a..97741c7 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -69,6 +69,15 @@
      IOCTL(KDSETLED, 0, TYPE_INT)
      IOCTL_SPECIAL(KDSIGACCEPT, 0, do_ioctl_kdsigaccept, TYPE_INT)
=20
+     IOCTL(RTC_AIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_AIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_UIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_UIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_PIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_PIE_OFF, 0, TYPE_NULL)
+     IOCTL(RTC_WIE_ON, 0, TYPE_NULL)
+     IOCTL(RTC_WIE_OFF, 0, TYPE_NULL)
+
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(BLKRRPART, 0, TYPE_NULL)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ce399a5..74c3c08 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -107,6 +107,7 @@
 #include <netpacket/packet.h>
 #include <linux/netlink.h>
 #include <linux/if_alg.h>
+#include <linux/rtc.h>
 #include "linux_loop.h"
 #include "uname.h"
=20
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 98c2119..f91579a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -763,6 +763,16 @@ struct target_pollfd {
 #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flag=
s] */
 #define TARGET_KDSIGACCEPT     0x4B4E
=20
+/* real time clock ioctls */
+#define TARGET_RTC_AIE_ON           TARGET_IO('p', 0x01)
+#define TARGET_RTC_AIE_OFF          TARGET_IO('p', 0x02)
+#define TARGET_RTC_UIE_ON           TARGET_IO('p', 0x03)
+#define TARGET_RTC_UIE_OFF          TARGET_IO('p', 0x04)
+#define TARGET_RTC_PIE_ON           TARGET_IO('p', 0x05)
+#define TARGET_RTC_PIE_OFF          TARGET_IO('p', 0x06)
+#define TARGET_RTC_WIE_ON           TARGET_IO('p', 0x0f)
+#define TARGET_RTC_WIE_OFF          TARGET_IO('p', 0x10)
+
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)=
 ||    \
        defined(TARGET_XTENSA)
 #define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
--=20
2.7.4


