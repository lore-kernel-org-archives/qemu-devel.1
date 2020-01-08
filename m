Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7204C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8576B2070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0A9Q5nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8576B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Kb-0006N2-VG
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I2-0003FA-ED
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2I1-0002hS-9V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:50 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:39481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2I1-0002gT-4B
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:49 -0500
Received: by mail-pg1-x52e.google.com with SMTP id b137so869503pga.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QROkLTblnGhCZH9GNWCjPQW6ivwBc2Lh/2EXrbymzQY=;
 b=P0A9Q5nnAMsJwLdGR1IMrrf3H3W/URNvmLTdIOeQGczlWoBJDn7lPPo7j0DnK6K8f/
 VPHjrLbDbaOYlzXod9ZqZclZkxekLr6J7Rffbz4xVl4JCheWl2EMoPW3EZA/T0qH+Py4
 Jw4LrV485f/slcCZE7gbNf22790EvG/I3CUbTudBJQHiNUdxDX4YDIO84dbPpckvsufk
 eYitvQmNLFZ/+RxrZBaYLJBL4KbM4o5P4SCF+up2tNLLJPj4N8vWTyUrrLggTtIOIuUU
 i1F/Zpptpll4BtuKBuAg0unYtswBKh7kyyYU+jntRCvDbIfaOd7ZXU3tyNo/XVTMAYDO
 t+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QROkLTblnGhCZH9GNWCjPQW6ivwBc2Lh/2EXrbymzQY=;
 b=Qno9H+dwqvyinkI1gs+Rlmz0hlUC2PoqnzRr1CjpAy42SjW4BOOwcshXtc/9un/bm7
 In8pIzRFpQPJ6rEbZ6IuhqmHdYn1p9O7YZUQ7/bTKOV0sap00r9Mb59A3qgT7Ya5yUFD
 Js+6j6eYLWRvh6I3UI2OtpEbhbQtTwSADc/dA/CR6hmr0dEojcQHkdDj3RqJwX9Zmx2x
 doCCPURzSJJcscCEvYdsj3J14n7HfGxsGqXZjdOjgNjyfp9skH2aDwl2hP7gLeQRO5WU
 XlgGxXc3hltVJdPfVK1J6KhfE7gGUQRE6SxPbaUyYZ4Fq3kllG6+zwvzJP6WuBUctwZn
 hLyw==
X-Gm-Message-State: APjAAAWwA32YUNrw/gyln1pAPHhTH8tVvEawPgGhbupN7fPz72AlQB+r
 yaqgFWHaYFSKDGvntwyI1jEvLJoIJmne+Q==
X-Google-Smtp-Source: APXvYqz8fSsZ9S14GMvC6oWjtDnrdAATaB4uFHjJsgLwm8w/0on7fUfwJJtiPfN9+ygJgVFi7bG/7g==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr3017809pgf.2.1578455147870;
 Tue, 07 Jan 2020 19:45:47 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] configure: Override the os default with --disable-pie
Date: Wed,  8 Jan 2020 14:44:48 +1100
Message-Id: <20200108034523.17349-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
 configure | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 1dd12edcc3..de2c4867ad 100755
--- a/configure
+++ b/configure
@@ -2036,19 +2036,18 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
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


