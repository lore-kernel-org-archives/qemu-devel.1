Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B4C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58912133F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58912133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXBR-00026k-5L
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgWNw-0001ci-FD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hgWNr-0005yG-69
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:32:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56321 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hgWNf-0005kq-8M
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:32:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 401611A4597;
 Thu, 27 Jun 2019 17:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 103831A4595;
 Thu, 27 Jun 2019 17:32:05 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu
Date: Thu, 27 Jun 2019 17:31:47 +0200
Message-Id: <1561649510-21183-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v14 2/5] linux-user: Add support for strace for
 statx() syscall
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
Cc: amarkovic@wavecomp.com, Jim Wilson <jimw@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jim Wilson <jimw@sifive.com>

All of the flags need to be conditional as old systems don't have
statx support.  Otherwise it works the same as other stat family
syscalls.  This requires the pending patch to add statx support.

Tested on Ubuntu 16.04 (no host statx) and Ubuntu 19.04 (with host
statx) using a riscv32-linux toolchain.

Signed-off-by: Jim Wilson <jimw@sifive.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  3 ++
 2 files changed, 89 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6f72a74..c80e93b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -976,6 +976,76 @@ UNUSED static struct flags msg_flags[] = {
     FLAG_END,
 };
 
+UNUSED static struct flags statx_flags[] = {
+#ifdef AT_EMPTY_PATH
+    FLAG_GENERIC(AT_EMPTY_PATH),
+#endif
+#ifdef AT_NO_AUTOMOUNT
+    FLAG_GENERIC(AT_NO_AUTOMOUNT),
+#endif
+#ifdef AT_SYMLINK_NOFOLLOW
+    FLAG_GENERIC(AT_SYMLINK_NOFOLLOW),
+#endif
+#ifdef AT_STATX_SYNC_AS_STAT
+    FLAG_GENERIC(AT_STATX_SYNC_AS_STAT),
+#endif
+#ifdef AT_STATX_FORCE_SYNC
+    FLAG_GENERIC(AT_STATX_FORCE_SYNC),
+#endif
+#ifdef AT_STATX_DONT_SYNC
+    FLAG_GENERIC(AT_STATX_DONT_SYNC),
+#endif
+    FLAG_END,
+};
+
+UNUSED static struct flags statx_mask[] = {
+/* This must come first, because it includes everything.  */
+#ifdef STATX_ALL
+    FLAG_GENERIC(STATX_ALL),
+#endif
+/* This must come second; it includes everything except STATX_BTIME.  */
+#ifdef STATX_BASIC_STATS
+    FLAG_GENERIC(STATX_BASIC_STATS),
+#endif
+#ifdef STATX_TYPE
+    FLAG_GENERIC(STATX_TYPE),
+#endif
+#ifdef STATX_MODE
+    FLAG_GENERIC(STATX_MODE),
+#endif
+#ifdef STATX_NLINK
+    FLAG_GENERIC(STATX_NLINK),
+#endif
+#ifdef STATX_UID
+    FLAG_GENERIC(STATX_UID),
+#endif
+#ifdef STATX_GID
+    FLAG_GENERIC(STATX_GID),
+#endif
+#ifdef STATX_ATIME
+    FLAG_GENERIC(STATX_ATIME),
+#endif
+#ifdef STATX_MTIME
+    FLAG_GENERIC(STATX_MTIME),
+#endif
+#ifdef STATX_CTIME
+    FLAG_GENERIC(STATX_CTIME),
+#endif
+#ifdef STATX_INO
+    FLAG_GENERIC(STATX_INO),
+#endif
+#ifdef STATX_SIZE
+    FLAG_GENERIC(STATX_SIZE),
+#endif
+#ifdef STATX_BLOCKS
+    FLAG_GENERIC(STATX_BLOCKS),
+#endif
+#ifdef STATX_BTIME
+    FLAG_GENERIC(STATX_BTIME),
+#endif
+    FLAG_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -2611,6 +2681,22 @@ print_tgkill(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_statx
+static void
+print_statx(const struct syscallname *name,
+            abi_long arg0, abi_long arg1, abi_long arg2,
+            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_at_dirfd(arg0, 0);
+    print_string(arg1, 0);
+    print_flags(statx_flags, arg2, 0);
+    print_flags(statx_mask, arg3, 0);
+    print_pointer(arg4, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 /*
  * An array of all of the syscalls we know about
  */
diff --git a/linux-user/strace.list b/linux-user/strace.list
index db21ce4..63a9466 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1650,3 +1650,6 @@
 #ifdef TARGET_NR_atomic_barrier
 { TARGET_NR_atomic_barrier, "atomic_barrier", NULL, NULL, NULL },
 #endif
+#ifdef TARGET_NR_statx
+{ TARGET_NR_statx, "statx", NULL, print_statx, NULL },
+#endif
-- 
2.7.4


