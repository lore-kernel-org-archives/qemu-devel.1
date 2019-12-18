Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7DAC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5400920717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veaVSP0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5400920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhyX-0006x0-Gv
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuC-0001YP-KI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuB-0003yA-Ir
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:56 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37215)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhuB-0003xm-Cy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:55 -0500
Received: by mail-pj1-x1043.google.com with SMTP id m13so1545084pjb.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U++KNLczq+T0iSXhRIdVMellsLpueqaa5pKBG4Au/Xo=;
 b=veaVSP0yzNYOIt1Y7emls/H5UuzaSVzRv8gD+Z7MtnHFigqRMtdc6CVY+d018N9v4G
 cz7G71bO1yg5cOoKr3zPp7WcZLmD5Grq0ZRQQbk055g7PHDRzqMLJcKzFIRpdQGELbA+
 IEgOdBRbgbZy//jvG95aFfg5c+1EgPuserCtV3MNSvIbk7gUuuQHPf8XMYJxz0Y59485
 2l+nIUh16JZ9ityDbIQtaPkFWGCVb0fDg4UuiBG5wegYOBwL8BK01UQth/xBY65Aw1jb
 NRsL/2YvEMAbUrbFuOHS323eO4Z2vwW4mEog5JHzASS2d+owmPBaVNvg5NMtKJQEPLaN
 1MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U++KNLczq+T0iSXhRIdVMellsLpueqaa5pKBG4Au/Xo=;
 b=GMPQGNDoVBMuIeD67ucSSXtt8MVLFJ53OlhnbyGU5U5fVu4OzCwwrwfN5ED4aVDjyQ
 vzBPoBUjYV7GV52qrJ6IQ4V/kHVuwKrtjk1aoILhghzLpsT7dSeh92liubKOpSu/qyCM
 SjjcN+7NegehSaBCzWSqx1GkgjIbAm7LSUehizsNZ4ZNiKvkpYxAu7erDwefw7u+niEX
 W4bLb3lthIZRZ6AMEtvcyTSKciVE01C5TvNfMEI+aDQn5gkHsRSxLr2CpSqJy+LIrICF
 o2zVhWag4uJbPhv6fvipebcgC0+20fyVLloEG2OQ7V6o5nVwaqGY/ytfVGlQJS25XzSc
 iZgg==
X-Gm-Message-State: APjAAAW1ruB5pnL16SXYzNT0bdxwfM5hrOfmc0LPeQSCYaInIGVhuz7e
 o9S2VRJQlXgeQ4dZs/VjI4s8zy63N+M=
X-Google-Smtp-Source: APXvYqw6AWhDJwVlc/VnN2OG3zpAwPIDELznbx5A+Ce3E92oqIdZ8JGjkrmpTs/mmVF/TMf5G2aPOQ==
X-Received: by 2002:a17:90a:6:: with SMTP id 6mr5808158pja.71.1576708494153;
 Wed, 18 Dec 2019 14:34:54 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] configure: Override the os default with --disable-pie
Date: Wed, 18 Dec 2019 12:34:40 -1000
Message-Id: <20191218223441.23852-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: philmd@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some distributions, e.g. Ubuntu 19.10, enable PIE by default.
If for some reason one wishes to build a non-pie binary, we
must provide additional options to override.

At the same time, reorg the code to an elif chain.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 2503288654..f6ff079fab 100755
--- a/configure
+++ b/configure
@@ -2035,19 +2035,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
   LDFLAGS_NOPIE="-no-pie"
 fi
 
-if test "$pie" != "no" ; then
-  if compile_prog "-fPIE -DPIE" "-pie"; then
-    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    LDFLAGS="-pie $LDFLAGS"
-    pie="yes"
-  else
-    if test "$pie" = "yes"; then
-      error_exit "PIE not available due to missing toolchain support"
-    else
-      echo "Disabling PIE due to missing toolchain support"
-      pie="no"
-    fi
-  fi
+if test "$pie" = "no"; then
+  QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
+  LDFLAGS="$LDFLAGS_NOPIE $LDFLAGS"
+elif compile_prog "-fPIE -DPIE" "-pie"; then
+  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+  LDFLAGS="-pie $LDFLAGS"
+  pie="yes"
+elif test "$pie" = "yes"; then
+  error_exit "PIE not available due to missing toolchain support"
+else
+  echo "Disabling PIE due to missing toolchain support"
+  pie="no"
 fi
 
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
-- 
2.20.1


