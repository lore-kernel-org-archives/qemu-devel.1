Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2243C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0D620717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peic9dvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0D620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhyN-0006pW-Hx
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhuA-0001Up-F9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu9-0003wn-0c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:54 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhu8-0003wD-RA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:52 -0500
Received: by mail-pj1-x1044.google.com with SMTP id w23so1538950pjd.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nApRZuyphk20QYsTZlcyHkybuciklnqNiVIxVWJIGrs=;
 b=peic9dvHg0FZLS19Thrdo42vWWlyzsc1NRmi9oIJyqhEkzB4O52jcu4+qpBeqPcko8
 G3P779Vn9oYD+1087jriTUnZR9YO5uiMAZcyRANWNrLg0FS9Fxmc01bP+AOcvohKUKt8
 teFU2jNS3TbmACMZwqFTZzCW6cG7gWrVHY76DSRcfBVG3WbbACwE22G0bajiowLbtzzL
 EMXzYPJFGdrjd4Jp0prybUjyWIicR4xbrKDUS3QKCvdSQZ0WrcZki3/vhjV2rK1M/48b
 pnB+WzJFb5gAWgWmlXCJhwZaBWPTwRHU/NFXemGdBcDGOJTZmdNJdo92HxuZqyffHcUM
 Ya9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nApRZuyphk20QYsTZlcyHkybuciklnqNiVIxVWJIGrs=;
 b=C1q4H5G+qSFLPmgVCvArGH+kIyVFA3IJ3S1H2Ocs31q3HnCKhKWXHc9yzI6tLVAw3E
 pmUwS0fO0aZ6t/JDgJKP3/Cb2qPXLDlvFWcJlsEdr25lHI5jZ2CSSXEoXFIWKANXejd0
 B/+ZBq3/p7ksaicEO50c1YVE2PxB7SFux/c4Ddx6GobZ0dZ4tcALRQStQAlbT1MK62Ba
 44YBexhO5mAAgwZcESbOsP3Ki29sVuE2oFyAhLfTnVHd+IAK651U2PPVHBvuTxfAGqdn
 Ya2vS1ZALJj5eCPmQL6qdcMkkdSU3hgITPhI3L10iYU5vSc1o++G2fJ00Qxpr3EbTe8q
 F/rg==
X-Gm-Message-State: APjAAAUYaxeDHst3Uyc+C4i7S0SNQsZZ8PX3LfXLFzT4CvKhXL+RNUd9
 QOpkv5FAzh1nbZb+TgDdKtIvsjBwyuA=
X-Google-Smtp-Source: APXvYqxGiCZtuPCmngDvuKYoM9o8BlXeJMigZyhOWu3gnE9GUTrTjg8aPLoaltQ5VfLLcpoDhFCMzA==
X-Received: by 2002:a17:90a:f494:: with SMTP id
 bx20mr5727450pjb.60.1576708491152; 
 Wed, 18 Dec 2019 14:34:51 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] configure: Always detect -no-pie toolchain support
Date: Wed, 18 Dec 2019 12:34:38 -1000
Message-Id: <20191218223441.23852-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
index 99faf64a74..7a646ec007 100755
--- a/configure
+++ b/configure
@@ -2018,26 +2018,24 @@ if ! compile_prog "-Werror" "" ; then
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
     LDFLAGS="-pie $LDFLAGS"
-- 
2.20.1


