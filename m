Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDEDC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4112072A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ek8AHqbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4112072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ840-0004lU-1q
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zX-0004dh-SA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zW-0008Eu-PQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:07 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zW-0008Ea-K3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id v23so7599875ply.10
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nFUQTfUSKaEvMkBYs+/kSP9YEBdIr8bGAjyzPCvPYkQ=;
 b=Ek8AHqbCycWVJDm79edQGPIqhsWrWcw4RfwumJ/TYaZfgZohPLYtoTYKfuqpQjiEfV
 iZqLRmQJLJnk49e0ekks+hTN5kLFD6PiQDw3E2BzQ0AQ4oG+XjdZXJztfI07Uppb/scj
 zzSZnDcYDM4tE91f2gEhB5gpVxt123mrVjxpVVDas2hLc9+znaz54yQcindUZidwq06d
 nGvj4paMQX99mzBUfdfaIWUIkct5QHyLzg3hZrpKa4VXVOMMkBfJ0VfJw3o8CBF7dDbl
 2ghI41ZqNE/yVfPxBmJe07q4SbrRd3qkZ/51Lmu2Lri0Hsu1uZ5AHg5HzDsGEjOFxSB3
 dMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nFUQTfUSKaEvMkBYs+/kSP9YEBdIr8bGAjyzPCvPYkQ=;
 b=AOfdtDoRESHHE6O3S50xSjKNKqfrqxhuNF0qk4sgriiAhbWaafSJ1wxVo/tAUU2E6x
 nRkgzhg8lszmbdgP+hYtZft+OpoTYzIWzWB+1NapXXokhu0nznOLpb2Y2C0ahpD7HnBL
 8qdFrPcSOQk7XudB+ru4uaCwH7LQnNpsRaLYjF7dfAIUs+KuirKHmSvB7wy2x1W+518j
 U4x5FefW5q14ec0vYBQOfHX+iw6WXXup1Vsd07YCTFJIdpaAqLS9Qmvf6sZcmd/Udhcs
 hu0IcH1mu7HY38xwMrIKI5MCWsYFP8hMLL9xG6ZhAnryd686BC6kD4dReJynCcAJCQ46
 u7Fw==
X-Gm-Message-State: AGi0Pubwe5JKrwzWbjHYzOtVqrB/zdGgk9SOqa4+Ov47/kS0wuYcW/2J
 osAASfpbUBP5x/63kN+FR4JqAH7G28M=
X-Google-Smtp-Source: APiQypJVh29T/nGzjdjCzKTzwzuvG+MWq0YGLNrjs/g85wzWcUjfpX/Y34jWH5j2TPzRVCg2VllSAA==
X-Received: by 2002:a17:90a:a484:: with SMTP id
 z4mr1556857pjp.77.1585626905312; 
 Mon, 30 Mar 2020 20:55:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 04/10] configure: Always detect -no-pie toolchain
 support
Date: Mon, 30 Mar 2020 20:54:50 -0700
Message-Id: <20200331035456.6494-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
in pc-bios/optionrom/Makefile, which has nothing to do
with the PIE setting of the main qemu executables.

This overrides any operating system default to build
all executables as PIE, which is important for ROMs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index d4c2c7a563..1cdc439a57 100755
--- a/configure
+++ b/configure
@@ -2107,26 +2107,24 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" != "no" ; then
-  cat > $TMPC << EOF
+cat > $TMPC << EOF
 
 #ifdef __linux__
 #  define THREAD __thread
 #else
 #  define THREAD
 #endif
-
 static THREAD int tls_var;
-
 int main(void) { return tls_var; }
-
 EOF
-  # check we support --no-pie first...
-  if compile_prog "-Werror -fno-pie" "-no-pie"; then
-    CFLAGS_NOPIE="-fno-pie"
-    LDFLAGS_NOPIE="-nopie"
-  fi
 
+# Check we support --no-pie first; we will need this for building ROMs.
+if compile_prog "-Werror -fno-pie" "-no-pie"; then
+  CFLAGS_NOPIE="-fno-pie"
+  LDFLAGS_NOPIE="-no-pie"
+fi
+
+if test "$pie" != "no" ; then
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
-- 
2.20.1


