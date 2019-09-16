Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2CFC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471AF2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=polymtl.ca header.i=@polymtl.ca header.b="bR9mu/FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471AF2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=polymtl.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tyi-0001vi-Bv
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olivier.dion@polymtl.ca>) id 1i9tMb-0007yl-RI
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olivier.dion@polymtl.ca>) id 1i9tMZ-00047k-8t
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:56:29 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:47308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olivier.dion@polymtl.ca>)
 id 1i9tMZ-00045z-2F
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:56:27 -0400
Received: from clara.localdomain (modemcable059.101-200-24.mc.videotron.ca
 [24.200.101.59]) (authenticated bits=0)
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id x8GFtwgY006121
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT); 
 Mon, 16 Sep 2019 11:56:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca x8GFtwgY006121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polymtl.ca;
 s=default; t=1568649379;
 bh=/hSMpdkHAV+GRRFXHYbEqSBWoOpNrQe7qkJthuSQHIs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bR9mu/FJAJGWMgWeMw7baUP6ePWd7ZOe9l2h8vomZGAqDCynhHjwjCX5j5/+h/Tfr
 T71cLNgQlH2ud+YsEOWO0+zaWpAx21r0LdUdAvdao7QsXhShBnJWdgX+GXTj3pHO+e
 uNqMb4pz+wPICaCYO4ZtVNA/b/OXWu559klJkYSo=
From: Olivier Dion <olivier.dion@polymtl.ca>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 11:55:45 -0400
Message-Id: <20190916155545.29928-2-olivier.dion@polymtl.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916155545.29928-1-olivier.dion@polymtl.ca>
References: <20190807135458.32440-1-dion@linutronix.de>
 <20190916155545.29928-1-olivier.dion@polymtl.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Poly-FromMTA: (modemcable059.101-200-24.mc.videotron.ca [24.200.101.59]) at
 Mon, 16 Sep 2019 15:55:58 +0000
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 132.207.4.11
Subject: [Qemu-devel] [PATCH v2 1/1] Handle /proc/self/exe in syscall execve
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
Cc: Olivier Dion <olivier.dion@polymtl.ca>, john.ogness@linutronix.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If not handled, QEMU will execve itself instead of the emulated
process.  The function do_openat already solves the /proc/self/exe
problem, so we can use it to get the executable file descriptor.  We
then make a safe call to execveat.

Note that safe_execve has been replaced by safe_execveat, since the
former is now useless.

Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
---
 linux-user/syscall.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2af3c1494..68340bcb67 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -736,7 +736,7 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
-safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
+safe_syscall5(int, execveat, int, dirfd, const char *, pathname, char **, argv, char **, envp, int, flags)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
@@ -7507,8 +7507,18 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
              * before the execve completes and makes it the other
              * program's problem.
              */
-            ret = get_errno(safe_execve(p, argp, envp));
-            unlock_user(p, arg1, 0);
+            {
+                int execfd = get_errno(do_openat(cpu_env, AT_FDCWD, p, O_PATH, 0));
+                unlock_user(p, arg1, 0);
+                if (is_error(execfd)) {
+                    ret = execfd;
+                    goto execve_end;
+                }
+                ret = get_errno(safe_execveat(execfd, "",
+                                              argp, envp,
+                                              AT_EMPTY_PATH));
+                close(execfd);
+            }
 
             goto execve_end;
 
-- 
2.23.0


