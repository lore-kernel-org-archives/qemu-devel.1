Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0FAC3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDFB720730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qssiGh92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFB720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0oL-0002XK-6J
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0n6-0001Av-S4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0n5-0006qj-Cz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:11:08 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iz0n5-0006q6-6Z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:11:07 -0500
Received: by mail-wm1-x342.google.com with SMTP id g1so3911382wmh.4
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WXHuWTqPCctY5SsX5s98ozqJxeYA3dnOEm0Mn9wPeV0=;
 b=qssiGh92UxIB4BSRpcbIl8FvUxP1OeQ1uVu6IFjvTpCW9dMUa9voQLug+/vBT+7+Ze
 awBE+9JvIGl05P8yIpPSlgUDBJR/S2l7p/hPFH4B1L3bf68gqkefo7VHf65jyflHnn00
 OiXiAohWqN0wD8Lj15FTq3T1wNAIx+QQk8X3/ZtNbp7eZWKsB7pjA4k0sj4dpOhGcZJH
 FXA7HetBFwuUpFsd5ZCVhhTNVJEbXzE0hYvsTOYeo271DDqYHbsUyM/0OU495pCUCWbr
 X+KIWK5HoDs/thMoKdpR5O4YmyQBqBDD27Wc+Enhm4F8bdYXYJipA9iob+IHPT/YkWaJ
 yYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WXHuWTqPCctY5SsX5s98ozqJxeYA3dnOEm0Mn9wPeV0=;
 b=WUGd4iZV5HoOwl4SkrDalf9/6TqubrB9qG4T5uLVZ37dLCMVTWe5WcFdZFhXW+ZhRy
 Tg9Z6vqmyfu64VMIdZ42lVs/MA+hlOxnwczEeTJV/Do5c2x1n6oRwDqOQAY3INHwTJcI
 Rr0jwXjJbpL3Hx6/WWjNv1dzYOPmJXxUVhzCoVMkNCwB/HxwQHOnMVtkWmnTDcmReNwG
 O3AoCuzeb9X0HLVybu63zS+0ur1uJEyRWxHLcoLVc1FjIiKfquhnn8RO3Df3QjWmku3Z
 uCUSapGB0Q9fJcuS8efnzBrF09hwwW4ivs+OzZ08nZcL4nVxV7WLUPN3+/qWj7p2/wO6
 /AQQ==
X-Gm-Message-State: APjAAAUsJkXteUDvi77WVfdKM4I6W1TgvEp0SAowDwPmXQEF0g1wK1jq
 RKXx4ydhNCmmqi1EjZmMcSzi+Rcj
X-Google-Smtp-Source: APXvYqxBxSYHd60/vUEulRD2O03L9YpcEc7U+FfpLejmSc01K7UzANHY3Rc4rFIZ1049zoBImyBi5A==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr7000396wma.177.1580832665849; 
 Tue, 04 Feb 2020 08:11:05 -0800 (PST)
Received: from donizetti.redhat.com ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id w8sm4463708wmm.0.2020.02.04.08.11.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 08:11:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build: move TARGET_GPROF to config-host.mak
Date: Tue,  4 Feb 2020 17:11:04 +0100
Message-Id: <20200204161104.21077-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TARGET_GPROF is the same for all targets, write it to
config-host.mak instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/syscall.c   | 6 +++---
 configure            | 4 +++-
 linux-user/exit.c    | 4 ++--
 linux-user/signal.c  | 2 +-
 tests/check-block.sh | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 0d45b654bb..d38ec7a162 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -330,7 +330,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
     switch(num) {
     case TARGET_FREEBSD_NR_exit:
-#ifdef TARGET_GPROF
+#ifdef CONFIG_GPROF
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
@@ -432,7 +432,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
 
     switch(num) {
     case TARGET_NETBSD_NR_exit:
-#ifdef TARGET_GPROF
+#ifdef CONFIG_GPROF
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
@@ -511,7 +511,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
 
     switch(num) {
     case TARGET_OPENBSD_NR_exit:
-#ifdef TARGET_GPROF
+#ifdef CONFIG_GPROF
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
diff --git a/configure b/configure
index 5095f01728..08c28e73db 100755
--- a/configure
+++ b/configure
@@ -6771,6 +6771,9 @@ fi
 if test "$l2tpv3" = "yes" ; then
   echo "CONFIG_L2TPV3=y" >> $config_host_mak
 fi
+if test "$gprof" = "yes" ; then
+  echo "CONFIG_GPROF=y" >> $config_host_mak
+fi
 if test "$cap_ng" = "yes" ; then
   echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
 fi
@@ -7951,7 +7954,6 @@ alpha)
 esac
 
 if test "$gprof" = "yes" ; then
-  echo "TARGET_GPROF=y" >> $config_target_mak
   if test "$target_linux_user" = "yes" ; then
     cflags="-p $cflags"
     ldflags="-p $ldflags"
diff --git a/linux-user/exit.c b/linux-user/exit.c
index a362ef67d2..1594015444 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
-#ifdef TARGET_GPROF
+#ifdef CONFIG_GPROF
 #include <sys/gmon.h>
 #endif
 
@@ -28,7 +28,7 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
-#ifdef TARGET_GPROF
+#ifdef CONFIG_GPROF
         _mcleanup();
 #endif
 #ifdef CONFIG_GCOV
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62b15..02f860ecb9 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -509,7 +509,7 @@ void signal_init(void)
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
     for(i = 1; i <= TARGET_NSIG; i++) {
-#ifdef TARGET_GPROF
+#ifdef CONFIG_GPROF
         if (i == SIGPROF) {
             continue;
         }
diff --git a/tests/check-block.sh b/tests/check-block.sh
index 679aedec50..ad320c21ba 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -16,7 +16,7 @@ if [ "$#" -ne 0 ]; then
     format_list="$@"
 fi
 
-if grep -q "TARGET_GPROF=y" *-softmmu/config-target.mak 2>/dev/null ; then
+if grep -q "CONFIG_GPROF=y" config-host.mak 2>/dev/null ; then
     echo "GPROF is enabled ==> Not running the qemu-iotests."
     exit 0
 fi
-- 
2.21.0


