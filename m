Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19899C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68D92070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSX0wIsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68D92070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2K8-0005iQ-5W
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I4-0003Jo-Sp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I3-0002k5-Lv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:52 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:36286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2I3-0002jG-GK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:51 -0500
Received: by mail-pf1-x432.google.com with SMTP id x184so912797pfb.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WAyFVokvd/qDR4nuAyVDRmGp5pg99piONaTKi+oPUR0=;
 b=XSX0wIsTN6Rprrhea0R4b3vHQgYQIZeUwGeWQqqBru0235sJqfM8YgMes6LEFPAzjY
 vl9W9J8ta5W1IvJKv+cIcvq0mhrrB8bn9lR90lKhQaFr0xfPiCaQyd//mhmR3uoIFhH3
 PtljSA9Rv7KZmpgH+3XeftjsxKqBcnLQX6lYy72nZNv2xxq6yS0Quc+0sTot0x2HWbNj
 w+gZnxrghhtGTAs0uXHpFRZX5NLPebL7ZFy/+j13RnyDjVp0qtGw6kUEzRpfh1EIehnB
 /wRAaBf8lNmioV3vU62AKolgVLqHmBEi04AlM/Sluxefm5btMrtTRpFToIHpI8fcWJt2
 s+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WAyFVokvd/qDR4nuAyVDRmGp5pg99piONaTKi+oPUR0=;
 b=CjGhaT6+SgcQM/7s1N+L5i6wX10F3E6fnNSmPJA/mALBXWdQ0IzfKb4Y+Wb7VsYX/P
 1jwczXz8AgOv+I0wcVjXqPutQjtZ6wR69N6LlpBVN7HDTJtA5mO/U0rNUeWheQ/W0HsF
 VNxeU6HuKMAwtbV1SRqcABCyxXX1Rdtg6aHgPpEylXDVU/DZAbTW3oTHsaZTI5a6CVCs
 MIMr/AffvB6hsrP+AafcpoS2d83cqf5rrUNMM8sq2G1LVqZIxHe263vxY+CKRPFOiEtW
 Ytbnxui7I+7Eb+fIS6BPCCEgQxuAV48u1mby2h47kE8UmYMxTYkhC+OjOYYQujh2R0kT
 eqoA==
X-Gm-Message-State: APjAAAUQ/MfVaRC9+r/MrV83Z+z2tAAwHA5U6ZMeQnzKhjhDGJf+4JB4
 QPYJe/Hm4mKkAHbluhLUp3QNPPht9tPfvA==
X-Google-Smtp-Source: APXvYqyo/y2l25JmbNfQkGSc1w2aPPLpQGGsNPAUw3XCnrc9H28Pb+HKce6TKkJczk3PZpNcPL4Sdw==
X-Received: by 2002:a62:62c4:: with SMTP id w187mr2940652pfb.216.1578455150297; 
 Tue, 07 Jan 2020 19:45:50 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] configure: Support -static-pie if requested
Date: Wed,  8 Jan 2020 14:44:49 +1100
Message-Id: <20200108034523.17349-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent toolchains support static and pie at the same time.

As with normal dynamic builds, allow --static to default to PIE
if supported by the toolchain.  Allow --enable/--disable-pie to
override the default.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix --disable-pie --static
---
 configure | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index de2c4867ad..94a4b1c848 100755
--- a/configure
+++ b/configure
@@ -1025,7 +1025,6 @@ for opt do
   ;;
   --static)
     static="yes"
-    LDFLAGS="-static $LDFLAGS"
     QEMU_PKG_CONFIG_FLAGS="--static $QEMU_PKG_CONFIG_FLAGS"
   ;;
   --mandir=*) mandir="$optarg"
@@ -2001,11 +2000,6 @@ if test "$static" = "yes" ; then
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
@@ -2036,7 +2030,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
   LDFLAGS_NOPIE="-no-pie"
 fi
 
-if test "$pie" = "no"; then
+if test "$static" = "yes"; then
+  if test "$pie" != "no" && compile_prog "-fPIE -DPIE" "-static-pie"; then
+    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+    LDFLAGS="-static-pie $LDFLAGS"
+    pie="yes"
+  elif test "$pie" = "yes"; then
+    error_exit "-static-pie not available due to missing toolchain support"
+  else
+    LDFLAGS="-static $LDFLAGS"
+    pie="no"
+  fi
+elif test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
 elif compile_prog "-fPIE -DPIE" "-pie"; then
-- 
2.20.1


