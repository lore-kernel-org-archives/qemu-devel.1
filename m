Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E748C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC95120715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7Td26JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC95120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPtl-00063C-K1
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs8-0004CY-Ln
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs7-0002nM-Jx
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:36 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPs7-0002mJ-E4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:35 -0500
Received: by mail-pg1-x542.google.com with SMTP id b137so447265pga.6
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jQ/iIszATFHSOTQDeJa8KJZXVRGX9Wk3W4o78mWyy8c=;
 b=C7Td26JBg2DeSPn3In/NgHzc9ZBHnWvdYisiPXb61qYCoWnR3bhiNx0VVtTSRPQNY4
 WtpRSZgZhAAHQIRlOg70Q+VKAdnh2r98qj5gaKzL82BVH5gXKgl1W0qf03UqiDmIuJex
 txVOxty6zkom0Psg/1aRYbLD0cQKB+wyN3syTtH1H6JGY8CTBrkvF1a4oTZcwtpPxocX
 wm7/+eWogKW33UYV8qICU1KriRil69VtwRTLlibRxPxjl6MeWFJVf+6yiWII22DPe5Q6
 a4jW8/ZhXHIZzXiQdkaeBC+CQQzX0bIO55EEYHQKsHsJeenJhwVZen955cX3S8bIfPNt
 6qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jQ/iIszATFHSOTQDeJa8KJZXVRGX9Wk3W4o78mWyy8c=;
 b=YSPVPgoC4N/J9Gy+wKay02gthfX9d7SbPLxo2ICUrYfYdYf+NgcT8sVUmEC9p1q2H5
 1FvlHQxpi/GVA5Sst7BAQ4lzjCys0N7qLHduZmAnHSbU9yswsYp31wzBTShQzaz6iPkM
 FbOovmhVzKmYqT41mBa9e/dbxq2dBdRHVRy/KcVIMPEW04pgCHAbfWgql/+tMzfUgja0
 K8hohoi3U2C9tG9nTsw9yI/iJQwE5M8gFFB1Y59/NhjCKQdG1GLhaWmjkrnsvQJ97zDW
 rp+9RaF53GAWCv0QeLg962gEex0X4K9wrJksGymI+agjCNWCZ3raH5g4x5MjG5TAXxyn
 JbsQ==
X-Gm-Message-State: APjAAAU/jIuMtPNOa8Sx0+TnXFcxTBlByzOfKpWCu84bZOgHZ2oZ984i
 OEH1aXDZHGDfpT7dxmHOtdd6ybIWuvA=
X-Google-Smtp-Source: APXvYqysgFmZt1Hs5Eigo61Bq/hL08LCzw76grC4cilGo7IV4qdzSyU1wH/rom8vn1SarNRIgasBIA==
X-Received: by 2002:a65:56c9:: with SMTP id w9mr323141pgs.296.1576639174204;
 Tue, 17 Dec 2019 19:19:34 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] configure: Support -static-pie if requested
Date: Tue, 17 Dec 2019 17:19:20 -1000
Message-Id: <20191218031920.6414-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent toolchains support static and pie at the same time.

As with normal dynamic builds, allow --static to default to PIE
if supported by the toolchain.  Allow --enable/--disable-pie to
override the default.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index 1645a58b3a..c03491018a 100755
--- a/configure
+++ b/configure
@@ -1023,7 +1023,6 @@ for opt do
   ;;
   --static)
     static="yes"
-    LDFLAGS="-static $LDFLAGS"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
   --mandir=*) mandir="$optarg"
@@ -1994,11 +1993,6 @@ if test "$static" = "yes" ; then
   if test "$modules" = "yes" ; then
     error_exit "static and modules are mutually incompatible"
   fi
-  if test "$pie" = "yes" ; then
-    error_exit "static and pie are mutually incompatible"
-  else
-    pie="no"
-  fi
 fi
 
 # Unconditional check for compiler __thread support
@@ -2032,6 +2026,17 @@ fi
 if test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
+elif test "$static" = "yes"; then
+  if compile_prog "-fPIE -DPIE" "-static-pie"; then
+    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    LDFLAGS="-static-pie $LDFLAGS"
+    pie="yes"
+  elif test "$pie" = "yes"; then
+    error_exit "-static-pie not available due to missing toolchain support"
+  else
+    LDFLAGS="-static $LDFLAGS"
+    pie="no"
+  fi
 elif compile_prog "-fPIE -DPIE" "-pie"; then
   QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
   LDFLAGS="-pie $LDFLAGS"
-- 
2.20.1


