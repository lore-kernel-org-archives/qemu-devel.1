Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246A3C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08CF2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWdirTW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08CF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Tf-0003TP-TY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hz-0003A3-36
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hy-0002dX-04
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Hx-0002cu-Qo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:45 -0500
Received: by mail-pf1-x444.google.com with SMTP id 2so890374pfg.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9XBwaLHF8KEizZazlqtConhjNieZR2lcZTE6WMySySg=;
 b=GWdirTW1e0n4wYNVtN+Ax940cr9mjRdOqdlet9n7qoz5Ql6YDow8O8HszgxrwrchmG
 NzcStEo+I4Qt33lHBl7E+XZ0vSHaVHjgBpEw1jw42bRqlHRCUSoh34M8j2sLjzXpC6BS
 bTiWjfDiRn7Dw52HPQ4KvVlBkRUFsNFMIP0x7D1PQ42ZRj21X4P2LvvtKX4WPFxqtOXc
 s7Zt/0a6vLfo49blOxZwHw4qpNlfaYHqnJSIuWilt6mnB5WgP5+sGmMA50uvQYdxVqx+
 rjMH7eC0FtK9sDEwAuo+ZEH3a95Bb5eTK9t3JpHYFXI/th5e5du2bV/rVfrZUfyACdTE
 Wv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9XBwaLHF8KEizZazlqtConhjNieZR2lcZTE6WMySySg=;
 b=oASVmkLwJPXH/bao23LF/3xtgnTkhpuPQDIXjeLO7Ax0NN0PaablYzY46FUadFh7pT
 ozxtMvoBwR+bZQoCoNKnnXdnwuaIXf2P+ej/XaYaD93WY+W9jM3k36eqTUYER4n3AR+g
 lz1Ybq9Z4J6/jB8M3sjSuhREJYVyc0QDQ8ED7GRJGsnDm5IkZAn3B6GUh7ckHAa/CvBE
 8fm3gFvBQSF/YIu6ODrx1Ji9euzYOACsBoj68ZmWS/mWg8j3D22UgLMt22zOfvoxF5Vd
 ZAtCBQCqCId8fgMVCu4fmqUC7qgc6JPoQxbAD6XEIBvbJS/ryNhJZ6d5b1xQ0smo73yF
 XrqA==
X-Gm-Message-State: APjAAAVLzXcUsIUqaapu67Q1QniLmXDhnRK/30C76p+It3E52Ig30aHm
 Rq1x4MsA8Exf++KvO0Sqfgl/pd2yBF+Dig==
X-Google-Smtp-Source: APXvYqytZaUKs2Weqs/KqucBtW3KAzdANxD42GtSHdeAlpheYjlniHGsiY89h69yDS7xesrCqQN0qw==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr3080026pgj.53.1578455144595;
 Tue, 07 Jan 2020 19:45:44 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] configure: Unnest detection of -z,relro and -z,now
Date: Wed,  8 Jan 2020 14:44:47 +1100
Message-Id: <20200108034523.17349-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, Fangrui Song <i@maskray.me>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing about these options that is related to PIE.
Use them unconditionally.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fangrui Song <i@maskray.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not split into two tests.
---
 configure | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index f5248f86cd..1dd12edcc3 100755
--- a/configure
+++ b/configure
@@ -2041,9 +2041,6 @@ if test "$pie" != "no" ; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     LDFLAGS="-pie $LDFLAGS"
     pie="yes"
-    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-      LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
-    fi
   else
     if test "$pie" = "yes"; then
       error_exit "PIE not available due to missing toolchain support"
@@ -2054,6 +2051,12 @@ if test "$pie" != "no" ; then
   fi
 fi
 
+# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
+# The combination is known as "full relro", because .got.plt is read-only too.
+if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
+  LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
+fi
+
 ##########################################
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
-- 
2.20.1


