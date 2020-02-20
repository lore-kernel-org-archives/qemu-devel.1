Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC01C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CF920801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CF920801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i4E-0000WN-81
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1X-00048z-4i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1W-00088v-4T
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:35 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:38107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1V-000886-Rn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:34 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M5PRT-1j3sXF3qgX-001VXL; Thu, 20 Feb 2020 10:20:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] linux-user: Implement membarrier syscall
Date: Thu, 20 Feb 2020 10:20:41 +0100
Message-Id: <20200220092053.1510215-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pCfKeP0sdaMCzYW0ZbJkVeNq0bI4maMyKzmKSjuSrcmKZI1xGFd
 7C0K27YLuS00xrsNInms9G+O2K4tRcQaeqxSzBCcXis/AMu7vyx2Kr6O/6NNP6tFi9qzFPM
 0bn3Qxis0smc/6WJeUPkTZ4uRk7k1lNcycdY2bN38S6KFWUO/kgouKgcDK11cf+J6Uyc1gd
 cqHwqEvkBII+PJAllSNAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHo6oa5FLIk=:eUQqno9qkdHaBHO60/r+WJ
 uu6febSZaNZW1CIWMRshqWUF3RwlrxB+y81w8BFH18yOaME2/0KdgJE5I5N8+5odZSfAvPkT0
 ZvzZ3Ke/Xi+n6u2LpWmyhSqc8aiqSh3m9acynt79yoQzK4bMnL9wq5rILGV3f4azLp0sF/+qP
 uvMI+5oG0iMZR8sDf5q9AAQ97I5yGVTvbAQDFAXQRHBA2y3oSKdxZDxr0LjMPQKR4Y5l/OyOf
 C/O+oFyWxM1k7rHH0mpDBp6LJabac5Gf3Ea6HmgeMUgr1deo3/9vl+fxonUb0KH+Egh7/RVsN
 j+7b+HzTB+JmGBzCUDqdSUiZTSphSD4/iW7j5NUkJDTCh+FExz2yR04tOy3h/aVvX5IJgoP7X
 OfHvlnCbYC0ljhJi0FMGkK9G/uLhA3RDydaXf1QWWiFvmnnBQKFiuWdiEijMWA9RGXxhfiEzl
 mi6y++Cc09Z/gAdSAAuFDiVn8OucmdaAclDVR2AGRq4xipMoLoNUr0JRJ1u6nvJOnE78PLCkZ
 vFwBIDDpSSZz2qj37iHo0DZMy2L6M4nxOrLZUXbDO+lYRVjpml0SHm4GXye5Q3iFbI+wOHF9P
 X2nTYWTqDJb2+yGiHuqdYmQgn7tvJJhNaGFJ2l1qOzDsm+58Ebcu90a3whxgHOIVINQmU/R4b
 tBn1aJNOEzLee8NYEdHlPH8vX3/b6LDuMeRgPzn1H9ZwEjkEbl8Ldi6fu+2MPu1ak1YJhEEDH
 LrwJaEXmrbgakEa6/BW6SRk5WchhiMt/1Tr1R1oFdEKVmbdc0edJobzVg2v/u2VZhi35Vxtu2
 Uu3QkXpTnRoAPhHtgYsfRAnVn8/Mj+YpJ3LULmaFdYp7eNB1zwZ+Fn4NUdw1Ajfh1KDgz+9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Andreas Schwab <schwab@suse.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Schwab <schwab@suse.de>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvmpnomohfm.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c930577686da..7aaa9d96397c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -334,6 +334,9 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
 _syscall5(int, sys_statx, int, dirfd, const char *, pathname, int, flags,
           unsigned int, mask, struct target_statx *, statxbuf)
 #endif
+#if defined(TARGET_NR_membarrier) && defined(__NR_membarrier)
+_syscall2(int, membarrier, int, cmd, int, flags)
+#endif
 
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -12090,6 +12093,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg1, 0);
         return ret;
 #endif
+#if defined TARGET_NR_membarrier && defined __NR_membarrier
+    case TARGET_NR_membarrier:
+        return get_errno(membarrier(arg1, arg2));
+#endif
 
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
-- 
2.24.1


