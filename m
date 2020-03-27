Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B497FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C87A2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1+rRHcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C87A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHxD3-0003mB-M2
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx5C-0003Hq-FZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx5B-0000lO-ED
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:06 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx5B-0000iS-8i
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:05 -0400
Received: by mail-pl1-x641.google.com with SMTP id m1so3953191pll.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tgJO+PAqo3hq/ulVfkyK+PFQv1YttMuVGSUleyX1kKY=;
 b=j1+rRHcGn5E+TfXwHn9dOI5k/PPIjT4twOdWM7Bi5RcKw4kbudTEBZAj9cHSqQYh+P
 r1XUbNKGIAgIQ42pNAKN5dip/1Li2Kzj4ycffJksdk5HOiZ9bdZtOXhf/IRI7EcEXqRY
 tkl+qn+iGLOjPKeuFMjygLIIZQNa7/sLe9rq+86Az/xleBOZEUyTIyd92PO+vfv9GECE
 pcajirkSar1DYZ+TVWviQwod/nLneGkla0EFCYgPVaAQlnicgxkKzHmr3G4sYc0dAR+W
 F5Z1vwvc8LwaUGtAs3NF5fFfhyXSzKiDGUHzc+X+ofVWavi1LjRTY5gbzGSdOXSo8TWi
 tM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tgJO+PAqo3hq/ulVfkyK+PFQv1YttMuVGSUleyX1kKY=;
 b=jDSNrGR/gsZ3cKZhZPs3rkSbY3jUN8NwHvr4uD3k/hrK41Wr8ZcgidZtjza/1AhwaA
 Zh23aX9qhOEoXwTHOkX4wxCeecsmvFYZ0GZqpox4kZk2DO7xvqoddGUJJBt8YuhnAHRW
 4SkNxSoGHv5cBg9dcSkG2RvhE5f9OkJcieyEq8PoxZWCQ+VchiVUfbAUW567WItwkE3P
 Hq6m1Sww8BhmrQNhYfTX5Pz37NdY5CULOuerfne8JgOse4CXg3J/i67S5i+UOqQjuWVM
 OgisbTXqudCtjx48NDhjOJ+gbKtaAMjmkWUTEwepawMK9aFcd6NA4f7Dcr9xij0iKzcV
 TF/A==
X-Gm-Message-State: ANhLgQ3s9ojJ3TbuanLDw8rxNowesiKxqrVcugqVgGHa93l42Uzbsd9R
 lvGE6Noc4rcw1nCbjTb8KLW9x2o0k4I=
X-Google-Smtp-Source: ADFU+vstRWahSsEbMTfrxMdaoylQ1cLvjKhh5jogzPB0sNf4FHy2i4t6cVNlfhl3UedNEV4pV0L36A==
X-Received: by 2002:a17:90a:d103:: with SMTP id
 l3mr1680163pju.91.1585346643818; 
 Fri, 27 Mar 2020 15:04:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:04:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 6/7] configure: Override the os default with
 --disable-pie
Date: Fri, 27 Mar 2020 15:03:52 -0700
Message-Id: <20200327220353.27233-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: dim@FreeBSD.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some distributions, e.g. Ubuntu 19.10, enable PIE by default.
If for some reason one wishes to build a non-pie binary, we
must provide additional options to override.

At the same time, reorg the code to an elif chain.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Update for QEMU_LDFLAGS.
---
 configure | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 4dead416ae..b304bd0cf8 100755
--- a/configure
+++ b/configure
@@ -2124,19 +2124,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
   LDFLAGS_NOPIE="-no-pie"
 fi
 
-if test "$pie" != "no" ; then
-  if compile_prog "-fPIE -DPIE" "-pie"; then
-    QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
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
+  QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
+elif compile_prog "-fPIE -DPIE" "-pie"; then
+  QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
+  QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
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


