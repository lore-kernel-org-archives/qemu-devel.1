Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD24C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C452924673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C452924673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXum-0005V6-Aq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlW-0001PI-Ix
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlV-0003Bi-6X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:02 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003Ar-TT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:01 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4ahC-1iwBeh1skI-001lkt; Thu, 23 Jan 2020 09:22:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] linux-user: Add support for getting/setting RTC wakeup
 alarm using ioctls
Date: Thu, 23 Jan 2020 09:22:25 +0100
Message-Id: <20200123082227.2037994-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zdqdDNWBwfZsV4R+PpOwZvnTVGLtTagEPRs4t94OcOAorDHakqu
 8ntWNNwoeL2GTOACpBFsEzVMghWvKqCCI2M5hwxMyCvgyHRjgxtyxlDl/S+StMdUNkbe0ih
 RYGZGSpcK3FIrI4LQby7dp+eYXFcF/v2xcyXToaSFmrCtTc73kGrpukLGfmBFVL2YlwynWV
 wbExouApCNtaQMkc48Ugg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dOQ0sgx6Riw=:izbcffJT4Gr119nlJIhRuP
 yyGpfSTSq/DsLFHAcRRXI6iZC6NrT9dF3HWjaLKTa4yRHeuCdQGdBdTSOvV7hHP034mUo7U/r
 g0Vrcg1sX2cAuTAQ9oHJ/7VMRPYXoZGATE09/Nl3xGl4tk2hFXweiRj0EKFiaU++9VBkEIOF8
 Qv93SflVEhxyDmMxx1C0/g04IfRbSSRIIiH/35y0mfohX77iAqCQPX3zBsaJrbU+ke21mn9Ou
 9AYwdkSrAy74TGHqHcnZSpoqGiLniLwwri1QfKqiDvdrYkUyJ2Nl3TCGWmfgybntYRsZVzyXe
 MJ//G1QvvecSou8KGTl0JEptFdNodw9yIKx71TujbnWV4KVtsC7Bo+Ekr2cSkowk7Izt3UWWm
 IuaAdjSwD+dsRqzSHMQtF+eqhukYEk8lwP4b1gLqRKleW/RlAbq5snru8WpWGfpAVt8PzIk2d
 68EfO9Wr1D6PfAKkB43lxheTxwnh/GMf4O05FJIDWrPhPhEcjqZy0fALR70X0CjLcxdCU2ZX6
 RqzXHES7vHwbuTCeMgIQ7o19RK3pL2Yk5DbKek95fdn05whoIy948gzRL+ZWqR9HcmBUN7SC3
 TrxA8Mo5w0IUZJlCWV97J/1VFmOL1eZwUbnnVnXJcuMuNtiIwqoE5Gl6wx+gfVd6g44p2ZCKV
 5BPou6jQxH/fbAqfl/bhLzgH6tsmA6qxZ5+3nvbby0rizUHM80iM0OuC5U08h+KZik403T/ij
 4RM8MREd/+DfN7/8myqRgJYISlH8LgveSWIHX0pOHC4Zt68G4EII+BD/Yxu8X17BZ3GuPU325
 RtwAwx1jKg6nAk99uR+H4CeXfTYnuANf3HjlE6Wl3jDQxR2fQU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

RTC_WKALM_SET, RTC_WKALM_GET - Getting/Setting wakeup alarm

    Some RTCs support a more powerful alarm interface, using these
    ioctls to read or write the RTC's alarm time (respectively)
    with this structure:

        struct rtc_wkalrm {
            unsigned char enabled;
            unsigned char pending;
            struct rtc_time time;
        };

    The enabled flag is used to enable or disable the alarm
    interrupt, or to read its current status; when using these
    calls, RTC_AIE_ON and RTC_AIE_OFF are not used. The pending
    flag is used by RTC_WKALM_RD to report a pending interrupt
    (so it's mostly useless on Linux, except when talking to the
    RTC managed by EFI firmware). The time field is as used with
    RTC_ALM_READ and RTC_ALM_SET except that the tm_mday, tm_mon,
    and tm_year fields are also valid. A pointer to this structure
    should be passed as the third ioctl's argument.

Implementation notes:

    All ioctls in this patch have a pointer to a structure
    rtc_wkalrm as their third argument. That is the reason why
    corresponding definition is added in linux-user/syscall_types.h.
    Since all  elements of this structure are either of type
    'unsigned char' or 'struct rtc_time' (that was covered in one
    of previous patches), the rest of the implementation is
    straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-5-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 2 ++
 linux-user/syscall_defs.h  | 2 ++
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 9e91eaae7705..e4c1fbf52b1b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -85,6 +85,8 @@
      IOCTL(RTC_IRQP_SET, IOC_W, TYPE_ULONG)
      IOCTL(RTC_EPOCH_READ, IOC_R, MK_PTR(TYPE_ULONG))
      IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
+     IOCTL(RTC_WKALM_RD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
+     IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index fcbb2ee9a387..c33432a374e5 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -780,6 +780,8 @@ struct target_pollfd {
 #define TARGET_RTC_IRQP_SET         TARGET_IOW('p', 0x0c, abi_ulong)
 #define TARGET_RTC_EPOCH_READ       TARGET_IOR('p', 0x0d, abi_ulong)
 #define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
+#define TARGET_RTC_WKALM_RD         TARGET_IOR('p', 0x10, struct rtc_wkalrm)
+#define TARGET_RTC_WKALM_SET        TARGET_IOW('p', 0x0f, struct rtc_wkalrm)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index bddc89a6641b..3efa9536ccfa 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -266,6 +266,11 @@ STRUCT(rtc_time,
        TYPE_INT, /* tm_yday */
        TYPE_INT) /* tm_isdst */
 
+STRUCT(rtc_wkalrm,
+       TYPE_CHAR, /* enabled */
+       TYPE_CHAR, /* pending */
+       MK_STRUCT(STRUCT_rtc_time)) /* time */
+
 STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* op */
        TYPE_INT, /* flags */
-- 
2.24.1


