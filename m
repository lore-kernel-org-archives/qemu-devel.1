Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A5C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1A920675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4vBdPKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1A920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53542 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST2C-0003Om-CW
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:07:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZb-0003b4-33
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZX-0004I8-9k
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:21 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZT-0004BC-Ho
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id t87so6175238pfa.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=zGbVnBZ7x7Ulj+gsvlvNaeMFujeF8l5vm6cHIrbAA7c=;
	b=u4vBdPKixyBIqFlT8YlHC5VIlOngyb5q7cjyC+o8gfIuqzEG8w2crdWj/NDd3DRc+M
	6ng+lrb0c1+8G+UaVeWUjmF85CB2VEF33yuSUKX17+VOaPEC0c6hThwZF9Qk2b7Bs7bn
	eVXY9iBg3685j6UGcpSU/KzYQweyjjdW4DP9J8hXhxyuJyTuFueMvUgt6zt1mNHg01Eo
	08EQgG4nO/6hqBZP/AOvV4cUfCC4Ar3b6w6KAOyFxOQ3Coj7KjrXUa1v7pPPbFAuMcvE
	7Vsx/dRxl9RMs3bSutzkMN8fFWWPYHjVjNjXhim7DwgfLeAPm/TIPUPlHUeK6mrrMDHV
	MJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=zGbVnBZ7x7Ulj+gsvlvNaeMFujeF8l5vm6cHIrbAA7c=;
	b=GXwdLJ7tmH9UUdim/9sB0PNv8DJe6oeYHeOxo9a30zF2i0YkGIF+8qy/CXa1Ky7OdK
	zKbk+gwrmw3SeavcnjYS3wGTIshZLeZGFd7pHoPJ5pauTOJLMNCU7cx1498Ih036PJsT
	yB7E70VyDNsKIWYCb/5iLA1vh2zCftNV/i0KKU7UeOeuwXym4AK1G7IPBDiYIQdxSPZw
	yNVBhboUu87NjToSioGrAAbS2ShMQG9JMVXUYHrjWET8jSnxOKTfjzgYig42RZNcD+R6
	BvE9kzElIrxJHBOJjO3AUqt7uPQo4xlAXD70PyfYt/wXrnyMgtBjHQknSuYmTCqWqLp+
	TDFA==
X-Gm-Message-State: APjAAAU3tU/RJMSgs7m1bCBFKgW6xvwP+2FGjG6amX09F56c92y4ct7d
	Hq/UXPaCOag36r+4yyzUkWlf0Hy3F7I=
X-Google-Smtp-Source: APXvYqyHcH9cKLsE0kIopki8dHiQsrPBjnCJYCTjweHB8FSBH4Gdy0yla21N4fPjtG+OUBbjPglMzw==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr72583935pgc.25.1558298293401;
	Sun, 19 May 2019 13:38:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:46 -0700
Message-Id: <20190519203726.20729-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 34/74] linux-user: Split out alarm, pause
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h    |  6 ++++++
 linux-user/syscall-sig.inc.c | 36 ++++++++++++++++++++++++++++++++++++
 linux-user/syscall.c         | 12 +-----------
 linux-user/strace.list       |  6 ------
 4 files changed, 43 insertions(+), 17 deletions(-)
 create mode 100644 linux-user/syscall-sig.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 6ca82af397..9d0dd7457b 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifdef TARGET_NR_alarm
+SYSCALL_DEF(alarm, ARG_DEC);
+#endif
 SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
@@ -106,6 +109,9 @@ SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 SYSCALL_DEF(open_by_handle_at, ARG_DEC, ARG_PTR, ARG_OPENFLAG);
+#ifdef TARGET_NR_pause
+SYSCALL_DEF(pause);
+#endif
 SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
                  .args = args_pread64_pwrite64,
                  .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
new file mode 100644
index 0000000000..f4e43eb00e
--- /dev/null
+++ b/linux-user/syscall-sig.inc.c
@@ -0,0 +1,36 @@
+/*
+ *  Linux signal related syscalls
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifdef TARGET_NR_alarm
+SYSCALL_IMPL(alarm)
+{
+    return alarm(arg1);
+}
+#endif
+
+#ifdef TARGET_NR_pause
+SYSCALL_IMPL(pause)
+{
+    if (!block_signals()) {
+        CPUState *cpu = ENV_GET_CPU(cpu_env);
+        TaskState *ts = cpu->opaque;
+        sigsuspend(&ts->signal_mask);
+    }
+    return -TARGET_EINTR;
+}
+#endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae56ecbbc7..96e77ea38f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,17 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_alarm /* not on alpha */
-    case TARGET_NR_alarm:
-        return alarm(arg1);
-#endif
-#ifdef TARGET_NR_pause /* not on alpha */
-    case TARGET_NR_pause:
-        if (!block_signals()) {
-            sigsuspend(&((TaskState *)cpu->opaque)->signal_mask);
-        }
-        return -TARGET_EINTR;
-#endif
 #ifdef TARGET_NR_utime
     case TARGET_NR_utime:
         {
@@ -9224,6 +9213,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #include "syscall-ipc.inc.c"
 #include "syscall-mem.inc.c"
 #include "syscall-proc.inc.c"
+#include "syscall-sig.inc.c"
 #include "syscall-time.inc.c"
 
 #undef SYSCALL_IMPL
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d0646b9424..2a65457c76 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -25,9 +25,6 @@
 #ifdef TARGET_NR_afs_syscall
 { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_alarm
-{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_aplib
 { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
 #endif
@@ -872,9 +869,6 @@
 #ifdef TARGET_NR_osf_waitid
 { TARGET_NR_osf_waitid, "osf_waitid" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pause
-{ TARGET_NR_pause, "pause" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_pciconfig_iobase
 { TARGET_NR_pciconfig_iobase, "pciconfig_iobase" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


