Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE616C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B167720651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B167720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbkf-00063S-0P
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:13:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfX-0001T1-TT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfW-0003DE-Si
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46155 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hMbfW-0001ft-ML
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 194DB1A2207;
	Fri,  3 May 2019 19:07:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id EDB121A1E19;
	Fri,  3 May 2019 19:07:16 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 19:06:45 +0200
Message-Id: <1556903209-6036-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v3 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for xtensa
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, thuth@redhat.com, jcmvbkbc@gmail.com,
	arikalo@wavecomp.com, daniel.santos@pobox.com,
	amarkovic@wavecomp.com, nchen@wavecomp.com, philmd@redhat.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503170645.Ki2KaEO7i1WHiGX1jF0J-AGwsYrNxf0uaGN0hfmF7JI@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix support for the SIOCATMARK and SIOCGPGRP ioctls for xtensa by
correcting corresponding macro definition.

Values for TARGET_SIOCATMARK and TARGET_SIOCGPGRP are determined by
Linux kernel. Following relevant lines are from kernel source tree:

arch/ia64/include/uapi/asm/sockios.h:#define SIOCATMARK    0x8905
arch/mips/include/uapi/asm/sockios.h:#define SIOCATMARK    _IOR('s', 7, int)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCATMARK  0x8905
arch/sh/include/uapi/asm/sockios.h:#define SIOCATMARK      _IOR('s', 7, int)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCATMARK  _IOR('s', 7, int)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCATMARK   _IOR('s', 7, int)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCATMARK   0x8905
include/uapi/asm-generic/sockios.h:#define SIOCATMARK	   0x8905

arch/ia64/include/uapi/asm/sockios.h:#define SIOCGPGRP     0x8904
arch/mips/include/uapi/asm/sockios.h:#define SIOCGPGRP     _IOR('s', 9, pid_t)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCGPGRP   0x8904
arch/sh/include/uapi/asm/sockios.h:#define SIOCGPGRP       _IOR('s', 9, pid_t)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCGPGRP   _IOR('s', 9, pid_t)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCGPGRP    _IOR('s', 9, pid_t)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCGPGRP    0x8904
include/uapi/asm-generic/sockios.h:#define SIOCGPGRP       0x8904

It is visible that xtensa should have the same definitions as
alpha, mips and sh4 already do. This patch brings that to the
accurate state.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall_defs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 12c8407..1e86fb9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -736,7 +736,8 @@ struct target_pollfd {
 #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
 #define TARGET_KDSIGACCEPT     0x4B4E
 
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
+       defined(TARGET_XTENSA)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
-- 
2.7.4


