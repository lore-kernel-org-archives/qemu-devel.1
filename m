Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E3C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C32C20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C32C20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUw4e-0000zw-Rv
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 12:32:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hUvwy-0002p3-AS
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hUvsk-0007Ow-Af
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36566 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hUvsk-0007O1-03
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id BC9FC1A4BCA;
	Sun, 26 May 2019 18:19:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 8901C1A4B54;
	Sun, 26 May 2019 18:19:16 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 18:19:08 +0200
Message-Id: <1558887551-32137-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 09/12] linux-user: fix __NR_semtimedop
 undeclared error
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
defined if __NR_msgsnd is defined.

But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
__NR_semtimedop and it breaks the QEMU build.

__NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd_n=
32.h
but not in asm-mips/unistd_o32.h.

Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtimed=
op.
It introduces __NR_semtimedop_time64 instead.

This patch fixes the problem by checking for each __NR_XXX symbol
before defining the corresponding syscall.

Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190523175413.14448-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5521258..5e29e67 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -763,14 +763,7 @@ safe_syscall2(int, nanosleep, const struct timespec =
*, req,
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
 #endif
-#ifdef __NR_msgsnd
-safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
-              int, flags)
-safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
-              long, msgtype, int, flags)
-safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
-              unsigned, nsops, const struct timespec *, timeout)
-#else
+#if !defined(__NR_msgsnd) || !defined(__NR_msgrcv) || !defined(__NR_semt=
imedop)
 /* This host kernel architecture uses a single ipc syscall; fake up
  * wrappers for the sub-operations to hide this implementation detail.
  * Annoyingly we can't include linux/ipc.h to get the constant definitio=
ns
@@ -785,14 +778,29 @@ safe_syscall4(int, semtimedop, int, semid, struct s=
embuf *, tsops,
=20
 safe_syscall6(int, ipc, int, call, long, first, long, second, long, thir=
d,
               void *, ptr, long, fifth)
+#endif
+#ifdef __NR_msgsnd
+safe_syscall4(int, msgsnd, int, msgid, const void *, msgp, size_t, sz,
+              int, flags)
+#else
 static int safe_msgsnd(int msgid, const void *msgp, size_t sz, int flags=
)
 {
     return safe_ipc(Q_IPCCALL(0, Q_MSGSND), msgid, sz, flags, (void *)ms=
gp, 0);
 }
+#endif
+#ifdef __NR_msgrcv
+safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
+              long, msgtype, int, flags)
+#else
 static int safe_msgrcv(int msgid, void *msgp, size_t sz, long type, int =
flags)
 {
     return safe_ipc(Q_IPCCALL(1, Q_MSGRCV), msgid, sz, flags, msgp, type=
);
 }
+#endif
+#ifdef __NR_semtimedop
+safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
+              unsigned, nsops, const struct timespec *, timeout)
+#else
 static int safe_semtimedop(int semid, struct sembuf *tsops, unsigned nso=
ps,
                            const struct timespec *timeout)
 {
--=20
2.7.4


