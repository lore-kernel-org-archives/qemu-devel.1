Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0AEC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB3C206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YumT0yhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB3C206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlf8-00087d-2S
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcc-0003LD-I2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcb-0003do-A1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlca-0003Xv-Vo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id j17so10544549wru.13
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UvjQIXOYDmX/EoTXnR+r4XSFKQrLP267MXe/Bc4WNPw=;
 b=YumT0yhKzv9AigpJ/m+kwl7j+CxbLGRmOx2luHxqdwL1f88CPIFa4Df5AxGvK8dRQQ
 KWeANL3vPWc5trJQeuwUpmIAgeftnX/V72XcX3kwAuytuUsu5WQEayFoovTiWme+drXx
 6LTw2ijnk7fsw9fgNTxvOPnTJGzGRvC59aPPEUfpTA+s/DBiUTWFPZinzPnoyENuZTm8
 MWEajZHfaKibu3xZzSn3mDNdks8WmIywA5Uq0Q+ckaMQVUE6qgD9FOwHwRIXEgagL+Bb
 tcBtBS93mN4WfxqycBgtNLIAcH7d3iN8odFGcj5rfXL5ggiw34SKuJ0ZKyJLksaJt5SJ
 w2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UvjQIXOYDmX/EoTXnR+r4XSFKQrLP267MXe/Bc4WNPw=;
 b=L6HmDyGI3R0tfUSVTs73OqoY0Qc8eLcrAg2EbAiYGDuG0KxnqA3L+6AEB8cfTpmgk6
 fy0bFi5w526mGcxXz/0pPDOE5A9CveoGUExqR1qIlP2yuEH7BUZJqgVMVWq2x9WIx0UW
 KcM305AUh6l0mrw0zBNq2kJVHZCnC6YFnxdgRz87Ius6Xz4UgLn7XA97GR98b/ee9O7T
 QjqjXGn+ok4pPIBxsBzzttuYL9zQsIHd6S/PJOrxCMMWxs4hw0p48xg0BJ2qAZ1uDWJ6
 K2RKkyXmTLC7o9YD0Ngvee8Vay5ESdzzMWu19nJMPaDmQSMZLLYtnXB0JX5SOsOtzmks
 0Ppg==
X-Gm-Message-State: ANhLgQ1tKlsnmO7IlWYaNgB+gTeidjOhu90gKhcP4kR1Tt7aFSHK4LQS
 ddBBbLehj0tezLYruw8qKurytw==
X-Google-Smtp-Source: ADFU+vuIaT7xdcg5XM4BpguZixEuC+PJLVvIgsJgU3zd6ub4XvdBVwfmI+t/8OXe0yZcqdYBqWc5PA==
X-Received: by 2002:adf:e946:: with SMTP id m6mr14582541wrn.187.1585302587304; 
 Fri, 27 Mar 2020 02:49:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w204sm7521430wma.1.2020.03.27.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:49:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 910461FF8C;
 Fri, 27 Mar 2020 09:49:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/7] linux-user: protect fcntl64 with an #ifdef
Date: Fri, 27 Mar 2020 09:49:40 +0000
Message-Id: <20200327094945.23768-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327094945.23768-1-alex.bennee@linaro.org>
References: <20200327094945.23768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Checking TARGET_ABI_BITS is sketchy - we should check for the presence
of the define to be sure. Also clean up the white space while we are
there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/syscall.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 49395dcea97..a3da46d69f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11223,11 +11223,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
            This is a hint, so ignoring and returning success is ok.  */
         return 0;
 #endif
-#if TARGET_ABI_BITS == 32
+#ifdef TARGET_NR_fcntl64
     case TARGET_NR_fcntl64:
     {
-	int cmd;
-	struct flock64 fl;
+        int cmd;
+        struct flock64 fl;
         from_flock64_fn *copyfrom = copy_from_user_flock64;
         to_flock64_fn *copyto = copy_to_user_flock64;
 
@@ -11238,7 +11238,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
 #endif
 
-	cmd = target_to_host_fcntl_cmd(arg2);
+        cmd = target_to_host_fcntl_cmd(arg2);
         if (cmd == -TARGET_EINVAL) {
             return cmd;
         }
-- 
2.20.1


