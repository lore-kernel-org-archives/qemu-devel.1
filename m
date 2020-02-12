Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8887C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9554720714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ailBCaG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9554720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v7N-0000FF-N8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v55-0003PZ-81
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v54-0001lW-2n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:43 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v53-0001kI-Sx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id g3so3175561wrs.12
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yp9J3Sdvti8kkDmOijc4vUS6SBVhz37pfagJZGeOW6o=;
 b=ailBCaG4TCTkPA5mxR1PSHwKqickulvu+C/zHMVk7yRJ10By3WN/ZPNeVwiy42t4zt
 CwKHzqbl/Ql1IdNfk5jEhz58gtkKBZNE1vi96lwjMaAmCAm9KSyvLhSLdmDDrO4R7/13
 lngQ3NVhFAw1O1YzspDsEZ1olsx4D704nAOzTgt9SwRrkFmo2x8j02J80rBprV3ceQKw
 FgSo3PXdc3JnU6sMKUtu2P7sT4Yl5o1kBl1bQIjlJcpa/dFk/M+/gnSHh6Ty733dDRze
 qYJ5WOKcfbhwmUFKu/7YxNmMtbP3kTrZ0l/+FXDPZ4XhHrNCo8GSmckbYt2Hsv/kEcMI
 73bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Yp9J3Sdvti8kkDmOijc4vUS6SBVhz37pfagJZGeOW6o=;
 b=JuqL3oXLFGrR8E6UqKy5rXqTd89FWVhoAuQHsKf7N6LaKb1H7C4funWhDQ7a2Xqn5r
 hEkI7z4PSWBSdjIEb0ae+0vNy+oVCwf4MznlGedKL/W7bGRoPhGhUPpbYHPwOfwWG9ry
 FJ5ILqEYHSA8Mb0GYru7LFRaZS/ik7bSZnpkNykwu6VpVtddVaShPrLj7/GsefmDilhP
 zEpgQkrPGqYjKKA6+V9wL/3Ik9eYAG8bJiqpdSp/QS8d/r8uZpXrc8JzP0K0y51VBul/
 lreizseFiPVRP+NNG32CRNXKxXEQfK9GWkPiQZoWY9v4RsLCOJdw3Z5SLJYrDRo16AfX
 Bjkw==
X-Gm-Message-State: APjAAAVcJI7WTqd/Q2zcnvyk9RYOMkrc9JKXLnB2w/Capqj0O0z07eMV
 JPtUCs4fcmgiCO4OsLzcHdzbC0mI
X-Google-Smtp-Source: APXvYqynxyW7pu+cCTXgugSscnx59Lb6tH7dPxrYdnmSqQ4o8AdS891gbaekg4qGW2tYY3exztNgCQ==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr16090640wrp.1.1581525700560; 
 Wed, 12 Feb 2020 08:41:40 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] build: move TARGET_GPROF to config-host.mak
Date: Wed, 12 Feb 2020 17:41:26 +0100
Message-Id: <20200212164129.6968-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TARGET_GPROF is the same for all targets, write it to
config-host.mak instead.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: <20200204161104.21077-1-pbonzini@redhat.com>
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
index 115dc38085..16f94cd96b 100755
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



