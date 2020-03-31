Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA79C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1709F2072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0iVltKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1709F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ83w-0004dC-7h
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7za-0004jJ-Df
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zZ-0008G2-7q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:10 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:40623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zZ-0008Ff-2J
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:09 -0400
Received: by mail-pj1-x1030.google.com with SMTP id kx8so509781pjb.5
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S+YD6LWo1z5Vsgzq3ypvuc0IEmwxuyzEeq5y1l14e9U=;
 b=F0iVltKBtDusq4Qu78xf8Dgg2AK0wrtUwzFG0F4FqPtqM596JK+LHTw8Ha4bbt7sLI
 hYL+YYQPcpHlRxNuD5CUG0CHT9kpCwKDlqcjaNsNLjuZ6qJ3XhCfe2I5BGSnFPeCB0Zq
 EBdvy8ESOP+lIVkvDUmdTwed633e8O7Q7VBPdgIwie6TCYrZNz10MYCCx89tNLIB/BNT
 DB2b1q6RjCdMf9VfRcrb4Y7AfFnZ0uJvcbqFqzKG2quVWPb0alMgcGKIgr5LwwE9Tsww
 yftmzybgy//6tR96tasRCDkya9zFKwAi7owLiSI8pO+lEBqU+9XiNyhIHLyQdAAXZaGH
 iwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S+YD6LWo1z5Vsgzq3ypvuc0IEmwxuyzEeq5y1l14e9U=;
 b=LhNR0t6ZZLt8v1CGibW0eJWmxIx5ZOtfQCZ9zcNvOLs7mCANl2At9pKs4yC/H5GL2T
 qoWphpNfZrSVpNuRmhMQrZCGCFRaf57RndTXGjJ72HLn6HrRckCtNdvdNXX6WJhDKEna
 mffwVJkQyz5WGaATIQI6F0UgPBDSShC6OplcNWVitlJMT35j3JpFdCP7Od1s1XCxHddC
 nAYI0wta5RNxPPcNppO7cnxyRa3kQlu9mngEHsnPijtE/0pnXCBqL3LN6NWv81YzIogd
 SuYWZkV/8ACsvefLJEXaY1u4IuFbSLujX0YYQRg3mds8xTSQfvLBoEX5S05aN0oVeYPu
 99Dw==
X-Gm-Message-State: AGi0Pua/99fER5f/xZNDhSBWFn9+jTtX05ryFYv3o50gi9AVnGSwCC4/
 U7GyuKAWGqK0PTSUoL5oAP4no5eUtX0=
X-Google-Smtp-Source: APiQypLtIUbS8qiECTzHGXvPwEMXrI8JVJVquDIhLXXlA1rMq7l0LegnQAv1Gg0Ukex5NcS0MG4f5A==
X-Received: by 2002:a17:90a:8c18:: with SMTP id
 a24mr1585344pjo.43.1585626907775; 
 Mon, 30 Mar 2020 20:55:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 06/10] configure: Override the os default with
 --disable-pie
Date: Mon, 30 Mar 2020 20:54:52 -0700
Message-Id: <20200331035456.6494-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1030
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
v3: Update for QEMU_LDFLAGS.
---
 configure | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index 1e622f5acb..481d5077f7 100755
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


