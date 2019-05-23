Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447A720851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KknHiVSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447A720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlBa-0003cL-Bc
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:42:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvK-0005ue-0Z
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvA-0001Jr-OO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv4-0000uS-DP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id j187so6754165wma.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ClzRD6CI4ag8pii4JNWlYLGFqOxEmOFpGkxKaMBsRlY=;
	b=KknHiVSn4tKPDo6MAF76n0trlEPaus08nEOmHAyxZyjfPBavs6gGNS91/oIaT2gpIO
	OVDIrnkHSlhg46TQ33HUC1IyQ6Kp8c3TeqweRi6CLc0+f3JoaGKBw9i2pdQrsaTv1XgI
	iEiTSCXZT1IPGZA7hImPvgfMxPOqSo8u56F5wc+mjPri58EbWhwgyQ2/f17rUKlNs+vS
	1C8BRS2C06SFjGItDADj4591O7ByeD17TLfaWvbA39ECvi4hr+t9Ljvf4YIAQQTbmTKN
	4dhM7wNKNsciMwbkrBb3Vs+VbQ88uUfVta+gk7D7Gc8389rPq8HRYN21iQoInY9rqMOk
	trbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ClzRD6CI4ag8pii4JNWlYLGFqOxEmOFpGkxKaMBsRlY=;
	b=ZwtT4suNyAqRkjyfiqaNr1Wg6wg1vwrE3VReH5aMN+Ld1r+zoetrtJ7XI0Lgi1S0N/
	02DsUmRb6Hi5+n8psuT+bJyVpGYq5NBdposGKpXcz0G5RsRXx5rhjOED3TctKLsRN40s
	+ukF+QM8lkoIsdf9FwHDZJhxEwnRgqgRQLEJs36GzpKh4leePtAUMhAzi8IhLB9e6X/0
	fSfmXhIHj+SUvhlzMIQ0KJe4KmCAuBKrnzM/22S1ittgOyoZD+UvhnwKgLTRFbOeG8EG
	NzPLMaAm0YSXk8VnnbqKOWhkynmfDamVTq1Mi/BGv3sqCm+gCtTzNtcNe1olK2fr+FRf
	WcpQ==
X-Gm-Message-State: APjAAAWPtEvA9imu58pNNdgW1I8lGUyHgDhVHFXrLv6xRmBm51hsY0T2
	Zg84uxJ57bktOM15MhHXZQ8xnHC5dnQ=
X-Google-Smtp-Source: APXvYqyWs78GUzteu2dAde2p7C6NOldmjHqQZBRLegw0J6EDkTlQOJCnkqSlf2pnbrrh29shMqvkYg==
X-Received: by 2002:a1c:7303:: with SMTP id d3mr10893139wmb.119.1558607137301; 
	Thu, 23 May 2019 03:25:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id n5sm7077195wrj.27.2019.05.23.03.25.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E42081FF92;
	Thu, 23 May 2019 11:25:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:09 +0100
Message-Id: <20190523102532.10486-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 05/28] target/arm: fixup some of the
 commentary for arm-semi
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This cleans up a number of the block comments to fit the proper style.
While we are at it we also reference the official specification and
document what the return register value can be.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/arm/arm-semi.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 3273306c8ea..9e5a414dd89 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -2,6 +2,7 @@
  *  Arm "Angel" semihosting syscalls
  *
  *  Copyright (c) 2005, 2007 CodeSourcery.
+ *  Copyright (c) 2019 Linaro
  *  Written by Paul Brook.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -16,6 +17,10 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *  ARM Semihosting is documented in:
+ *     Semihosting for AArch32 and AArch64 Release 2.0
+ *     https://static.docs.arm.com/100863/0200/semihosting.pdf
  */
 
 #include "qemu/osdep.h"
@@ -240,6 +245,15 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
      put_user_u64(val, args + (n) * 8) :                \
      put_user_u32(val, args + (n) * 4))
 
+/*
+ * Do a semihosting call.
+ *
+ * The specification always says that the "return register" either
+ * returns a specific value or is corrupted, so we don't need to
+ * report to our caller whether we are returning a value or trying to
+ * leave the register unchanged. We use 0xdeadbeef as the return value
+ * when there isn't a defined return value for the call.
+ */
 target_ulong do_arm_semihosting(CPUARMState *env)
 {
     ARMCPU *cpu = arm_env_get_cpu(env);
@@ -510,14 +524,16 @@ target_ulong do_arm_semihosting(CPUARMState *env)
 
             output_size = ts->info->arg_end - ts->info->arg_start;
             if (!output_size) {
-                /* We special-case the "empty command line" case (argc==0).
-                   Just provide the terminating 0. */
+                /*
+                 * We special-case the "empty command line" case (argc==0).
+                 * Just provide the terminating 0.
+                 */
                 output_size = 1;
             }
 #endif
 
             if (output_size > input_size) {
-                 /* Not enough space to store command-line arguments.  */
+                /* Not enough space to store command-line arguments.  */
                 return -1;
             }
 
@@ -571,8 +587,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             GET_ARG(0);
 
 #ifdef CONFIG_USER_ONLY
-            /* Some C libraries assume the heap immediately follows .bss, so
-               allocate it using sbrk.  */
+            /*
+             * Some C libraries assume the heap immediately follows .bss, so
+             * allocate it using sbrk.
+             */
             if (!ts->heap_limit) {
                 abi_ulong ret;
 
@@ -620,7 +638,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         }
     case TARGET_SYS_EXIT:
         if (is_a64(env)) {
-            /* The A64 version of this call takes a parameter block,
+            /*
+             * The A64 version of this call takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
              */
@@ -633,14 +652,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
                 ret = 1;
             }
         } else {
-            /* ARM specifies only Stopped_ApplicationExit as normal
-             * exit, everything else is considered an error */
+            /*
+             * ARM specifies only Stopped_ApplicationExit as normal
+             * exit, everything else is considered an error
+             */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
         gdb_exit(env, ret);
         exit(ret);
     case TARGET_SYS_SYNCCACHE:
-        /* Clean the D-cache and invalidate the I-cache for the specified
+        /*
+         * Clean the D-cache and invalidate the I-cache for the specified
          * virtual address range. This is a nop for us since we don't
          * implement caches. This is only present on A64.
          */
-- 
2.20.1


